Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5A5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E8A20873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoWXB/+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E8A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbeGMPHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:07:24 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42996 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbeGMPHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:07:24 -0400
Received: by mail-vk0-f65.google.com with SMTP id t4-v6so18239471vke.9;
        Fri, 13 Jul 2018 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OCe+zM7A0FYptJ87g5NYAwp07b0R6UpaCnGTihlLRj4=;
        b=KoWXB/+HurJp4M0vBAeRwQquLnzlhyoovtwb11h6jR0revU9KHTApomt6tPO1jKspA
         QOK98uFuz2eAGK7QhEHxBz2dnE2xXtA+ioRmbhIv6eb+xZ7QRIIRfUcfTv8oC9n+7Dgw
         5elqgoQVdL/ymBF5rnMuXjW9rnApefVR7rYR2cMBWtpEnC3dThtwTqFkFSlkaYLapMjH
         uNEemt5ffEUiTQBheo+EJp1/wYI2oY8J8gBkIqG+oraTBtLOt+5yy+obM0jnF0btqSaG
         tA5DTd477NxFJvx/T8kXAczPUGbwxE+7XXZvQRGTOZ0gLZnxxjLxNIbuTN5LARqEig0A
         vceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OCe+zM7A0FYptJ87g5NYAwp07b0R6UpaCnGTihlLRj4=;
        b=eXpZjhFxKQvO8jptw2RPv6aC9XqIMSwd3fxLAkDDMO4BgeB7shXWDoEOy25X8OkKUZ
         n4/y4qmvgfFc1o2ABHVQypVOCcI9zlNP21R1l6+d5TSqDSu6oME3PL0zdzFbomYsd2Ys
         r7A2CqsiCGUpX8qZupNYJjnY6jsG5kPlmsy1OGsjktDyClB6PFXCxnF20OE5ig0PM3cJ
         uFEWItr+TBX/fbA3o1qZrA7lnDIDuZgDIWon28/DVllc1My+kWXfWPskgN7Hl2MCAyzs
         FtI5NRkxjT8zdcRuwkCiOuPnqnoHDpPq2jyXDkFSwQ8qVuV/raFA/QIEy84XoKAnmugb
         fY8A==
X-Gm-Message-State: AOUpUlGqu+botxAT2j4U9F4cRfamWzPH5o+VYJXCpa2cQ0ndmnq3AYG6
        +aE4aNHQ1GslRR8oCodU9l/e/TamxhAHQhHvmZE=
X-Google-Smtp-Source: AAOMgpchZe0pl5FhZfsv+IeBYOD0rBziNzWQlbrC55Y+5SpcYF13qKu0kqwezMdKMBTDxjy4jHZpSQkzEOkN6/TkIfA=
X-Received: by 2002:a1f:6dc4:: with SMTP id i187-v6mr3922869vkc.131.1531493545418;
 Fri, 13 Jul 2018 07:52:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 07:52:24
 -0700 (PDT)
In-Reply-To: <20180711080910.4769-1-colin.king@canonical.com>
References: <20180711080910.4769-1-colin.king@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Jul 2018 17:52:24 +0300
Message-ID: <CAHp75VcHniqfcsSZmZY-qU=Cx8u64u-ixuhvRbV2wFXVeJW4rg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_ips: remove redundant variables slope
 and offset
To:     Colin King <colin.king@canonical.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 11:09 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Variables slope and offset are being assigned but are never used hence
> they are redundant and can be removed.
>

Sounds like some half-baked calculus and perhaps would be fixed
better. Though, no one complained so far and git will keep previous
version in index anyway.

> Cleans up clang warnings:
> warning: variable 'slope' set but not used [-Wunused-but-set-variable]
> warning: variable 'offset' set but not used [-Wunused-but-set-variable]
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/platform/x86/intel_ips.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
> index 014fc1634a3d..c5ece7ef08c6 100644
> --- a/drivers/platform/x86/intel_ips.c
> +++ b/drivers/platform/x86/intel_ips.c
> @@ -858,10 +858,7 @@ static u16 read_mgtv(struct ips_driver *ips)
>
>  static u16 read_ptv(struct ips_driver *ips)
>  {
> -       u16 val, slope, offset;
> -
> -       slope = (ips->pta_val & PTA_SLOPE_MASK) >> PTA_SLOPE_SHIFT;
> -       offset = ips->pta_val & PTA_OFFSET_MASK;
> +       u16 val;
>
>         val = thm_readw(THM_PTV) & PTV_MASK;
>
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
