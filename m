Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275CBC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7D82146D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7D82146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeLGNt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:49:56 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:55939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeLGNt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:49:26 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MFbFW-1ggky21jdW-00HBPo; Fri, 07 Dec 2018 14:49:00 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-sh@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/8] timekeeping: remove unused {read,update}_persistent_clock
Date:   Fri,  7 Dec 2018 14:48:21 +0100
Message-Id: <20181207134824.300024-6-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181207134824.300024-1-arnd@arndb.de>
References: <20181207134824.300024-1-arnd@arndb.de>
X-Provags-ID: V03:K1:OcW1EjK2QvkncvWHyHl+OxmhGy7ZIKUinp3oxKVRHZE3HIC2kDW
 iOCDasX8geUc44bVIaIVlJa7GQIzVPeXjQ/zACjzeVgWT75LzL9QxQzrFYEuy5V4VEP0LjT
 4jDaOZb6zd2Xw7JVbg2BuCIEmiFCUNMtMhXs9qq1ShDabg1TFl83A32PRR/J9iVbEl7Bbf+
 2TybBy312Ym1G1uDYThZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OjdzZaaMYb0=:hhn4tt77z/XwUlvehXYcED
 BQ7aygCmWjIji7cDKTxf6sYxpcjy6Ewxb1rXdkUM8JZcCcdbOp/fY82fN1NMvgXXXRnZ/Ydr3
 eiXvXcecwXh2wLP/Af8CfWbyXi7qN4K19mgLMsamvLcf/V41RNoaLHK3oRpKjPqojAw3XMZzu
 J79lzjLWKn9OehvIjAKcHKvofx4CVoavUbExCCNFj27iaBTeJRXGLb4I6kfuvLmMIK3b3kOZs
 LFBldss6SchWde1IvoH8PTVhbeWZkdXKS31NvRZQMVAbPGjPqF+GDyyxb2woQwGHL0Lh4JDZT
 3Y/PqJT6+s3IpnXI7wAu7sm+xir+mhdBAzVnzpOfbd9lre6F/XDIoAPbyePDOu4E60yeTQPSO
 5gG18xlMWw6Y/4nkaqG724NCZulJfgI3Vt10Fs52m+Jw8dGIibY4KP+KpcDaEeFzogDL1ROkO
 iZTLa1xsYV/W6Z+xPuWQ/6esK0nrlqmCDSteCwlgey8UWOLXEnTmrRa100f17bjNHINb4m4VF
 PHBIRwIBCeFYgdGYgMKwA7b7kQK1uUWBz+MGc6OtvjNEMsVvezimUnQEHIU0ungyZeEfAZPuG
 V9auTF3Vk6qSqUlj/5UGB+hXR6ehvBEiDcfGbBb107fMCfwtAhGKeFgrLiuSTEwJ3VkWx24OR
 aEqSTl+tcZx5c2XA4SeAgVc8ESiW+0fs3IP6ChomTM0gVHSUdkvIr4UXYfTHAIP8WArSaoJMs
 JgyP82vqq3Ymt9L8RtNxHBCbL2yVulTB2zqNxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After arch/sh has removed the last reference to these functions,
we can remove them completely and just rely on the 64-bit time_t
based versions. This cleans up a rather ugly use of __weak
functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/timekeeping32.h |  6 ------
 kernel/time/ntp.c             | 10 +---------
 kernel/time/timekeeping.c     | 12 ++----------
 3 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
index a502616f7e1c..0036ff314ac5 100644
--- a/include/linux/timekeeping32.h
+++ b/include/linux/timekeeping32.h
@@ -52,10 +52,4 @@ static inline void getboottime(struct timespec *ts)
 	*ts = timespec64_to_timespec(ts64);
 }
 
-/*
- * Persistent clock related interfaces
- */
-extern void read_persistent_clock(struct timespec *ts);
-extern int update_persistent_clock(struct timespec now);
-
 #endif
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index c5e0cba3b39c..e23be418d015 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -555,17 +555,9 @@ static void sync_rtc_clock(void)
 }
 
 #ifdef CONFIG_GENERIC_CMOS_UPDATE
-int __weak update_persistent_clock(struct timespec now)
-{
-	return -ENODEV;
-}
-
 int __weak update_persistent_clock64(struct timespec64 now64)
 {
-	struct timespec now;
-
-	now = timespec64_to_timespec(now64);
-	return update_persistent_clock(now);
+	return -ENODEV;
 }
 #endif
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 2d110c948805..eb09be4871b3 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1467,7 +1467,7 @@ u64 timekeeping_max_deferment(void)
 }
 
 /**
- * read_persistent_clock -  Return time from the persistent clock.
+ * read_persistent_clock64 -  Return time from the persistent clock.
  *
  * Weak dummy function for arches that do not yet support it.
  * Reads the time from the battery backed persistent clock.
@@ -1475,20 +1475,12 @@ u64 timekeeping_max_deferment(void)
  *
  *  XXX - Do be sure to remove it once all arches implement it.
  */
-void __weak read_persistent_clock(struct timespec *ts)
+void __weak read_persistent_clock64(struct timespec64 *ts)
 {
 	ts->tv_sec = 0;
 	ts->tv_nsec = 0;
 }
 
-void __weak read_persistent_clock64(struct timespec64 *ts64)
-{
-	struct timespec ts;
-
-	read_persistent_clock(&ts);
-	*ts64 = timespec_to_timespec64(ts);
-}
-
 /**
  * read_persistent_wall_and_boot_offset - Read persistent clock, and also offset
  *                                        from the boot.
-- 
2.18.0

