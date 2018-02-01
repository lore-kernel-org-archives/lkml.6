Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeBAQrb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:47:31 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39313 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbeBAQr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:47:28 -0500
X-Google-Smtp-Source: AH8x227JuBindemuxk+q75yuyGXGrsmZIlQDHdo5Uch6g1Je0WvrCxX93JEpLkVDdR44OIy8A8otSw==
From: Mathieu Malaterre <malat@debian.org>
Cc: Mathieu Malaterre <malat@debian.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] driver/rtc: remove a warning during scripts/kernel-doc step
Date: Thu,  1 Feb 2018 17:47:14 +0100
Message-Id: <20180201164714.25709-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During compilation using W=1 one would get:

drivers/rtc/systohc.c:11: info: Scanning doc for rtc_set_ntp_time
drivers/rtc/systohc.c:23: warning: bad line:  (

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/rtc/systohc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/systohc.c b/drivers/rtc/systohc.c
index 0c177647ea6c..718293d72426 100644
--- a/drivers/rtc/systohc.c
+++ b/drivers/rtc/systohc.c
@@ -20,7 +20,7 @@
  * cases.
  *
  * -EPROTO is returned if now.tv_nsec is not close enough to *target_nsec.
- (
+ *
  * If temporary failure is indicated the caller should try again 'soon'
  */
 int rtc_set_ntp_time(struct timespec64 now, unsigned long *target_nsec)
-- 
2.11.0
