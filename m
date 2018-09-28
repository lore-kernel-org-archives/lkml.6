Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA05C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259E5206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259E5206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbeI1WQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:16:45 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38606 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbeI1WQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:16:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id 204-v6so3474325qkd.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5yB+YUP4b8jH1Ml0hq1zz6gNrHnS4SyRFbgMxbJbxU=;
        b=Uyunkla/pu7xb45NL/Grhc/2r4mr5C/fQi8Mps4nu1LO5nXoO7SXI+x9OxoBPLXDOw
         4yoAuYRa+y1imbWW3phwU145NXHrBNxRRj14bJcuu20km4o0luEKOk44NcFjDgBYJaBP
         FD/jOPkxKG8+nS538eYNRmCZJebgVFKTM8wz/4YwaTr66lMDa1FwTE8q5uz3u56gILU5
         wi/ewCbsmGojbXaBj2hohguB2aTJtvTQ9mwYTlm7flBMCY7njLPDrK4Xm7ukGC3JjQoi
         86Izk3lVDGG0ZJ/obWKWZZtM9OfycdIrQkhhGf/mLLK9/XG0GTxbHlQtdE8tjLGabaIK
         nvNA==
X-Gm-Message-State: ABuFfojK7QfDZg/x4OyOhpPl6otIiO4BG18gY5rTFw+EkCBKn1lN6P73
        Vyl1SOkGiJL6uCEwT7yEPtchTEFyaHEZ51cDalyQl/hb
X-Google-Smtp-Source: ACcGV61IqbAUE07P1UTy96HQH4ZkUy2XF9eh89py6+y72NJnayyQ9SGBT47E57P4GyXESF9YogObihXKDS2fJrvoqU0=
X-Received: by 2002:a37:c542:: with SMTP id p63-v6mr12097227qki.330.1538149942917;
 Fri, 28 Sep 2018 08:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180926135110.13061-1-Jason@zx2c4.com>
In-Reply-To: <20180926135110.13061-1-Jason@zx2c4.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Sep 2018 17:52:06 +0200
Message-ID: <CAK8P3a0+s6DM=QUqS_KrNp+95aDj2QTsWb+w73piwLsQFvq+pg@mail.gmail.com>
Subject: Re: [PATCH] arm: support big-endian for the virt architecture
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 3:52 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
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

Applied for 4.20 with subject line changed s/arm/ARM/, thanks!

We don't really handle this well in general, by allowing a big-endian
build if any of the enabled platforms select ARCH_SUPPORTS_BIG_ENDIAN,
rather than making sure that /all/ of them do.

I think most people just build a 'defconfig' kernel, which includes
multiple platforms that use ARCH_SUPPORTS_BIG_ENDIAN.

A better way to do this might be to assume ARCH_SUPPORTS_BIG_ENDIAN
for ARCH_MULTIPLATFORM, and then mark all platforms that are
known to be broken as 'depends on !CPU_BIG_ENDIAN'.

Your patch is certainly fine for 4.20, but since we haven't decided
what the proper fix should be, I didn't want to push this for 4.19.

        Arnd
