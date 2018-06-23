Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1967CC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27D324D06
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="rCVbw4x0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27D324D06
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeFWVKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 17:10:01 -0400
Received: from vern.gendns.com ([206.190.152.46]:36214 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751967AbeFWVJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 17:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YZOcb97MCD3PibKaF4dn8eXvxk98fS+/5AgfJmzYkko=; b=rCVbw4x0zbJQYo8eF4/18itYd
        2JbN9v/HPyVkPX2PLcd2CLtCUVRUfNbjqyDwrn8rhZ3Y2M2SwGWceQWdBuX7BDt9YfZPN86K3XUam
        jeAm47QKxM7HM+Wcn3fEBHtH4fLbF3xxj6rTMuq6plXIxkeCUe8MCmlbUSen1UOGkteIRoM60sAg4
        eIEJUYhbv/OlOd0GhGHJSEBFP+XEfLHx7Tivv29i2RlZz+2dkZjom1ZhwvvKz0NTyFpZE9huHCcpL
        5gUyv0cCbTOuq4HprnnbudoqLUBq3AYHFHqFBQxqbMlHCg+XinBEIMmkyYN54CeiW9+AMQsM6PrJl
        wTx7BtDrg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51098 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fWpmn-00CkwS-BZ; Sat, 23 Jun 2018 17:09:34 -0400
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
Subject: [PATCH 7/8] ARM: dts: da850: add node for PRUSS
Date:   Sat, 23 Jun 2018 16:08:09 -0500
Message-Id: <20180623210810.21232-8-david@lechnology.com>
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

This adds a new remoteproc node to the da850 device tree for the PRUSS.

Signed-off-by: David Lechner <david@lechnology.com>
---

Note: this requires the recent common-clk patches for power-domains

 arch/arm/boot/dts/da850.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 3fc8b8fd816e..8b052e96fb53 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -540,6 +540,14 @@
 			clocks = <&pll0_auxclk>;
 			status = "disabled";
 		};
+		pru_rproc: cpu@30000 {
+			compatible = "ti,da850-pru-rproc";
+			reg = <0x30000 0x10000>;
+			interrupts = <3>, <4>;
+			interrupt-names = "pru0-vq", "pru1-vq";
+			power-domains = <&psc0 13>;
+			status = "disabled";
+		};
 		mmc0: mmc@40000 {
 			compatible = "ti,da830-mmc";
 			reg = <0x40000 0x1000>;
-- 
2.17.1

