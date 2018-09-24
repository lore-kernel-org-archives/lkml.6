Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896E2C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425CA20989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCFI7gl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425CA20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeIYFjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:39:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52976 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeIYFjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:39:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id l7-v6so6614908wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 16:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8i4uKV5XaHAEjVazlfVR+fRPrWqLxr5v70/JSIs4Vgw=;
        b=sCFI7gl+T1qJ8dsDGe7QGZY9kPf9QApbGzHzUH5hzsqVkQ9QM0ttXICJz2Msg7WTq3
         G9Giz7za7UkRmX7QNludzXvbpou9cibZGYyGwtdrFMIZ3vthKaQZEugEFKBwmo2j2mG5
         WDx8ASZVe1g5/mVEqLq2+t/5Jz/0kaXEbue2Io0ESQzXTo/aWD6/A6ZBdtqtj3vo6ZHA
         ibqZ/hDv99mUqD7wsFeVYzCgvLuv4uEbbVVr5ufEyRZnnXImGDS39nM46qo0UHTCzBh9
         mXG6Hzm7aNNnAhK7027bW2vmirQbhdjUv2xYnLCMXGC8627SI7hlnjVu3jsWETtE+jSt
         wjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8i4uKV5XaHAEjVazlfVR+fRPrWqLxr5v70/JSIs4Vgw=;
        b=VPsI6z7EfppgisiCO6XxKLRDU2MSY0q8ZyW474IiuDnIY/cXaMWcB8/bgRj7NXaX0h
         yv9QkWbvWj98IHqfi6f5OHTzPPNR0rucxssRQRPekr9V3iP5RwmjA7ROQP+d0mW80Z3S
         Wje+9EaHbSPCrvMe54Aj3ejahLJOakUCcbGFFZzL2tvD+S5fQR1FnD/x6LXhdL2peE9k
         4t+AzhbQWNP8x/O6CKiLI0jbNGc8xrWFCf7tfh6uQHeSrgZjtH+aZIDF31QqdDZPlCUA
         XdPC1vi8UqHjt5dqioSFV0U2L8pL0n7woShu0zGrAd0TDKhEuFD6SZvt1SyY1gW/wz+l
         zDrQ==
X-Gm-Message-State: ABuFfoiJ7aoCmiONY04bh3qfexP46ijLNiPVaeoXtdA5zX57XD3YiI5B
        vKfK4EsUB+Ff8HD0eXyrIL4=
X-Google-Smtp-Source: ACcGV62jrB03Qo5pPgXuBmakmwJNfNK+hBq1Nk/fPOUstvcYGxAuYp5VHUCGPZbFCYRpi1W6gDyVYg==
X-Received: by 2002:a1c:7dce:: with SMTP id y197-v6mr356934wmc.78.1537832069778;
        Mon, 24 Sep 2018 16:34:29 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:c])
        by smtp.gmail.com with ESMTPSA id l12-v6sm467783wrv.29.2018.09.24.16.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 16:34:28 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
To:     Scott Branden <scott.branden@broadcom.com>
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
Subject: [PATCH v2] staging: vc04_services: Update TODO re: arm64
Date:   Tue, 25 Sep 2018 00:34:26 +0100
Message-Id: <20180924233426.32609-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924224835.32539-1-qader.aymen@gmail.com>
References: <20180924224835.32539-1-qader.aymen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the TODO item to remove manual cache flushing from bulk_receive.
This was previously done in this commit:

(7e8dbdea) staging: bcm2835-camera: Remove explicit cache flush
operations

Also remove the unnecessary asm/cacheflush.h header.

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
v2: Make commit message clearer

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

