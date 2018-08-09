Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCBEC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177E721E1F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VptZ2CTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177E721E1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbeHIPUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:20:08 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44091 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732007AbeHIPUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:20:08 -0400
Received: by mail-qt0-f194.google.com with SMTP id b15-v6so6271218qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FeTHl3nIWlmQhz0zBfBlt7yDqz1LnXB3sHmX2You0q4=;
        b=VptZ2CTjEWMwR4dDsY+uoKceCNBQv/Q0wa+74hIKFCz2qKuuXTs3Ke0g5+iGrFG8+l
         bcGbaKCg9lbCdCSdd/NJv5TttheNFBFSh5AlJdJt+rAaypqpJVvSNplKzIFpStqklpYg
         3pJluZffnnCRL+9N3mchR70GYsy3XpIcbVljM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FeTHl3nIWlmQhz0zBfBlt7yDqz1LnXB3sHmX2You0q4=;
        b=sFhKbuR7yQM3eUizCkPPP1uApdGxm7nfuCrw1CnW8FqYXGQQChY/cKi05t8Pgskz0j
         kQjJxBzSlwp7gFxODIKtH1mkXko+VDZRXU0HF4UggZt3r4vgWJE4s2mD7mSMSWyer3rW
         6B8SHBMANPu/CsmJ6O4Lc1r+vqS+be22+5mshwkoMWoJzgR4iElB8e9Yiaea6nu4ow8X
         UqQ1w8lsKsI3UJPHqav8Cz1IfF9Cug5my+trKf1MfqOdfVlYe59U47FFIRsja3FRFNrx
         4KORayDi5u8MrNPzrUPwAIKK/xvcykdUNL9mr0GHZtEFR6kVNMetUyuJGCXsqVq7blvi
         4s0A==
X-Gm-Message-State: AOUpUlEPEGxDjGghSIfOTBBZUsv5ic3deX2gpvVbPyIS/lFahekNF3iG
        JIN7GTROSS/0KwZ7JYv98Wey7Q==
X-Google-Smtp-Source: AA+uWPwMM0TbrcvNaRlDXrQhw2IzA1Cyb5ZLMPT+TPsCWkXniX8BDj7YZ526AqAlqWQqWAjhz0pocg==
X-Received: by 2002:ac8:3644:: with SMTP id n4-v6mr1807687qtb.323.1533819320312;
        Thu, 09 Aug 2018 05:55:20 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q51-v6sm4933654qta.92.2018.08.09.05.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Aug 2018 05:55:19 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 1/3] dt-bindings: thermal: Add binding document for SR thermal
Date:   Thu,  9 Aug 2018 18:24:57 +0530
Message-Id: <1533819299-3401-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533819299-3401-1-git-send-email-srinath.mannam@broadcom.com>
References: <1533819299-3401-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

Add binding document for supported thermal implementation
in Stingray.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../bindings/thermal/brcm,sr-thermal.txt           | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
new file mode 100644
index 0000000..fc9e6d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
@@ -0,0 +1,23 @@
+* Broadcom Stingray Thermal
+
+This binding describes thermal sensors that is part of Stingray SoCs.
+
+Required properties:
+- compatible : Must be "brcm,sr-thermal"
+- reg : memory where tmon data will be available.
+- brcm,tmon-mask: A one cell bit mask of valid TMON sources.
+                  Each bit represents single TMON source.
+
+Example:
+	tmons {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x8f100000 0x100>;
+
+		tmon: thermal@0 {
+			compatible = "brcm,sr-thermal";
+			reg = <0 0x40>;
+			brcm,tmon-mask = <0x3f>;
+		};
+	};
-- 
2.7.4

