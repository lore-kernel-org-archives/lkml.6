Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794CCC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A97208D9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A97208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeJCDxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:53:51 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:46133 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbeJCDxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:53:50 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MwQGj-1fqSx43NAL-00sQUa; Tue, 02 Oct 2018 23:08:27 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MwQGj-1fqSx43NAL-00sQUa; Tue, 02 Oct 2018 23:08:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator/mfd: fix pointer-to-int cast
Date:   Tue,  2 Oct 2018 23:07:32 +0200
Message-Id: <20181002210826.2588925-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:PK2j7E7n3iaOdwyXdtRoAWf7NIyf47EuZ6J4mDEKiMRzoSdpZi4
 Ai0gM6Lyc8AEE0qn1a7uONIoQEiohKtrzt5IeSuS1LfBiHNVdGwkE5vg2biYjru+gVct/Bl
 L1YEIaQBbCCDvaRf/RQbr/nsyOk6c8aZcTbdzqOQs+GCuTc0y85DK41uavG1QLsr6swKAiW
 Vfrodo92llGFYhyB0gXDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:12mV71LxHX0=:OEgRrM/pkIdGmXEWJxILml
 SHItNEzAXHT8wMD25WCCo8XVQAt4K53cmggrLHz/GK4CVRsglc1fbq77ky9dM5O2lqeFpCJOj
 /+6xyLh9tTczoPv5afxJJNhLplaX2PkqWcWhZpqQoFmzcbScjdESp3IowWT9FJxYNF11Fs0vA
 owBgnoyjK+eRzslab9dWyK3TbSCC3Hn2E0qIxGF4GMNhISp/Crjs0jaDn4tGCy94Tw/Nr8PAY
 ec2DBFBeClVKnHhFPXJ9f/MFDsqDK8jrlNpmtO27ByvuVud/KZTjvEMNkPDRTRhJty60nNqY/
 KO/uQ32+Hq4nP+ytOdg9l5JSEmqtyRHX8+rnsrolpgbc48WG1wnaFXRgqgXSTpq/fxsp4YQGF
 aUaVdTkuG/Kwem94wbPQ7ldAwZjMTE5w39z/RKNx1liAO8rUgQ53KxWqW8Lo7kmQyh6t21QxE
 YpraUThF1BiUKm/76GErwro2uxkiWladEAf4XnKkwLU7A/tLcDKW4eNi9mjpCHiiF8RgR6doi
 yJ4L2rpFnQNTa+AmbcNRDwoDxZsaeG+7hD4WRRZruGnkiD3lQiqrfj7wtC2s3TY90xQ7LLNxH
 /Ngi2acQNA5/HxK4NQS0oPuD29mfU4JYVALzjEvAFwqOzwfQ58dK4ozAn0PVtmwOVTudEuWUr
 T551RR/f09JxJRmnkB5AT7ALB9PD09wt6cKvR2XrCanfLjZa2njnyl4TjlE1CUMis7os=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc points out that a pointer is longer than an int on 64-bit
architectures, and that casting between the two may be dangerous:

drivers/mfd/rohm-bd718x7.c: In function 'bd718xx_i2c_probe':
drivers/mfd/rohm-bd718x7.c:101:23: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

In this driver it is correct, we just need the right kind of cast
to avoid the warning.

Fixes: 494edd266b94 ("regulator/mfd: Support ROHM BD71847 power management IC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/rohm-bd718x7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index 161c8aac6d86..e66d59190a82 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -98,7 +98,7 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	bd718xx->chip_irq = i2c->irq;
-	bd718xx->chip_type = (unsigned int)
+	bd718xx->chip_type = (uintptr_t)
 				of_device_get_match_data(&i2c->dev);
 	bd718xx->dev = &i2c->dev;
 	dev_set_drvdata(&i2c->dev, bd718xx);
-- 
2.18.0

