Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A254ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6BE20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrlWsmkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6BE20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbeGQSua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:50:30 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44452 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbeGQSua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:50:30 -0400
Received: by mail-lf0-f68.google.com with SMTP id g6-v6so1521730lfb.11;
        Tue, 17 Jul 2018 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4GSxZtM7bs09N+h61RbpI4cIW21aQS1iYyfxmvVGnI=;
        b=JrlWsmkO927Cp7xLgEl/sDPO85HMo0gDJZvdp7hj9tkyzXDtlwPpJ31iVLhG9eh+iq
         0A7dtiHdaGQXs7Id1bFHTdsrSMzLQluSzG+LUaVYN+M1zej36Ot5cKF0/ucelGz36gqF
         2a5qbOLoi8SRAgpIYVEv+s4Ch52l+ES90DDXlDBcp2b7Sb5EfCyOQk0ZN2xHAuvHrdql
         S4dBAOkLpp0pEAvsysLkhhe3lvQ5M4+GccjL8eEmQ8FmB9hpz0vqQMVSjMmuWjSep6ch
         04rHJJybOI82Hw6BP220L5T0r/+pqXgh+pcF0iZg4Ti5qVjGp9Fa3KIuoScIzCadQWIo
         lv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4GSxZtM7bs09N+h61RbpI4cIW21aQS1iYyfxmvVGnI=;
        b=FvmFPHabItsSlL6JydHSYwOm7ZDLNzfXvmQr4BwaPHsxHOi1mXV1EHI0qxYnHRIn5c
         ScwvnsjaiCHu8THP60OenS3JoIZomwUL5K8/nTdY3R+LOO/dica0esjhiRxPkdsfn19e
         nSHvWj2ED2YDlezVnc8bAXdQCOMUQ3P3N28jB6F9fGkGbOz9QziDsv2Ytm93vqX759XC
         5k9yw7fg4HuqZYLgYrlqPdeGFQoTcdBEcyLRdrSA5KrLeYMCuyOqT2NCGA8rlMgmdXpU
         Jg7TC1JpFtjh9NNhsjrrwMF9wBG9F539+gduk3Axv2qHiXQ28bYK9mh0+MS6wnFLdiY1
         YaLQ==
X-Gm-Message-State: AOUpUlG9g/jyw3GawhixCRPmEAI49JBqd3HFg/NLiJMhDgM+GFBzMMaL
        LM614jsOB+k2MLwP97CUqok=
X-Google-Smtp-Source: AAOMgpfjJQJT6EnKuNunC/A6qYEWL0Zvf8jcv0kivwbImJodUACfYv7ygsGxI+VOwGCEsue8MHp8nA==
X-Received: by 2002:a19:d7d1:: with SMTP id q78-v6mr1890180lfi.40.1531851398281;
        Tue, 17 Jul 2018 11:16:38 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.googlemail.com with ESMTPSA id u19-v6sm260911lje.51.2018.07.17.11.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 11:16:37 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 2/2] Input: atmel_mxt_ts: Document optional voltage regulators
Date:   Tue, 17 Jul 2018 20:16:26 +0200
Message-Id: <1531851386-17840-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531851386-17840-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1531851386-17840-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

