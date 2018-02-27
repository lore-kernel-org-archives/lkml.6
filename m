Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeB0WGA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:06:00 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34414 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeB0WF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:05:59 -0500
X-Google-Smtp-Source: AG47ELvsDGHlTgSXUrFbOOAjZLdJTk/8Gkbb+p3e0n88vkvubZXhtCDvv038HfpjT1WMjm2Gsm4gRg==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, hernan@vanguardiasur.com.ar
Subject: [PATCH 1/2] IB/qib: Remove unused variable (char *qib_sdma_event_names[])
Date: Tue, 27 Feb 2018 19:05:42 -0300
Message-Id: <1519769143-20000-1-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: This is compile only tested as I have no access to the hw.

This variable was not used anywhere in the code. Removing it saves 88 bytes.

add/remove: 0/1 grow/shrink: 0/0 up/down: 0/-88 (-88)
Function                                     old     new   delta
qib_sdma_event_names                          88       -     -88
Total: Before=2874565, After=2874477, chg -0.00%

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/infiniband/hw/qib/qib.h      |  1 -
 drivers/infiniband/hw/qib/qib_sdma.c | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
index 0235f76b..b709ebd 100644
--- a/drivers/infiniband/hw/qib/qib.h
+++ b/drivers/infiniband/hw/qib/qib.h
@@ -473,7 +473,6 @@ enum qib_sdma_events {
 };
 
 extern char *qib_sdma_state_names[];
-extern char *qib_sdma_event_names[];
 
 struct sdma_set_state_action {
 	unsigned op_enable:1;
diff --git a/drivers/infiniband/hw/qib/qib_sdma.c b/drivers/infiniband/hw/qib/qib_sdma.c
index c3690bd..1f2d7a0 100644
--- a/drivers/infiniband/hw/qib/qib_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_sdma.c
@@ -64,20 +64,6 @@ char *qib_sdma_state_names[] = {
 	[qib_sdma_state_s99_running]          = "s99_Running",
 };
 
-char *qib_sdma_event_names[] = {
-	[qib_sdma_event_e00_go_hw_down]   = "e00_GoHwDown",
-	[qib_sdma_event_e10_go_hw_start]  = "e10_GoHwStart",
-	[qib_sdma_event_e20_hw_started]   = "e20_HwStarted",
-	[qib_sdma_event_e30_go_running]   = "e30_GoRunning",
-	[qib_sdma_event_e40_sw_cleaned]   = "e40_SwCleaned",
-	[qib_sdma_event_e50_hw_cleaned]   = "e50_HwCleaned",
-	[qib_sdma_event_e60_hw_halted]    = "e60_HwHalted",
-	[qib_sdma_event_e70_go_idle]      = "e70_GoIdle",
-	[qib_sdma_event_e7220_err_halted] = "e7220_ErrHalted",
-	[qib_sdma_event_e7322_err_halted] = "e7322_ErrHalted",
-	[qib_sdma_event_e90_timer_tick]   = "e90_TimerTick",
-};
-
 /* declare all statics here rather than keep sorting */
 static int alloc_sdma(struct qib_pportdata *);
 static void sdma_complete(struct kref *);
-- 
2.7.4
