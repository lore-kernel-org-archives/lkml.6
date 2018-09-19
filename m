Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0B9ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292F52086E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbeZJ4ZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292F52086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeISULZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:11:25 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40353 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732265AbeISULY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:11:24 -0400
Received: by mail-qt0-f193.google.com with SMTP id h4-v6so5264240qtj.7;
        Wed, 19 Sep 2018 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6PZHZXzG2gUqodrftrjrMv9UkVaRrpj6xkdisoH7P94=;
        b=rbeZJ4ZRqjo4gMVplAcKiFPGdAUiBm9YmN08wucsOcjwpqggZ3LNvLFxG9YUk6Hlbk
         Q5dCrS8njA6aWAk3mqXsKcrsoty/IYS6WoTIyQmzspub7WQwdeDe5O3IjRsPDxLM9GXG
         TGlE3ePbSSwegWOlyVZ1JOjCVcMrgqNMsnXyrICPf35V9Ff91p3+RhfZBYEXFzLE1AKQ
         rx8F/6J/4xIaBwOHlDmZSwkBSutJDHXiv3Jg0wrLKseXpxwqJTteShj5syDk1zq+5A0o
         SoCj7i0erZyrIdxrJBPe8VkrCpwDAxu0C87+Fwz61CeHnLVVsjKu3+BbMF25x4xfDcP3
         1VOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6PZHZXzG2gUqodrftrjrMv9UkVaRrpj6xkdisoH7P94=;
        b=hOOS7OobhF5TZn2jshhV/HoPKPaNrpXtja9S/TYyQSAoyUzF9AEFlbBMR7v6OmXnFg
         7PGIF44EeVc4VI9MBfLfalyq5AVMpnqnrSzrL6saYj+uKUjrUoCPHkQfILEd210zPUpP
         NJdjMjZqOvQyYf2fVjzjdFMu7ySctjApKHzAu7BpYuFWXaCdes2rvjo0mNr5b2r1pAXO
         YZ9PgYliNhHIRfRdVLQaU6irBCgSTt7G0GyO6GYjT08mx797QQuG+SHgdlNF5krfDCHd
         nMVlhzky/V9ZGDu8ZdcmH0Id7uASRbgKrOxyxQ42b+4aQjP2ZKsLkirnHdq/CLBQf6oc
         1wxw==
X-Gm-Message-State: APzg51CFyy0X4rdToURZcWCNqBi6NR4J1f18bbTU7zQVPp8TiuoDh6W9
        ViJ01j1k8mBYaVO6QoSbz+vGD6y/
X-Google-Smtp-Source: ANB0VdYMCF7809XbGq2W0XuyXMf2X9OtjIgXOlkST6NLOe2qPMVvwdvEQTsW2HE6/XTy6lM78PzukA==
X-Received: by 2002:ad4:4089:: with SMTP id l9-v6mr25041164qvp.160.1537367591135;
        Wed, 19 Sep 2018 07:33:11 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 17-v6sm2104051qkf.74.2018.09.19.07.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 07:33:10 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 08/12] MIPS: BMIPS: add PCI bindings for 7425, 7435
Date:   Wed, 19 Sep 2018 10:32:03 -0400
Message-Id: <1537367527-20773-9-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the PCIe nodes for the Broadcom STB PCIe root complex.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7425.dtsi     | 28 ++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi     | 28 ++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts |  4 ++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts |  4 ++++
 4 files changed, 64 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index 410e61e..0edcbe4 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -584,4 +584,32 @@
 			};
 		};
 	};
+
+	pcie: pcie@10410000 {
+		reg = <0x10410000 0x830c>;
+		compatible = "brcm,bcm7425-pcie";
+		interrupts = <37>, <37>;
+		interrupt-names = "pcie", "msi";
+		interrupt-parent = <&periph_intc>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		linux,pci-domain = <0>;
+		brcm,enable-ssc;
+		bus-range = <0x00 0xff>;
+		msi-controller;
+		#interrupt-cells = <1>;
+		/* 4x128mb windows */
+		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0x0 0x20000000>;
+		/* 768M or 1GB memc0, 0-1GB memc1 */
+		dma-ranges =
+			<0x02000000 0x0 0x00000000 0x00000000 0x0 0x10000000>,
+			<0x02000000 0x0 0x10000000 0x20000000 0x0 0x30000000>,
+			<0x02000000 0x0 0x40000000 0x90000000 0x0 0x40000000>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &periph_intc 33
+				 0 0 0 2 &periph_intc 34
+				 0 0 0 3 &periph_intc 35
+				 0 0 0 4 &periph_intc 36>;
+	};
+
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 8398b7f..50bc7a0 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -599,4 +599,32 @@
 			};
 		};
 	};
+
+	pcie: pcie@10410000 {
+		reg = <0x10410000 0x930c>;
+		interrupts = <0x27>, <0x27>;
+		interrupt-names = "pcie", "msi";
+		interrupt-parent = <&periph_intc>;
+		compatible = "brcm,bcm7435-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		linux,pci-domain = <0>;
+		brcm,enable-ssc;
+		bus-range = <0x00 0xff>;
+		msi-controller;
+		#interrupt-cells = <1>;
+		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0x0 0x20000000>;
+		/* 768M or 1GB memc0, 0-1GB memc1 */
+		dma-ranges =
+			<0x02000000 0x0 0x00000000 0x00000000 0x0 0x10000000>,
+			<0x02000000 0x0 0x10000000 0x20000000 0x0 0x30000000>,
+			<0x02000000 0x0 0x40000000 0x90000000 0x0 0x40000000>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &periph_intc 35
+				 0 0 0 2 &periph_intc 36
+				 0 0 0 3 &periph_intc 37
+				 0 0 0 4 &periph_intc 38>;
+		status = "disabled";
+	};
+
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index 0ed2221..22270a9 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -152,3 +152,7 @@
 &waketimer {
 	status = "okay";
 };
+
+&pcie {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index 2c145a8..91bc1ec 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -128,3 +128,7 @@
 &waketimer {
 	status = "okay";
 };
+
+&pcie {
+	status = "okay";
+};
-- 
1.9.0.138.g2de3478

