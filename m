Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6654DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383B12087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ5VtSo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfAHSy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:54:58 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41651 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbfAHSyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:54:50 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so3719690lfj.8;
        Tue, 08 Jan 2019 10:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4offxaGy+4HDrpz9WgSh2avx++HfPwCLUC4H/LvwJXk=;
        b=lQ5VtSo5bBOltIIFLmn0BwKnBvbypfAKFx9y+gOnSTYdFmotkt8+H5622e63ocq6Q8
         enOeu3bF9iZSaox28YPf2ATFW1qjif6nDtN77C9bnyPE/FtCzEQpoDDUR9fnR4YKNELE
         7Q3RuWrWtOJtvDIQGn/O4PcF6Y35FaTqmDs51oR03l1TrI9xvYJynoSXC39pQUBp19Rf
         LFKhdqWz1B2t2qh70tAPqZxMQX+h+IKkZyhoDiM946Wf9Oq0DbTHNJjyk9wHvOKWJhWK
         i1wBy+3RhQQ6BiJIdB3C/TF7Q9pRxobseMiHyopZ/LZBU6FbVKF09RfJuWfPb8AkTvRi
         3yvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4offxaGy+4HDrpz9WgSh2avx++HfPwCLUC4H/LvwJXk=;
        b=M0SbrgJiXQ1MbilfMQQ9ShYSbg1GudJA8OIMGZ77hBbrsQ4e0MZ29porzZh8zH+zl9
         BmtiN17PCG0K8+ld3HdM6ouCSs8nthbmCwub48toJChmEl/d0eEAu4NBRlb4osB54+Sb
         3WnnI7o8wiNQPEYpYv4HZaM56PhKtlqfxyFNDbi57woAcoH1rhiAJQKIjoyDRXyoh40R
         2S8NVewbDGr2yM19frgSPK2X+mvMu4JgBEotbE+yD5kjJXmEBrwXJIkBB/KKvfwlS4Cd
         /UUzD2CPSqJ0Lv+YLQhRZNw26oaJ0vlIBOc4l/I4SnrKJrRRRfsBUP7XUScsLDlzk931
         hrpg==
X-Gm-Message-State: AJcUukf1DE2my4fEt3i4Tw7uY+9NWBOPON6WL+diWwmkEVKnn/pQsJsS
        xg6UNyAiMmQgO5sluLosbSs=
X-Google-Smtp-Source: ALg8bN7hvPbpQczkW67byMag3KDyAyEkg1ZaLUwiyqn1ubFF/wE4Q5wMyVRrSYl7DfG3jmXkNM3ufA==
X-Received: by 2002:a19:5349:: with SMTP id h70mr1689692lfb.50.1546973688441;
        Tue, 08 Jan 2019 10:54:48 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a11sm13321648lff.68.2019.01.08.10.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:54:47 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 5/5] rtc: pcf85063: set xtal load capacitance from DT
Date:   Tue,  8 Jan 2019 19:54:14 +0100
Message-Id: <20190108185414.26922-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190108185414.26922-1-sam@ravnborg.org>
References: <20190108185414.26922-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for specifying the xtal load capacitance in the DT node.
The pcf85063 supports xtal load capacitance of 7pF or 12.5pF.
If the rtc has the wrong configuration the time will
drift several hours/week.

The driver use the default value 7pF.

The DT may specify either 7000fF or 12500fF.
(The DT uses femto Farad to avoid decimal numbers).
Other values are warned and the driver uses the default value.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Urs Fässler <urs.fassler@bbv.ch>
---
 drivers/rtc/rtc-pcf85063.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 283c2335b01b..0c0b6030627e 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -27,6 +27,7 @@
 */
 
 #define PCF85063_REG_CTRL1		0x00 /* status */
+#define PCF85063_REG_CTRL1_CAP_SEL	BIT(0)
 #define PCF85063_REG_CTRL1_STOP		BIT(5)
 #define PCF85063_REG_CTRL2		0x01
 
@@ -180,6 +181,39 @@ static const struct rtc_class_ops pcf85063_rtc_ops = {
 	.set_time	= pcf85063_rtc_set_time
 };
 
+static int pcf85063_load_capacitance(struct i2c_client *client)
+{
+	u32 load;
+	int rc;
+	u8 reg;
+
+	rc = i2c_smbus_read_byte_data(client, PCF85063_REG_CTRL1);
+	if (rc < 0)
+		return rc;
+
+	reg = rc;
+	load = 7000;
+	of_property_read_u32(client->dev.of_node, "quartz-load-femtofarads",
+			     &load);
+
+	switch (load) {
+	default:
+		dev_warn(&client->dev, "Unknown quartz-load-femtofarads value: %d. Assuming 7000",
+			load);
+		/* fall through */
+	case 7000:
+		reg &= ~PCF85063_REG_CTRL1_CAP_SEL;
+		break;
+	case 12500:
+		reg |= PCF85063_REG_CTRL1_CAP_SEL;
+		break;
+	}
+
+	rc = i2c_smbus_write_byte_data(client, PCF85063_REG_CTRL1, reg);
+
+	return rc;
+}
+
 static int pcf85063_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
@@ -197,6 +231,11 @@ static int pcf85063_probe(struct i2c_client *client,
 		return err;
 	}
 
+	err = pcf85063_load_capacitance(client);
+	if (err < 0)
+		dev_warn(&client->dev, "failed to set xtal load capacitance: %d",
+		         err);
+
 	rtc = devm_rtc_device_register(&client->dev,
 				       pcf85063_driver.driver.name,
 				       &pcf85063_rtc_ops, THIS_MODULE);
-- 
2.12.0

