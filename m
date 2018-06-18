Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD38C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482AD208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W4s9Y0RS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482AD208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967076AbeFRJEW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:04:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55759 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967275AbeFRIcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:32:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so12567804wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 01:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Irc22/bvfU1TrQYW/Xpkl9MXBBBmeXF/9pb1lAv2h68=;
        b=W4s9Y0RSFgpS/bYZeHAKNR4M+fSKfReTtE6tSI5nw/+OCjUacyYYyKtAcuzPP2z4qY
         QfcEfAp3uvxfKFbASHfVD05nfyXczCkmJ+orMry8A/Hr4IecFruK27Rzlhg4sbrwF48/
         zUBrFtJOgCvo6C9xM4gPsTVKWPZTrcYPFx7wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Irc22/bvfU1TrQYW/Xpkl9MXBBBmeXF/9pb1lAv2h68=;
        b=EYP8dtOGbENPs3U4xT688UcIsoXI5Fzq+e+iR4AOT9/ujmuBEuIFiX9tWhEeSki1s2
         DophCKEijFOcK3xw/brSw0ZHLPMnZmq1ynYgd8VS5DUvbm84snAxONeFXiu2Ovvf9s56
         WJSJW7mjanUjoJAhg79kypOBW3NWgvjUScoRrW7LYTG8sd/0JIlDZnId09ZuL9OnaUQF
         BUdS2BesSgo/0JOKwcxRGBU4uTdoUC/FpwoiiscUjitc+MTPWJAsaY+5dcZqFkpfBWym
         Qp1Yu+U79CwwU0PHAa+mdOvqv0p/J3lNzpOq6XgXLPF+MOqKPuxKC8KVJTUyu3gQrxaP
         H/cg==
X-Gm-Message-State: APt69E1WOqQESDdBOLQ6k2vMoUB3QDRtp8RFnipxiSBQKcQ5Jamq6y36
        CUFqIdpVyyF62uB3CIYQHtwoYw==
X-Google-Smtp-Source: ADUXVKIbvLcC490gUMPUYKS1zfTFB1KxheV/TyOcMYpemLDZoMc2Nx+W5xy+3XH55dAilp6COpxz5w==
X-Received: by 2002:a50:a844:: with SMTP id j62-v6mr10338249edc.210.1529310735071;
        Mon, 18 Jun 2018 01:32:15 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r10-v6sm6261992edo.77.2018.06.18.01.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jun 2018 01:32:14 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: [PATCH v2 2/3] arm64: dts: stingray: Add Stingray Thermal DT support.
Date:   Mon, 18 Jun 2018 14:01:18 +0530
Message-Id: <1529310679-13482-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529310679-13482-1-git-send-email-srinath.mannam@broadcom.com>
References: <1529310679-13482-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

Add DT nodes for thermal zones memory base address
to read temperature.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 99aaff0..db1cc67 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -593,4 +593,41 @@
 			status = "disabled";
 		};
 	};
+
+	tmons {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x8f100000 0x100>;
+
+		tmon_ihost0: thermal@0 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x0 0x4>;
+		};
+
+		tmon_ihost1: thermal@4 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x4 0x4>;
+		};
+
+		tmon_ihost2: thermal@8 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x8 0x4>;
+		};
+
+		tmon_ihost3: thermal@c {
+			compatible = "brcm,sr-thermal";
+			reg = <0xc 0x4>;
+		};
+
+		tmon_crmu: thermal@10 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x10 0x4>;
+		};
+
+		tmon_nitro: thermal@14 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x14 0x4>;
+		};
+	};
 };
-- 
2.7.4

