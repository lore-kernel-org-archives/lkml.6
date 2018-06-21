Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A7AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0A420652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vdwa7Y8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0A420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933096AbeFUASw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:18:52 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45253 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754439AbeFUASu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:18:50 -0400
Received: by mail-qt0-f194.google.com with SMTP id i18-v6so1330467qtp.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 17:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gb4Pdm2QqFbIguGcTHmoGZ+awF8acNwZlEFaB9WSCwQ=;
        b=Vdwa7Y8MHxkxYnMnYO0wy8EEKpQ+cjJbadsP8TDvpmi6HPR9SSS8vljgv9RhUiCT7I
         i+noW6ng4B0q5E3uFymaKK6rqzrvixwI98oQ1DVDb1+mjA843Xx+eNwSu62BLat4wAbS
         4VZX4RhXqKL4ZGw8xErnO3Ag8+GYiZ03oHlFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gb4Pdm2QqFbIguGcTHmoGZ+awF8acNwZlEFaB9WSCwQ=;
        b=mfLgT8G7YWDI0sCB0WKPvbGpdGACjHilYNyi/oNeZ6Ym+edM7Cli7589wunKHl12O1
         6oBw+HwRxh8jveE5/lMdvM1Z1JVFozXlqFP0sSyvBso+XxNTfPuTrGUacgan6UNvj5W6
         VYxndjUllmqpMUh8jy4CdD2Ffe9Kbb1yORPNWqQd/kAEXgZ5WZqk08FDozBdGzFumR2S
         IOVPw8KuZbj/QspzO/mvJFqoLTefJS72+Jo6Hr1lJ+ZL8Fk1bDuQpNPw8S8YOIv9Ikrv
         b1uQd0OXCowQSMec0TZXcH7UO+P8vNJCBkjkXl0JAEmG/Ensc9ok4cyI+/ACrhNoNbmr
         4msg==
X-Gm-Message-State: APt69E0d8G3cA0Ufwutw6PQjz4L8y39JVAnrXTTseyaXvd8sKqv0IK3G
        D1K/+t00NacveGEEplE8S/9ANQ==
X-Google-Smtp-Source: ADUXVKLh4QCbzi9i8zM74HVFx4KTCM0Lgqq/+GwidK1N7Ox9YmC8q86FB+5nFrxNYEzJ6JNVedTrww==
X-Received: by 2002:a0c:c111:: with SMTP id f17-v6mr20834567qvh.105.1529540328658;
        Wed, 20 Jun 2018 17:18:48 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t13-v6sm2778156qkt.53.2018.06.20.17.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 17:18:47 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: Add binding doc for Stingray PCIe PHY
Date:   Wed, 20 Jun 2018 17:18:35 -0700
Message-Id: <1529540316-21706-2-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1529540316-21706-1-git-send-email-ray.jui@broadcom.com>
References: <1529540316-21706-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for Stingray PCIe PHYs for both PAXB and PAXC based
root complex

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../devicetree/bindings/phy/brcm,sr-pcie-phy.txt   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt b/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
new file mode 100644
index 0000000..c2eede6
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
@@ -0,0 +1,39 @@
+Broadcom Stingray PCIe PHY
+
+Required properties:
+- compatible: must be "brcm,sr-pcie-phy"
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

