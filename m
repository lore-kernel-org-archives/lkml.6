Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3D0C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EC9217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOjK09Mw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfAYSoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:44:18 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39781 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfAYSoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:44:10 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so9196041ljh.6;
        Fri, 25 Jan 2019 10:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pPz/f03XiBmSQ9/ft6p1O4l+O9E5ZDQ8xc0Zl8VFB+M=;
        b=aOjK09MwHDbgBw8YwXuHbzS5cLeeaXVCqCpRcj90UGu0pwGTpOEVMC1jGVYRVDkWhE
         77vPAXk3GxdVJduc0CWxji1beGVdALHLZtIq2mp1o8Z4OslgAuDNIxWjE7I3LE+Kl2Dh
         ZIKwkoiTUE13Gzsk0o/eEfb4bPOsw7mum/PVUO4cHN/mqVbh5OMkIMknWDDcMHYcunzw
         UfeRmGBaSzzulKigjKNbfo5IE7XPebPrCFmCK3VeVti5gqzBgVz6kx/pvwnPG8gZKj4K
         +zROaqO7hBlyDXKlUm8E38Q/ZTzPu+l68lBi5jQGnb6LtyXsObXXE2SYQ1mvEYax6T8F
         q+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pPz/f03XiBmSQ9/ft6p1O4l+O9E5ZDQ8xc0Zl8VFB+M=;
        b=HpiVHKCOZwchrVimbFBJUND0JOszO71YNTwiS65e5iq+tKEw5utucsS8te7+wORd+M
         FIPEdtMnKBNJKokwuHUX7Zjsd23DQFjZAa9IqW4pYadROtHj4PLD17w7+H2ZzsdLY/Iq
         HGbcyVLJpxupM/8+5UDf0Dkx0qSFIu7FUMV9YMR0HDmYAXzGl2XlJfIwb0XX1jdTgYxK
         +YVCkgS9fL1Eh50ZHlbTYktc7XhPPN5aQL/5hk6bnOJW9uEfD4yxdSYUvbfNHVroho4e
         splTvcqs3zTNuJfj2ILF0M3cthkI4opcU2L1hK9ieoEllPjRfyZfLmATewZRY8yeV0zM
         CLNg==
X-Gm-Message-State: AJcUukevqP7pQDDEnKF8AvPmg63dCi42uHiPvpzs7BE5Rjx6PZVZMu1L
        M9ypj5jsYiTGNBwXiOtM9b8=
X-Google-Smtp-Source: ALg8bN5ONvEF2McEFyyWMWorzsp0QLtnQJIgZHoEZh6HLPAbukTpm6/SvNml2Gpsho6dW0g17V71zQ==
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr9450366ljs.118.1548441847572;
        Fri, 25 Jan 2019 10:44:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6921:1f1d:2918:d853])
        by smtp.googlemail.com with ESMTPSA id f18sm1715432lfk.18.2019.01.25.10.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:44:06 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] input: dt-bindings: Add binding for bma150 sensor
Date:   Fri, 25 Jan 2019 19:44:00 +0100
Message-Id: <20190125184400.17669-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Add device tree bindings for Bosch BMA150 Accelerometer Sensor

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 .../bindings/input/bosch,bma150.txt           | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/bosch,bma150.txt

diff --git a/Documentation/devicetree/bindings/input/bosch,bma150.txt b/Documentation/devicetree/bindings/input/bosch,bma150.txt
new file mode 100644
index 000000000000..290c60e38c70
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/bosch,bma150.txt
@@ -0,0 +1,20 @@
+* Bosch BMA150 Accelerometer Sensor
+
+Also works for the SMB380 and BMA023 accelerometers
+
+Required properties:
+- compatible : Should be "bosch,bma150"
+- reg : The I2C address of the sensor
+
+Optional properties:
+- interrupt-parent : should be the phandle for the interrupt controller
+- interrupts : Interrupt mapping for IRQ.  If not present device will be polled
+
+Example:
+
+bma150@38 {
+	compatible = "bosch,bma150";
+	reg = <0x38>;
+	interrupt-parent = <&gph0>;
+	interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.17.1

