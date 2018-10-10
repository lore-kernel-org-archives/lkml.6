Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03DAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EBA2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EBA2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeJKCJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:09:39 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:53143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbeJKCJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:09:39 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MIUU3-1g6jmx0dlH-004Cbx; Wed, 10 Oct 2018 20:45:36 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MIUU3-1g6jmx0dlH-004Cbx; Wed, 10 Oct 2018 20:45:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: sa1100: avoid VLA in sa1100_setup_mtd
Date:   Wed, 10 Oct 2018 20:44:50 +0200
Message-Id: <20181010184533.691620-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:pHuP1hkqhMn8MKatBeMm63W7WEVioT9BzTTRBWh4fdDIu1/1sl3
 0S7NXZ6D7ybiznN6tkwS8FrnE1Q+KEWhDVtTuenuj0pc5cG88o1OYdJcjmzcmlAGK969VQ3
 9LpVBa6Vt88Siot4ABrLhhqoUeC5d9sgImpC7Y9gCcOOLHTzQ031XZWltDTK6H6MI2kn3zm
 3UGiaP5fNE2ML5H38z4Ew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VSaFjMSoa4M=:7C4ybR+/wN58XbM+2Xs8Pa
 gPVBmATlklcrx5ks+mTcK/tIGMY4Ywu9j6xLjaxOqo6tluyYTgStn/OqrJggxIT7cI69EAfxx
 8/NSMZX+idTxT0Hyk9I3iARDK4uo7tk/kLyuDAjsD0iFXbOgnLa5aSl7D1GjSCqyDubPm/lwU
 o6KEy0xniCaG6uB13Vsy2YTxbO1IETANy66M6tEEedjjBo3m+0SpkRde2gC5Rad8hBOlyDnTN
 gBSeR/l5l/3f5UCRNgg/AqJ4OAbMqG9AZERtyMPVi6ExXs7OScfvtaIpWyxIj8W1vfm8UbzMR
 haVy8W257gcQFiETcpaKQAbvtw34yayjiyz3aFpstjirwWuRkg0isqomFRY1bfhdyK7ymmCMU
 7PRokdVNBCltDltAFiBDedVfge6eBDryy1yHWLchQAt1bxE4IbraNRDoIaCqbk39+GN3y5CrI
 CDS3bW6s0h59V0WDiKd0ro7GN2XAhHhHPGlOdRlyyoqK2dsMDpkRZr3Qam/IR9E1+XSv4x7BW
 h5cj3nkCot7+w5DkFtbNPAer/m+egA/mC40nhvOKI9cNkhRPXkZN6f+CHv321jNGr+aFq1aCp
 FiUyjMxspS5P5AAMR/hiVIxhfGj3goG3wvFbuDeIeLQv7k5greH7kPoQtyObeGxijFTzARJ9l
 mkJG9HDZIdzU4N+rN45t+s1wHLINPc4s5W7I0qAJUFB4W1yXSM9obn1XRrNGF53bb9/k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling -Wvla found another variable-length array with randconfig
testing:

drivers/mtd/maps/sa1100-flash.c: In function 'sa1100_setup_mtd':
drivers/mtd/maps/sa1100-flash.c:224:10: error: ISO C90 forbids variable length array 'cdev' [-Werror=vla]

As far as I can tell, there is an upper bound on the number of resources
that can be passed, based on the number of CS lines on the bus.
In practice, all boards we support have either one or two resources,
but using six to be on the safe side has no extra cost.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/maps/sa1100-flash.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
index 784c6e1a0391..234573b401bd 100644
--- a/drivers/mtd/maps/sa1100-flash.c
+++ b/drivers/mtd/maps/sa1100-flash.c
@@ -23,6 +23,8 @@
 #include <asm/sizes.h>
 #include <asm/mach/flash.h>
 
+#define SA1100_NUM_CS 6
+
 struct sa_subdev_info {
 	char name[16];
 	struct map_info map;
@@ -157,7 +159,7 @@ static struct sa_info *sa1100_setup_mtd(struct platform_device *pdev,
 	/*
 	 * Count number of devices.
 	 */
-	for (nr = 0; ; nr++)
+	for (nr = 0; nr < SA1100_NUM_CS; nr++)
 		if (!platform_get_resource(pdev, IORESOURCE_MEM, nr))
 			break;
 
@@ -221,7 +223,7 @@ static struct sa_info *sa1100_setup_mtd(struct platform_device *pdev,
 		info->mtd = info->subdev[0].mtd;
 		ret = 0;
 	} else if (info->num_subdev > 1) {
-		struct mtd_info *cdev[nr];
+		struct mtd_info *cdev[SA1100_NUM_CS];
 		/*
 		 * We detected multiple devices.  Concatenate them together.
 		 */
-- 
2.18.0

