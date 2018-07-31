Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E74C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90E2208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRuh8ctH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90E2208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbeGaQ7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:59:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38799 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732464AbeGaQ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:59:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so14055630ljc.5;
        Tue, 31 Jul 2018 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ozyljyZE5/C7EY8axOryS5s7IqJ0ZZxO+Vl7BYdn5iY=;
        b=VRuh8ctHjQjGIBoqE2jaQ97QN9brDFtuKJs6VBAaft+92mB5NlGc7MPgMhJZ7XP5ok
         JUEEva1RAP5kiPT7f8kLrDmMTzRCfVenhKNbmEWjw5grD1Z0Khs7f+Ob3AcdLpUYimph
         1hYPzjEJFjjak1KuwMExPVsu4RDqrNflT82WQg7BckKpAlb4d/X10obykr82m+pr9DZO
         Fb6DCATN8uUerapCXH0PV4xlG+kHfdrBe1scP66OkJ1YkMyjWLT90OGbLKvXuYqHdlCH
         iVwlwIbFoyXfVsAQDIZNqHfobLAFtJ6HJUHX2tKVmJ1BsflLmlEguDVqGYXThQe6yr0A
         pSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ozyljyZE5/C7EY8axOryS5s7IqJ0ZZxO+Vl7BYdn5iY=;
        b=STneEy693EQQ011Xg/m7XW6nUiA3WduxpwNT+/nQ8aFlm2rdeurimc1q+D4TNr0fIs
         8kj7lpjuRPPkqQHHzH4/yBrD5tHi8frVaqgt7okWLHNIilHtN2EUukO0jjVEomBleYox
         Z+oTkBW3Ipj3ZrV8BJn5czYlaDidGhEu2Xcyv9DVW3Zpn9am4pgFNo0+VL7X65ulOF6K
         aaNLJAr6pzwXTHQsKEgbwsbmExg5lmgCvBqxolIygpeKbdxzQH55NczwsIoJ5cspmpJj
         CZ6fm5k6eVb/Y4XRsjKnjJlodKFRaFvB6+TwuFSqKXyZdHOFxNcVLGdHHdku155d1EOY
         c8wA==
X-Gm-Message-State: AOUpUlHPqkO3W7gM/WTM5l3drExthDF/QctK7GGHiOaqmKK+qDeeUcvr
        /fmofM/f/GxRAvtPxrCYNqPHQHs5IxE=
X-Google-Smtp-Source: AAOMgpcl1yxJL5lSenU9P6c/GEPj7+8QwNHgltsab8X96sMwEmy/V2177dO5mfnPo+WcyMlRdUY1LA==
X-Received: by 2002:a2e:8:: with SMTP id 8-v6mr16647901lja.112.1533050304738;
        Tue, 31 Jul 2018 08:18:24 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-173-71.play-internet.pl. [94.254.173.71])
        by smtp.googlemail.com with ESMTPSA id p88-v6sm2606209ljp.90.2018.07.31.08.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 08:18:24 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v3 3/3] Input: atmel_mxt_ts: Document optional voltage regulators
Date:   Tue, 31 Jul 2018 17:18:11 +0200
Message-Id: <1533050291-11502-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533050291-11502-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1533050291-11502-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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
 Documentation/devicetree/bindings/input/atmel,maxtouch.txt | 8 ++++++++
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
2.7.4

