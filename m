Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C8FECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFD12086E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFD12086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeJRC70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:59:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:42550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728330AbeJRC70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:59:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A33C3B08C;
        Wed, 17 Oct 2018 19:02:21 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     eric@anholt.net, stefan.wahren@i2se.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, nsaenzjulienne@suse.de, devel@driverdev.osuosl.org
Subject: [PATCH v2 7/7] staging: bcm2835-audio: update TODO
Date:   Wed, 17 Oct 2018 21:01:56 +0200
Message-Id: <20181017190156.30010-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017190156.30010-1-nsaenzjulienne@suse.de>
References: <20181017190156.30010-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following tasks were completed or not the right solution:

1/2- Not the proper solution, we should register a platform device in
vchiq the same way it's done with bcm2835-camera as commented here:
https://lkml.org/lkml/2018/10/16/1131

2/3- Fixed by Takashi Iwai here: https://lkml.org/lkml/2018/9/4/587

Also, adds a new task as per mailing list conversation.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/bcm2835-audio/TODO  | 25 +++----------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/TODO b/drivers/staging/vc04_services/bcm2835-audio/TODO
index 73d41fa631ac..cb8ead3e9108 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/TODO
+++ b/drivers/staging/vc04_services/bcm2835-audio/TODO
@@ -4,26 +4,7 @@
 *                                                                           *
 *****************************************************************************
 
+1) Revisit multi-cards options and PCM route mixer control (as per comment
+https://lkml.org/lkml/2018/9/8/200)
 
-1) Document the device tree node
-
-The downstream tree(the tree that the driver was imported from) at
-http://www.github.com/raspberrypi/linux uses this node:
-
-audio: audio {
-	compatible = "brcm,bcm2835-audio";
-	brcm,pwm-channels = <8>;
-};
-
-Since the driver requires the use of VCHIQ, it may be useful to have a link
-in the device tree to the VCHIQ driver.
-
-2) Gracefully handle the case where VCHIQ is missing from the device tree or
-it has not been initialized yet.
-
-3) Review error handling and remove duplicate code.
-
-4) Cleanup the logging mechanism.  The driver should probably be using the
-standard kernel logging mechanisms such as dev_info, dev_dbg, and friends.
-
-5) Fix the remaining checkpatch.pl errors and warnings.
+2) Fix the remaining checkpatch.pl errors and warnings.
-- 
2.19.1

