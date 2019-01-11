Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514B7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26312218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToWKXzoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbfAKTdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:33:02 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50947 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732371AbfAKTdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:33:01 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so4354583iti.0;
        Fri, 11 Jan 2019 11:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HI4PTAIhhLhQfiaKKjEHEUmrLNj0YGMEMyV9ySNdkQ=;
        b=ToWKXzoGwR9lXTeA96pFL8t5agtwEr2lBWtlpeIwGcAhP0xCDmRZveZ4mHLxcJkpG4
         Nq9jeWCdWF/LIE1dg5WcYtyod0bG8d9+H+mLF7eQGvCrglNaAbd3YenrjBUiMPvs92x3
         WsnJBNKQIRU1Su9jhFbT4ExHSqQpRniwqIDb8eUhnyHu92Qf2+UbFJ4YpGVYVe3hm1/X
         BhJIB8gnREy92VDwE2WtjGln1waEJCw7L7uJ0AIFF8m1ypE2kgF1i0MDDfajUoTay5h/
         /Q2oO7DQMedwHePNwWIIomDtcrtphUZDQgdGzJA/XgRMcsmUQsmGv/0GTN0/7VhluVIf
         +8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1HI4PTAIhhLhQfiaKKjEHEUmrLNj0YGMEMyV9ySNdkQ=;
        b=FlAvPLjQXyCDJ9BhFhmVQOEo1d5p3JDa+/o044ziQRrJiAew4ET8VMPDtUwaBxL2Sn
         yVM2/8xOb3aRf/+tNw7qAaWA+MxQL8khwgtvKDXIADhXxOH48/LDcv01J9Mx5tZ1vPNc
         Ny95mP7aE8+2k8eY+ZkCFAPvVaQY61iAl0TZ695OfCg3F3VI3oaS0evthDeSxN1vdChL
         AzBIMRcdl6AsqrC6m69djijpg/2CQ0XSA4BX9zQBwnK2dBUSolHTy2l6yKxEtOJAN4qc
         IvvVzW0HScXn1yPmWyxSY/WmtBJZvgvaBQ6UxQfLPjGR4KDaW1FSFkrDgavdNHmt43ku
         IYVg==
X-Gm-Message-State: AJcUuketOrEeTcfmovurIqLLWGjGbQagF9zOt+uflhkyf6FyL3A/PvnB
        1ebDrqR0y/WWx3QhP6mP0Xq4o06XGaA=
X-Google-Smtp-Source: ALg8bN6PziUpYQTgSMD/PMUc6KBnJC1yuQlsvPBObxq/A9dZapJssSp0ygdEpReQUcG3nG6DTE4aEA==
X-Received: by 2002:a24:3dd5:: with SMTP id n204mr2265194itn.104.1547235179023;
        Fri, 11 Jan 2019 11:32:59 -0800 (PST)
Received: from localhost ([67.218.223.154])
        by smtp.gmail.com with ESMTPSA id z10sm33992203ioh.20.2019.01.11.11.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 11:32:58 -0800 (PST)
From:   Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        himanshujha199640@gmail.com, mark.rutland@arm.com,
        robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org,
        Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Subject: [PATCH 2/2] dt-bindings: iio: chemical: Add bindings for bme680
Date:   Fri, 11 Jan 2019 14:31:41 -0500
Message-Id: <20190111193141.20607-2-sebastien.bourdelin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111193141.20607-1-sebastien.bourdelin@gmail.com>
References: <20190111193141.20607-1-sebastien.bourdelin@gmail.com>
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

