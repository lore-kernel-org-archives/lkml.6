Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C6CC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D55720644
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i/iGZaar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D55720644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeJIW4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:56:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56259 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIW4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:56:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181009153847euoutp026fc1f182cbca25246cf1f0dc0676bd5c~b_t2M6Z3n0533705337euoutp02U
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 15:38:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181009153847euoutp026fc1f182cbca25246cf1f0dc0676bd5c~b_t2M6Z3n0533705337euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539099527;
        bh=GgnH9nKgtYkvdXXWYJJo/oXFCifTX4P0Xhb6dhYg3Ic=;
        h=From:To:Cc:Subject:Date:References:From;
        b=i/iGZaarOxl0TtPlnz0XtQzdZjVh7/MLHSUyVUMJ7TqhSfg3GdO7gSoyy1mfubfNb
         1rcEqmcfH5BEmrx67G9y4e48VO1CMzYdV0H60V0JMH9ETgvQRFnm3+Y49ds/C4ffuA
         liPHR0If73+PpwJWWBLYbaD1LSUkl7PVzDaoMNEs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181009153846eucas1p1ce5a9449f15741a0b9f6329711ef75ef~b_t1tlfuG3066630666eucas1p1G;
        Tue,  9 Oct 2018 15:38:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DF.EA.04294.68BCCBB5; Tue,  9
        Oct 2018 16:38:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181009153845eucas1p2875e0bc30471919adc89f63e57a8d7f2~b_t016W_j0771107711eucas1p2k;
        Tue,  9 Oct 2018 15:38:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181009153845eusmtrp2a9a7ac6d6ecb2bbf2282dc0f0bd00441~b_t0kqsuv0179201792eusmtrp2c;
        Tue,  9 Oct 2018 15:38:45 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-56-5bbccb86c70e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4A.14.04128.58BCCBB5; Tue,  9
        Oct 2018 16:38:45 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181009153845eusmtip2b99d6f5f4485a7d4e18f3e33dbbe5027~b_t0N7jyk1377013770eusmtip2S;
        Tue,  9 Oct 2018 15:38:44 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     l.luba@partner.samsung.com, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk
Subject: [PATCH] config: arm: ezx: remove PROVE_LOCKING from defconfig
Date:   Tue,  9 Oct 2018 17:38:37 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7djP87ptp/dEG5xv47PYOGM9q8WtBhmL
        TY+vsVpc3jWHzeLQ1L2MDqwel69dZPbYvKTe4+C7PUwefVtWMXp83iQXwBrFZZOSmpNZllqk
        b5fAlXF633zGgkWcFWd+T2NrYHzE3sXIySEhYCLR+X0/WxcjF4eQwApGiRt7GxlBEkICXxgl
        3j7whkh8ZpSY+mofI0zHzvWfGSESyxklTp54wQrhAHUc+HCNuYuRg4NNQE9ix6pCkAYRATeJ
        G40dTCA2s0CgxJIz+8EGCQPFt+w+xgJiswioSrzd9oUFYoGcxM1zncwgMyUEjrBJzN7VxgqS
        4BUok1j+fxPUFS4ST3e0Q9nCEq+Ob4H6R0bi/875TBB2scTZjlVsEHaNRPvJHVA11hKHj19k
        BbmTWUBTYv0ufYiwo8TKd2fAzpcQ4JO48VYQ4mQ+iUnbpkOFeSU62oQgqjUktvRcgFokJrF8
        zTSo4R4S7zpuMYKUCwnESnyY6DiBUW4WwqoFjIyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLz
        czcxAqP99L/jX3Yw7vqTdIhRgINRiYd3Rt7uaCHWxLLiytxDjBIczEoivKLbd0UL8aYkVlal
        FuXHF5XmpBYfYpTmYFES5102b2O0kEB6YklqdmpqQWoRTJaJg1OqgXG50uSq3seBE0V1z92P
        uvph8uca5UTLTl2WMyuZr6ldC84IDCtZa2G+kCXRqbNqz1RlTjtehf2Z2zbO28F7rH/Fw4kJ
        3dJ1Nb+OzkpPY9Z1iQv8t+eONWeZrrDjDOuiM7ysuSLzlqSf3SYy95/GqqNppWUiKVdZ56Uf
        f/Usac/EJOXn9dcTo5VYijMSDbWYi4oTAXN8RCHyAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsVy+t/xe7qtp/dEGyz9L2SxccZ6VotbDTIW
        mx5fY7W4vGsOm8WhqXsZHVg9Ll+7yOyxeUm9x8F3e5g8+rasYvT4vEkugDVKz6Yov7QkVSEj
        v7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+P0vvmMBYs4K878nsbW
        wPiIvYuRk0NCwERi5/rPjF2MXBxCAksZJZ7f/cMKkRCTmLRvO1SRsMSfa11sEEWfGCVmPWoD
        KuLgYBPQk9ixqhCkRkTAQ6Lt3z1mEJtZIFhizpdZYHOEBdwktuw+xgJiswioSrzd9gXM5hXw
        lNh1+QkbxHw5iZvnOpknMPIsYGRYxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERhq24793LKD
        setd8CFGAQ5GJR7eGXm7o4VYE8uKK3MPMUpwMCuJ8Ipu3xUtxJuSWFmVWpQfX1Sak1p8iNEU
        aPlEZinR5HxgHOSVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamAs
        sP2mYBYcf+5giwlzcfjG4mnXRNQq7m4USX764nMbo9pSOx592/96N2brs7273JJmtn5eJV/v
        PXu2ILWgvKLZydd049gn8DFOr02cGzLjyU7VVK+o5z+M5X8zOJ+awdtje5S7mfMM6ymFwjfX
        uX/77XvCKbC4rPHsKxvWP3yBsv+67TPvhCqxFGckGmoxFxUnAgAcydUkSwIAAA==
Message-Id: <20181009153845eucas1p2875e0bc30471919adc89f63e57a8d7f2~b_t016W_j0771107711eucas1p2k@eucas1p2.samsung.com>
X-CMS-MailID: 20181009153845eucas1p2875e0bc30471919adc89f63e57a8d7f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009153845eucas1p2875e0bc30471919adc89f63e57a8d7f2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009153845eucas1p2875e0bc30471919adc89f63e57a8d7f2
References: <CGME20181009153845eucas1p2875e0bc30471919adc89f63e57a8d7f2@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PROVE_LOCKING enables LOCKDEP, which causes big overhead on cache and
bus transactions.

On some ARM big.LITTLE architecutres (Exynos 5433) the overhead is really big.
The overhead can be measures using hackbench which will speed up
by x3 times (11sec -> 3.4sec).
When you check transaction on cache or buses, the results are way higher
than normal for the same hackbench test:
L1d cache invalidations: 26mln vs 4mln
L2u cache invalidations: 42mln vs 12mln
bus cyc/access: 30cyc/access vs. 20cyc/access
context switch is x3 times cheaper

Enable this option only when you have some locking issue to investigate.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/ezx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index 484e51f..ddfb44c 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -367,7 +367,6 @@ CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_RT_MUTEXES=y
-CONFIG_PROVE_LOCKING=y
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO_NULL=m
-- 
2.7.4

