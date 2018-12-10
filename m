Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DEFC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAA32084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAA32084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbeLJVks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:40:48 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:40459 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeLJVks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:40:48 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MKt3r-1gkxju2shR-00LBkS; Mon, 10 Dec 2018 22:40:39 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] staging: rtl8723bs: remove semaphore remnants
Date:   Mon, 10 Dec 2018 22:40:32 +0100
Message-Id: <20181210214032.1441224-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181210214032.1441224-1-arnd@arndb.de>
References: <20181210214032.1441224-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UIWJreOK1DoDOD+HihI3f0vtdhFbCYFZJ4q6s5/HZGs0VyhXOg9
 3DrLSI6S6dV8t0UzJg5i11Cw9IymXEVLzrcCjTBAufK1SvWGUYBpevx78jxbpULuvtZSJGn
 Up6ZlPf/k2CMgVemonZTUnz0R05mj7Tivz7BrfuYi/CxTzS/ygj6XgGNBPiC59l/9G49Ee9
 xNF9XKFRr2/AXvNQanpaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mThaKqYdTIY=:7vcTxszwHksxVdQ0ydQ3qZ
 qmgo7dTQG+kGnPApNf3PB9xs/rrZ+rgM8/+o9iV2Em7gB3LMzxUy2ZtN3MRWys4htioSdgCB5
 TS39eKWyrrPmS62IpPgFlpoUmmQ/2dH+HmsVjTk6E0Jy8qfghJtEa7UDtlJ/Q1jhbNJeQUJ2G
 E5jppVR0rUVk5DFK9W93NpG7WEq9LecYpuUe7lp+OTIQrR6w/E4mWmkXnBbhiPyBOuC8vX6VK
 L9jJSpUiglzRkpNFJGmp0d221YsW1USW1RDC5clcNjDcan66IVjlnZj7Rq02HhD0TCF8EMmNJ
 dKb3B0pntqbj56fcJZbGgvjxHSWdX29hxOa+/4/uYhqwmpXjNqEvdGnEkCXj8AOPusyGmYQdX
 T2MxdOOx1xkMSJWhyXcgNxpw8dPx5VWf7l5qRULC/yDRRN0tgPJo4Ms8e8pwco6nymEysxTjC
 In9jMgvwxEemnqDDEiH9kRvrKSX0tdcQbxZJdDQ1lGTWe7sWotD66CNMGIcsITbiz1sIlZpbM
 mATxq/s6LksHH8WnjAOfy1MrBFkxsA7RC35K5XIVKSWHGdCB+UVYssHq8bhDsBkPndnMDlhyb
 nqnuEH7IfK4YgHKo0mMLVB41f66OxGWOneIDrkdxIkrHNGCzZFbxfMcYcra+BVeqCjLYfQq22
 SYlAzhQFcDvWhbn5W9WZCJJBXG9ytBAKJ70t8r5KYW3P1kq5datz1llo31Rz7YUWYBiXMlCOS
 DqWSSGFR5z4NQLtDqpXHVWI9U6jeuqPTQQUjoA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing uses the semaphores any more in this driver, so remove
all references to that type.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c            | 1 -
 drivers/staging/rtl8723bs/include/osdep_service_linux.h | 2 --
 drivers/staging/rtl8723bs/include/rtw_io.h              | 1 -
 drivers/staging/rtl8723bs/include/rtw_mp.h              | 1 -
 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h         | 5 -----
 5 files changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index b7dd5fec9b31..eb27522a5444 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -1126,7 +1126,6 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 	struct pwrctrl_priv *pwrctrlpriv = adapter_to_pwrctl(padapter);
 
 	mutex_init(&pwrctrlpriv->lock);
-	sema_init(&pwrctrlpriv->check_32k_lock, 1);
 	pwrctrlpriv->rf_pwrstate = rf_on;
 	pwrctrlpriv->ips_enter_cnts = 0;
 	pwrctrlpriv->ips_leave_cnts = 0;
diff --git a/drivers/staging/rtl8723bs/include/osdep_service_linux.h b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
index 58d1e1019241..2f1b51e614fb 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service_linux.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
@@ -22,7 +22,6 @@
 	#include <asm/byteorder.h>
 	#include <linux/atomic.h>
 	#include <linux/io.h>
-	#include <linux/semaphore.h>
 	#include <linux/sem.h>
 	#include <linux/sched.h>
 	#include <linux/etherdevice.h>
@@ -41,7 +40,6 @@
         #include <net/ieee80211_radiotap.h>
 	#include <net/cfg80211.h>
 
-	typedef struct	semaphore _sema;
 	typedef	spinlock_t	_lock;
 	typedef struct mutex		_mutex;
 	typedef struct timer_list _timer;
diff --git a/drivers/staging/rtl8723bs/include/rtw_io.h b/drivers/staging/rtl8723bs/include/rtw_io.h
index 4f8be55da65d..99d104b3647a 100644
--- a/drivers/staging/rtl8723bs/include/rtw_io.h
+++ b/drivers/staging/rtl8723bs/include/rtw_io.h
@@ -115,7 +115,6 @@ struct io_req {
 	u32 command;
 	u32 status;
 	u8 *pbuf;
-	_sema	sema;
 
 	void (*_async_io_callback)(struct adapter *padater, struct io_req *pio_req, u8 *cnxt);
 	u8 *cnxt;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mp.h b/drivers/staging/rtl8723bs/include/rtw_mp.h
index 839084733201..bb3970d58573 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mp.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mp.h
@@ -62,7 +62,6 @@ typedef struct _MPT_CONTEXT
 	/*  Indicate if the driver is unloading or unloaded. */
 	bool			bMptDrvUnload;
 
-	_sema			MPh2c_Sema;
 	_timer			MPh2c_timeout_timer;
 /*  Event used to sync H2c for BT control */
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
index abf48ae01900..e2a4c680125f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
@@ -94,10 +94,6 @@ struct reportpwrstate_parm {
 	unsigned short rsvd;
 };
 
-
-typedef _sema _pwrlock;
-
-
 #define LPS_DELAY_TIME	1*HZ /*  1 sec */
 
 #define EXE_PWR_NONE	0x01
@@ -209,7 +205,6 @@ typedef struct pno_scan_info
 struct pwrctrl_priv
 {
 	struct mutex lock;
-	_pwrlock	check_32k_lock;
 	volatile u8 rpwm; /*  requested power state for fw */
 	volatile u8 cpwm; /*  fw current power state. updated when 1. read from HCPWM 2. driver lowers power level */
 	volatile u8 tog; /*  toggling */
-- 
2.20.0

