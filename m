Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03020C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A1B2089D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NMnt9+d+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A1B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752965AbeGDSWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 14:22:35 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39702 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbeGDSWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 14:22:30 -0400
Received: by mail-qt0-f196.google.com with SMTP id q12-v6so5192044qtp.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u+F3y+yYo9Cwzf0kOPkoirfjGTzJkpMSd3SOiIee9qw=;
        b=NMnt9+d+5d2fpX42G8z52sOztaJdti2BTu4vpTRWcgdcy54FrgFzFMvI5AazwEbkL9
         D2fo1npD5rcNrfaUi5PoXfxyVXi2THrBJIIzIx5eBnc+A/6ftpcQS+TZXnwOvw+t8q2I
         MPSRcy4VmXz1lJQt1t6x+4KQOFTnkT+eFaW94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u+F3y+yYo9Cwzf0kOPkoirfjGTzJkpMSd3SOiIee9qw=;
        b=ULG9RDu7WZpcfgO/9YSC1d2ChhjfwxyZt8f8r3ZnCRPF1Ju+2K1rLtqlgaiG+x8qx0
         MnK3KUrKB9oE0DeVWZvpcVIGbmTIT9np1q2PKrSwAIvc16ptILO6MNq5QH2/Zq+ak/AV
         GAUvlmQVZ8+NO8ieeXF+Ofckf3BMdJEV0SAiHsZXMsN4fIqV/+CVa8DJHYSpBRZcjXpF
         FAOyAs/8U58FKYHzzDXERbMboQhbiOI2AQO8vs+J1Xbix8qX4nnf5MoeScuAw1qh87cP
         HQGAntW7gkO/SQ4vUC2wvzoYLluj6b6RD9xMqN3hiSqmIDKeWxkleGEyfW3H+XSIu7Tx
         thZw==
X-Gm-Message-State: APt69E1OX+cunAA/MyONkqTtovQJd3cI2rdY7aNPVKSBdWuYbl9CkHkw
        qxTi4c1qMfGaBGLrL1tz6R6E5Q==
X-Google-Smtp-Source: AAOMgpeipMrm/9oxh5OETgP2LJ/K5hHGOcwASM9c/GsLKoKmKkdT+76OKBNuY9FlUkQIRNlAzOnEjQ==
X-Received: by 2002:a0c:c309:: with SMTP id f9-v6mr2592625qvi.104.1530728549692;
        Wed, 04 Jul 2018 11:22:29 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p56-v6sm3485249qtc.7.2018.07.04.11.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 11:22:28 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v3 1/2] dt-bindings: phy: Add binding doc for Stingray PCIe PHY
Date:   Wed,  4 Jul 2018 11:22:12 -0700
Message-Id: <1530728533-28770-2-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1530728533-28770-1-git-send-email-ray.jui@broadcom.com>
References: <1530728533-28770-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for Stingray PCIe PHYs for both PAXB and PAXC based
root complex

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 .../devicetree/bindings/phy/brcm,sr-pcie-phy.txt   | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt b/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
new file mode 100644
index 0000000..5a13511
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
@@ -0,0 +1,41 @@
+Broadcom Stingray PCIe PHY
+
+Required properties:
+- compatible: must be "brcm,sr-pcie-phy"
+- reg: base address and length of the PCIe SS register space
+- brcm,sr-cdru: phandle to the CDRU syscon node
+- brcm,sr-mhb: phandle to the MHB syscon node
+- #phy-cells: Must be 1, denotes the PHY index
+
+For PAXB based root complex, one can have a configuration of up to 8 PHYs
+PHY index goes from 0 to 7
+
+For the internal PAXC based root complex, PHY index is always 8
+
+Example:
+	mhb: syscon@60401000 {
+		compatible = "brcm,sr-mhb", "syscon";
+		reg = <0 0x60401000 0 0x38c>;
+	};
+
+	cdru: syscon@6641d000 {
+		compatible = "brcm,sr-cdru", "syscon";
+		reg = <0 0x6641d000 0 0x400>;
+	};
+
+	pcie_phy: phy {
+		compatible = "brcm,sr-pcie-phy";
+		reg = <0 0x40000000 0 0x800>;
+		brcm,sr-cdru = <&cdru>;
+		brcm,sr-mhb = <&mhb>;
+		#phy-cells = <1>;
+	};
+
+	/* users of the PCIe PHY */
+
+	pcie0: pcie@48000000 {
+		...
+		...
+		phys = <&pcie_phy 0>;
+		phy-names = "pcie-phy";
+	};
-- 
2.1.4

