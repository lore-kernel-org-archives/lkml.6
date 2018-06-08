Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1cWqGc+sGlvmaAAAmS7hNA
	; Fri, 08 Jun 2018 16:21:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 940F7607E4; Fri,  8 Jun 2018 16:21:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJsDXFx8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E9572601B4;
	Fri,  8 Jun 2018 16:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9572601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeFHQVI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:21:08 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38313 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbeFHQVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:21:05 -0400
Received: by mail-wr0-f196.google.com with SMTP id e18-v6so5719909wrs.5;
        Fri, 08 Jun 2018 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Z8BTLsMqz68FyZueOj7rIvHOxo9E4uO/+ybVvG7tHw=;
        b=sJsDXFx81wyBerNeXrGVjijtRKAz5ybjVNlXMyqdW4hOQu80EK7M8JnOm3EUtYudCA
         nX7kBXRQbYKibhKR5qAbVAotKWj8pFzKLDmSEgORUY9hwafjv16KkXPmlDqVj6K86BH5
         ua3m69+zL5DMM+T+4ziArePd4r+EmbNV/heTwgCEKdItQvgeExD319eoftooKGVW4zqW
         WzhrRRRrkHsnxvBjc68VAlJlz3U2arRZs699gERoB62Dt+9GC93mnRhpyB5dgMgh+pRq
         hgYT8EpdelQForHITmYvBy2yPAQvXzBWW8mqb840Bt6sdoBwImjrArwW38GZvUjmdWHu
         mCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Z8BTLsMqz68FyZueOj7rIvHOxo9E4uO/+ybVvG7tHw=;
        b=O7y31pXfV03upgm4wBUzLxvY01UdgFizB1g1qYIUNvtxPbsjmrn10DydnmlYX/Mver
         Ve6lwJ/Q98XjhRVS+V6bnvWbR4T5aXrftwpm8x4k2k4hdfD5rb2t/MEuZu4tydvoZcdQ
         mgDPa+w6fJkpW0caausDT1k6MCBVsujlMgH2htfxMKqGYxmzgL3oR5tkWc5r2PalyD6l
         bsydU1XF+wUmUXAbh4RN3l/QmTORy3F2EpP3kdXq8okCEmvi+4m5WY8NB8/peYX3Pdr+
         fY0BIA6VVeAVadHDsqTIlHey+KM9+Ppsu4LmLdNRG9j2In7/0+ZglvsxnvCjEN1UOCKt
         ScVQ==
X-Gm-Message-State: APt69E2yxsBSwQSpqomOBwYEqmzVeeSFaHT4Hetvjy/FNUwXtqDviEQS
        c8hYSAb4CMBxPJ71is9WvaQ=
X-Google-Smtp-Source: ADUXVKKoLTMku6OxngoGZyVOgiLEwW1pvFYjUD8Wo0V+uvuNoBt1sWNPLt1fS37RMDK+HnIkpJhVSQ==
X-Received: by 2002:adf:ee0e:: with SMTP id y14-v6mr5966574wrn.63.1528474864148;
        Fri, 08 Jun 2018 09:21:04 -0700 (PDT)
Received: from localhost.localdomain ([188.24.92.194])
        by smtp.googlemail.com with ESMTPSA id m185-v6sm2545041wma.36.2018.06.08.09.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 09:21:03 -0700 (PDT)
From: attitokes@gmail.com
Cc: =?UTF-8?q?Attila=20T=C5=91k=C3=A9s?= <attitokes@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Artiom Vaskov <velemas@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Configure SCO routing automatically
Date: Fri,  8 Jun 2018 19:20:09 +0300
Message-Id: <20180608162009.22762-1-attitokes@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <280FCB2C-6DF1-4790-A89F-AF5BE3513AE5@holtmann.org>
References: <280FCB2C-6DF1-4790-A89F-AF5BE3513AE5@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Attila Tőkés <attitokes@gmail.com>

Added support to automatically configure the SCO packet routing at the device setup. The SCO packets are used with the HSP / HFP profiles, but in some devices (ex. CYW43438) they are routed to a PCM output by default. This change allows sending the vendor specific HCI command to configure the SCO routing. The parameters of the command are loaded from the device tree.

Signed-off-by: Attila Tőkés <attitokes@gmail.com>
---
 .../bindings/net/broadcom-bluetooth.txt       |  7 ++
 drivers/bluetooth/hci_bcm.c                   | 72 +++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index 4194ff7e..aea3a094 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -21,6 +21,12 @@ Optional properties:
  - clocks: clock specifier if external clock provided to the controller
  - clock-names: should be "extclk"
 
+ SCO routing parameters:
+ - sco-routing: 0-3 (PCM, Transport, Codec, I2S)
+ - pcm-interface-rate: 0-4 (128 Kbps - 2048 Kbps)
+ - pcm-frame-type: 0 (short), 1 (long)
+ - pcm-sync-mode: 0 (slave), 1 (master)
+ - pcm-clock-mode: 0 (slave), 1 (master)
 
 Example:
 
