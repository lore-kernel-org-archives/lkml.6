Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6FBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2242087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gzwzWbmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2242087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeJJWIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:08:52 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35269 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeJJWIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:08:52 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181010144620euoutp027aab720f6f2cf5e61b8d0c25f8d63b96~cRpWKzH-72316623166euoutp02H
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 14:46:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181010144620euoutp027aab720f6f2cf5e61b8d0c25f8d63b96~cRpWKzH-72316623166euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539182780;
        bh=4dS9OUkP0YEIlYVpvAwCx8Vl9Ss4zrO52nqfTDbg9+0=;
        h=To:Cc:From:Subject:Date:References:From;
        b=gzwzWbmgPTRq0yh/W8Ycx5/aG0sMk+8lEA7FpOIqhc0KobmioVfMcKuZ0/OUzhG+e
         qW5IQ71XMTogapLnro2FjTUw/twf/f2qarqitJQlSrUaF+tOwgEkg7EFgpRL4hyyJG
         xs3MBl+AbKRRXH6UV7q34k17NlY/24gR7faei4zw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181010144620eucas1p23e42e60aeaa1d229e90ed7590cc178a4~cRpV00-cl1426914269eucas1p2N;
        Wed, 10 Oct 2018 14:46:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E8.C1.04806.BB01EBB5; Wed, 10
        Oct 2018 15:46:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181010144619eucas1p2e4e6d3c43dd12e5b9cec7a29c4bf95ad~cRpUq8hi71426914269eucas1p2J;
        Wed, 10 Oct 2018 14:46:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181010144618eusmtrp17a0de580e8c79aaffa36c821915f630c~cRpUacND81731817318eusmtrp1P;
        Wed, 10 Oct 2018 14:46:18 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-68-5bbe10bbfbc4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CD.12.04284.AB01EBB5; Wed, 10
        Oct 2018 15:46:18 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181010144618eusmtip293dce115b12bee7df75d15323ce14222~cRpUMGeh70934209342eusmtip2-;
        Wed, 10 Oct 2018 14:46:18 +0000 (GMT)
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ARC: remove redundant 'default n' from Kconfig
Date:   Wed, 10 Oct 2018 16:46:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djP87q7BfZFG8z5YWpxedccNovWO2uZ
        LA5tfcTiwOyxeUm9x5b9nxk9Pm+SC2CO4rJJSc3JLEst0rdL4MpofLqWuWCTVMWaS5fYGxib
        RLoYOTkkBEwk1m1uYO9i5OIQEljBKLHj/Qso5wujxNbZW5kgnM+MEo3nfzDBtMx5fpQNIrGc
        UeLRtgZmkISQwHtGiSmPlEBsEQE1iaPd89hAbGYBF4l/D28zgthsAlYSE9tXgdnCAvYSr55t
        YgWxWQRUJW48vg8U5+AQFYiQ6D+jDhLmFRCUODnzCQvEGHmJ7W/nMEPccJtN4llrEEg5r0CZ
        xMn3/hBhF4kpt+5ClQhLvDq+hR3ClpE4PbmHBeRkCYHpjBJvfi2FctYzSqw5cwzqMWuJw8cv
        soIMZRbQlFi/Sx8i7Chx9dhvJpCwhACfxI23ghDn8ElM2jadGSLMK9HRJgRRrSaxYdkGNpi1
        XTtXQp3jIXHu1DZ2SEDFSnw+dJ95AqPCLCRPzkLy5CyEGxYwMq9iFE8tLc5NTy02zkst1ytO
        zC0uzUvXS87P3cQITBSn/x3/uoNx35+kQ4wCHIxKPLwNF/ZEC7EmlhVX5h5ilOBgVhLhvXV4
        b7QQb0piZVVqUX58UWlOavEhRmkOFiVx3mXzNkYLCaQnlqRmp6YWpBbBZJk4OKUaGHnv82S+
        efyOSf9UReH7LA41GcEHmifmpbtdUfnE+r/6w1o5noiPCuds98h+v7j9jc5tm1ajxOtTjsn0
        LZe7b3jRV7Tc+qC6u8mjo8c1pl26Eind236m+lLAYT1B1qjtnzLnst66c63ItOG2h+AKh5LF
        wudu7JSPuHZ8ds+qMPv/S5POcTubiyqxFGckGmoxFxUnAgByX50AEAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsVy+t/xe7q7BPZFG/zqMLS4vGsOm0XrnbVM
        Foe2PmJxYPbYvKTeY8v+z4wenzfJBTBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqb
        x1oZmSrp29mkpOZklqUW6dsl6GU0Pl3LXLBJqmLNpUvsDYxNIl2MnBwSAiYSc54fZeti5OIQ
        EljKKHF36QrGLkYOoISMxPH1ZRA1whJ/rnVB1bxllJh7djsjSEJEQE3iaPc8NhCbWcBF4t/D
        22BxNgEriYntq8BsYQF7iVfPNrGC2LwCdhJPGheA1bMIqErceHwfrEZUIELi1sMOFogaQYmT
        M5+wQMxUl/gz7xIzhC0vsf3tHOYJjPyzkJTNQlI2C0nZAkbmVYwiqaXFuem5xYZ6xYm5xaV5
        6XrJ+bmbGIFBve3Yz807GC9tDD7EKMDBqMTD23BhT7QQa2JZcWXuIUYJDmYlEd5bh/dGC/Gm
        JFZWpRblxxeV5qQWH2I0BTp8IrOUaHI+MOLySuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeW
        pGanphakFsH0MXFwSjUwCiy++9Y/vIzTcevPjUUGTDNzKpdHWJnunnbEdNv6ZSdjFZ9t4xBh
        6puZPeHxsZl6FQu0V61X2hLNGmN/7mb+hhi2M3/XOczqdfYKmry5db69WFeCJZfkevuztS/P
        xy3ecefawh+XVx67cX6FEVfJGf4Z4c96r08W71x2oeYs95y7WXmdKns89ZVYijMSDbWYi4oT
        AbXMr9CAAgAA
