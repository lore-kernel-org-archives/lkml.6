Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6306BC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2779B20645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2779B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeIDUYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:24:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:50960 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727783AbeIDUYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BAF76B0B2;
        Tue,  4 Sep 2018 15:59:02 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/29] staging: bcm2835-audio: Remove unnecessary header file includes
Date:   Tue,  4 Sep 2018 17:58:52 +0200
Message-Id: <20180904155858.8001-24-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yet a few header files are included unnecessarily.  Drop them.

Also remove trivial comments.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../bcm2835-audio/bcm2835-vchiq.c             | 19 -------------------
 .../vc04_services/bcm2835-audio/bcm2835.h     |  6 ------
 2 files changed, 25 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 7fff5c63e33f..1d756f467eb8 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -1,31 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2011 Broadcom Corporation.  All rights reserved. */
 
-#include <linux/device.h>
-#include <sound/core.h>
-#include <sound/initval.h>
-#include <sound/pcm.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-#include <linux/mm.h>
-#include <linux/syscalls.h>
-#include <linux/uaccess.h>
 #include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/atomic.h>
 #include <linux/module.h>
 #include <linux/completion.h>
-
 #include "bcm2835.h"
-
-/* ---- Include Files -------------------------------------------------------- */
-
 #include "vc_vchi_audioserv_defs.h"
 
-/* ---- Private Constants and Types ------------------------------------------ */
-
 struct bcm2835_audio_instance {
 	struct device *dev;
 	VCHI_SERVICE_HANDLE_T vchi_handle;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 319c3e5dfbe4..4e41069dc22a 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -5,16 +5,10 @@
 #define __SOUND_ARM_BCM2835_H
 
 #include <linux/device.h>
-#include <linux/list.h>
-#include <linux/interrupt.h>
 #include <linux/wait.h>
 #include <sound/core.h>
-#include <sound/initval.h>
 #include <sound/pcm.h>
-#include <sound/pcm_params.h>
 #include <sound/pcm-indirect.h>
-#include <linux/workqueue.h>
-
 #include "interface/vchi/vchi.h"
 
 #define MAX_SUBSTREAMS   (8)
-- 
2.18.0