@@ -31,5 +37,6 @@ Example:
        bluetooth {
                compatible = "brcm,bcm43438-bt";
                max-speed = <921600>;
+               sco-routing = <1>; /* 1 = transport (UART) */
        };
 };
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ddbd8c6a..0e729534 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -83,6 +83,16 @@
  * @hu: pointer to HCI UART controller struct,
  *	used to disable flow control during runtime suspend and system sleep
  * @is_suspended: whether flow control is currently disabled
+ *
+ *  SCO routing parameters:
+ *   used as the parameters for the bcm_set_pcm_int_params command
+ *	@sco_routing:
+ *	 >= 255 (skip SCO routing configuration)
+ *	 0-3 (PCM, Transport, Codec, I2S)
+ *	@pcm_interface_rate: 0-4 (128 Kbps - 2048 Kbps)
+ *	@pcm_frame_type: 0 (short), 1 (long)
+ *	@pcm_sync_mode: 0 (slave), 1 (master)
+ *	@pcm_clock_mode: 0 (slave), 1 (master)
  */
 struct bcm_device {
 	/* Must be the first member, hci_serdev.c expects this. */
@@ -114,6 +124,13 @@ struct bcm_device {
 	struct hci_uart		*hu;
 	bool			is_suspended;
 #endif
+
+	/* SCO routing parameters */
+	u8			sco_routing;
+	u8			pcm_interface_rate;
+	u8			pcm_frame_type;
+	u8			pcm_sync_mode;
+	u8			pcm_clock_mode;
 };
 
 /* generic bcm uart resources */
@@ -189,6 +206,40 @@ static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	return 0;
 }
 
+static int bcm_configure_sco_routing(struct hci_uart *hu, struct bcm_device *bcm_dev)
+{
+	struct hci_dev *hdev = hu->hdev;
+	struct sk_buff *skb;
+	struct bcm_set_pcm_int_params params;
+
+	if (bcm_dev->sco_routing >= 0xff) {
+		/* SCO routing configuration should be skipped */
+		return 0;
+	}
+
+	bt_dev_dbg(hdev, "BCM: Configuring SCO routing (%d %d %d %d %d)",
+			bcm_dev->sco_routing, bcm_dev->pcm_interface_rate, bcm_dev->pcm_frame_type,
+			bcm_dev->pcm_sync_mode,	bcm_dev->pcm_clock_mode);
+
+	params.routing = bcm_dev->sco_routing;
+	params.rate = bcm_dev->pcm_interface_rate;
+	params.frame_sync = bcm_dev->pcm_frame_type;
+	params.sync_mode = bcm_dev->pcm_sync_mode;
+	params.clock_mode = bcm_dev->pcm_clock_mode;
+
+	/* Send the SCO routing configuration command */
+	skb = __hci_cmd_sync(hdev, 0xfc1c, sizeof(params), &params, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		int err = PTR_ERR(skb);
+		bt_dev_err(hdev, "BCM: failed to configure SCO routing (%d)", err);
+		return err;
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
 /* bcm_device_exists should be protected by bcm_device_lock */
 static bool bcm_device_exists(struct bcm_device *device)
 {
@@ -534,6 +585,9 @@ static int bcm_setup(struct hci_uart *hu)
 			host_set_baudrate(hu, speed);
 	}
 
+	/* Configure SCO routing if needed */
+	bcm_configure_sco_routing(hu, bcm->dev);
+
 finalize:
 	release_firmware(fw);
 
@@ -1004,9 +1058,21 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 }
 #endif /* CONFIG_ACPI */
 
+static void read_u8_device_property(struct device *device, const char *property, u8 *destination) {
+	u32 temp;
+	if (device_property_read_u32(device, property, &temp) == 0) {
+		*destination = temp & 0xff;
+	}
+}
+
 static int bcm_of_probe(struct bcm_device *bdev)
 {
 	device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
+	read_u8_device_property(bdev->dev, "sco-routing", &bdev->sco_routing);
+	read_u8_device_property(bdev->dev, "pcm-interface-rate", &bdev->pcm_interface_rate);
+	read_u8_device_property(bdev->dev, "pcm-frame-type", &bdev->pcm_frame_type);
+	read_u8_device_property(bdev->dev, "pcm-sync-mode", &bdev->pcm_sync_mode);
+	read_u8_device_property(bdev->dev, "pcm-clock-mode", &bdev->pcm_clock_mode);
 	return 0;
 }
 
@@ -1022,6 +1088,9 @@ static int bcm_probe(struct platform_device *pdev)
 	dev->dev = &pdev->dev;
 	dev->irq = platform_get_irq(pdev, 0);
 
+	/* SCO routing configuration is disabled by default */
+	dev->sco_routing = 0xff;
+
 	if (has_acpi_companion(&pdev->dev)) {
 		ret = bcm_acpi_probe(dev);
 		if (ret)
@@ -1281,6 +1350,9 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 	bcmdev->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, bcmdev);
 
+	/* SCO routing configuration is disabled by default */
+	bcmdev->sco_routing = 0xff;
+
 	if (has_acpi_companion(&serdev->dev))
 		err = bcm_acpi_probe(bcmdev);
 	else
-- 
2.17.0
