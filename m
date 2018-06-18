Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A66C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624C820864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iJ5uLm43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624C820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967274AbeFRIcO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:32:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50220 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967253AbeFRIcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:32:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id e16-v6so12584145wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 01:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iR2v+kuN30ftELoSNPlNUv88TqryikV5EH7A4LGx1N4=;
        b=iJ5uLm43Jy4tPmMc1jhVWy5YigG2Qb0GoHcd90mOKCev2096WOADShmNC5ZCfgliFV
         scElJZwso2R9DMWzNOdV4oGLCPuf7kiM50l2ND25P4FAku7o0t0TcX/hjb6HBsMHLCHK
         bmcniKGewxVHUaMVks4VsNd0rskGPljo78SLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iR2v+kuN30ftELoSNPlNUv88TqryikV5EH7A4LGx1N4=;
        b=YqGBGlmet9p0fZ1uZ9YTsdVO8jnZArUooa+zJw9cO9yKgVOxW6qS4IVXmLUfsD0ctr
         /dhIGftiGhJXDAMtjvcEhBVNU4qr91YYsk/3AnoGa8Ck3k/D1DQ5EqKqpeVhH1wCiDIm
         1Yicc3XSBCPtEt1Ef7SSjwLIYEaOOJNAMUKV8ubsDoelq+ywgyups4/+2tG8TUuX999b
         uFzD8fARV3X3gTs72BvlQOdQjBP1mfgpl+UpqVlkcAMSbzM1jZo8l27EvdLLWSko+uhr
         armYm+Z9XR1KxCH06EByFqORuhzEYtH4xnZwZUSw68QQRXcAfjNkYLJ80wZK04Kj/uct
         ypcQ==
X-Gm-Message-State: APt69E2sFQ7TGc0dY7BJvc/D19T6RaT9S95wUohMM5x9rbdouYMIqe9z
        pdco8zccbAuGvnZDn6B6S364Fw==
X-Google-Smtp-Source: ADUXVKJZVZD8CDKXpTDzvDYmzMxahPA56kOeMOz4GdTtXbJKJai6HagnZGb5hyqJVSbZbfo/54IApw==
X-Received: by 2002:a50:e615:: with SMTP id y21-v6mr10382330edm.278.1529310729492;
        Mon, 18 Jun 2018 01:32:09 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r10-v6sm6261992edo.77.2018.06.18.01.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jun 2018 01:32:08 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: [PATCH v2 1/3] dt-bindings: thermal: Add binding document for SR thermal
Date:   Mon, 18 Jun 2018 14:01:17 +0530
Message-Id: <1529310679-13482-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529310679-13482-1-git-send-email-srinath.mannam@broadcom.com>
References: <1529310679-13482-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

Add binding document for supported thermal implementation
in Stingray.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 .../bindings/thermal/brcm,sr-thermal.txt           | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
new file mode 100644
index 0000000..33f9e11
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
@@ -0,0 +1,45 @@
+* Broadcom Stingray Thermal
+
+This binding describes thermal sensors that is part of Stingray SoCs.
+
+Required properties:
+- compatible : Must be "brcm,sr-thermal"
+- reg : memory where tmon data will be available.
+
+Example:
+	tmons {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		tmon_ihost0: thermal@8f100000 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x8f100000 0x4>;
+		};
+
+		tmon_ihost1: thermal@8f100004 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x8f100004 0x4>;
+		};
+
+		tmon_ihost2: thermal@8f100008 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x8f100008 0x4>;
+		};
+
+		tmon_ihost3: thermal@8f10000c {
+			compatible = "brcm,sr-thermal";
+			reg = <0x8f10000c 0x4>;
+		};
+
+		tmon_crmu: thermal@8f100010 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x8f100010 0x4>;
+		};
+
+		tmon_nitro: thermal@8f100014 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x8f100014 0x4>;
+		};
+	};
-- 
2.7.4

