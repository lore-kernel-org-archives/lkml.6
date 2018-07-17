Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2808ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8342075C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik7O0BqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8342075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbeGQQir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:38:47 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41686 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbeGQQiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:38:46 -0400
Received: by mail-lf0-f65.google.com with SMTP id v22-v6so1238306lfe.8;
        Tue, 17 Jul 2018 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ievmCPOfA2lYaLJg84mR/nisVBqFLbu512+iDeovEK4=;
        b=ik7O0BqEa8/N10RKWJ3YhChRdBTiyZm4gb22FWCHQrQP2deRWHcoUuFcV3zrS47O/1
         4Hpwj1A51xo8IkqlIeuKZ6ioEF3F5fiuhI6+AP6LxsugwYQlUrTLIhRlmoyj1zZNPERz
         SCps54mpTxtdbwoyfSeZCyyA9q4uKU8YLYEc50sjKSNzhMLet88U5a7hjSZRR/We0cAY
         yrGVtVhzBgF823pOep8VIEuHmYMdjeP/KW7e//5pEgu/yi6uxBYZHVtU0uuB76lczuMH
         t7+Nuyr8mGoSFT2EWD/FofpKTjGad8BxJOxSZY6/ZfkI9GGA2xAJutjjNOv80Sx7iKWG
         P5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ievmCPOfA2lYaLJg84mR/nisVBqFLbu512+iDeovEK4=;
        b=Mey/bu+fCzhgvX2TPefC0stIjnw8Ldg5iKZctV6oVhHOQgf8/rMH0nLgTFULINYHib
         pSULm6K1QSu2VkjA7gsUr71BUka5NOCLIR9WsgFDD1YAAN7O1tAhP+UMIYhvtZEc/TOS
         WPGbNtkDhTjTjM6P9Ey6cpDNlqejtDgS6gCopmk7PBaU0dLocCcyyjcjNvQqNDuxj3v0
         6LqJwxq13lBI7FblomR/CQOKX+Z3H6Xj9s6WekhzClYOnqeyniShmzEeR6qZhCMmWTd5
         SI9dU8gcYlIoRbkwaHcMhGPlDf1SUqJp28XUUU/Ru9NzIMzjr7NlCHNliwSMxxDNqwas
         Im7g==
X-Gm-Message-State: AOUpUlEMi/WBFPPvvcqqqgLG+zNl0yIP0XuT2grrxSQdF0NmJL7XIZDS
        6YfK0DZxz68NwWAlcySq3V0=
X-Google-Smtp-Source: AAOMgpeiiaBzCmd4i6xZ1zCmibs2YvJjON7NC8I/HOdN2burEmpC78QD4WcJb1J91EXnDhOtkxK+AA==
X-Received: by 2002:a19:db44:: with SMTP id s65-v6mr1602235lfg.109.1531843523864;
        Tue, 17 Jul 2018 09:05:23 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.googlemail.com with ESMTPSA id d23-v6sm229861ljg.17.2018.07.17.09.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 09:05:23 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v3 3/3] dt-bindings: mfd: max8998: Add charger subnode binding
Date:   Tue, 17 Jul 2018 18:05:09 +0200
Message-Id: <1531843509-3533-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531843509-3533-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1531843509-3533-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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
Changes from v2:
  - Make charge-restart-level-microvolt optional.
  - Make charge-timeout-hours optional.

Changes from v1:
  - Removed unneeded Fixes tag
  - Correct description of all charger values
  - Added missing property unit
---
 Documentation/devicetree/bindings/mfd/max8998.txt | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Documentation/devicetree/bindings/mfd/max8998.txt
index 23a3650ff2a2..264040f4ad15 100644
--- a/Documentation/devicetree/bindings/mfd/max8998.txt
+++ b/Documentation/devicetree/bindings/mfd/max8998.txt
@@ -50,6 +50,24 @@ Additional properties required if max8998,pmic-buck2-dvs-gpio is defined:
 - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microvolts
   for buck2 regulator that can be selected using dvs gpio.
 
+Charger: Configuration for battery charging controller should be added
+inside a child node named 'charger'.
+  Required properties:
+  - max8998,charge-eoc-percent: Setup End of Charge Level.
+    If value equals 0, leave it unchanged.
+    Otherwise it should be value from 10 to 45 by 5 step.
+
+  Optional properties:
+  - max8998,charge-restart-level-microvolt: Setup Charge Restart Level.
+    If property is not present, this will be disabled.
+    If value equals 0, leave it unchanged.
+    Otherwise it should be one of following values: 100, 150, 200.
+
+  - max8998,charge-timeout-hours: Setup Charge Full Timeout.
+    If property is not present, this will be disabled.
+    If value equals 0, leave it unchanged.
+    Otherwise it should be one of following values: 5, 6, 7.
+
 Regulators: All the regulators of MAX8998 to be instantiated shall be
 listed in a child node named 'regulators'. Each regulator is represented
 by a child node of the 'regulators' node.
@@ -99,6 +117,13 @@ Example:
 		max8998,pmic-buck2-dvs-gpio = <&gpx0 0 3 0 0>; /* SET3 */
 		max8998,pmic-buck2-dvs-voltage = <1350000>, <1300000>;
 
+		/* Charger configuration */
+		charger {
+			max8998,charge-eoc-percent = <0>;
+			max8998,charge-restart-level-microvolt = <100>;
+			max8998,charge-timeout-hours = <7>;
+		};
+
 		/* Regulators to instantiate */
 		regulators {
 			ldo2_reg: LDO2 {
-- 
2.7.4

