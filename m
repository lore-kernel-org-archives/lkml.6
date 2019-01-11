Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C80EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F902133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtEZw6NF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfAKUzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:55:01 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52880 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfAKUzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:55:00 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so4754969itg.2;
        Fri, 11 Jan 2019 12:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HI4PTAIhhLhQfiaKKjEHEUmrLNj0YGMEMyV9ySNdkQ=;
        b=EtEZw6NFJHES8kV224Qg1+F9GOquEvrU15z/OBnmePl/smUqrCyhXHRdJLuSwHskop
         eovaoKBBT7MHgMWHpoz96XhzC5zfn1phZAHF2A4abMxVPGPNCopeMPM+k6E95mo2kfFu
         74A/pzdbm/eQM6uXNuy1NXJVaU8m7www981UzKYhpamgoxLYYEZUL7PYeuVA1+PwBR0D
         4SwFjh5MxcVL3MpBHqBFx6BOkcN/71zaG3xagf+s4nhKs7ZJ26s5Gem/g0vA6QPOc5LJ
         n6S4KSDqDt5FyHNaTywkFK8+Xkxjyt5ZHU8s/JxrHba3j9cAObO0AFtqXtHM5A0BddWD
         xCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1HI4PTAIhhLhQfiaKKjEHEUmrLNj0YGMEMyV9ySNdkQ=;
        b=Fw+s3Eu7GGvxGVGJT/Cx7M+aIzM1iSTMl6txYmaOiaJLTAD9+6ww0n9/2U+LuBteqy
         Wp9SeDKp57hvrp89Z7mYfYnaFlOZNRswSSvhGfGg/yHMwza1E01hnEs4NNjRpVfn6lys
         4dBn/FN/BLbnGz5tYCiAGmwECAyCUq2v1yAFlD0P7XtYRZBAKgVR2uLie/7Bv/WA2nBT
         OzJC646/5cw2B0XRnJVptqi5CErXVJwM6cpMnO0EbnWWlvWV9R5jDF43xtCImyLq5I1e
         kTxfHh6qt/Kse+GlqMC/4z1tsb5DhX//UIQuJaGauoVNRJi3sozAXfVwFZ+X/9TA3wRo
         eBvg==
X-Gm-Message-State: AJcUukcU05wrZZT5jCzPkUPGv/O8mDOC9R3UPD4hC0m0cxNovXbE6a3Y
        3K41fHZEsbpH5bq1k/K40fEeU8E2pkQ=
X-Google-Smtp-Source: ALg8bN4ECw1fjjcdVSJx/8dToj3YgfBn1hQurkFvjOdwiGhjPY+86MTl75wSqMWmCa2HXMh9co8gzA==
X-Received: by 2002:a02:8894:: with SMTP id n20mr12184112jaj.52.1547240098915;
        Fri, 11 Jan 2019 12:54:58 -0800 (PST)
Received: from localhost ([67.218.223.154])
        by smtp.gmail.com with ESMTPSA id y21sm34930550iof.51.2019.01.11.12.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 12:54:58 -0800 (PST)
From:   Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        himanshujha199640@gmail.com, mark.rutland@arm.com,
        robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org,
        Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: chemical: Add bindings for bme680
Date:   Fri, 11 Jan 2019 15:53:59 -0500
Message-Id: <20190111205359.14158-2-sebastien.bourdelin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111205359.14158-1-sebastien.bourdelin@gmail.com>
References: <20190111205359.14158-1-sebastien.bourdelin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BME680 is a pressure/temperature/humidity/voc sensor.

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
---
 .../devicetree/bindings/iio/chemical/bme680.txt       | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/bme680.txt

diff --git a/Documentation/devicetree/bindings/iio/chemical/bme680.txt b/Documentation/devicetree/bindings/iio/chemical/bme680.txt
new file mode 100644
index 000000000000..885a1b918340
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
+bme680@77 {
+          compatible = "bosch,bme680";
+          reg = <0x77>;
+};
-- 
2.20.1

