Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE564C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47505208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad+3XHr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47505208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbeGaQx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:53:26 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45242 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeGaQx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:53:26 -0400
Received: by mail-io0-f194.google.com with SMTP id k16-v6so13317378iom.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 08:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WA/GarRzykqHcF1HteiWOC5DY95QANxm7aa+s6+sefA=;
        b=Ad+3XHr0fs461mHStjkEbl5ybvbUBqfBZYk9SVskxzj65JC0Sq+w4f0q7/SW2Xgdah
         roHmblBeBaFW0fJQ8meV55tgaMYgEfiDrnXn2XohT+nzuhgrsO/zWpfYlT01Wcn+kmvE
         kRuDSj7W7/+6R5H/322PGtkPH1Deep9mMtg5djP7tTMMtZuc3t5/zu3CwktPj/uc7SXy
         KIKOVjeUu7kVnnfb9By/Z01ikk5S/hyxTgDWPmdY9wJ/lZbbqc4CIeX4SLMUlej3UytT
         Vo6oEPXTq6VX1BCfas3g9HYlG3PsGAT5sF42pLxV2G33hXDiZL4If+jSGdMdi1u1V8zN
         zF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WA/GarRzykqHcF1HteiWOC5DY95QANxm7aa+s6+sefA=;
        b=aqo1Z2n8wP+SKLcMel3ekrcEqToG17ysaCy6WDQrwowj0nnlqIsgXVoWsKAwsTxHbo
         5VGrgIiDy11gPeW71s18O3iSPd5rO7RLefrzwNH0BbxFRI7tyXD67yeWsLWsELq1WIvQ
         1T9pJYSOtNLlRUDRBVrZ2U938XcJTnalIH/mRHimK25Xaiwe2GMPtjF7fgunbO38JNQw
         hXVicL03AyVjdy1ulksWphnAMGwhkY7cgPsCOVrq70rtUhJRQqrHrYi/YhFEMMan6txj
         izSGuDXQ7pyJpnz+szJ76+/qsgW5yjMHuSXo/mte9pys5cCamvoWfxpMxrGHY54ZUdkS
         eNDw==
X-Gm-Message-State: AOUpUlE6HiWsIByoGCioATeCSWgDv8yfSZtPt3Pi04O7W3VpK1VOsX7T
        kbe1A49FEeilwNUpHlJldPsf81aC9g4=
X-Google-Smtp-Source: AAOMgpef+8eeGA4dF54FfgpAEOEx4wbkOyqyZnzTp29RRlod2JJ1I9GuimbWyjfaUKYpwkn0njM1GA==
X-Received: by 2002:a6b:3902:: with SMTP id g2-v6mr133184ioa.168.1533049958779;
        Tue, 31 Jul 2018 08:12:38 -0700 (PDT)
Received: from [10.0.2.15] ([72.138.96.106])
        by smtp.gmail.com with ESMTPSA id z1-v6sm4430531ioj.51.2018.07.31.08.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 08:12:38 -0700 (PDT)
Subject: Re: [RESEND PATCH 0/6] rapidio: move Kconfig menu definition to
 subsystem
To:     Alexei Colin <acolin@isi.edu>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     John Paul Walters <jwalters@isi.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
        Matt Porter <mporter@kernel.crashing.org>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180731142954.30345-1-acolin@isi.edu>
From:   Alex Bounine <alex.bou9@gmail.com>
Message-ID: <1273cd44-677a-fd51-5be3-8278b3448e57@gmail.com>
Date:   Tue, 31 Jul 2018 11:12:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731142954.30345-1-acolin@isi.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alexandre Bounine <alex.bou9@gmail.com>


