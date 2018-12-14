Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EF0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31029206A2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA+sTsi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbeLNPMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:12:47 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44148 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730425AbeLNPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:12:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so5167567lji.11;
        Fri, 14 Dec 2018 07:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XFPTtMJpSFiF4PFAqSj6g1FCx0iqQrUaJq/0mQ1Us/I=;
        b=AA+sTsi+2r9TaO4AjoiPveHi7QEZ6CyRaTCdXyKbmlI4V5cPPLC9vA20OsRILHzxQr
         CvZg0bUe/UPRkXVS0MVkXtL6IhiWSOfC8Kex/z1PmxDwJchTZm4w+muB6fO9ewNLO+as
         XyS86vKWHrbwDakwcrtK8Ol3ZbSCqYn251CyJjaeuF1BOY6QpNqzP2ygsQ+7zLkid0gB
         hVA9d4lK73+xUAZeUDzFPv0m1UGCnRpfA1DEY5OSjFhs7u07FasCp7QwhuOTcZP0JWPj
         anWcHm7OQpXHjxwVdu7QwF6x2wSJQauFEY6WcE1OE+hJkLwH7cHdgNkSNKlrPcnrQeWo
         kfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFPTtMJpSFiF4PFAqSj6g1FCx0iqQrUaJq/0mQ1Us/I=;
        b=qmbJYsMna5X1EKgaelBrC83ES0dQ5aX6A6MB+fBqpFBw6gLFwLyVPK8XvNzABy7GeH
         Hze6QHdWclL2t7HDUVklqAw4wjpUp5fLXPLdJgiA1wM8pwjlnchfCsjiOFXpvmt79Iqu
         Rv1Ymq9ldlnPgGeKPPLFvPCIQUfxLmGSKkAvU3MPF1pEnJ+x9sDPHiM3hZgIcrMHFwkc
         vMEeyfgil67ktZBE64GWvOh/jQYg8C3OMck/x3XsAXsJVPaoST9BCcOpt1K5Nm2OHGg4
         +PsVya4rHO32U4xftCgSYj2FMUidQR3UUpYssYryNz7L3zXu2faNOlsj0Z9f32QiylWB
         7q9A==
X-Gm-Message-State: AA+aEWbz8V3ih/Wb2jt41bmcl+vzLGYYG/lV6Bx5xuso37SOvQBNOcTC
        8Tk2VWNkwwoc5+NDTpTFsvZP/Bjs+eI=
X-Google-Smtp-Source: AFSGD/UpvwuG6QLqDJlXq4Uy1lBkqEcft6k+rwE4UIl4p+PwyZEFl5PQO5/79a6L9O4ktaEg+Nx93Q==
X-Received: by 2002:a2e:87c3:: with SMTP id v3-v6mr2259538ljj.13.1544800363045;
        Fri, 14 Dec 2018 07:12:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:976:99fb:a7e3:627c])
        by smtp.googlemail.com with ESMTPSA id o17sm951975lff.77.2018.12.14.07.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 07:12:42 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v5 3/3] Input: atmel_mxt_ts: Document optional voltage regulators
Date:   Fri, 14 Dec 2018 16:12:14 +0100
Message-Id: <20181214151214.5391-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
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
 .../devicetree/bindings/input/atmel,maxtouch.txt          | 8 ++++++++
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
2.17.1

