Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1ADC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B922421E22
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hFLesbDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B922421E22
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbeHIPUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:20:14 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34357 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732071AbeHIPUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:20:13 -0400
Received: by mail-qt0-f195.google.com with SMTP id m13-v6so6343887qth.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hrgHFPYoEpKqd3f/g1YAai5EWYLaffRXvvbW0KMIBAg=;
        b=hFLesbDPdSXHKgPwlrRRUEx1/BgINBV5GbKQ8nuHpHl/so8CtQxdDSbGyGt9ocwyN8
         h8eg2b1COodaDT88OvczolyqlkHyBjnmQYPF3HB4Bctn5P+mifycjb0c9dblgNAKAU0l
         IHCmro4RbTkDR4yJEp97YasdaAySOVpogxvYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hrgHFPYoEpKqd3f/g1YAai5EWYLaffRXvvbW0KMIBAg=;
        b=Vwhua1AAVgisFDiZCbvedh+zAy3saQsp4KeDth2/OespxA6noGbosE3l9VeoOeFVwJ
         QsRgvCQQkDfJBK+95njHNRuJi805+/S6YFDEgyuPAcjylgEkhjWTC4h3zAiY6Sz1N47I
         yCMagzNPyKGgWA9pLET3WngH14bmhsWhQxXY6VjvGhfl460lKsPpnwGkmJVtin7N1eUH
         PI5U0gnZkrcLJ4g0Q3Zb52gnRt41gq4DRXm7D/ihsibXcVUSniPKk3fLoRK3UbChrMy4
         cjDCDsJ5af2znv6flSD+0kVs1wvsTvv01iwlTXxd9HXmSF5AtBcbiZGjcz4mqFFbHVNu
         wqzw==
X-Gm-Message-State: AOUpUlE/vz/Myo8DCDSM7JNNvzIGnUWQ1uzig1ZBSv3abPuS+0dGeeQX
        ZIKN57yMRuHll7JbLtz2srCPBw==
X-Google-Smtp-Source: AA+uWPxoXVBLsW4vfpQReSAcbb828cpzGdsNvP6dihwP/EAfx0Rqqcy4Vg9JlQTRLPJ0HSecqoFJ0A==
X-Received: by 2002:ac8:365b:: with SMTP id n27-v6mr1851524qtb.141.1533819326039;
        Thu, 09 Aug 2018 05:55:26 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q51-v6sm4933654qta.92.2018.08.09.05.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Aug 2018 05:55:25 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 2/3] arm64: dts: stingray: Add Stingray Thermal DT support.
Date:   Thu,  9 Aug 2018 18:24:58 +0530
Message-Id: <1533819299-3401-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533819299-3401-1-git-send-email-srinath.mannam@broadcom.com>
References: <1533819299-3401-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

Add DT nodes for thermal zones memory base address
to read temperature.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index b203152..eeccf94 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -593,4 +593,17 @@
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
+		tmon: thermal@0 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x0 0x40>;
+			brcm,tmon-mask = <0x3f>;
+		};
+	};
 };
-- 
2.7.4

