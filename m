Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AF2C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FE220843
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUZTEV8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FE220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeIYExc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:53:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45634 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbeIYExc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:53:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id m16so4815138wrx.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 15:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xlPS3jvGGNsddE6F+jXFhI8iiomJak5fnBdTPWjKO48=;
        b=tUZTEV8+zCD3ZlWa0E75WrVhtpLa5ndsDKUUnwy3IU0IueJjtGxaO1P5QmFgB3jCKM
         xI2Qm0MXm349s08yvFHTIFZUmHFzkesxdhN3Xf8aMabi5e65gdE/RXquCMndXk9gVAZg
         rEFrFEsmU87w3zGXRv5SQ0jRBeookLFyKZC2W/P6tYcbYAYxKbeUHe8rsFzY0X0n5eLE
         rBYr/ul76VSNJKOdCh2uLL9V+6NfPb4wDdqdBJ3AF3iz137B6Qd4Rmh3IHHb1JfYYNuP
         6wU+iiaJSBPE85urGOxPmQ90kk1uYXmChIv1jJzKcMXruqowTTlF76hrrSuKpq2kdYMD
         fT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xlPS3jvGGNsddE6F+jXFhI8iiomJak5fnBdTPWjKO48=;
        b=XAEUyEn+wYRAJTLN62NyORt8KFT0vOwl9Dt0teKXYSHQrhN73921NSBCAdFa3mdFgA
         2XRuRDeeDaj8mm/7cguE7nrQQ/caQX94hGYR4ut00QTRgixOnC3c0knJk+kVAwTOxUXY
         kKw1bWiy8GfyImUkEG+ReblS1A3eRNAN3w9WvUEXfe4n9nz1uPmXPCNZ8Dmv3psCHGrY
         M74wc+272NbwxXSMHBGVtwebfZ7Y90i8mp26t0wEr8Py5Z79nnL4PajPjG2IBTccWg/T
         11CSARUXgrVvK/YPBhcL0lkrotaoVasLzfon9+uX5q5uQWN1kQZi/REDqWTkiNtYE7tM
         exjQ==
X-Gm-Message-State: ABuFfognw/Xia+kg1A7kV8e4hmUhxNn/DQiomOsefh4nks/EsK+B4CZ2
        uNd79WfBAREossos+sFcRWk=
X-Google-Smtp-Source: ACcGV62ro8KrIgPUZ8jCvAw033To/zXhi3rZHeJ0rlKTlw4BytHTYJ71HkCQqNeqjUvSWn6IXRak0Q==
X-Received: by 2002:adf:91a4:: with SMTP id 33-v6mr602173wri.37.1537829341216;
        Mon, 24 Sep 2018 15:49:01 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:c])
        by smtp.gmail.com with ESMTPSA id 14-v6sm521230wmp.32.2018.09.24.15.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 15:49:00 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vc04_services: Update TODO re: arm64
Date:   Mon, 24 Sep 2018 23:48:35 +0100
Message-Id: <20180924224835.32539-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the TODO item to remove manual cache flushing from b
ulk_receieve - this was done in 7e8dbea. Also remove the unnecessary
asm/cacheflush.h header.

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/TODO         | 6 ------
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/TODO b/drivers/staging/vc04_services/bcm2835-camera/TODO
index cefce72d814f..6c2b4ffe4996 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/TODO
+++ b/drivers/staging/vc04_services/bcm2835-camera/TODO
@@ -15,9 +15,3 @@ padding in the V4L2 spec, but that padding doesn't match what the
 hardware can do.  If we exposed the native padding requirements
 through the V4L2 "multiplanar" formats, the firmware would have one
 less copy it needed to do.
-
-3) Port to ARM64
-
-The bulk_receive() does some manual cache flushing that are 32-bit ARM
-only, which we should convert to proper cross-platform APIs.
-
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index 51e5b04ff0f5..6e5c1d4ee122 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/vmalloc.h>
-#include <asm/cacheflush.h>
 #include <media/videobuf2-vmalloc.h>
 
 #include "mmal-common.h"
-- 
2.17.1

