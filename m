Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4A1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF97A2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJXVQx8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfANUUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:20:24 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34729 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfANUUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:20:24 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so9197253itd.1;
        Mon, 14 Jan 2019 12:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWWBhP1h9Hc8koqBL0WoAsnfwYMffg2tUxcLnb26314=;
        b=aJXVQx8eoVLqaPznpemApvysfNRT9YNBTAlc8CFA5GA6iAFEBSy10RAYRmLas+MH5E
         uYdVStblctanEoV85psNUu7YUSGJolSoPzfFG/xZZZEUduNXHZ5cNnC0qqq6KuwXRr13
         L8PJs1ctAefWGe7Fj1rFhq7IvugVthgBnNVqGtJCWTkb6rnpvsdvzBMKoslzZbcYsNF0
         +EnowJx25DNBr2GvO8BgeV3dWgWVL0cxKgtfoSPnG2QPfdhyjKGgLOXJ+BVn2MW1gRQW
         +ATK8M+LE+reqna71alsfP/2v/1W9MFVNZxk/4eCm2iFgVZsUv/XySuq04oihqOgp9ky
         ZsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWWBhP1h9Hc8koqBL0WoAsnfwYMffg2tUxcLnb26314=;
        b=cXIF6XJ8ktwWUj4NPo+Izvzag1yYjo6kTOljfpGmWJPPh7BlQV69vb75QzN2RrGTd5
         e0OM4MczdvVGQe8ShtNmwl6LsPQVmTn/dELqANEyqUpkSOLGvGWJbg2n5KDpjjXSwpZc
         KGAlWw0AavT8nFw1uDJNsxbYDX2T093Br8cGgei7H4/GyYeX1aIi8/+hWlRTVmEwW4M9
         30n12ag/zoAPQ5Uk9fqcBjvEyv0UY2Xiu7PYgayHI9txMRI3SpyQy2ilKdpgCIKrmWPP
         TgwjHeb06coP2AgXMMVdaR3NpWh5UYZEqmdF+FaM8HTa1c/MMgH/DXD2fCUwKTA6FTxt
         Tpqg==
X-Gm-Message-State: AJcUukccMIoU70DQAZFzbFgTyjnQatB4UVi5wciiFKFcaucGfUneTjsk
        uW2Sc9wNFUkOfcgMdohUL0kwnTUBKL8=
X-Google-Smtp-Source: ALg8bN4hCJb1RQg2UKXVpEnvXFFDMk0GFlTlupPrTb8+pWeCe99Va1z69cH6ySbQgnkbVz2zWufJnw==
X-Received: by 2002:a24:32c5:: with SMTP id j188mr556895ita.139.1547497223149;
        Mon, 14 Jan 2019 12:20:23 -0800 (PST)
Received: from localhost ([67.218.223.154])
        by smtp.gmail.com with ESMTPSA id x128sm697210itb.8.2019.01.14.12.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:20:22 -0800 (PST)
From:   Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        himanshujha199640@gmail.com, mark.rutland@arm.com,
        robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org,
        Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Subject: [PATCH v3 2/2] dt-bindings: iio: chemical: Add bindings for bme680
Date:   Mon, 14 Jan 2019 15:19:14 -0500
Message-Id: <20190114201914.24572-2-sebastien.bourdelin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114201914.24572-1-sebastien.bourdelin@gmail.com>
References: <20190114201914.24572-1-sebastien.bourdelin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BME680 is a pressure/temperature/humidity/voc sensor.

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
---
v2 -> v3:
  - change i2c address to 0x76 as it seems more reliable: Suggested by Himanshu Jha <himanshujha199640@gmail.com>
  - rebase on master
---
 .../devicetree/bindings/iio/chemical/bme680.txt       | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/bme680.txt

diff --git a/Documentation/devicetree/bindings/iio/chemical/bme680.txt b/Documentation/devicetree/bindings/iio/chemical/bme680.txt
new file mode 100644
index 000000000000..7f3827cfb2ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/bme680.txt
@@ -0,0 +1,11 @@
+Bosch Sensortec BME680 pressure/temperature/humidity/voc sensors
+
+Required properties:
+- compatible: must be "bosch,bme680"
+
+Example:
+
+bme680@76 {
+          compatible = "bosch,bme680";
+          reg = <0x76>;
+};
-- 
2.20.1

