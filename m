Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F39C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1A0208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jaZCfUTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1A0208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeGKKDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:03:34 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41747 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeGKKDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:03:33 -0400
Received: by mail-io0-f193.google.com with SMTP id q9-v6so23068674ioj.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tLLGgBGDGfhIKCSoHxXtiZpksHyCXwes474qm1r75Ts=;
        b=jaZCfUTZ+G80NCIxG3ZeL8mOsB2hbtiRgfIDurGsujshZ2u/xoAQJlPNLmYcYtIxbK
         5z/P4V04hRjQbNrYK/q/A0wTQBLbHuDDYzXn0dqwdcoWzh23GJI3J/9zNGmOfrxUTEqI
         YU4PFMKvddRMCxB9eUaRjg8K/O+hrNmYmFeYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tLLGgBGDGfhIKCSoHxXtiZpksHyCXwes474qm1r75Ts=;
        b=XYiwz8LEdHczVgnpp9AfeHQOK0EakWy6AVwwmulLkLB06euPa7SGKN467TmWECLg6a
         w5n68CZ9dtsZECi4V0Airgh1m1OYfkGDOLhzYoLKYAFtpIEtfogQA+uTEMxufivk85oN
         WV5m75RLMkl/RFCNDKQRZRbOM0Lq+OU9RNxB0XqK5eUgoRjj4VDBXVtpZA6pW26rkn2Q
         DTTcTKWr+qBzM2tZRSVMG4kFirL5BIuK40aJ/AGheqVFgOeo9NB1k4gsVsV+wWG5YU4J
         C3dG70LiqKBKR4OaOm5Ue9G8wTraA0xb7yw6bJEuKdP5FX8vPHj9s4YWXJrv4tt/BTWz
         Et4A==
X-Gm-Message-State: AOUpUlFHKWRnqJaHNg2SmYKjPzO+WXOxvWvPw5YIiur468NrM8lODIY2
        xjwbZpt+kaiXbRlz7CTQsMFBnhz4I2DGwFId7ZF+bQ==
X-Google-Smtp-Source: AAOMgpdcKlfPcuk8Tx0KPmoBA8uO2+Kx+4graLrIfnPSm10XOtHQmbMBLhYIbiIU6x8WUSnC7X8ryp4kfRfzh6O0Pls=
X-Received: by 2002:a6b:5d1a:: with SMTP id r26-v6mr15801816iob.170.1531303201247;
 Wed, 11 Jul 2018 03:00:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 03:00:00
 -0700 (PDT)
In-Reply-To: <1530624720-32004-1-git-send-email-brijesh.singh@amd.com>
References: <1530624720-32004-1-git-send-email-brijesh.singh@amd.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 11 Jul 2018 12:00:00 +0200
Message-ID: <CAKv+Gu_3kD+7O4oR9751VH2CsG=+NmBY-Gypc25LFo9eT6m3RQ@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Access EFI MMIO data as unencrypted when SEV is active
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        KVM devel mailing list <kvm@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        "# 4 . 15 . x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 July 2018 at 15:32, Brijesh Singh <brijesh.singh@amd.com> wrote:
> SEV guest fails to update the UEFI runtime variables stored in the
> flash. commit 1379edd59673 ("x86/efi: Access EFI data as encrypted
> when SEV is active") unconditionally maps all the UEFI runtime data
> as 'encrypted' (C=1). When SEV is active the UEFI runtime data marked
> as EFI_MEMORY_MAPPED_IO should be mapped as 'unencrypted' so that both
> guest and hypervisor can access the data.
>
> Fixes: 1379edd59673 (x86/efi: Access EFI data as encrypted ...)
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: linux-efi@vger.kernel.org
> Cc: kvm@vger.kernel.org
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: <stable@vger.kernel.org> # 4.15.x
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/platform/efi/efi_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index 77873ce..5f2eb32 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -417,7 +417,7 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
>         if (!(md->attribute & EFI_MEMORY_WB))
>                 flags |= _PAGE_PCD;
>
> -       if (sev_active())
> +       if (sev_active() && md->type != EFI_MEMORY_MAPPED_IO)
>                 flags |= _PAGE_ENC;
>
>         pfn = md->phys_addr >> PAGE_SHIFT;

Is it safe to only update this occurrence and not the one in
efi_runtime_update_mappings() ?
