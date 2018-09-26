Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9BDC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E7620676
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E7620676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeIZUfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:35:13 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:60095 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeIZUfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:35:13 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mt7st-1fl2IA2oCf-00tUey; Wed, 26 Sep 2018 16:20:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Wolfram Sang <wsa@the-dreams.de>, Suman Anna <s-anna@ti.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ARM: omap1: add nand_chip declaration
Date:   Wed, 26 Sep 2018 16:20:16 +0200
Message-Id: <20180926142029.619397-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:+2aEDEHPhuPtkatMxBfGCkomV23AdYrmV8miquPBds4A+qZuiJC
 vhNH/rcNJfz5LrBB0Z8e5Z5fLTjmMt3NGjxsAv5gl/m7f+/jBO8B9PL/H1bARUou72E2AXz
 D1ojdoavvMK19Qjg6n2NY1JfnMVFG1tGwpar+H8MbvJAo9VT1SRASkcyuuBwDEvyGNUN3Ee
 uzL7YwgacpfyGaCCPkaJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ydeKJruM30k=:ywtJ4AYRcf3ctcX6dMYAsu
 ZaIVNU3UV/V5wc6W38mUpHjfMyW9RhQ0uSAVmIw2qCtzfZ+f9SyFhM6WVGqJqWBMMBM9DXv4U
 60mbSiMxHZPFUs6KKiGQHPQXe8AN9uC8+/lWi78Vn8PxTALdYGwtAWi0OY9mwFQNkHY8QAslb
 uPqWuHbex8m9vjaOdnjWx1k77YrrvOu0USbmrDKDbUNc56ZN7ypj8ftlmp0DKb6oUsQ5m6YJb
 kqD7M7WAZCjlIjk7cgeJASnwt4v85w25+n/ETSFV//Vp/MzI80EW5IK4Dhw6nozhG4uXvvZ7E
 tfwB3U30YQKIo3hyMkct3E+DhYxE9Y5P735OK7oSXGnQD4tqi6n0g/iiuBLHbqX+5HnnewsQX
 hYdo7y0c+G8pvQwz3OZwTd24h0+fmcR1OHSED8s44h2L2SCcl4+1b0vn9VierOlzbxn1a2T2n
 DZ3DFMX2NrWfmFxC3M4vnfVhmrPPJIVRjfXPbv2o51Qdq362vUIOg2p21PImCeegSKUiwsMv9
 VthVnRJYiV3sXBQLTjpxzpooatoS2wijXzOp+kEtJtvjD0E04pIOuhrCT/hzQgZBH56bhXcCU
 rV6SEkMpoe9kdcKM3Wpyjzm0F26hahSbyXqVkIC3KTnWqxSfMNMbPRwf//fYlU3dJkY9fVTgO
 6Li8LcuBOsIQqIDmqwO44UFpiTslOJ5lhb92Xn140LEahWkcwVYb/1ht0juzari9pg6c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent MTD changes caused a minor build regression on OMAP1:

In file included from arch/arm/mach-omap1/devices.c:31:
arch/arm/mach-omap1/common.h:85:39: error: 'struct nand_chip' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]

Fixes: 1002aed789bc ("mtd: rawnand: plat_nand: Pass a nand_chip object to all platform_nand_ctrl hooks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
v2: remove unused linux/mtd/mtd.h inclusion
---
 arch/arm/mach-omap1/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index 11b87a4c84d4..504b959ba5cf 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -26,7 +26,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP1_COMMON_H
 #define __ARCH_ARM_MACH_OMAP1_COMMON_H
 
-#include <linux/mtd/mtd.h>
 #include <linux/platform_data/i2c-omap.h>
 #include <linux/reboot.h>
 
@@ -82,6 +81,7 @@ void omap1_restart(enum reboot_mode, const char *);
 
 extern void __init omap_check_revision(void);
 
+struct nand_chip;
 extern void omap1_nand_cmd_ctl(struct nand_chip *this, int cmd,
 			       unsigned int ctrl);
 
-- 
2.18.0

