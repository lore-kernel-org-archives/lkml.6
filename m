Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA0AECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADD62086E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADD62086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeJRC7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:59:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:42534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728096AbeJRC7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:59:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24155B08B;
        Wed, 17 Oct 2018 19:02:21 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     eric@anholt.net, stefan.wahren@i2se.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, nsaenzjulienne@suse.de, devel@driverdev.osuosl.org
Subject: [PATCH v2 6/7] staging: bcm2835-audio: rename platform_driver structure
Date:   Wed, 17 Oct 2018 21:01:55 +0200
Message-Id: <20181017190156.30010-7-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017190156.30010-1-nsaenzjulienne@suse.de>
References: <20181017190156.30010-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was called bcm2835_alsa0_driver, that "0" didn't mean much.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 039565311d10..e14b7c5aa07c 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -343,7 +343,7 @@ static const struct of_device_id snd_bcm2835_of_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, snd_bcm2835_of_match_table);
 
-static struct platform_driver bcm2835_alsa0_driver = {
+static struct platform_driver bcm2835_alsa_driver = {
 	.probe = snd_bcm2835_alsa_probe,
 #ifdef CONFIG_PM
 	.suspend = snd_bcm2835_alsa_suspend,
@@ -359,7 +359,7 @@ static int bcm2835_alsa_device_init(void)
 {
 	int retval;
 
-	retval = platform_driver_register(&bcm2835_alsa0_driver);
+	retval = platform_driver_register(&bcm2835_alsa_driver);
 	if (retval)
 		pr_err("Error registering bcm2835_audio driver %d .\n", retval);
 
@@ -368,7 +368,7 @@ static int bcm2835_alsa_device_init(void)
 
 static void bcm2835_alsa_device_exit(void)
 {
-	platform_driver_unregister(&bcm2835_alsa0_driver);
+	platform_driver_unregister(&bcm2835_alsa_driver);
 }
 
 late_initcall(bcm2835_alsa_device_init);
-- 
2.19.1

