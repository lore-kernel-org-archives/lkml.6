Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFE1C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B17219E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJOfFsP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B17219E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbeHFW1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:27:15 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39641 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731308AbeHFW1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:27:14 -0400
Received: by mail-ua0-f195.google.com with SMTP id g18-v6so13630996uam.6;
        Mon, 06 Aug 2018 13:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+6iP6XLnOkkoNW2fzNFKmb32Q4HgiEXj5q1bUzun4xM=;
        b=CJOfFsP1izHCwPwcSx0UWkJLlXiDejXnxU9wAqbrDwekLWEgjEUfVJ83VYOBp5kjl+
         7+1HrjjF3QLGB7OM6vmJO5yYoInpBg+HGQTZ5PmoHgoZ8136F2gS6di7gts+lBQUQ/TQ
         OyNzD8zrP/y5D9CJr4PZmQIt1FtERUPAyQgNmK8tRXhDUGbSBCps3E1NaLHt85OzrcCe
         06bed3ohX+1qyMk0rhV8RiWIT3szPV45tjI+BLb6mA6qGz56BLkneO7VCNg4JqD/g+Fq
         HDlBo4OlYLK9zJ8voG9pd+VucgJ50kpztXjIvRiMfcMELGoBMV6ICsjMzbC/sJYm539E
         AoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+6iP6XLnOkkoNW2fzNFKmb32Q4HgiEXj5q1bUzun4xM=;
        b=d8SRLQRS5p7XeqUDM3B5GfbQhSwg67xLJJR+5GY/2wbUgUS9UXT1ZNFtKYC5ZIH9v9
         QL6XN90xYp+4nBZteFT+kNDS9exzmJBJmthqaQxGeYJhGWkNGqwvOks7VsReZdauLXHK
         BX+wuLZHmiLAnARrIZoqnOHwpl0Vgt8q7ROJi3AUvdsYS22nGIdWzEgwEQQFSKz0Qfxc
         Te1pDrD0IdA8Z+QrdXF/bI1CHe8EGUmIccj4IZunV0mJ2oCpuF+UXDs5KLgtYQfhdQ9N
         7lrR4x/VpBIfJ1CZmJuqrSA808PpA0Y0PVqbHFxu+G3RCLidx4QApPdzBGBgsPBKnecn
         2arQ==
X-Gm-Message-State: AOUpUlHDovwD0DPFmx/uPCojQPDSNOemp1MvKML3MIDyRQEBiozfpRna
        tj9btqZcSKzfWt86rw00FMTTvA3MPayGYds4cT8=
X-Google-Smtp-Source: AAOMgpfGnZMxEnaAG6bo7pVefiorF4EGQ9Lyhji6DtBN/grsP7SKG9vRwbH7tRuWwyTbo8w8Xm/pwShDtKfdxhjFF/I=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr11335527ual.141.1533586591743;
 Mon, 06 Aug 2018 13:16:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 13:16:31 -0700 (PDT)
In-Reply-To: <20180806200052.GA29026@embeddedor.com>
References: <20180806200052.GA29026@embeddedor.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Aug 2018 23:16:31 +0300
Message-ID: <CAHp75VdrmVgGSTeT+rzyQbKwJyseq06b6s+d8aXCvimGgL3uMQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: refactor function has_cap
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Joe Perches <joe@perches.com>,
        David Laight <David.Laight@aculab.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 11:00 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Refactor function has_cap in order to avoid returning integer
> values, when instead it should return booleans.
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/platform/x86/acer-wmi.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 8952173..ff1689d 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -672,10 +672,7 @@ static void __init find_quirks(void)
>
>  static bool has_cap(u32 cap)
>  {
> -       if ((interface->capability & cap) != 0)
> -               return 1;
> -
> -       return 0;
> +       return (interface->capability & cap) != 0;
>  }

Thanks, as Joe mentioned even != 0 part is not needed (followed by
unneeded parens), though I would let it be (one line is good enough to
me) if there will be no strong preferences.

-- 
With Best Regards,
Andy Shevchenko
