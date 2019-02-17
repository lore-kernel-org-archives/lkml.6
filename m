Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47489C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CA0218FF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EYAWN59C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfBQJOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:14:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45828 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfBQJOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:14:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so6956422pgc.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 01:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sRJ5c25qWheOilSsmmqZvMXVbqNH0bBR8OITkpzpTAc=;
        b=EYAWN59CkpvWDLmEzMxKccC1PtFVeDykVwj+2tT8DUboiQpc7kgqhdcTh/uteNIULn
         gLKdoC4Xx9G4Zyue9vQsQLKp26uiSvuX+F4LKi3IEZbEkZ+E3qhn9mVd98MvOJc0DrfB
         9J6LlJIY0cyDISWOTr2ADY9kfi1J2tVQZm6OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sRJ5c25qWheOilSsmmqZvMXVbqNH0bBR8OITkpzpTAc=;
        b=lyIbSM8onxEBtoYdJqJTnjEYWFOrOqTVTBAh4IUUaj/Ri2XGHSWbA+tV0cGSxK+UwM
         4ReZ5aCyDG/0UIbfva9kjcxeDlRQ6RARX1FeGqQEYbmUQTK1xH5BTDaTeGw3vIhUywJ/
         sgj5bo7QzOJQYnG1rVXrfsLKSaO49XLsjNGMKjFsRt3/5GXfJ7s5ta7sAn+1kC3akuI9
         V8g+6TnLqh+DD+jNQXp2LlFNhq4cNM4pEhwr/p3YJrd8hBt34GeLvTcFyOeaJfW3JzVo
         L8J1zwSg+b+4RNj9nOt8mczMNDqdJ9uTjkNL+hb1siIp1VSMs/TAlyaY40GePBWAnAkh
         1J3A==
X-Gm-Message-State: AHQUAuZcuFBat47zsU/oHP3D3dC/5OSJLzmYPSaeQKURHwr9JVQTubJ3
        xTumaGcRuW7i5D8x+ZDFr4+5Yg==
X-Google-Smtp-Source: AHgI3IZQBeiGGFaMLpHeHDrMxTamYUB6ozF96bpS0PWn1MCNLPIziWwk1DynUBUX598J/98IpANTOw==
X-Received: by 2002:a62:be0b:: with SMTP id l11mr18846152pff.52.1550394890791;
        Sun, 17 Feb 2019 01:14:50 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id v15sm5565924pfa.75.2019.02.17.01.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 01:14:50 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 1/4] dt-bindings: input: touchscreen: goodix: Document regulator properties
Date:   Sun, 17 Feb 2019 14:44:33 +0530
Message-Id: <20190217091436.3702-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190217091436.3702-1-jagan@amarulasolutions.com>
References: <20190217091436.3702-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goodix CTP controllers support analog, digital and gpio regulator
supplies on relevant controller pin configurations.

Out of which AVDD28 regulator is mandatory supplied regulator in most
of the board designs, so document AVDD28 as required property and
rest marked as optional regulators.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../devicetree/bindings/input/touchscreen/goodix.txt       | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index f7e95c52f3c7..8f6e6eede64d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -23,6 +23,13 @@ Optional properties:
  - touchscreen-inverted-y  : Y axis is inverted (boolean)
  - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
                              (swapping is done after inverting the axis)
+ - AVDD28-supply	: Analog power supply regulator on AVDD28 pin
+
+Optional properties:
+
+ - AVDD22-supply	: Analog power supply regulator on AVDD22 pin
+ - DVDD12-supply	: Digital power supply regulator on DVDD12 pin
+ - VDDIO-supply		: GPIO power supply regulator on VDDIO pin
 
 Example:
 
-- 
2.18.0.321.gffc6fa0e3

