Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id z2P1FjE6GVuFFQAAmS7hNA
	; Thu, 07 Jun 2018 14:06:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 42C01608C1; Thu,  7 Jun 2018 14:06:17 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3dYiJ+T"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A3773602FC;
	Thu,  7 Jun 2018 14:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3773602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932906AbeFGOGO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:06:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38226 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932578AbeFGOGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:06:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so6424265wmf.3;
        Thu, 07 Jun 2018 07:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4xQu35NKdZryjxoFd0n+XVKmVWi5YIPE1muIXvtypkE=;
        b=P3dYiJ+TQytf2wsZ1ekaS5nO6GNvVWvEJmEj5bvzjVhWqfa72SQu6nbU+P0J3/9Pjv
         BRfVW6U8RHQcbuepqCdU7/ur/wXejeNQ3EuQ9PXVK1MahdhnCnfDyRVVhgYfHC1FaUgM
         OYFe7fQEnS9xTmtjrphPpEP6gBsg2PPJFCfhZWjZQyKzBk1zP763HNv5yP5uY+BBfIoD
         8r59MLbWl1CEwn4il2Pt+737h5nqOejjeT6QSF49w3Sqnw3d1o5BNFfRbnqcNfl22Imz
         5wZ6KW6gA7s8t+MGoGy+ltOZIYOFhTv2YGhirfBXRhVqL2B9jAxyMlxkYEQrk8IgX/At
         F6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4xQu35NKdZryjxoFd0n+XVKmVWi5YIPE1muIXvtypkE=;
        b=l4CdD7ai43xl5pXySCNQCsXlqL3Tpl0VIipdSWOhoKDGw6Fzr2EW+i1oZoTkp6Y8pO
         ZbDgVw+6troc59WK24r5aIgVAHsNYMAK0nKHhhEzvwYfCnl7C1Cdaj9RnAkP0qNgEn19
         OVz/m1nuF3iNH02/oyRwJY4742Li2ZMlTHZZ8yQy6HuTFxdiLsxEr89dTeoauayPHygk
         Emqs1l8eY1bJjHqFL6t+fFzQc6sl+IGno/YYKg1nP4s7Yo/X0IA0vQDqiWU0+sDOK8ld
         IO6dsfsLxPeNJnxYy7JQk7R/OVefL5c5Utk0AqKHpQrLXKze4SQHUgeo3lOb+1abEJDi
         LH1w==
X-Gm-Message-State: APt69E0QwNfkSTzxep6CGaAgQVH7zmhSpLXMJxhYkFU6G9ea+TiYcfm4
        yDLOKWS4M779R8oWKSWXt9U=
X-Google-Smtp-Source: ADUXVKKVGYfDO49JVhQoMcxyVs5THdPkempDaleawu5XIUvGKlvzWVgReifJxFtIWRMSbG7HpAEBAA==
X-Received: by 2002:a1c:7e87:: with SMTP id z129-v6mr1787675wmc.131.1528380367724;
        Thu, 07 Jun 2018 07:06:07 -0700 (PDT)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id 135-v6sm2032331wmx.21.2018.06.07.07.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:06:07 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v6 3/5] dt-bindings: timer: add i.MX EPIT timer binding
Date: Thu,  7 Jun 2018 16:05:42 +0200
Message-Id: <20180607140544.22268-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180607140544.22268-1-peron.clem@gmail.com>
References: <20180607140544.22268-1-peron.clem@gmail.com>
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
