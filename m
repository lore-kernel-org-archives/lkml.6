Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5082C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F1E2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUOfv7LP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F1E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeH3NEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:04:44 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38221 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeH3NEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:04:43 -0400
Received: by mail-it0-f66.google.com with SMTP id p129-v6so1691990ite.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BhjBE9iF06Ss2qBx9xoNeBPT5CxjiYSSTR/cLqAO7E0=;
        b=FUOfv7LPXsqcHWiA7BnGMRIU/ybTfHqve9Xh8IuEiiZWneDFDZ64rmIXe/S4cTJvrX
         1GC7n1Za7VXBu12MJjH2S5Ey4T5KhdTt4SbVXvti0Dd3YSqlYeU2FEeXVUzqpJYg9oB/
         dUp0xPtOYgf3AYdwsd9gCNN+QE2Jfk1t/fIU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhjBE9iF06Ss2qBx9xoNeBPT5CxjiYSSTR/cLqAO7E0=;
        b=d4+WRF1NtDhDJx+xMwiNyjKanMKN/KqQY3VwOHbg64elSJ/Gu1diiQlnzHPvewIzXX
         l1Mp1CAlXwkFe2MqYcqVwx2H4ykJ7axi+Zs1nrDX/F2B+cLcTrD3zK6k44jI4n0ErBbd
         BODMcqdmDUFFJ9u9fRxwkPuHuvGkVnsKtiSEH/DaPS/vWAwVfv9bysdVQTXOAjycp/k4
         HtBYpskgmNjxIBKAERqfZKedzJIfvNgxOhsX3XW+sEPipQ2TlEXC2sLnVKNAb2/TrTbv
         MYax37HN0NH6wgcLZOIREQDaB5XsCObynhFAOx6wbp8xjyTvvRx2ny0i+Nr4PJS3UVrs
         84Zg==
X-Gm-Message-State: APzg51AxOGWn5P3OGOJABHRj6M8QPCeivK7aqFqK1UgO5cpxiJWBvjHU
        EJY/RJHAdeF0bhl9ttwlKg4Qi7ivRyHrQ0N0qx37Hw==
X-Google-Smtp-Source: ANB0VdaB4byNaqo6NBMJ6kwR2gy+OLKpK28xYLi6KjH0mkEGehMCuDaKUp002/UVvimPnYgEPekTQ+/8lqQ2C59DXT8=
X-Received: by 2002:a02:13c6:: with SMTP id 189-v6mr8737134jaz.50.1535619815658;
 Thu, 30 Aug 2018 02:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180827083916epcas1p43a3fc8570269411de215254ce0ae4b37@epcas1p4.samsung.com>
 <1535359139-6264-1-git-send-email-srikanth.h@samsung.com>
In-Reply-To: <1535359139-6264-1-git-send-email-srikanth.h@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 30 Aug 2018 11:03:23 +0200
Message-ID: <CACRpkdZm8ZOmn0j3ksaaCjKQt+pY032JzR==9V62Lo9+N9FWVA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Preventive patch in the pin control subsystem to
 handle NULL check.
To:     srikanth.h@samsung.com
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srikanth, thanks for your patch!

On Mon, Aug 27, 2018 at 10:39 AM Srikanth K H <srikanth.h@samsung.com> wrote:

 @@ -269,8 +269,9 @@ void pinconf_show_setting(struct seq_file *s,

>                 desc = pin_desc_get(setting->pctldev,
>                                     setting->data.configs.group_or_pin);
> -               seq_printf(s, "pin %s (%d)", desc->name,
> -                          setting->data.configs.group_or_pin);
> +               if (desc)
> +                       seq_printf(s, "pin %s (%d)", desc->name,
> +                                  setting->data.configs.group_or_pin);

Under what circumstances do you expect this to happen?
Did you provoke it with a real usecase during development?

We do not sprinkle NULL or error handling over code that
will not derail, and since this is in debugfs we are even more
lax.

If it annoys users (which would then be developers using
debugfs during development), then we need to look into it.

Yours,
Linus Walleij
