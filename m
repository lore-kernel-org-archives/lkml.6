Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFD1C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978B22088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVe1x4LO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978B22088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeILXp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:45:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39960 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeILXp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:45:28 -0400
Received: by mail-io1-f68.google.com with SMTP id l14-v6so1048686iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 11:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7PonDIHDj57NYUwqBclwBDQt3qui53gpoL+rJlXa0Uk=;
        b=WVe1x4LOdokSMJdcPN7kZ3Tq2JNUmvKlfzE9MhTB3keYuNOxrDR5PNRLp/swiS5Mpn
         QxT3+PBFs9VTuv4TwAkBoAPDUeo0RHWsT5R/2u9g/bdr+ZAnRo1tFTj/o2u1OOjcTZG3
         0FlZ1OL/O1xURPjVkcKBwAyQhXYrTUDWvqORg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7PonDIHDj57NYUwqBclwBDQt3qui53gpoL+rJlXa0Uk=;
        b=Kvk9ZR3hNP5A/h6fTd8hUt8MBj7IrzYlLGAw5RnmglyyxQMHZ/qQ342g1/wygL/jmo
         ntWCRF4foAVZ7K3O+GMKJ3xPKB+0+GPuziyu95XQsgYpEdkfW46g11xOqh0n68YjbPTD
         ptWflhc44DhSrzJyoLDhKRpxdXyHnHBPdkfTcsa04Gfji20CbWJHCOx406m7l6KHwehD
         p8WYg6C61IpGJjXZPHh1fdzjNnoJlTDLQs4QZ2nGPFc2/e/JnwaN4w9cXv7M36ZUaAvb
         ahLrHT+GLXpnbLpT2HQ9MUmoulJyZ6jNv8MzdCGqAvE84Qsu4YsPQpGIOXmq3j6Vp5kE
         5NZQ==
X-Gm-Message-State: APzg51AewCC2oYgpaUN1awZU9JJjsXkMlKmi98oJZuKt4fYbgpdwN6JX
        a2XBb7iwP6pCW96eVdPbabiqqfwWT0ymw6cbEEldeA==
X-Google-Smtp-Source: ANB0VdaYpUOmVI6M5/bMiW9H3m/LCU/7/YJaYXPd6kVnOK3J3WvBz5ib0AtQXSZaPFCsiQ28Ii6TZ8Kdx93TD5MNPs0=
X-Received: by 2002:a6b:4516:: with SMTP id s22-v6mr3179897ioa.60.1536777579925;
 Wed, 12 Sep 2018 11:39:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 11:39:39
 -0700 (PDT)
In-Reply-To: <1536775208-8064-1-git-send-email-aaron.ma@canonical.com>
References: <1536423828-5693-1-git-send-email-aaron.ma@canonical.com> <1536775208-8064-1-git-send-email-aaron.ma@canonical.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 12 Sep 2018 20:39:39 +0200
Message-ID: <CAKv+Gu9D-qSYVxT7zgK5SBUoJfR-XJgGQrco6mfme_e049LA7A@mail.gmail.com>
Subject: Re: [PATCH v2] x86/efi: earlyprintk - Add 64bit efi fb address support
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 September 2018 at 20:00, Aaron Ma <aaron.ma@canonical.com> wrote:
> EFI GOP uses 64-bit frame buffer address in some BIOS.
> Add 64bit address support in efi earlyprintk.
>
> V2:
> Fix type of address.
>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

Thanks. Queued in efi/next.

> ---
>  arch/x86/platform/efi/early_printk.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/platform/efi/early_printk.c b/arch/x86/platform/efi/early_printk.c
> index 5fdacb322ceb..7476b3b097e1 100644
> --- a/arch/x86/platform/efi/early_printk.c
> +++ b/arch/x86/platform/efi/early_printk.c
> @@ -26,12 +26,14 @@ static bool early_efi_keep;
>   */
>  static __init int early_efi_map_fb(void)
>  {
> -       unsigned long base, size;
> +       u64 base, size;
>
>         if (!early_efi_keep)
>                 return 0;
>
>         base = boot_params.screen_info.lfb_base;
> +       if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> +               base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
>         size = boot_params.screen_info.lfb_size;
>         efi_fb = ioremap(base, size);
>
> @@ -46,9 +48,11 @@ early_initcall(early_efi_map_fb);
>   */
>  static __ref void *early_efi_map(unsigned long start, unsigned long len)
>  {
> -       unsigned long base;
> +       u64 base;
>
>         base = boot_params.screen_info.lfb_base;
> +       if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> +               base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
>
>         if (efi_fb)
>                 return (efi_fb + start);
> --
> 2.17.1
>
