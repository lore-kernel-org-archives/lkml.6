Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8A1C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6669A21748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivCwtlWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6669A21748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeI1PDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:03:44 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53640 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbeI1PDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:03:44 -0400
Received: by mail-it1-f193.google.com with SMTP id q70-v6so1666809itb.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 01:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XxJkT8So9d2JGtU+Y+wMMHRZFlCEgB9TLe2Pp5fmWz0=;
        b=ivCwtlWCSmyeLx2FQYhQFm3J6iJjsyR7uIpekfEwTBEzcpPllZSGVIrU/mv27U1sYw
         oZknRPL3jYrcT6Hizk1yO2WWecdmXY2Cs2+sjHcAU0EjWU3QVZNxikMByv1k9vVxQZBx
         b4qLpSe0KwimS7fk2FerioG8ttK0NRhB80BZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XxJkT8So9d2JGtU+Y+wMMHRZFlCEgB9TLe2Pp5fmWz0=;
        b=kJNrvrCENmIusE/h7h/NOTg06dU6UPFC/AvhOZLHICIwXL6v8NWOCN5m4CMUpIj6J2
         xZ09oAABVoURHZbhnOK93q8bxGNvEN5vwRH8KIms1SIbtBl5rPmhlXeccepgyI0wKwPi
         pgc/EDepjiFrWWyr6yHwKYmgwbyGueoSJvv+Xa6bdmyLTmFtvTBGTsAydUmsHd7vVdUs
         DNBu6t5WR6epa/rWGkfO6jjqmF7ViirR42Wz5+LDxKUTEWAwuUw8IVl9LCQvNe/C0E+a
         zDcR1nC3p35/n94O105V4kHnyQ/aRroQiA75HSlA3J58mles63bNTWIogFf0Z/6cHEEh
         L1zg==
X-Gm-Message-State: ABuFfoizUIa6LcekYwHNOapvdpuW4QKlcmFbLotYStoc8vHrjZMAUIOB
        rIJ2XjSpsGb7E179uZqzjQGY+z1ZeAuvGo8bkFzobQ==
X-Google-Smtp-Source: ACcGV61z+tnzn/7N2bCRYQWkn4psDlPfhxxdrNzdiqgEpxLM0U64FPYpIikW4oobQuAi2mj+rlXgEzcnwD6ylR8fsVU=
X-Received: by 2002:a02:9b97:: with SMTP id p23-v6mr13165004jak.5.1538124063339;
 Fri, 28 Sep 2018 01:41:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 01:41:02
 -0700 (PDT)
In-Reply-To: <20180926135110.13061-1-Jason@zx2c4.com>
References: <20180926135110.13061-1-Jason@zx2c4.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 28 Sep 2018 10:41:02 +0200
Message-ID: <CAKv+Gu-e-t7Jp3LkGEe2DA+Ci1ap5xKAqvq12g6sYUMocLS=cg@mail.gmail.com>
Subject: Re: [PATCH] arm: support big-endian for the virt architecture
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, arm@kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ arm-soc)

On 26 September 2018 at 15:51, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> This architecture, used for running in QEMU, runs just fine when
> compiled in big-endian mode. So enable it. This is enabled in exactly
> the same way that it is for other platforms (such as vexpress) that also
> support big-endian mode in QEMU successfully.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Personally, I'm using this as part of WireGuard's CI, and patching
> kernels to include this is a bit annoying. Any chance this can get into
> 4.19?
>
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e8cd55a5b04c..b8c6062ca0c1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -701,6 +701,7 @@ config ARCH_VIRT
>         select ARM_GIC_V3_ITS if PCI
>         select ARM_PSCI
>         select HAVE_ARM_ARCH_TIMER
> +       select ARCH_SUPPORTS_BIG_ENDIAN
>
>  #
>  # This is sorted alphabetically by mach-* pathname.  However, plat-*
> --
> 2.19.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
