Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA1CC282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BB7214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8sSN6QK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfBDMsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:48:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45147 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbfBDMsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:48:39 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so11363824ljd.12;
        Mon, 04 Feb 2019 04:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=odKZR5LuUPQq6nEynHHZu620HK8qG1oypfpwL9UmJOI=;
        b=B8sSN6QKIcxS+IglLxosSA0jjlNsykMSeA+VA9IbL7jEUqfcec5cdNaQeKryMcFejV
         rYcZCOW//fzE28Ue5xpeOWKDAejLv7NMlA9OAc4bQEZtN2WD5+hYrRLFG0rcrwks0Qbb
         UZeOOS2V3/LkRRJqT2oBgSt3pcAJZfk5gJusWCLqzBzFzuQJ747zFwAyw0vwhLRldL1s
         yBk0yneSkFUefz+CYW9I+HaS4i97UKrCilZ0K6IUcz03NICRyWL5crhCXcW8mg7Uis2x
         b77+P4QUrbKZbM4cqRvkNI02eJwGvYtirMKJq3DQSYn01IqDmmwJQ1aANcL6ZhJ+TkAC
         CS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=odKZR5LuUPQq6nEynHHZu620HK8qG1oypfpwL9UmJOI=;
        b=UJaKLwf0/bBzPZRMebJwRthF4TnyiAFzyM9gQPds1UAkKAjHT09E9QIX14zbQThbzI
         dot8dftn/J5SAfqyIMgk6rFvyZ/haVf+4TQJZ+ZET0OY2zVhokaKJt447O7j8wDeuFj4
         0nFTWjl9kPgu9GGZqb9Nlt6iTuBy8dJ0pxae3UevHf4Nc+mCf5O9yDEX19M/UcSSXMul
         IoWw2OgmjUuOYMFijuZgKEOVn8l3nZWGQCjxgUfRxP1OaqkNSfR4o+4fZ2dD6B5t1Tin
         FEy2pwQ/CZa+NR1Xvw5HtMcdUsza0E0gOod4ur/DBA+b+rpStqn5l2l1h2y8MqPKRIcs
         N/tQ==
X-Gm-Message-State: AHQUAuZeg1Anp0GHD0Lpbv+tPIOxBVi5LWBQWwXrYfsuXxQj5o0z2RH1
        s3a2paNDW0EGMXJKVvAvPM4=
X-Google-Smtp-Source: AHgI3IaXISGFwkthbAWLEA6y/aCqzB4L/6VddmrRjpSiN1ooITIEitVOGQNOS/OYDOhRrq0ILJ0cZA==
X-Received: by 2002:a2e:8e8e:: with SMTP id z14-v6mr4755141ljk.84.1549284517300;
        Mon, 04 Feb 2019 04:48:37 -0800 (PST)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id d23sm3056791lfc.11.2019.02.04.04.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 04:48:35 -0800 (PST)
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/2] iio:dac:dac7612: device tree bindings
Date:   Mon,  4 Feb 2019 13:48:33 +0100
Message-Id: <20190204124833.18779-2-ricardo@ribalda.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204124833.18779-1-ricardo@ribalda.com>
References: <20190204124833.18779-1-ricardo@ribalda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings for dac7612.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
---
v4 Changelog by Rob Herring <robh@kernel.org>

-Add ti, prefix to gpio
-Fix example da@1
-Fix partname

 .../bindings/iio/dac/ti,dac7612.txt           | 29 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
new file mode 100644
index 000000000000..14a66c0dcdaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
@@ -0,0 +1,29 @@
+* Texas Instruments Dual, 12-Bit Serial Input Digital-to-Analog Converter
+
+The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with guaranteed
+12-bit monotonicity performance over the industrial temperature range.
+Is is programmable through an SPI interface.
+
+The internal DACs are loaded when the LOADDACS pin is pulled down.
+
+http://www.ti.com/lit/ds/sbas106/sbas106.pdf
+
+Required Properties:
+- compatible: Should be one of:
+		"ti,dac7612"
+		"ti,dac7612u"
+		"ti,dac7612ub"
+- reg: Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Optional Properties:
+- ti,loaddacs-gpios: GPIO descriptor for the LOADDACS pin.
+- spi-*: Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Example:
+
+	dac@1 {
+		compatible = "ti,dac7612";
+		reg = <0x1>;
+		ti,loaddacs-gpios = <&msmgpio 25 GPIO_ACTIVE_LOW>;
+	};
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 30ba5435906b..e28e5afaae16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14882,6 +14882,7 @@ M:	Ricardo Ribalda <ricardo@ribalda.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	drivers/iio/dac/ti-dac7612.c
+F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
 
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
-- 
2.20.1

