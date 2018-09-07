Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAB6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD22320652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obeliks.de header.i=@obeliks.de header.b="Ugwt6RIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD22320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nospam.obeliks.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeIGWco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:32:44 -0400
Received: from scopuli.esotechnik.de ([79.143.188.15]:36696 "EHLO
        mail.esotechnik.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeIGWco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:32:44 -0400
Received: by mail.esotechnik.net (Postfix) with ESMTPSA id 51F3CAE0B82;
        Fri,  7 Sep 2018 19:35:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=obeliks.de; s=jul2017;
        t=1536341717; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kwVJxlRBwObGSuUluWCFRaIRGaCErdzhKSHHJ0CGFt4=;
        b=Ugwt6RIqCWXWrP/5Dqed1FsCEdDa/adjpl4hVfNuZKNfF5B4heXNqL79Z7SemHehsuwUPC
        8ydt+ABFbBqbIIY4571mnjax5NmENwZ3NuMPV6t1XTrIfn4zlo/SmcMUG5Dchp/4+eIqYr
        BWtoklbAIATAn+w4j4rwe/lke9F60gmH7obaWiW5sEp4FvAQ2S3KOb1kIsRKZcE9YK8fgb
        dYpsuzJOP7L9vF1O6NdOWKFFL3NL71j9KwMsOXOCBtKOjKIOHE8Nw+SZmGLxjuwJpP9qj/
        ZQZvxsWq9/usk+H5yOCJg4psxrkU6fo5CUmtyDfeelDZgzp3ls/4xaSOg5jbSw==
From:   Bernhard Frauendienst <kernel@nospam.obeliks.de>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: add bindings for mtd-concat devices
Date:   Fri,  7 Sep 2018 19:35:14 +0200
Message-Id: <20180907173515.19990-3-kernel@nospam.obeliks.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180907173515.19990-1-kernel@nospam.obeliks.de>
References: <20180907173515.19990-1-kernel@nospam.obeliks.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bernhard Frauendienst <kernel@nospam.obeliks.de>
---
 .../devicetree/bindings/mtd/mtd-concat.txt    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtd-concat.txt

diff --git a/Documentation/devicetree/bindings/mtd/mtd-concat.txt b/Documentation/devicetree/bindings/mtd/mtd-concat.txt
new file mode 100644
index 000000000000..2daf3157b163
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mtd-concat.txt
@@ -0,0 +1,36 @@
+Virtual MTD concat device
+
+Requires properties:
+- devices: list of phandles to mtd nodes that should be concatenated
+
+Example:
+
+&spi {
+	flash0: flash@0 {
+		...
+	};
+	flash1: flash@1 {
+		...
+	};
+};
+
+flash {
+	compatible = "mtd-concat";
+
+	devices = <&flash0 &flash1>;
+
+	partitions {
+		compatible = "fixed-partitions";
+
+		partition@0 {
+			label = "boot";
+			reg = <0x0000000 0x0040000>;
+			read-only;
+		};
+
+		partition@40000 {
+			label = "firmware";
+			reg = <0x0040000 0x1fc0000>;
+		};
+	}
+}
-- 
2.17.1

