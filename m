Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781EDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AC020675
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfAHU0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:26:17 -0500
Received: from srv2.anyservers.com ([77.79.239.202]:48363 "EHLO
        srv2.anyservers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfAHU0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:26:17 -0500
X-Greylist: delayed 1424 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2019 15:26:16 EST
Received: from apn-46-169-43-203.dynamic.gprs.plus.pl ([46.169.43.203]:41994 helo=milkyway.galaxy)
        by srv2.anyservers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <amade@asmblr.net>)
        id 1ggxa0-00BU5p-Ad; Tue, 08 Jan 2019 21:02:28 +0100
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>
To:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
Cc:     =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>
Subject: [PATCH] ALSA: usb-audio: fix CM6206 register definitions
Date:   Tue,  8 Jan 2019 21:03:11 +0100
Message-Id: <20190108200311.4969-1-amade@asmblr.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv2.anyservers.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - asmblr.net
X-Get-Message-Sender-Via: srv2.anyservers.com: authenticated_id: amade@asmblr.net
X-Authenticated-Sender: srv2.anyservers.com: amade@asmblr.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix typo after a recent commit causing headphones to have no sound

Fixes: ad43d528a7ac (ALSA: usb-audio: Define registers for CM6206)
Signed-off-by: Amadeusz Sławiński <amade@asmblr.net>
---
 sound/usb/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 96340f23f86d..ebbadb3a7094 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -768,7 +768,7 @@ static int snd_usb_cm6206_boot_quirk(struct usb_device *dev)
 		 * REG1: PLL binary search enable, soft mute enable.
 		 */
 		CM6206_REG1_PLLBIN_EN |
-		CM6206_REG1_SOFT_MUTE_EN |
+		CM6206_REG1_SOFT_MUTE_EN,
 		/*
 		 * REG2: enable output drivers,
 		 * select front channels to the headphone output,
-- 
2.20.1

