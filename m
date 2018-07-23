Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88198ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA6C20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="S1q3RPXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA6C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=castello.eng.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeGWFci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:32:38 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.210]:48581 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbeGWFci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:32:38 -0400
X-Greylist: delayed 1377 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jul 2018 01:32:37 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id E9621400D5BD4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 23:09:34 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id hSAAf4nPfPvAdhSAAf944E; Sun, 22 Jul 2018 23:09:34 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GgGZmjOQR9xtwOYRIyHgKsDrFuSnUHm3BwBAMQ+Vkuo=; b=S1q3RPXrUrFqZVUF6/b+dnM7H
        5bPwyBiVzHKc5w6Ivk8I1hpVksB1JdQ+5FYCADZS0ev8tzXlBPvqZ3ti5ZNiMtBioiGDDKRzkz0gx
        FrZdLyWctzFUzgwizgTXKFHhG9RBm5G0JE4cXl/t20JhwKO+kpF3S/5jC+hXaAgDGaUDHqQZyeZpY
        mUu1GX1EwnfAEU8FtMJeaSU7hEEGxsMLcCbEfJCetiVjOpNO/PkfWXDiXA+W5/bS/UFeRnw75rd/4
        dKqhcFkseZVkPI9ODLaEwPVbPqdPWPPmuag1heW+caagweITnDY0JAVfTbLlS5wKx6DSddVI2hPpC
        lIsNxTi4A==;
Received: from [191.189.20.114] (port=7927 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1fhSAA-001oyu-5a; Mon, 23 Jul 2018 01:09:34 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 2/4] power: supply: max17040: Config alert SOC low level threshold from FDT
Date:   Mon, 23 Jul 2018 00:08:14 -0400
Message-Id: <20180723040816.19455-3-matheus@castello.eng.br>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20180723040816.19455-1-matheus@castello.eng.br>
References: <20180723040816.19455-1-matheus@castello.eng.br>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.20.114
X-Source-L: No
X-Exim-ID: 1fhSAA-001oyu-5a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.20.114]:7927
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 15
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For configuration of fuel gauge alert for a low level state of charge
interrupt we add a function to config level threshold and a device tree
binding property to set it in flatned device tree node.

Now we can use "maxim,alert-soc-level" property with the values from
1 up to 32 to configure alert interrupt threshold.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 6e54e58814a9..3efa52d32b44 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -47,6 +47,8 @@ struct max17040_chip {
 	int soc;
 	/* State Of Charge */
 	int status;
+	/* Alert threshold */
+	int alert_threshold;
 };
 
 static int max17040_get_property(struct power_supply *psy,
@@ -123,6 +125,28 @@ static void max17040_get_soc(struct i2c_client *client)
 	chip->soc = (soc >> 8);
 }
 
+static int max17040_set_soc_threshold(struct i2c_client *client, u8 level)
+{
+	int ret;
+	u16 data;
+
+	/* check if level is between 1% and 32% */
+	if (level > 0 && level < 33) {
+		/* alert threshold use LSb 5 bits from RCOMP */
+		/* two's-complements form: 00000 = 32% and 11111 = 1% */
+		level = 32 - level;
+		data = max17040_read_reg(client, MAX17040_RCOMP);
+		data &= 0xFFE0;
+		data |= level;
+		max17040_write_reg(client, MAX17040_RCOMP, data);
+		ret = 0;
+	} else {
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static void max17040_get_version(struct i2c_client *client)
 {
 	u16 version;
@@ -165,6 +189,16 @@ static void max17040_get_status(struct i2c_client *client)
 		chip->status = POWER_SUPPLY_STATUS_FULL;
 }
 
+static void max17040_get_of_data(struct max17040_chip *chip)
+{
+	struct device *dev = &chip->client->dev;
+	struct device_node *np = dev->of_node;
+
+	if (of_property_read_s32(np, "maxim,alert-soc-level",
+			&chip->alert_threshold))
+		chip->alert_threshold = 4;
+}
+
 static void max17040_work(struct work_struct *work)
 {
 	struct max17040_chip *chip;
@@ -231,6 +265,7 @@ static int max17040_probe(struct i2c_client *client,
 
 	chip->client = client;
 	chip->pdata = client->dev.platform_data;
+	max17040_get_of_data(chip);
 
 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
@@ -262,6 +297,7 @@ static int max17040_probe(struct i2c_client *client,
 
 	max17040_reset(client);
 	max17040_get_version(client);
+	max17040_set_soc_threshold(client, chip->alert_threshold);
 
 	INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
-- 
2.13.3

