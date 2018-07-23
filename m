Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A665ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D3020856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYHGOuy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D3020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbeGWQau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387922AbeGWQau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:30:50 -0400
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com [209.85.216.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3310120875;
        Mon, 23 Jul 2018 15:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532359745;
        bh=hZ3uG7Zt7daSG+I8nTODIX5CMJqrhjeanp/2Q+iKpvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IYHGOuy5HgnxlpfWu8cg+xfNabEU0Lqm4DfavnXlqUn/L5N4f1dDgDmPMsV+Z6bjR
         4UNUjreAcdgQYoU7j5sLQmZS4tywdewlyIIv/vfjYbSWfIcfThhtNUbfDJ5nsbdeMz
         nSWAh7q1dqWDQWMjCqlxLuWedrDFvzQgvu3MfzTk=
Received: by mail-qt0-f170.google.com with SMTP id f18-v6so1005964qtp.10;
        Mon, 23 Jul 2018 08:29:05 -0700 (PDT)
X-Gm-Message-State: AOUpUlF8dxR7Fb0etOyQB3oIb9vQ8MKfQmhcgj6lwaa5pQO8B9zzhBkO
        VfhCABsezSGtVZLs4fmcY2TFCxeJjfAOqTGi0w==
X-Google-Smtp-Source: AAOMgpfA5FfY/MopNaSKfgXVTg4cWG7qmRbSnPnEJX2sZr5fcXn64sDelMHM7rQBI3LmadSFCFjLRYIEHoyn2V8Npps=
X-Received: by 2002:ac8:71c9:: with SMTP id i9-v6mr12327953qtp.22.1532359744417;
 Mon, 23 Jul 2018 08:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <1532187494-2704-1-git-send-email-liu.xiang6@zte.com.cn>
In-Reply-To: <1532187494-2704-1-git-send-email-liu.xiang6@zte.com.cn>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 23 Jul 2018 09:28:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLozSJ-0YeajN=qHuR69KCjeR_xO21MyZxr-n6tR5G0cw@mail.gmail.com>
Message-ID: <CAL_JsqLozSJ-0YeajN=qHuR69KCjeR_xO21MyZxr-n6tR5G0cw@mail.gmail.com>
Subject: Re: [PATCH] of: irq: Add a helper function for irq_of_parse_and_map
To:     liu.xiang6@zte.com.cn
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        liuxiang_1999@126.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 9:38 AM Liu Xiang <liu.xiang6@zte.com.cn> wrote:
>
> Implement a resource managed irq_of_parse_and_map function.

That is obvious from the diff. Why do you need this?

Anything that is a platform device should use platform_get_irq. The
mapping is created by the core Also, of_irq_get() is preferred over
irq_of_parse_and_map() for new users as it has better error return
handling.

>
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
> ---
>  drivers/of/irq.c       | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/of_irq.h |  7 +++++++
>  2 files changed, 45 insertions(+)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 02ad93a..947fe41 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -45,6 +45,44 @@ unsigned int irq_of_parse_and_map(struct device_node *dev, int index)
>  }
>  EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
>
> +static void devm_irq_dispose_mapping(struct device *dev, void *res)
> +{
> +       irq_dispose_mapping(*(unsigned int *)res);

We don't ref count creating mappings, so this would break for any shared irq.

Rob
