Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bNePLzyaHlsAUAAAmS7hNA
	; Mon, 11 Jun 2018 15:50:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9B8FA607A4; Mon, 11 Jun 2018 15:50:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSK0sRi9"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 125E9600D0;
	Mon, 11 Jun 2018 15:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 125E9600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933188AbeFKPuS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:50:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37439 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933014AbeFKPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:50:13 -0400
Received: by mail-wr0-f195.google.com with SMTP id d8-v6so20949558wro.4;
        Mon, 11 Jun 2018 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUr+6NOSsNUEwURPfi8G1Ijjt8fnnFLs1nUeW5tCN0I=;
        b=oSK0sRi9gjEhUiOFhSau5Duy8Jn+N2RtWiCVnCpaju0rfcDg1DT+/ZYdNeki64VvzD
         qGag8fTdmmp35QTzruP+PYoOw8rdidV1ix1HoCkY7xpQgVVCBBO6QdVtALIZLQBqMjF6
         T1o77sCfdbTNVfQ50obL+a/VjjRTxBCSwLxQOoyzkxCE1llFb7h0lZk2ctHAekC15O+h
         PbGBnJpiAfNpy3NCEkH+wbEfUTlIN/a4+P3xlpsvfisWAyDj4+U8JzQzwd8QPvnJsEhg
         5c/bazbG740Phy3xIHvCXGPWamzCHcU9OdZcKQX5Ry/AEs0vEL1M/IfHlgxy/CaVNJdk
         fW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUr+6NOSsNUEwURPfi8G1Ijjt8fnnFLs1nUeW5tCN0I=;
        b=HGoiBwgurjZFj7mLPqi0JASYeFWbszoNYUS6aq6DKXlz3basuwX7E8b6jRwjvsAGKI
         WQYu5ej74/1oivKhn4Xl+YXVWVAwwYb/7DE/sF9aTlzH4w67wu2JOvmwVzx8qYmb+Xij
         IGos7gnYt0H6zyW52Y/F2wO1Z6i+H4lb7Anh0SqYF2jB4TyBqTkLBGTieWAe0aZrhtz6
         Gj71nqUlYHM1UhtX0RLIpKOvnWwx/B9K+TlYZ0qTF7zcucpNBsRg+QUFkNh8aW8lzC0U
         9yERtK/YG4P7MDlzCXCQcz/eGzgjPW8iMBCZHeURZNhwJts6nvNHGJDGVWQe5xgRpjLI
         kKFg==
X-Gm-Message-State: APt69E2zwGtfc4h3QEaSBDXhz8sb8DXnQoPBn8Hth45nA9jD+2bxNEBt
        2MeqQsaEGmvhucn3eYL9BtI=
X-Google-Smtp-Source: ADUXVKLI6WtBEQod9cOLr99RLOhLzxZ7xN2w5cc+oyjlXwABekfDOoj+WL1AG29N8SBwAWrZpsqzAg==
X-Received: by 2002:adf:ee91:: with SMTP id b17-v6mr14460364wro.21.1528732211704;
        Mon, 11 Jun 2018 08:50:11 -0700 (PDT)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id n11-v6sm30308862wro.13.2018.06.11.08.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 08:50:10 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Stefan Agner <stefan@agner.ch>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v7 3/5] dt-bindings: timer: add i.MX EPIT timer binding
Date: Mon, 11 Jun 2018 17:49:59 +0200
Message-Id: <20180611155001.3506-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611155001.3506-1-peron.clem@gmail.com>
References: <20180611155001.3506-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Peron <clement.peron@devialet.com>

Add devicetree binding document for NXP's i.MX SoC specific
EPIT timer driver.

Signed-off-by: Clément Peron <clement.peron@devialet.com>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
---
 .../devicetree/bindings/timer/fsl,imxepit.txt | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxepit.txt

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxepit.txt b/Documentation/devicetree/bindings/timer/fsl,imxepit.txt
new file mode 100644
index 000000000000..819d6458a860
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/fsl,imxepit.txt
@@ -0,0 +1,21 @@
+Binding for the i.MX Enhanced Periodic Interrupt Timer (EPIT)
+
+The Enhanced Periodic Interrupt Timer (EPIT) is a 32-bit set-and-forget timer
+that is capable of providing precise interrupts at regular intervals with
+minimal processor intervention.
+
+Required properties:
+- compatible: should be "fsl,<chip>-epit", "fsl,imx31-epit" where <chip> is
+  imx25, imx6qdl, imx6sl, imx6sul or imx6sx.
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: Should contain EPIT controller interrupt
+- clocks : The clock provided by the SoC to drive the timer.
+
+Example for i.MX6QDL:
+	epit1: timer@20d0000 {
+		compatible = "fsl,imx6qdl-epit", "fsl,imx31-epit";
+		reg = <0x020d0000 0x4000>;
+		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clks IMX6QDL_CLK_EPIT1>;
+	};
-- 
2.17.1