On 2018-07-31 10:29 AM, Alexei Colin wrote:
> Resending the patchset from prior submission:
> https://lkml.org/lkml/2018/7/30/911
> 
> The only change are the Cc tags in all patches now include the mailing
> lists for all affected architectures, and patch 1/6 (which adds the menu
> item to RapdidIO subsystem Kconfig) is CCed to all maintainers who are
> getting this cover letter. The cover letter has been updated with
> explanations to points raised in the feedback.
> 
> 
> 
> The top-level Kconfig entry for RapidIO subsystem is currently
> duplicated in several architecture-specific Kconfig files. This set of
> patches does two things:
> 
> 1. Move the Kconfig menu definition into the RapidIO subsystem and
> remove the duplicate definitions from arch Kconfig files.
> 
> 2. Enable RapidIO Kconfig menu entry for arm and arm64 architectures,
> where it was not enabled before. I tested that subsystem and drivers
> build successfully for both architectures, and tested that the modules
> load on a custom arm64 Qemu model.
> 
> For all architectures, RapidIO menu should be offered when either:
> (1) The platform has a PCI bus (which host a RapidIO module on the bus).
> (2) The platform has a RapidIO IP block (connected to a system bus, e.g.
> AXI on ARM). In this case, 'select HAS_RAPIDIO' should be added to the
> 'config ARCH_*' menu entry for the SoCs that offer the IP block.
> 
> Prior to this patchset, different architectures used different criteria:
> * powerpc: (1) and (2)
> * mips: (1) and (2) after recent commit into next that added (2):
>    https://www.linux-mips.org/archives/linux-mips/2018-07/msg00596.html
>    fc5d988878942e9b42a4de5204bdd452f3f1ce47
>    491ec1553e0075f345fbe476a93775eabcbc40b6
> * x86: (1)
> * arm,arm64: none (RapidIO menus never offered)
> 
> This set of architectures are the ones that implement support for
> RapidIO as system bus. On some platforms RapidIO can be the only system
> bus available replacing PCI/PCIe.  As it is done now, RapidIO is
> configured in "Bus Options" (x86/PPC) or "Bus Support" (ARMs) sub-menu
> and from system configuration option it should be kept this way.
> Current location of RAPIDIO configuration option is familiar to users of
> PowerPC and x86 platforms, and is similarly available in some ARM
> manufacturers kernel code trees. (Alex Bounine)
> 
> HAS_RAPIDIO is not enabled unconditionally, because HAS_RAPIDIO option
> is intended for SOCs that have built in SRIO controllers, like TI
> KeyStoneII or FPGAs. Because RapidIO subsystem core is required during
> RapidIO port driver initialization, having separate option allows us to
> control available build options for RapidIO core and port driver (bool
> vs.  tristate) and disable module option if port driver is configured as
> built-in. (Alex Bounine)
> 
> Responses to feedback from prior submission (thanks for the reviews!):
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593347.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593349.html
> 
> Changelog:
>    * Moved Kconfig entry into RapidIO subsystem instead of duplicating
> 
> In the current patchset, I took the approach of adding '|| PCI' to the
> depends in the subsystem. I did try the alterantive approach mentioned
> in the reviews for v1 of this patch, where the subsystem Kconfig does
> not add a '|| PCI' and each per-architecture Kconfig has to add a
> 'select HAS_RAPIDIO if PCI' and SoCs with IP blocks have to also add
> 'select HAS_RAPIDIO'. This works too but requires each architecture's
> Kconfig to add the line for RapidIO (whereas current approach does not
> require that involvement) and also may create a false impression that
> the dependency on PCI is strict.
> 
> We appreciate the suggestion for also selecting the RapdiIO subsystem for
> compilation with COMPILE_TEST, but hope to address it in a separate
> patchset, localized to the subsystem, since it will need to change
> depends on all drivers, not just on the top level, and since this
> patch now spans multiple architectures.
> 
> Alexei Colin (6):
>    rapidio: define top Kconfig menu in driver subtree
>    x86: factor out RapidIO Kconfig menu
>    powerpc: factor out RapidIO Kconfig menu entry
>    mips: factor out RapidIO Kconfig entry
>    arm: enable RapidIO menu in Kconfig
>    arm64: enable RapidIO menu in Kconfig
> 
>   arch/arm/Kconfig        |  2 ++
>   arch/arm64/Kconfig      |  2 ++
>   arch/mips/Kconfig       | 11 -----------
>   arch/powerpc/Kconfig    | 13 +------------
>   arch/x86/Kconfig        |  8 --------
>   drivers/rapidio/Kconfig | 15 +++++++++++++++
>   6 files changed, 20 insertions(+), 31 deletions(-)
> 
