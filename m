Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FF3C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C785820811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C785820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeLLSye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:54:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:46554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726440AbeLLSyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:54:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC0A8AF88;
        Wed, 12 Dec 2018 18:54:29 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, stefan.wahren@i2se.com, eric@anholt.net,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH 3/3] staging: vchiq: delete vchiq_killable.h
Date:   Wed, 12 Dec 2018 19:51:35 +0100
Message-Id: <20181212185136.6620-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212185136.6620-1-nsaenzjulienne@suse.de>
References: <20181212185136.6620-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users for that header file.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_2835_arm.c      |  1 -
 .../interface/vchiq_arm/vchiq_arm.c           |  1 -
 .../interface/vchiq_arm/vchiq_connected.c     |  1 -
 .../interface/vchiq_arm/vchiq_core.c          |  1 -
 .../interface/vchiq_arm/vchiq_killable.h      | 55 -------------------
 .../interface/vchiq_arm/vchiq_util.c          |  1 -
 6 files changed, 60 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_killable.h

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 691038cdfdab..66fbb9ff551a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -48,7 +48,6 @@
 
 #include "vchiq_arm.h"
 #include "vchiq_connected.h"
-#include "vchiq_killable.h"
 #include "vchiq_pagelist.h"
 
 #define MAX_FRAGMENTS (VCHIQ_NUM_CURRENT_BULKS * 2)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 227c208dd122..acc7b07c7291 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -55,7 +55,6 @@
 #include "vchiq_ioctl.h"
 #include "vchiq_arm.h"
 #include "vchiq_debugfs.h"
-#include "vchiq_killable.h"
 
 #define DEVICE_NAME "vchiq"
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
index 7ea29665bd0c..7d64e2ed7b42 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
@@ -33,7 +33,6 @@
 
 #include "vchiq_connected.h"
 #include "vchiq_core.h"
-#include "vchiq_killable.h"
 #include <linux/module.h>
 #include <linux/mutex.h>
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index afe2aa5ac3e9..31e69b445b4c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -32,7 +32,6 @@
  */
 
 #include "vchiq_core.h"
-#include "vchiq_killable.h"
 
 #define VCHIQ_SLOT_HANDLER_STACK 8192
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_killable.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_killable.h
deleted file mode 100644
index 778063ba312a..000000000000
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_killable.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/**
- * Copyright (c) 2010-2012 Broadcom. All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The names of the above-listed copyright holders may not be used
- *    to endorse or promote products derived from this software without
- *    specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2, as published by the Free
- * Software Foundation.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
- * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
- * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
- * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
- * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
- * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
- * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
- * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#ifndef VCHIQ_KILLABLE_H
-#define VCHIQ_KILLABLE_H
-
-#include <linux/mutex.h>
-#include <linux/semaphore.h>
-
-#define SHUTDOWN_SIGS   (sigmask(SIGKILL) | sigmask(SIGINT) | sigmask(SIGQUIT) | sigmask(SIGTRAP) | sigmask(SIGSTOP) | sigmask(SIGCONT))
-
-static inline int __must_check down_interruptible_killable(struct semaphore *sem)
-{
-	/* Allow interception of killable signals only. We don't want to be interrupted by harmless signals like SIGALRM */
-	int ret;
-	sigset_t blocked, oldset;
-	siginitsetinv(&blocked, SHUTDOWN_SIGS);
-	sigprocmask(SIG_SETMASK, &blocked, &oldset);
-	ret = down_interruptible(sem);
-	sigprocmask(SIG_SETMASK, &oldset, NULL);
-	return ret;
-}
-#define down_interruptible down_interruptible_killable
-
-#endif
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
index 42e10d7d97a4..248a3170b42c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
@@ -32,7 +32,6 @@
  */
 
 #include "vchiq_util.h"
-#include "vchiq_killable.h"
 
 static inline int is_pow2(int i)
 {
-- 
2.19.2

