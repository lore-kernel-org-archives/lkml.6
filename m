Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248C4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A9A214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K0dIvQEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A9A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeJJWXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:23:33 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39926 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJWXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:23:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181010150057euoutp010607980f41f31fb85f95bc872854eea2~cR2Grhs0R2174021740euoutp01N
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 15:00:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181010150057euoutp010607980f41f31fb85f95bc872854eea2~cR2Grhs0R2174021740euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539183657;
        bh=oohU+Xj20Wd1dJ35XDGtxX8ZWJZbNodD+gKAMZxWLPw=;
        h=To:Cc:From:Subject:Date:References:From;
        b=K0dIvQEfkt0jhL8gKGuXxEqev3Tr2i2Gqu6wIsUSUfTQKwtAteLTMc4x69cYd7iyv
         0gnY1vMv6c4ayhgWLq1tMf8RzlRyInvmd7SXk2XrFicINdJHCfPHrQE+6m5fUEoAas
         coeYitgTHUnEXKY/TBYVIitlR9zE74IUxOQiu/jE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181010150056eucas1p2455d0b86220939fb627e116cba403658~cR2GN7XcP2073720737eucas1p2s;
        Wed, 10 Oct 2018 15:00:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DC.A3.04806.8241EBB5; Wed, 10
        Oct 2018 16:00:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181010150055eucas1p1b50d2fa2333e2b0b84f90c14fb06111b~cR2FGBz6f2704627046eucas1p1B;
        Wed, 10 Oct 2018 15:00:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181010150055eusmtrp281f3c8182583d118fc0c2c9dcb39ea06~cR2E08opG3143631436eusmtrp28;
        Wed, 10 Oct 2018 15:00:55 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-25-5bbe14281c5a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 42.93.04128.7241EBB5; Wed, 10
        Oct 2018 16:00:55 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181010150055eusmtip147c981e05166ce9b622c7d78bfea3c3b~cR2Ej5lMV1835918359eusmtip1V;
        Wed, 10 Oct 2018 15:00:55 +0000 (GMT)
To:     Ley Foon Tan <lftan@altera.com>
Cc:     nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] nios2: remove redundant 'default n' from Kconfig-s
Date:   Wed, 10 Oct 2018 17:00:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djPc7oaIvuiDf6vFLd4OuEOm8XlXXPY
        LLpmPWVzYPZo3TuBzePq8iVMHp83yQUwR3HZpKTmZJalFunbJXBlPHm9ir3gnnxF27VdTA2M
        ZyS6GDk5JARMJA4eWcTexcjFISSwglHi0rknbBDOF0aJJ7M/MEM4nxklbt3YzwzTsu33f1aI
        xHJGiYmd96Cc90BVz9eyglSJCChLTN98iwnEZhZwkmid38QOYrMJWElMbF/FCGILCzhLTL2w
        nqWLkYODRUBV4vsMFxBTVCBCov+MOkgFr4CgxMmZT1ggpshLbH87B+wgCYH7bBLde+ayg9Tz
        CpRJ7O/kgbjNRaK78QoLhC0s8er4FnYIW0bi/875TBC90xkl3vxaygLhrGeUWHPmGBNElbXE
        4eMXWUGGMgtoSqzfpQ8RdpRo69jMBhKWEOCTuPFWEOIePolJ26YzQ4R5JTrahCCq1SQ2LNvA
        BrO2a+dKaLB5SLw83wl2sZBArETLd/0JjAqzkDw5C8mTsxBOWMDIvIpRPLW0ODc9tdg4L7Vc
        rzgxt7g0L10vOT93EyMwVZz+d/zrDsZ9f5IOMQpwMCrx8DZc2BMtxJpYVlyZe4hRgoNZSYSX
        QWBftBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeZfM2RgsJpCeWpGanphakFsFkmTg4pRoY53Hq
        zxMX2HAsw//EbsPZfzSnWjPH3pi2Ovlq257m0FnmM/0SnE7M1/L5t+Lcso2tp/NvbzPsFDnA
        EtHNyj5dPtd/Xj9rd9X3eTeEnqnHeQrFfH6R/9Dm1JxJwQvq08sS5h24/6tNs+eg8LHfX2bf
        1vRatyF8xc32LxxhPJetKzZE+B6wmLiLX4mlOCPRUIu5qDgRAEoSLo8RAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsVy+t/xu7rqIvuiDZbdFbN4OuEOm8XlXXPY
        LLpmPWVzYPZo3TuBzePq8iVMHp83yQUwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
        m8daGZkq6dvZpKTmZJalFunbJehlPHm9ir3gnnxF27VdTA2MZyS6GDk5JARMJLb9/s/axcjF
        ISSwlFHiw8qJ7F2MHEAJGYnj68sgaoQl/lzrYoOoecso8fPPdhaQhIiAssT0zbeYQGxmASeJ
        1vlN7CA2m4CVxMT2VYwgtrCAs8TUC+vB6nkF7CT2bb7NCjKfRUBV4vsMF5CwqECExK2HHVAl
        ghInZz5hgRipLvFn3iVmCFteYvvbOcwTGPlnISmbhaRsFpKyBYzMqxhFUkuLc9Nzi430ihNz
        i0vz0vWS83M3MQKDetuxn1t2MHa9Cz7EKMDBqMTDe+PSnmgh1sSy4srcQ4wSHMxKIrwMAvui
        hXhTEiurUovy44tKc1KLDzGaAt09kVlKNDkfGHF5JfGGpobmFpaG5sbmxmYWSuK85w0qo4QE
        0hNLUrNTUwtSi2D6mDg4pRoYpx7jUuPt+8FS2RW0LFJ/V2a85XSjzwdX7VJatqfvw7uzKlWF
        mVsnnq89HZjeHfBMtWixd/qamcybYv2NdEp2sEwKcPT4o7bcY/MXvn+h0TFPelT4vB9dL+m8
        emGi59GPOaGKpq/+9rJZ22Uad5XctjoRxun6aJV+8e7GfwIL2t7vPLvyM8MKJZbijERDLeai
        4kQAL3IdooACAAA=
