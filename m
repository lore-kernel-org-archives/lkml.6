Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C32DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BB320877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8cihARM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BB320877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933753AbeGIPun (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932862AbeGIPuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:50:40 -0400
Received: from mail-it0-f54.google.com (mail-it0-f54.google.com [209.85.214.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8DB320877
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 15:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531151439;
        bh=KzFnMcknNtGI1qmkBElGH1EYSPTNJoY2Lu4IJdI3IWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z8cihARMNcnO5erJZE+RWUEFd5iXxEkl/kbp3rmmgVGJaV/+lEBYgzcg9DbBA3o9q
         LsiseT49IEox2CsBDubPUqcT5Occjo2DqsONylPSOWJogb11SmVgO78BO8Cc7DuZS5
         xZBFk0hFspaRzXNpWYspN243HANkYn/OoZK2/9KQ=
Received: by mail-it0-f54.google.com with SMTP id 16-v6so26009360itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:50:39 -0700 (PDT)
X-Gm-Message-State: APt69E3d+2drpBoHM40UxZQ4eODLms9v5RDn6NE8H86HSBoq4RZPMiob
        zHipegBjuhrbDTd62K4lmAWDVJzgD11RaL4Gyg==
X-Google-Smtp-Source: AAOMgpeq4K7BX++NuK+jKijwFfHMm2DBV6PeC1GteTuOJ3SzX+ozvu2Gm29e0qKAAzfzPz3lnEykAO5LR4RyBHSd1c0=
X-Received: by 2002:a02:986d:: with SMTP id x42-v6mr17763546jaj.131.1531151439265;
 Mon, 09 Jul 2018 08:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180619214054.19326-1-robh@kernel.org>
In-Reply-To: <20180619214054.19326-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Jul 2018 09:50:27 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+-psrjcu77x9B6hig96i9Ld2ntimS0ConjWMWCMtupCw@mail.gmail.com>
Message-ID: <CAL_Jsq+-psrjcu77x9B6hig96i9Ld2ntimS0ConjWMWCMtupCw@mail.gmail.com>
Subject: Re: [PATCH] h8300: remove unnecessary of_platform_populate call
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 3:40 PM Rob Herring <robh@kernel.org> wrote:
>
> The DT core will call of_platform_populate, so it is not necessary for
> arch specific code to call it unless there are custom match entries,
> auxdata or parent device. Neither of those apply here, so remove the call.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/h8300/kernel/setup.c | 10 ----------
>  1 file changed, 10 deletions(-)

Ping?

>
> diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
> index a4d0470c10a9..b2b51f75774e 100644
> --- a/arch/h8300/kernel/setup.c
> +++ b/arch/h8300/kernel/setup.c
> @@ -23,7 +23,6 @@
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/of_fdt.h>
> -#include <linux/of_platform.h>
>  #include <linux/of_address.h>
>  #include <linux/clk-provider.h>
>  #include <linux/memblock.h>
> @@ -188,15 +187,6 @@ const struct seq_operations cpuinfo_op = {
>         .show   = show_cpuinfo,
>  };
>
> -static int __init device_probe(void)
> -{
> -       of_platform_populate(NULL, NULL, NULL, NULL);
> -
> -       return 0;
> -}
> -
> -device_initcall(device_probe);
> -
>  #if defined(CONFIG_CPU_H8300H)
>  #define get_wait(base, addr) ({                \
>         int baddr;                      \
> --
> 2.17.1
>
