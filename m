Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2692ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE9A2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0S/L33b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE9A2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbeGNMqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 08:46:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39914 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeGNMqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 08:46:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so6241609lji.6;
        Sat, 14 Jul 2018 05:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wh7GzlNbA4xHoPdoWLkTmb0jFMR0vUEuUFJC+vi/QOs=;
        b=m0S/L33bo9+n9BI9dOGkKYo2jG+70/RLfuu3ZwRGqP0UwpluDsIlovWvWr9vPlqGSj
         LB16piiWX467RR4VfxCtt5Y2KPnPjeLErzF60d+AZ+3khTmfcrQD9Z69HHf7vdbnGMjv
         Pn+M7Vbcv3xDROXZJ5Ryun6K2CpNfc/ahkT+i+tjrsHVqj+9im8PAczAEQukuSs1oCEy
         oPSlBlzRERzmGV1BtP+T1uVb27ID3WTHQbTaqd7HsnVBYaWZbBNJtCmiHNms1+Hr+F5s
         JjxLWRqPbVrXVxo6I/kooHw9eFpU8C/KYmIuFoSPZOPOzYgyAhJbVvOEIiJPp4NTOTBz
         cATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wh7GzlNbA4xHoPdoWLkTmb0jFMR0vUEuUFJC+vi/QOs=;
        b=s1lJGHyOmNnZj2gQuuluySAxP6IO55u7lopZw4SvuejuQaEuEcLeFz/RskjTDVSiPR
         tA5MoVkCcRDvymuhDx5r1oY5OR6CTGEFrC91GPblDHX9PkXlUPImcIMcQyUU1jR1vcZu
         I1mAOO8Xpvua7A0JKkMksJZb7HcmMWY82aX94hQaXMdqVVughhYa+dkyK079oUDkhOQA
         V1OnLlkP6MKou9nyYR309dNeHvaLuYDLHFhSVasp2pUn0zeuBtWJ1DhUzt0At/K7LDIg
         GoQHw9kjOshgmKOBMItOk9kWXlxE2elVqeTFQV4FaoyOgP26/9/S9vobgyzth/qHmI3M
         blpQ==
X-Gm-Message-State: AOUpUlHzz3cMlWLGc2kltxBZlUn7ZF4fe/DT58xsEASV2goImN2Dihte
        MHm3btbB3IikOsXDeR5PwFs=
X-Google-Smtp-Source: AAOMgpcWOlLpyvEVjN44f2+YS6ixgfGMqFwn5wc3bH3JAaOHYSvSsnHT9EBFPjX4RUIAUw8WIipmzQ==
X-Received: by 2002:a2e:2d11:: with SMTP id t17-v6mr5747469ljt.145.1531571223508;
        Sat, 14 Jul 2018 05:27:03 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.googlemail.com with ESMTPSA id l3-v6sm5860732lfi.36.2018.07.14.05.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Jul 2018 05:27:02 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 3/3] dt-bindings: mfd: max8998: Add charger subnode binding
Date:   Sat, 14 Jul 2018 14:26:53 +0200
Message-Id: <1531571213-30593-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531571213-30593-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1531571213-30593-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds devicetree bindings documentation for
battery charging controller as the subnode of MAX8998 PMIC.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v1:
  - Removed unneeded Fixes tag
  - Correct description of all charger values
  - Added missing property unit
---
 Documentation/devicetree/bindings/mfd/max8998.txt | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Documentation/devicetree/bindings/mfd/max8998.txt
index 23a3650ff2a2..196e50097a36 100644
--- a/Documentation/devicetree/bindings/mfd/max8998.txt
+++ b/Documentation/devicetree/bindings/mfd/max8998.txt
@@ -50,6 +50,23 @@ Additional properties required if max8998,pmic-buck2-dvs-gpio is defined:
 - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microvolts
   for buck2 regulator that can be selected using dvs gpio.
 
+Charger: Configuration for battery charging controller should be added
+inside a child node named 'charger'.
+  Required properties:
+  - max8998,charge-eoc-percent: Setup End of Charge Level.
+    If value equals 0, leave it unchanged.
+    Otherwise it should be value from 10 to 45 by 5 step.
+
+  - max8998,charge-restart-level-microvolt: Setup Charge Restart Level.
+    If value equals 0, leave it unchanged.
+    If value equals -1, it will be disabled.
+    Otherwise it should be one of following values: 100, 150, 200.
+
+  - max8998,charge-timeout-hours: Setup Charge Full Timeout.
+    If value equals 0, leave it unchanged.
+    If value equals -1, it will be disabled.
+    Otherwise it should be one of following values: 5, 6, 7.
+
 Regulators: All the regulators of MAX8998 to be instantiated shall be
 listed in a child node named 'regulators'. Each regulator is represented
 by a child node of the 'regulators' node.
@@ -99,6 +116,13 @@ Example:
 		max8998,pmic-buck2-dvs-gpio = <&gpx0 0 3 0 0>; /* SET3 */
 		max8998,pmic-buck2-dvs-voltage = <1350000>, <1300000>;
 
+		/* Charger configuration */
+		charger {
+			max8998,charge-eoc-percent = <0>;
+			max8998,charge-restart-level-microvolt = <(-1)>;
+			max8998,charge-timeout-hours = <7>;
+		};
+
 		/* Regulators to instantiate */
 		regulators {
 			ldo2_reg: LDO2 {
-- 
2.7.4