Message-Id: <20181010150055eucas1p1b50d2fa2333e2b0b84f90c14fb06111b~cR2FGBz6f2704627046eucas1p1B@eucas1p1.samsung.com>
X-CMS-MailID: 20181010150055eucas1p1b50d2fa2333e2b0b84f90c14fb06111b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181010150055eucas1p1b50d2fa2333e2b0b84f90c14fb06111b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181010150055eucas1p1b50d2fa2333e2b0b84f90c14fb06111b
References: <CGME20181010150055eucas1p1b50d2fa2333e2b0b84f90c14fb06111b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/nios2/Kconfig                   |    1 -
 arch/nios2/platform/Kconfig.platform |    9 ---------
 2 files changed, 10 deletions(-)

Index: b/arch/nios2/Kconfig
===================================================================
--- a/arch/nios2/Kconfig	2018-10-09 15:58:36.543122877 +0200
+++ b/arch/nios2/Kconfig	2018-10-10 16:57:50.411927641 +0200
@@ -126,7 +126,6 @@ config NIOS2_CMDLINE_IGNORE_DTB
 
 config NIOS2_PASS_CMDLINE
 	bool "Passed kernel command line from u-boot"
-	default n
 	help
 	  Use bootargs env variable from u-boot for kernel command line.
 	  will override "Default kernel command string".
Index: b/arch/nios2/platform/Kconfig.platform
===================================================================
--- a/arch/nios2/platform/Kconfig.platform	2018-09-03 18:11:12.057792442 +0200
+++ b/arch/nios2/platform/Kconfig.platform	2018-10-10 16:58:37.951928838 +0200
@@ -17,7 +17,6 @@ comment "Device tree"
 
 config NIOS2_DTB_AT_PHYS_ADDR
 	bool "DTB at physical address"
-	default n
 	help
 	  When enabled you can select a physical address to load the dtb from.
 	  Normally this address is passed by a bootloader such as u-boot but
@@ -37,7 +36,6 @@ config NIOS2_DTB_PHYS_ADDR
 
 config NIOS2_DTB_SOURCE_BOOL
 	bool "Compile and link device tree into kernel image"
-	default n
 	help
 	  This allows you to specify a dts (device tree source) file
 	  which will be compiled and linked into the kernel image.
@@ -62,21 +60,18 @@ config NIOS2_ARCH_REVISION
 
 config NIOS2_HW_MUL_SUPPORT
 	bool "Enable MUL instruction"
-	default n
 	help
 	  Set to true if you configured the Nios II to include the MUL
 	  instruction.  This will enable the -mhw-mul compiler flag.
 
 config NIOS2_HW_MULX_SUPPORT
 	bool "Enable MULX instruction"
-	default n
 	help
 	  Set to true if you configured the Nios II to include the MULX
 	  instruction.  Enables the -mhw-mulx compiler flag.
 
 config NIOS2_HW_DIV_SUPPORT
 	bool "Enable DIV instruction"
-	default n
 	help
 	  Set to true if you configured the Nios II to include the DIV
 	  instruction.  Enables the -mhw-div compiler flag.
@@ -84,7 +79,6 @@ config NIOS2_HW_DIV_SUPPORT
 config NIOS2_BMX_SUPPORT
 	bool "Enable BMX instructions"
 	depends on NIOS2_ARCH_REVISION = 2
-	default n
 	help
 	  Set to true if you configured the Nios II R2 to include
 	  the BMX Bit Manipulation Extension instructions. Enables
@@ -93,7 +87,6 @@ config NIOS2_BMX_SUPPORT
 config NIOS2_CDX_SUPPORT
 	bool "Enable CDX instructions"
 	depends on NIOS2_ARCH_REVISION = 2
-	default n
 	help
 	  Set to true if you configured the Nios II R2 to include
 	  the CDX Bit Manipulation Extension instructions. Enables
@@ -101,13 +94,11 @@ config NIOS2_CDX_SUPPORT
 
 config NIOS2_FPU_SUPPORT
 	bool "Custom floating point instr support"
-	default n
 	help
 	  Enables the -mcustom-fpu-cfg=60-1 compiler flag.
 
 config NIOS2_CI_SWAB_SUPPORT
 	bool "Byteswap custom instruction"
-	default n
 	help
 	  Use the byteswap (endian converter) Nios II custom instruction provided
 	  by Altera and which can be enabled in QSYS builder. This accelerates