Message-Id: <20181010144619eucas1p2e4e6d3c43dd12e5b9cec7a29c4bf95ad~cRpUq8hi71426914269eucas1p2J@eucas1p2.samsung.com>
X-CMS-MailID: 20181010144619eucas1p2e4e6d3c43dd12e5b9cec7a29c4bf95ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181010144619eucas1p2e4e6d3c43dd12e5b9cec7a29c4bf95ad
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181010144619eucas1p2e4e6d3c43dd12e5b9cec7a29c4bf95ad
References: <CGME20181010144619eucas1p2e4e6d3c43dd12e5b9cec7a29c4bf95ad@eucas1p2.samsung.com>
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
 arch/arc/Kconfig |   11 -----------
 1 file changed, 11 deletions(-)

Index: b/arch/arc/Kconfig
===================================================================
--- a/arch/arc/Kconfig	2018-10-09 15:58:34.951122837 +0200
+++ b/arch/arc/Kconfig	2018-10-10 16:44:11.551907020 +0200
@@ -176,13 +176,11 @@ endchoice
 
 config CPU_BIG_ENDIAN
 	bool "Enable Big Endian Mode"
-	default n
 	help
 	  Build kernel for Big Endian Mode of ARC CPU
 
 config SMP
 	bool "Symmetric Multi-Processing"
-	default n
 	select ARC_MCIP if ISA_ARCV2
 	help
 	  This enables support for systems with more than one CPU.
@@ -254,7 +252,6 @@ config ARC_CACHE_PAGES
 config ARC_CACHE_VIPT_ALIASING
 	bool "Support VIPT Aliasing D$"
 	depends on ARC_HAS_DCACHE && ISA_ARCOMPACT
-	default n
 
 endif	#ARC_CACHE
 
@@ -262,7 +259,6 @@ config ARC_HAS_ICCM
 	bool "Use ICCM"
 	help
 	  Single Cycle RAMS to store Fast Path Code
-	default n
 
 config ARC_ICCM_SZ
 	int "ICCM Size in KB"
@@ -273,7 +269,6 @@ config ARC_HAS_DCCM
 	bool "Use DCCM"
 	help
 	  Single Cycle RAMS to store Fast Path Data
-	default n
 
 config ARC_DCCM_SZ
 	int "DCCM Size in KB"
@@ -366,13 +361,11 @@ if ISA_ARCOMPACT
 
 config ARC_COMPACT_IRQ_LEVELS
 	bool "Setup Timer IRQ as high Priority"
-	default n
 	# if SMP, LV2 enabled ONLY if ARC implementation has LV2 re-entrancy
 	depends on !SMP
 
 config ARC_FPU_SAVE_RESTORE
 	bool "Enable FPU state persistence across context switch"
-	default n
 	help
 	  Double Precision Floating Point unit had dedicated regs which
 	  need to be saved/restored across context-switch.
@@ -453,7 +446,6 @@ config HIGHMEM
 
 config ARC_HAS_PAE40
 	bool "Support for the 40-bit Physical Address Extension"
-	default n
 	depends on ISA_ARCV2
 	select HIGHMEM
 	select PHYS_ADDR_T_64BIT
@@ -496,7 +488,6 @@ config HZ
 
 config ARC_METAWARE_HLINK
 	bool "Support for Metaware debugger assisted Host access"
-	default n
 	help
 	  This options allows a Linux userland apps to directly access
 	  host file system (open/creat/read/write etc) with help from
@@ -524,13 +515,11 @@ config ARC_DW2_UNWIND
 
 config ARC_DBG_TLB_PARANOIA
 	bool "Paranoia Checks in Low Level TLB Handlers"
-	default n
 
 endif
 
 config ARC_UBOOT_SUPPORT
 	bool "Support uboot arg Handling"
-	default n
 	help
 	  ARC Linux by default checks for uboot provided args as pointers to
 	  external cmdline or DTB. This however breaks in absence of uboot,
