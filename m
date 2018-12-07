Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135D1C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D610E20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D610E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeLGNtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:49:55 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:53479 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeLGNt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:49:26 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MNtGq-1goy972j72-00OE8Q; Fri, 07 Dec 2018 14:49:01 +0100
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
Subject: [PATCH 8/8] timekeeping: remove obsolete time accessors
Date:   Fri,  7 Dec 2018 14:48:24 +0100
Message-Id: <20181207134824.300024-9-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181207134824.300024-1-arnd@arndb.de>
References: <20181207134824.300024-1-arnd@arndb.de>
X-Provags-ID: V03:K1:4q8hGpFp0fG5EmYuKhTDqJXQLIB2ZrNwqYnzxKG4qaFm5RvWFyl
 NGBIj/D44nLXSFSYGO9DFv9hUXH+3GzYV2CVw/qHxKSzsZ0vtbf7NEkHbTn42eHwCUDRoPA
 4YOEdqvE3d8qnJGRx7hzTpPuXkp2r8z6hzMMDdC76JOLVZjdMRPa/aNxoFjaYQJPgO6IwVC
 xCVGH01REyEosZhzRplmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eDPw5ra8pQk=:j+wBAUu+B10noLnFh/U+Ez
 wVigcBAnD2/GpGoPJolk4KhTu1dL1TIUiexqQuFS0FTMOodJWIPxmRlqYS9kuAkVJmwzTaUo2
 CnmMMkehrO3asT/lPK7tVNHo9cMeciaHYqLy0WHy2gTyvypXaa0HoUo82Hf7DlhqvSe0AhtPi
 ilVj5ZurhAhSY0dkJroBHR4LHgWppmr5JZORPG19Ud3/O24kmeshUHg9G337GkgdrPrTzBuLI
 uvPYFJXi+dLcDz9VEVZkVu2Rm+VvDsa9H9F07H1+EpDWmOc0odH46irKlu00F+J+kDf857Jem
 Hwh8tzkDoiZpdiz/I+uL5VF2djy0alEtzzlxJiVv9UpFWT00CRO6VaacUXkhshpz07qvc8mqH
 r38Db2iOGJWTXHzWLEAISjQPG3c848sDuTcp+yRCYMZubGHSeQH8jieA0Tb+9SU0sOZ4LKqlc
 B+NL0DLxH/eku6YmfLNXQ00uoxPF9FI1oja+p9XY1CXhjOZo3nqjnktGBxvI7hLB6rFPth904
 isb9B9PofCW2/FuxbY6HO0VrDZztP66k8gakTnOFcKz+0qpUBImMpf9KL7ypDOENUaP6a+Tss
 wGVbniz52ZyEWek5rSxxVum+1GvJ7c381gtXPcUaPEmVov5gr4choYjri7IEzau2DcLksjJch
 n02/tAzGF0BgEBrqxS0G89o1d/TQ+M/8wo1O49sdSiGjbH/uQ+k5MCj8emIGyguRVwIaxE1so
 3U98EbDn6RgRmLp8pHrGuILA5p1RXEvOrGV9Ow==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more remaining users of these deprecated wrappers, so
let's remove them before new users have a chance to make it in.

See Documentation/core-api/timekeeping.rst for replacements when
porting old drivers that contain calls to this function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/timekeeping.h   | 14 --------------
 include/linux/timekeeping32.h |  9 ---------
 2 files changed, 23 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 29975e93fcb8..a8ab0f143ac4 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -262,18 +262,4 @@ void read_persistent_wall_and_boot_offset(struct timespec64 *wall_clock,
 					  struct timespec64 *boot_offset);
 extern int update_persistent_clock64(struct timespec64 now);
 
-/*
- * deprecated aliases, don't use in new code
- */
-#define getnstimeofday64(ts)		ktime_get_real_ts64(ts)
-
-static inline struct timespec64 current_kernel_time64(void)
-{
-	struct timespec64 ts;
-
-	ktime_get_coarse_real_ts64(&ts);
-
-	return ts;
-}
-
 #endif
diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
index 0036ff314ac5..cc59cc9e0e84 100644
--- a/include/linux/timekeeping32.h
+++ b/include/linux/timekeeping32.h
@@ -6,15 +6,6 @@
  * over time so we can remove the file here.
  */
 
-static inline void do_gettimeofday(struct timeval *tv)
-{
-	struct timespec64 now;
-
-	ktime_get_real_ts64(&now);
-	tv->tv_sec = now.tv_sec;
-	tv->tv_usec = now.tv_nsec/1000;
-}
-
 static inline unsigned long get_seconds(void)
 {
 	return ktime_get_real_seconds();
-- 
2.18.0

