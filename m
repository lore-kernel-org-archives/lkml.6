Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09F1ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A63C2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk6WUUBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A63C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbeGMSqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:46:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43372 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbeGMSqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:46:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id r13-v6so25181495ljg.10;
        Fri, 13 Jul 2018 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4GSxZtM7bs09N+h61RbpI4cIW21aQS1iYyfxmvVGnI=;
        b=dk6WUUBOBriLgIqeZdudu0brkdzEC9g9jN9l8L6YDHvic7U66zh034DX5QEZ9VfgEJ
         bXN+nlwj6ZDm4evzk043UH4HCzT87NW85yHGURPMYlbM0EtqZqkXvZCAy/TeMfeS9L1Y
         RYEq5ULr9jpA+tXEbWvLTvF3zu25YRve5nMy09s5kKTOS0u4zUEMyaF0FsG3Th4llVtz
         W3i8/Ah9F3RlH9+iz0SZleQf3qn8EDbHJ4zRYC4rsQnRzkOybkohJRWt7d1Ysk8eA7pw
         nQnXgmAEiomHR8AxEAtpd9OnfMPYvTZoExlZ1CO52ajDXfVmsq3xZyQOh1YGMvc9adqQ
         zQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4GSxZtM7bs09N+h61RbpI4cIW21aQS1iYyfxmvVGnI=;
        b=EMXl7H5SvATW4RVAtJxX20LiNn+oO4ByOQVacwL0Qmj3ppR0+csQUooA6JLRqcOzXn
         xTJzl5Zoz2vfNzV9+lEyxqgJlo4r3BQid963PnzUmNANhYnEU3yk7F2GMV+GvUDyjWB4
         nEMl441cB2zsWtF11Az8/YwH+wGBPj6/yR09gpHSKtbaRd26WBUdyzEIQp3uTJrxEl4o
         eCh1BVMZj1Hyh+H1Nq7Ysvtw1r1QBzmjOFx4qHXzrr5QoWH0rEvsZh4COojhfbka6VLH
         VEEpK8sVDnroIk64595u0swyF5zsuegDMXoAIMq09+Qe92EYf2YXj9INDgeUj4xcanVi
         37AQ==
X-Gm-Message-State: AOUpUlFo4ezbl0Zqp2m0BnXvGLaq9JRDxfgX5SExKnjuTC3/GN8+zgJm
        g6LLhcNiIdn1SgCKyoTjJeg=
X-Google-Smtp-Source: AAOMgpeEkNaRUMcGe3jJXv5Dg4QIl9fvGev0VBbjNJFy83P5E4cbd+B5bnhjqgYYk4LIKQsnD28Mtg==
X-Received: by 2002:a2e:89c5:: with SMTP id c5-v6mr3929302ljk.19.1531506634409;
        Fri, 13 Jul 2018 11:30:34 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.googlemail.com with ESMTPSA id j12-v6sm491268ljh.13.2018.07.13.11.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 11:30:33 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 2/2] Input: atmel_mxt_ts: Document optional voltage regulators
Date:   Fri, 13 Jul 2018 20:30:08 +0200
Message-Id: <1531506608-24479-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531506608-24479-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1531506608-24479-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

