Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1855CC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23542086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23542086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeIHTRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:17:53 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:53125 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeIHTRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:17:53 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MdNse-1fPJWa0qJM-00ZMfa; Sat, 08 Sep 2018 16:31:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] compat_ioctl: remove PCI ioctl translation
Date:   Sat,  8 Sep 2018 16:28:14 +0200
Message-Id: <20180908142837.2819693-8-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908142837.2819693-1-arnd@arndb.de>
References: <20180908142837.2819693-1-arnd@arndb.de>
X-Provags-ID: V03:K1:5i0atZbPU/6NU8g3lethk2tgTnaPSx3cL96LTyt/iN9OTM4WgXC
 67Zz3stSmOARnU8rh1TnOzrc0bhhhVx4WUU8a2z0BXswwQmgqStzU0W4rG4qkbejKns8HdE
 qG2aByc4kotLE79J2Q1ELscEyCzqFQyQNCyFfJx2rdVZpC0w1InNg8r5smujCUqxnhK0dij
 4qvOmSKwvaXXAwTO4RFrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B+APLvWVNGg=:9uBcQdvy1Q/zEmVZ5M8znf
 wfwaJlo15jDnM589Yagx84SpsWTIZzjneA0fVQOfkg3pxO2JGLBliym0DhC24c+MqADOcPtb0
 p/awAWYA9wi7Ou+XvYE3PPPm2S6ykgTVmQu93hPWN+1Y7PpWjh/g6yKfOnkIMxNHlsG0xL8vQ
 CTl8/wYz+3LgeviRg8AWmyW9dlq23aom/bu7iL4UiI6tQ2rcRahm58508hSCE93ZeaD1LG/W/
 nOFA2k9tCca8Mxzfdz4e9tAIjN9QzyZIzgU9Djzs/klYu3M1i5wxfZxDys5yc3cSC8eOKQyV8
 lcB9cJYDsB/b6EbwsY6HVUZrTxv97i7W3rMWok1MfYiUkHySWkb6N+sJqJNXdHPiuIwK5RNX/
 6ll2jx8Ftgy5Yy3n8NKFgvbwK78/m/BQBwusKB/0frBqzNrq1CGb+MLgID8/BPTE9he3YQJ08
 AH5l2s7816QY/Z/DwYiJzGf+llDCFcBl7po2kH/Zc33yMrxJ9/3cHc8eKPzPcuG8me10fIAqt
 uWR1bebRHMmvwcKInNovYgve87ZhJ5fnEm269rxHDynBs22HQrxfAIi4wC6he5TMjwHp004Qc
 KZ9I/dzLxExdKhDjyoaiev/EZbyI8cxvJR9mgQVJ0A64JnTDC2iPSaXcFXrLHUqMYQ+r8AVM1
 ouz/k1v05oTI52hnmCy72GQw1vyTVHFtyRfh2zjEKqYfTOQFuq8JGYgrUgjfcPPUySE0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /proc/pci/ implementation already handles these just fine, so
the entries in the table are not needed any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 23c0406d8b30..28ebff2d1799 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -44,7 +44,6 @@
 #include <linux/raw.h>
 #include <linux/blkdev.h>
 #include <linux/elevator.h>
-#include <linux/pci.h>
 #include <linux/serial.h>
 #include <linux/if_tun.h>
 #include <linux/ctype.h>
@@ -640,10 +639,6 @@ COMPATIBLE_IOCTL(HIDPGETCONNINFO)
 /* Misc. */
 COMPATIBLE_IOCTL(0x41545900)		/* ATYIO_CLKR */
 COMPATIBLE_IOCTL(0x41545901)		/* ATYIO_CLKW */
-COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
-COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
-COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
-COMPATIBLE_IOCTL(PCIIOC_WRITE_COMBINE)
 #ifdef TIOCGLTC
 COMPATIBLE_IOCTL(TIOCGLTC)
 COMPATIBLE_IOCTL(TIOCSLTC)
-- 
2.18.0

