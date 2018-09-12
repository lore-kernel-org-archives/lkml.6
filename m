Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C93C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CCF20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CCF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeILUUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:20:54 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:32889 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeILUUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:20:54 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MgNlH-1fLpVU11RP-00hsbB; Wed, 12 Sep 2018 17:15:55 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/17] compat_ioctl: remove /dev/raw ioctl translation
Date:   Wed, 12 Sep 2018 17:13:08 +0200
Message-Id: <20180912151422.571531-7-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912151422.571531-1-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151422.571531-1-arnd@arndb.de>
X-Provags-ID: V03:K1:biePc2ACx7bwrpc7sls9V7X4YqnMWv0qCNnd8+u5xLT+XAECBkK
 ZFYXrb7jRSNkSkjJpPRcw3alera/JU/7FeuMNMRNKAIDomey/ioMEf1CAsl7lnBiaOH3sXZ
 A10+I0P6xDPLZqnG5Y5H6lTcwTjwZLVyb8roHQ2FwM7+eGic2Lw8Go2mGkpKtEvWgN1dwTZ
 KPJ5XcVRyT6gZV4r/bntQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kPHCRZJg7MI=:Wz0bgwxd92ONpCXC12X0Be
 /uyoS4PyStatIt1hdfIBOzi3Lc51LJEEMlLw/Uk10Xxjx4xXVweA98yC4PUvqvQSSMrSrSiUe
 TfjobK4Swyv3+x/7Ox6lSy8/I9MJ7Bm3K4IdotSndriCsNNb3QaoeUCX8d4GYUxHwfTStPqIP
 Ea+bBMmk+fQ4UKK4H/M8/gDUiSP5aeKGziewT8UGhSgprfKK/R3jjwwrktSPf5yvlUY4sqqo+
 FiXHzmIQoyvqAkcu0qaoXu1U5xtkch/ijHs9BfNn9fKOCVjkqtlkyMGOe0hqLJs7PeNmW3CIf
 smBUv5uxh+sPpVEmB5BJVDAZIp1FstEyuVo4qR/gbRMTNmrwuEIHBMxq3YOzafFeMwsAAvF7S
 +CfBKpqErb1TYxia88KmYOot6KBp1hG9hEbK79ORsYAv8TetGqZLfC2qMdUgsqwlNyWnblGy3
 AS7forVMQx+kW+WZTboRfEiz+X2Nv5klkECDGElEFnf485mASfUxBkMLOVhvaNXdV9NstjWJ7
 hfZGXZQ51j6JmxaHizLRPH2YQ0NMHP4yIJU5YBLENFYMO3a29f12CBAVFvbyJG47PnaGbN2t8
 OhrEivXrUzwfZk+u10sTE3EJjr4PxejT4shStVLpxSUZkKxOfgQaFjhB7VA/kdMpP3cepW0/6
 Q8+ExD/ONsXeNN1rl0AcRLU99xT/H+5wr7udJnui5NOvjBw9rjW53c1x7sregMnzpkxY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /dev/rawX implementation already handles these just fine, so
the entries in the table are not needed any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 8510cd652bb0..79ad7c3afd70 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -40,7 +40,6 @@
 #include <linux/fb.h>
 #include <linux/videodev2.h>
 #include <linux/netdevice.h>
-#include <linux/raw.h>
 #include <linux/blkdev.h>
 #include <linux/elevator.h>
 #include <linux/serial.h>
@@ -747,9 +746,6 @@ COMPATIBLE_IOCTL(PPPIOCGL2TPSTATS)
 /* PPPOX */
 COMPATIBLE_IOCTL(PPPOEIOCSFWD)
 COMPATIBLE_IOCTL(PPPOEIOCDFWD)
-/* Raw devices */
-COMPATIBLE_IOCTL(RAW_SETBIND)
-COMPATIBLE_IOCTL(RAW_GETBIND)
 /* Watchdog */
 COMPATIBLE_IOCTL(WDIOC_GETSUPPORT)
 COMPATIBLE_IOCTL(WDIOC_GETSTATUS)
-- 
2.18.0

