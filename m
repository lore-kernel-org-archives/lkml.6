Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218EFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70F120856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwXSDmNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbeL1QS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:18:59 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42061 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbeL1QSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:18:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so19056583lja.9;
        Fri, 28 Dec 2018 08:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VPTqR/NzmUP1Wul0aNxp78EL3f6kYB4v+Ag3WPPcrKg=;
        b=cwXSDmNZZWiczSKWBk/SCxRIp590NyY+UjX9pdCeYzjJHP4NP3AostVNWWhIr9F1UH
         XhwuV5sbGOR2vlaVczSTSS26T41B80JFjpWTgWbCxsykut9JlBgnXUGnM8Vr8KYv+c0X
         Y8VbVNwjtiXKdsgjPK6oNaUIGdGsJIEmcBfPIVGSsT3LWKQ5LNrE9b9pL7q3wnrCZAne
         XIm30Tgh5qqJMvAsRU+nnra7JgeRc9hgKdy++n+vDuatfwTWGgILUTfo+xiVpDyRRDVD
         k1xMXNojYPO15j4q/btA0u69GQZP/BX1O9hB78cBCDVOX1xxW3OqwYz7Zi7ria1WBX2h
         bgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VPTqR/NzmUP1Wul0aNxp78EL3f6kYB4v+Ag3WPPcrKg=;
        b=rp2Bn37WDaSL86QXFTWonGa9L9omE7kVC8Mj5i5s6x6cqtOfLxuIuQB+cgAfR9wWHf
         aoBw5qd98SCpfd+QAOpr17vM1cJAXNcvkfkA2in+kvuXpnfwZTi9UDdV62HXM4KVPFQq
         FYaD63WaAvwxr7j8qMP5AxJSjyN/vwuSeDQFKepuTq8401hVBmsYG6sSVzr3P94KYRVC
         awIUMj/OQtWpK228iv9YgmP5m7l/fGxpjijpT+bVcMrdB40Eece9kNogvumeO97OId1R
         xKOk7/5nlVHeycJy0QBmD8c1M0GFRLUqZLfcu5fPvvP0/BB91vjgSkOVqlTmMyxODT1g
         EXnw==
X-Gm-Message-State: AJcUukfdXH4yN3Rqn7giT105qAvMAAWyG4LJK+kJNRrTfBdRwt2Drg5u
        JI/oPeJHlF6nT5o6kOeLUAY=
X-Google-Smtp-Source: ALg8bN7vhbcxBxIUfk+PmZCMDZupq1zYbzPLi0ZpXHL7/tBc90xphfD81cJH9cKIDY5cZnRYpgLB3w==
X-Received: by 2002:a2e:5d12:: with SMTP id r18-v6mr18419477ljb.89.1546013917644;
        Fri, 28 Dec 2018 08:18:37 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id r4sm8136502lfe.60.2018.12.28.08.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 08:18:37 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] ARM: dts: s5pv210: aries: Add reserved memory for mfc
Date:   Fri, 28 Dec 2018 17:18:17 +0100
Message-Id: <20181228161819.18931-5-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds memory reservation required by MFC to run.
On S5PV210 both regions needs to be on separate memory banks.
Size of both regions is taken from stock sources.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 575094ea7024..35ba009a1a33 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -23,6 +23,24 @@
 			0x50000000 0x08000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		mfc_left: region_mfc_left@43000000 {
+			compatible = "shared-dma-pool";
+			no-map;
+			reg = <0x43000000 0x2000000>;
+		};
+
+		mfc_right: region_mfc_right@51000000 {
+			compatible = "shared-dma-pool";
+			no-map;
+			reg = <0x51000000 0x2000000>;
+		};
+	};
+
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpg1 2 GPIO_ACTIVE_LOW>;
@@ -329,6 +347,10 @@
 	status = "okay";
 };
 
+&mfc {
+	memory-region = <&mfc_left>, <&mfc_right>;
+};
+
 &pinctrl0 {
 	wlan_bt_en: wlan-bt-en {
 		samsung,pins = "gpb-5";
-- 
2.17.1

