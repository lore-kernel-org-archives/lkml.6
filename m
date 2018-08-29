Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD58C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC4B2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC4B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeH2MLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:11:08 -0400
Received: from mout.perfora.net ([74.208.4.194]:39663 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeH2MLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:11:07 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M912Z-1g58up2hu1-00COmB; Wed, 29 Aug 2018 10:15:19 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 30/31] ARM: tegra: colibri_t20: iris: add colibri ssp support
Date:   Wed, 29 Aug 2018 10:14:06 +0200
Message-Id: <20180829081407.11304-31-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:rN+xYbSc3OyMVQZY6vDqZ+dCQ2RzymHPryX4iqG9922KePpplWb
 TRBwfFvHvPUq8SyyPF3GXQp7Dsvuo4HAXHOPAQ3BfEQme/bcNkscT49oRVMHZi/gTvwTgx7
 5E9iNWeWNKviz1+3IGDIArtj+nQZrcIRwxV4KytbqlyGnCKsJkFGxIYi3YNHsgumlM1orRD
 sdHcrzb9o829EL3n9diKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0Ffz+k65SmA=:3Hq7Z3GLaT9A3SZUKzHg6b
 uGlTrLU/zoCOe7cY2o+ip1O+rcs0oxkIXPg5OVrmGdJugD3HCPajIPRCE6ur22VEzcXlNXk1J
 aq53BR4mroSil3i9y8WJhCf/DPnLjRnXZ/t0VhrBhTL5SsC9UrYP0JXlhQ1xRhMPnTintbImo
 mG+LqcC5EsOXH5P651no605I8/4SbRLuud+DQ3q9HaQO45P+fY87JD+K+d4Ph/KBao6kJChZM
 YBlKoBZXMtXwonP3R5SxkK7NdATECQJtn0VxFpydDcd8J+UhIRwjfXIERCPos/hHTMHVhYhx5
 OKfMvJNFDPp2KJYnFmFP8ScCgtdqIZ4V0ZD3Z7AmC4UFWLYhQ6KyW1jTNKkKN2oKCyeDxCa2o
 XME/gz8Qn/3uc2mO8dQvUM3s3MZrzZ5xX/QbKVcAkEWrYItGn7XOVDIjSXI4qtJUGEZV5ddlN
 4QG6ZK+lmJ+NRuk31+NAUsG6UO9Mp7L22puvcKGsanNHs1imDM97xN6a0DiAnqNceiewhs6fb
 aRfKT4v73HiwEe4W7BbcYKOW39I3Oj1oteoC1avbNDoAUBwsks8FXeQMp7Pf7VQCoTKNVjtJO
 0mHM3tI+Q9pUETgLbLnWiZ8jZThjse1yM/T1v39nMVReuRNibA8ENovKaLCmPFULZFdYLlJ1Q
 5u00yxhBuyTCRChtjcajBpEvQAXqyadQpoqEfA5GzfavQvEuCvAjyejhAGdHQif7/5XU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add Colibri SSP aka SPI support using the SPI4 instance.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 3bcbb74edf2a..ee4b956b0325 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -164,6 +164,12 @@
 		vbus-supply = <&reg_usbh_vbus>;
 	};
 
+	/* SPI4: Colibri SSP */
+	spi@7000da00 {
+		status = "okay";
+		spi-max-frequency = <25000000>;
+	};
+
 	/* SD/MMC */
 	sdhci@c8000600 {
 		status = "okay";
-- 
2.14.4

