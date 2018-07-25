Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDA0C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457B820844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="klM042gO";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="klM042gO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457B820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbeGYVAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:00:09 -0400
Received: from node.akkea.ca ([192.155.83.177]:60924 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbeGYVAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:00:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id F1501542053;
        Wed, 25 Jul 2018 19:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1532548018; bh=KJhhEAgXKcfa9aQ9ByulMkCLjro1GlN+IHhOLV28/7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=klM042gOF3DZ1QtCB41WZ1rKfaVgO577LOvoIdblOEMK5bEnp8lEUn1bTpfuICTJZ
         pdwu4OmkRwco8ekJFTE0cUQePuslVg1952u3NtWtnH/uL50hSegJl3Yvt7Xfn5BGWo
         duohZfC0YssSZ4O/K1Z94zTr/6HIl49Cgv23MSqk=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Cp6UAWp3QNTS; Wed, 25 Jul 2018 19:46:58 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.cg.shawcable.net [68.144.56.170])
        by node.akkea.ca (Postfix) with ESMTPSA id 1965454204B;
        Wed, 25 Jul 2018 19:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1532548018; bh=KJhhEAgXKcfa9aQ9ByulMkCLjro1GlN+IHhOLV28/7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=klM042gOF3DZ1QtCB41WZ1rKfaVgO577LOvoIdblOEMK5bEnp8lEUn1bTpfuICTJZ
         pdwu4OmkRwco8ekJFTE0cUQePuslVg1952u3NtWtnH/uL50hSegJl3Yvt7Xfn5BGWo
         duohZfC0YssSZ4O/K1Z94zTr/6HIl49Cgv23MSqk=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2 1/4] power: bq25890_charger.c: Add debugging output of failed initialization
Date:   Wed, 25 Jul 2018 13:46:27 -0600
Message-Id: <20180725194630.10414-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180725194630.10414-1-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180725194630.10414-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ease adding a new part variant some debugging is handy

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/power/supply/bq25890_charger.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 8e2c41ded171..7f0b3a46c50c 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -608,30 +608,40 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 	};
 
 	ret = bq25890_chip_reset(bq);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_dbg(bq->dev, "Reset failed %d\n", ret);
 		return ret;
+	};
 
 	/* disable watchdog */
 	ret = bq25890_field_write(bq, F_WD, 0);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_dbg(bq->dev, "Disabling watchdog failed %d\n", ret);
 		return ret;
+	};
 
 	/* initialize currents/voltages and other parameters */
 	for (i = 0; i < ARRAY_SIZE(init_data); i++) {
 		ret = bq25890_field_write(bq, init_data[i].id,
 					  init_data[i].value);
-		if (ret < 0)
+		if (ret < 0) {
+			dev_dbg(bq->dev, "Writing init data failed %d\n", ret);
 			return ret;
+		};
 	}
 
 	/* Configure ADC for continuous conversions. This does not enable it. */
 	ret = bq25890_field_write(bq, F_CONV_RATE, 1);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_dbg(bq->dev, "Config ADC failed %d\n", ret);
 		return ret;
+	};
 
 	ret = bq25890_get_chip_state(bq, &state);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_dbg(bq->dev, "Get state failed %d\n", ret);
 		return ret;
+	};
 
 	mutex_lock(&bq->lock);
 	bq->state = state;
@@ -767,6 +777,9 @@ static int bq25890_fw_read_u32_props(struct bq25890_device *bq)
 			if (props[i].optional)
 				continue;
 
+			dev_err(bq->dev, "Unable to read property %d %s\n", ret,
+				props[i].name);
+
 			return ret;
 		}
 
-- 
2.17.1

