Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E3DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FCD223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS3f3rBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FCD223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbeKOImw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:42:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:36278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733164AbeKOI3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:25 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C03322544;
        Wed, 14 Nov 2018 22:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234260;
        bh=8MWU8JAfSzjbGXva6fgpsaHEvMjZFsEwCcHtGRpQkCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gS3f3rBN+ZIgtenB+5Rn85/70K7uSXUOIX/xEb3e25HOH7JIUhUyIzucu6MFZu3S/
         PMYXQH3rlwBDA/CQcteceU7nkZmx5wMLhaTaRRshdUqVrDMf61yWRdeJAGH/BvzGjo
         dujpOnaouDFD7YHlYKq7RMAae2rVv06Muh5A7xQI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 24/59] ARM: dts: fsl: Fix improperly quoted stdout-path values
Date:   Wed, 14 Nov 2018 17:22:56 -0500
Message-Id: <20181114222335.99339-24-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 1af6ab3bac8458fc2e92ad7bb97b62de4a1fddef ]

A quoted label reference doesn't expand to the node path and is taken as
a literal string. Dropping the quotes can fix this unless the baudrate
string is appended in which case we have to use the alias.

At least on VF610, the problem was masked by setting the console in
bootargs. Use the alias syntax with baudrate parameter so we can drop
setting the console in bootargs.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx53-ppd.dts       | 2 +-
 arch/arm/boot/dts/vf610m4-colibri.dts | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index 3aa6f693fa9f..1228789f0f3a 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -55,7 +55,7 @@
 	};
 
 	chosen {
-		stdout-path = "&uart1:115200n8";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory@70000000 {
diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts b/arch/arm/boot/dts/vf610m4-colibri.dts
index 41ec66a96990..ca6249558760 100644
--- a/arch/arm/boot/dts/vf610m4-colibri.dts
+++ b/arch/arm/boot/dts/vf610m4-colibri.dts
@@ -50,8 +50,8 @@
 	compatible = "fsl,vf610m4";
 
 	chosen {
-		bootargs = "console=ttyLP2,115200 clk_ignore_unused init=/linuxrc rw";
-		stdout-path = "&uart2";
+		bootargs = "clk_ignore_unused init=/linuxrc rw";
+		stdout-path = "serial2:115200";
 	};
 
 	memory@8c000000 {
-- 
2.17.1

