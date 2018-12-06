Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CED2C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C0F20645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MrwJZ4fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C0F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbeLFJp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:45:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51115 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeLFJp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:45:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so309479wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 01:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7J3xZHVOI+hzAANlNNiS0Za6N/YwngUnZ25+nCJd4ms=;
        b=MrwJZ4fcSnjluNbHaWOvnJrOPyjczzg16oZWoVzqaLgNIR03bzYsQOCJnSDrAPfDLz
         oSpd3D1A/W0T4tdu8jNR5F1p5FRjet4IIHLkCuEpNVnUynsQnwjP0QxgpgFfT8T71C5X
         q0tcotQrDu4NsKERMAjpMOSy3DfpWiPjILYoRxJ7Mg8HYLYfQYNfqfq+uqFa0z5MXOCO
         C3+3vXWHYkgCAXUWF4Gd9tCHagFQeC6kpzHF/lqC6ZOHo45G5d+s4O7xLJDi96nKGLHD
         n4fzg8+CbCjzWwv3VyPV4VmJcyupyHOZDS4XYeQwh1m69Mpz0HQf+cwYHccz0JbykgQA
         uEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7J3xZHVOI+hzAANlNNiS0Za6N/YwngUnZ25+nCJd4ms=;
        b=RBb9wd0rWTM1sjpNB5QaECdJx0Wbxq/asKyMHVrAy+JZj4WqVj8VkvoyQauu5hXHPy
         62LuxwGRWzWzHinodYeyOJ19vtQWjE+nqYenW0FwOK8MIITPfvXrl6WwM+hT4dWMPZH6
         5giCPaTHmnVwOMZf4g4DHwqXYa9eitEwRr6RfP0wpqN7u//Kko5na4HNYOtFNkA1iCYm
         +m3FyK3Nfm4ZlwxpMX2NYOmW5axqxloOpyPG6nNN2XTpe4Fn7h0QVIBRNpKPG5eSKMyB
         wPntzu84v/uDNfHsCvb7vgJmX3mYukLOQHoFvrEgiDB/h8Y+/3c5K9GV43nXE4j7idE4
         I8DA==
X-Gm-Message-State: AA+aEWZ3gkbQoLJwDOnslcdJHuaGFyQwZKTH1REwj0ZB2pDoLwAuHx7m
        riTYg91yFo7eRQRGqlWKNjfFQg==
X-Google-Smtp-Source: AFSGD/XPSWWDSWUa6X5Byb0K+d+Bjq0g7kosqbLv1xonkTPLdMwVpFn2Hx+liX773kt8BujBASMXGw==
X-Received: by 2002:a7b:cb96:: with SMTP id m22mr19654412wmi.39.1544089553821;
        Thu, 06 Dec 2018 01:45:53 -0800 (PST)
Received: from debian-brgl.baylibre.local (astlambert-681-1-11-11.w90-86.abo.wanadoo.fr. [90.86.132.11])
        by smtp.gmail.com with ESMTPSA id o62-v6sm333735wma.1.2018.12.06.01.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 01:45:53 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] dt-bindings: i2c: use correct vendor prefix for atmel's at24 EEPROMs
Date:   Thu,  6 Dec 2018 10:45:50 +0100
Message-Id: <20181206094550.18082-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to Thierry's patch which missed a few occurences.

Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 Documentation/devicetree/bindings/i2c/i2c-at91.txt        | 2 +-
 Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
index ef973a0343c7..b7cec17c3daf 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
@@ -33,7 +33,7 @@ i2c0: i2c@fff84000 {
 	clock-frequency = <400000>;
 
 	24c512@50 {
-		compatible = "24c512";
+		compatible = "atmel,24c512";
 		reg = <0x50>;
 		pagesize = <128>;
 	}
diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
index c661b9083ec6..8b1e49cdce3f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
@@ -54,7 +54,7 @@ Example:
 			reg = <1>;
 
 			eeprom@50 {
-				compatible = "at,24c02";
+				compatible = "atmel,24c02";
 				reg = <0x50>;
 			};
 		};
-- 
2.19.1

