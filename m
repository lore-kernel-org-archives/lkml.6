Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1342C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E98F2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E98F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeJKSe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:34:27 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:49351 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeJKSe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:34:27 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N5mWp-1fcus62Hut-017HlG; Thu, 11 Oct 2018 13:06:41 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N5mWp-1fcus62Hut-017HlG; Thu, 11 Oct 2018 13:06:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mtd: docg3: don't set conflicting BCH_CONST_PARAMS option
Date:   Thu, 11 Oct 2018 13:06:16 +0200
Message-Id: <20181011110639.2649053-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:2mIYcrEHCmuG7RUYybIDVljsxrxThacEvRjGsy7C+iWmgYoDRN4
 Fc4JO24me2dWv7uoQV36UloA1IEbTFkC9ECIkizJwsrlM+77GBxLyN3vwgsbnbohoXnrL7I
 goFriQ+tVm/2GnPy0oUyJqz9mfbwTNsgfzbJjD3/dD/+p2DgBuoltBBG0IAMjHUdyBHbFSU
 RlCk5e6M56SragKm5LZjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PK0Z4HPl4ms=:owGKW24RaCPoD8cNnxpm9N
 czitPy4aSY4by8sOQMMThVVpHT6MaBJefjnFHDaV6IeTAyvb6XWLL+rerGokrJNAx6wRNlg8A
 DxH626uMHGsP1Ide88061WPOdTq2hf3R80OQkq7+U1z+mRh2llUWsxUX6Avd7/6G2KWZiW5UU
 y64nt9jUwplrn7DXL1z7Q1KN0ZGSAjg0v+y5bgOXNSCKy92VUEUca0ULMMMneVPnLmA0NP3D6
 S+/rYo4NZ8+XsGtzroVSs/5LSUKqhkBz6893c8TBDs/nV6yn9OiMZ4CnKJW3sz1ii4j5MoFFu
 vfjOaM4iFPTZvIi2E8jIakneiLbU4e4HKB+2aPD8vwRr0el2ytB9dknZS6x9pwqtWrs4mBOcN
 mw922oDf0MaHbixDG1i5tKnuXyVNo/4l+fXwT7m4v+/O1xIBfH0R1494l7dyTFdOEdJtofNiC
 z3j7ofNqxLBxnRE3kafN3QnM/ocIXwhNNsCAreXV4SgZSRnfwR6cXdj9L/0U+my9b12YcVcOq
 ss3W9pNO+byZpNqVtxJwp+eh5D33oPnLtFWIaO0MOkQPvgnbhVNO4QsVoDgpxADgBVp77XNC1
 4IHbwrSgkz7r1ph4VJcDLjjxLNpT+VRRg6McjJOIL4LowO7Q41o+JrOFtWZHoZ77OD95LdunN
 JKQIkqf9qojSmTF0q7lrUhr5fw3IMhNmDGbo0SVgySgwmlF4Y0evGnFqYHHU+S4u834A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed during the creation of another bugfix that the BCH_CONST_PARAMS
option that is set by DOCG3 breaks setting variable parameters for any
other users of the BCH library code.

The only other user we have today is the MTD_NAND software BCH
implementation (most flash controllers use hardware BCH these days
and are not affected). I considered removing BCH_CONST_PARAMS entirely
because of the inherent conflict, but according to the description in
lib/bch.c there is a significant performance benefit in keeping it.

To avoid the immediate problem of the conflict between MTD_NAND_BCH
and DOCG3, this only sets the constant parameters if MTD_NAND_BCH
is disabled, which should fix the problem for all cases that
are affected. This should also work for all stable kernels.

Note that there is only one machine that actually seems to use the
DOCG3 driver (arch/arm/mach-pxa/mioa701.c), so most users should have
the driver disabled, but it almost certainly shows up if we wanted
to test random kernels on machines that use software BCH in MTD.

Fixes: d13d19ece39f ("mtd: docg3: add ECC correction code")
Cc: stable@vger.kernel.org
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/devices/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index e514d57a0419..aa983422aa97 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -207,7 +207,7 @@ comment "Disk-On-Chip Device Drivers"
 config MTD_DOCG3
 	tristate "M-Systems Disk-On-Chip G3"
 	select BCH
-	select BCH_CONST_PARAMS
+	select BCH_CONST_PARAMS if !MTD_NAND_BCH
 	select BITREVERSE
 	help
 	  This provides an MTD device driver for the M-Systems DiskOnChip
-- 
2.18.0

