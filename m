Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF25C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E488D2146D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnRExS/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E488D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeLGO3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:29:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35187 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeLGO3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:29:09 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so3179514lfc.2;
        Fri, 07 Dec 2018 06:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XFPTtMJpSFiF4PFAqSj6g1FCx0iqQrUaJq/0mQ1Us/I=;
        b=rnRExS/ioqXRd7pl9X9/WxnSDOkSz5BlvCsll1C0iOnrGjkL+YxDK5AG/ixFIJwLnj
         uBHkR/0kUmi2Vs3Gm3RSwug2RKF3WqLC0Z7P+4IJk4FsG4C+wD+M22uk3m9+G6fBWPjN
         y0v/Pmc+6RX9W7VLoifWD1QgiUtol9TfYdYDwd2d8gfrGngaWdq+6KEzhDbvEKCrkJZs
         jsOty8TBA9RGkBI0wEGUMB/zie8GdzJQWbpWSUP3UWXtVA2IEO0CrfGjKrmYxQokmk1E
         6xsSukU69ObfUN02s9DCMgGqfi9FKRY7YtAp8JUvw9TWjb+aNzazjNFGGQOIwlWxG7MV
         IoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFPTtMJpSFiF4PFAqSj6g1FCx0iqQrUaJq/0mQ1Us/I=;
        b=ZBVWzrYjTChOHoTevvXlXJ5uOTwRNdJhPWkNPUJEU4I62zD2g1aj5X4/+zWY6VuKqW
         ArZx41BnzvVcA/IEs4qlPx4BAVo2hwe5BwLWrXVQqgd+Q/X1+8TqYyZN7LrR2Owo9IUJ
         3qhOXP1ZCazYLEF3qsmGJe0rkB1Ifrx9JH4zJDi5AVw7b51aibWKDeeAJcf2PYNWeYf2
         iWm2LJpizYQrTEMlyfTH9sLL4evIKuyWxBl4tr4J4tP9GDJhggTzQJx6Mhn+v5RtpX2f
         oUs2CTHBqQ7rrMJOwgjqU/+QGhqA5VQd1gwJHs2H/osJhpGLBv4/X33ZK1XXBnS6mHAl
         hYeQ==
X-Gm-Message-State: AA+aEWb9YGW6zA7Av6OJPxtHBjEkmuWuad2EPZdzjO4xmkzNOc29jydg
        QFTkvDPfH4fsrN9Au7fbc+qFhxq268Y=
X-Google-Smtp-Source: AFSGD/UJGLWQZxgX4zc/qOv5w0brAukTjLL/vMZ7TccXHJhOgYWzodEmqX/Piod2kwFhkAi+/CaztQ==
X-Received: by 2002:a19:1d0d:: with SMTP id d13mr1430771lfd.74.1544192945963;
        Fri, 07 Dec 2018 06:29:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
        by smtp.googlemail.com with ESMTPSA id v64sm630504lfa.48.2018.12.07.06.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 06:29:05 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v4 3/3] Input: atmel_mxt_ts: Document optional voltage regulators
Date:   Fri,  7 Dec 2018 15:28:57 +0100
Message-Id: <20181207142857.15818-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new optional voltage regulators, which can be used
to power down/up touchscreen.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes from v1:
  - Added reviewed-by
---
 .../devicetree/bindings/input/atmel,maxtouch.txt          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
index c88919480d37..17930ecadad3 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
@@ -31,6 +31,12 @@ Optional properties for main touchpad device:
 
 - reset-gpios: GPIO specifier for the touchscreen's reset pin (active low)
 
+- avdd-supply: Analog power supply. It powers up the analog channel block
+    of the controller to detect the touches.
+
+- vdd-supply: Digital power supply. It powers up the digital block
+    of the controller to enable i2c communication.
+
 Example:
 
 	touch@4b {
@@ -38,4 +44,6 @@ Example:
 		reg = <0x4b>;
 		interrupt-parent = <&gpio>;
 		interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_LOW>;
+		avdd-supply = <&atsp_reg>;
+		vdd-supply = <&tsp_reg>;
 	};
-- 
2.17.1

