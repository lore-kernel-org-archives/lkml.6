Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADF6ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94682214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NzKaUFA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94682214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJSS7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:59:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37013 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJSS7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:59:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh10-v6so2331784plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 03:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SosU5iF7Ey+1v+4vcDwsnnSkHEG3BRB043fFaX95JpI=;
        b=NzKaUFA7uW8Qqw8bJsA1H+ca3lfOsCI6241EZDrw0IQeIIQalm5JvoUuM84ae154wx
         VCkdfzJnHGvuUbuWHqxSza5v7L+9rNuKO8LCsxBUYOs4iyw9z3ldq7WXnVN5qRZzQdZ1
         o72Vob3LeIT0oOHbUcfZoMmONULWd17TwL51g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SosU5iF7Ey+1v+4vcDwsnnSkHEG3BRB043fFaX95JpI=;
        b=n0+glMikWtRMjPgjdnP9Xga3P1t+MBBeO1nmVEOiI5q34pRtY6VvqbXxbPrRKMYHgw
         OJJlDA79IcDmVXc9QSt3I2nKBwT5aRRXTJPcLyCWq5X07eK634D2/7QyPN93VrJm6L/1
         LljF6tNv7V/ck3j4lU/pDjaT7Z9tNt2TePaCpnlvSpefr7LkaEbtVUO7duuAZu7o1wfz
         rkkb7hVJEY0glCZZ5dUhK8ZtqxBUH+dc68Wc6nB4IU5xcOB6uPTt/aEhjuLeOiJebuha
         V0grD4NBLaik6mJekK5Vi0wRyVMGBuc/eKYu++55GsqtcNCEefT+E3NL9zKoFtQ+tUXw
         CnOw==
X-Gm-Message-State: ABuFfoiaKxqoP/DzReJfnosX01kpIBB1gz6UIbIEkfI3SAceonImuA77
        HxdKxPiZGUNLg9LSWOnkap1ecg==
X-Google-Smtp-Source: ACcGV6106ejfio9Q8lrybMNCFXBJUgbCsudni40iKHwEV5qi3r4J7Cw569PhIEq2YDiEBXyR7g6L+g==
X-Received: by 2002:a17:902:a7:: with SMTP id a36-v6mr20823295pla.87.1539946412361;
        Fri, 19 Oct 2018 03:53:32 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m67-v6sm54918pfm.13.2018.10.19.03.53.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 03:53:31 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v5 1/6] dt-bindings: power: Introduce one property to present the battery internal resistance
Date:   Fri, 19 Oct 2018 18:53:10 +0800
Message-Id: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The internal resistance of a battery is not a constant in its life cycle,
this varies over the age of the battery or temperature and so on. But we
just want use one constant battery internal resistance to estimate the
battery capacity. Thus this patch introduces one property to present
the battery factory internal resistance for battery information.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes from v4:
 - None.

Changes from v3:
 - Split binding into one separate patch.
 - Add LinusW reviewed tag.

Changes from v2:
 - Rename the property.
 - Improve the commit message.

Changes from v1:
 - New patch in v2.
---
 .../devicetree/bindings/power/supply/battery.txt   |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index f4d3b4a..938d027 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -22,6 +22,7 @@ Optional Properties:
  - charge-term-current-microamp: current for charge termination phase
  - constant-charge-current-max-microamp: maximum constant input current
  - constant-charge-voltage-max-microvolt: maximum constant input voltage
+ - factory-internal-resistance-micro-ohms: battery factory internal resistance
 
 Battery properties are named, where possible, for the corresponding
 elements in enum power_supply_property, defined in
@@ -42,6 +43,7 @@ Example:
 		charge-term-current-microamp = <128000>;
 		constant-charge-current-max-microamp = <900000>;
 		constant-charge-voltage-max-microvolt = <4200000>;
+		factory-internal-resistance-micro-ohms = <250000>;
 	};
 
 	charger: charger@11 {
-- 
1.7.9.5

