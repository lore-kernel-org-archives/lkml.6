Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D976EC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6A924D06
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="SeBt8hv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6A924D06
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeFWVJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 17:09:42 -0400
Received: from vern.gendns.com ([206.190.152.46]:36224 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752022AbeFWVJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 17:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=21ETbAllMpuE2YPDA6nXyh4uKvUM4+PiuQmZKI8NrdM=; b=SeBt8hv4lGxIkAwcU3G1zvMFh
        SQx0GSqakUoG+YlsRtxAi+0C5S/9QHZOw/MLnXlLiO7JTovwT8SS0nTvJVE5f1zCYCYCyelhVc5Jt
        qg/ffA0yLYhZIRAyqtjeUDJhYiz0pXZCjS/BfszxqVoWEZ7H3YDBNLVIlWDboRrKm2UqNKrdctwe2
        dTM+rSnf+MHTFp4Ofiv8vILDKsagp3hydtMjbQR9zaGRbiew8IzPxqbhcYZeNc0q12fXfECibrnPZ
        wT3SkSI5OgomRAYccKZXwPCtZB4vYB7/no0LIRMQqmG3sUTNI87faj2KZHuWAwVM5MUCex/rCStgf
        QTWXpU78A==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51098 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fWpmq-00CkwS-3t; Sat, 23 Jun 2018 17:09:37 -0400
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
Subject: [PATCH 8/8] ARM: dts: am33xx: add node for PRU remoteproc
Date:   Sat, 23 Jun 2018 16:08:10 -0500
Message-Id: <20180623210810.21232-9-david@lechnology.com>
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

This adds a new node to am33xx.dtsi for binding the PRUSS as a
remoteproc device.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 9cd62bc2ca35..1e7837af4689 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -924,6 +924,15 @@
 			};
 		};
 
+		pru_rproc: cpu@4a300000 {
+			compatible = "ti,am3352-pru-rproc";
+			reg = <0x4a300000 0x80000>;
+			interrupts = <20>, <21>;
+			interrupt-names = "pru0-vq", "pru1-vq";
+			ti,hwmods = "pruss";
+			status = "disabled";
+		};
+
 		elm: elm@48080000 {
 			compatible = "ti,am3352-elm";
 			reg = <0x48080000 0x2000>;
-- 
2.17.1

