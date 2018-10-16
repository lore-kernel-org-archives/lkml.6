Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C054C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F90205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F90205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJPWyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:54:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:55712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727016AbeJPWyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:54:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C50AB06E;
        Tue, 16 Oct 2018 15:03:58 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     eric@anholt.net, stefan.wahren@i2se.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, tiwai@suse.de,
        nsaenzjulienne@suse.de
Subject: [PATCH 5/9] staging: bcm2835-audio: more generic probe function name
Date:   Tue, 16 Oct 2018 17:02:24 +0200
Message-Id: <20181016150228.16994-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016150228.16994-1-nsaenzjulienne@suse.de>
References: <20181016150228.16994-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There will only be one probe function, there is no use for appendig
"_dt" the end of the name.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 6ee8334dfc81..039565311d10 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -291,7 +291,7 @@ static int snd_add_child_devices(struct device *device, u32 numchans)
 	return 0;
 }
 
-static int snd_bcm2835_alsa_probe_dt(struct platform_device *pdev)
+static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	u32 numchans;
@@ -344,7 +344,7 @@ static const struct of_device_id snd_bcm2835_of_match_table[] = {
 MODULE_DEVICE_TABLE(of, snd_bcm2835_of_match_table);
 
 static struct platform_driver bcm2835_alsa0_driver = {
-	.probe = snd_bcm2835_alsa_probe_dt,
+	.probe = snd_bcm2835_alsa_probe,
 #ifdef CONFIG_PM
 	.suspend = snd_bcm2835_alsa_suspend,
 	.resume = snd_bcm2835_alsa_resume,
-- 
2.19.1

