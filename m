Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C14C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E11624D0B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="U6MOgnxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E11624D0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeFWVK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 17:10:57 -0400
Received: from vern.gendns.com ([206.190.152.46]:36184 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751582AbeFWVJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 17:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZNDAquXZ5nBxMw2hpkYc6dhZAG+MFPDo7JuhqyDUils=; b=U6MOgnxHWTEjQRADE4zNCLwx1
        TQCqaizpxzAJ9UbihcvOvol7UUAOw8huz4bT8DuAwtiNnVBIteAI3LeHxEhsg5DBYJgQx3g0781wQ
        qqhbpL+CElJFvLwf9d2UOhGi96Z/1ogblv9Y9M4EdT3O6JWG1lFppGegzsjXUho5Ddr1Y2I28oaf8
        rWwQGnh705iLv2P0fO6L1yWlzJ7BxdAb1q9HXroWPW+O/4rTW6IwtSABh9gON4z0qCEt+cVbfsmJg
        xTeZv31RiUvJueBFZtG4qccFCIFcOvm64slMO+VVMLQ0iLk8wQITAHO1DR51Dl8gwyRZmaWRIXlQh
        L6ATUhbVg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51098 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fWpmi-00CkwS-Gu; Sat, 23 Jun 2018 17:09:28 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     David Lechner <david@lechnology.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] dt-bindings: add bindings for TI PRU as remoteproc
Date:   Sat, 23 Jun 2018 16:08:06 -0500
Message-Id: <20180623210810.21232-5-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180623210810.21232-1-david@lechnology.com>
References: <20180623210810.21232-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new binding for the TI Programmable Runtime Unit (PRU)
as a remoteproc device.

Signed-off-by: David Lechner <david@lechnology.com>
---
 .../bindings/remoteproc/ti_pru_rproc.txt      | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt b/Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
new file mode 100644
index 000000000000..0e80a8db46d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
@@ -0,0 +1,51 @@
+TI Programmable Realtime Unit (PRU)
+===================================
+
+Some TI Sitara SoCs contain a Programmable Realtime Unit subsystem with two
+processor cores that can be used for hard-realtime tasks.
+
+
+Required properties:
+--------------------
+The following are the mandatory properties:
+
+- compatible:		Should be one of the following,
+			    "ti,da850-pru-rproc" for AM18xx/OMAPL138 SoCs
+			    "ti,am3352-pru-rproc" for AM355x SoCs
+
+- reg:			Should contain the memory region for the PRUSS
+
+- interrupts: 		Should contain the interrupt number used to receive the
+			virtualqueue kick interrupts from the PRU (i.e.
+			PRU_EVTOUT0 and PRU_EVTOUT1)
+
+- interrupt-names	Should contain "pru0-vq", "pru1-vq"
+
+Optional properties:
+--------------------
+
+- power-domains:	A phandle to the power domain that powers the PRUSS
+
+- ti,hwmods:		Name of the hwmod associated to the PRUSS, which is
+			typically "pruss"
+
+Example:
+--------
+
+	// AM18xx
+	pru_rproc: cpu@30000 {
+		compatible = "ti,da850-pru-rproc";
+		reg = <0x30000 0x10000>;
+		interrupts = <3>, <4>;
+		interrupt-names = "pru0-vq", "pru1-vq";
+		power-domains = <&psc0 13>;
+	};
+
+	// AM335x
+	pru_rproc: cpu@4a300000 {
+		compatible = "ti,am3352-pru-rproc";
+		reg = <0x4a300000 0x80000>;
+		interrupts = <20>, <21>;
+		interrupt-names = "pru0-vq", "pru1-vq";
+		ti,hwmods = "pruss";
+	};
-- 
2.17.1

