Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC1DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B2C20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B2C20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeIBOZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:34 -0400
Received: from mout.perfora.net ([74.208.4.196]:56719 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeIBOZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:33 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MMERP-1fzQ0f350X-0088jG; Sun, 02 Sep 2018 12:10:13 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 30/37] ARM: tegra: colibri_t20: iris: add colibri ssp support
Date:   Sun,  2 Sep 2018 12:08:59 +0200
Message-Id: <20180902100906.25792-31-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:wblQJFnePNaQnhsw+QoKUTwkeB/+ZjGUbb+AVI3tgmPVDWoE2lp
 utBgOHR2T1+7Y37O65x7fG5OQUVufM+daL5r+JFSTo50/4qfIBQOcei0+MTqoICswmEnnEm
 a0yMPVMzS0EXoxOqKQ6qXej7Wtgn3L9KUbTqEm0vHo6jZptJW9pSJJOx8Yb/Hb2NSNMoRb9
 A57QUFVU5wIYMd2j3zXcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+3Y+hnkGEgw=:sdPdRPL5cC//ET+6vrMzhS
 9YTugs/br9dgZQj3KLGUECsMMW8wB01q91MHal08PbHub+4MDvBSqt8ayd+oCnxNEUXhbdun2
 FzwXEA292JKkr1UVrF1hcHck2w/veAKFpo2AwJhQ2F3HdGIwhUc3o/3Qc02J9WqmAj4l/VLa8
 a6Ubu6DHsjssM7vh8zyKDAZrGxTSYAuD2y6fBAAWv5eNETTUcfGy66K2mCL1+VOQLnuMqOAq8
 g8E1kHKzeY1MoY+qwsLjGkg9shN5KlIokzY7rM7yzf29iRcbkwXnmVL8Qr2fP8ybaTgR4dW2Z
 EAGWfHl8za9fRg7GZdvumInoADbqFmT2UFLfa+BFr4kjN1D7aLhf+wr8WfPBEDkKK1Cx52US8
 lCxS4IGMvUN4tW6VHACTund35WlOdqORvqyZFTcbij8SIpjVAER8Mkm/0X4nRc2hofCrxgxH0
 6fnc3P1oy1r3+40nR8p8bZSj6cnCel4gwpSSZVqjlP873rQ26RJS1YfyifNp341MGe+o4BdDT
 OZpgRJggE6saMPCxra76j8mdzDMO7sa6krKyA447+6kvoTOa1OCtstMR+KyifKUyFjPHkSbt8
 33sa42v65yQ0R5NbAHmj7Az3U+37jF22n3x2M4bHwN/UHMQ3IBjaRgkOi+67uGcPVHZzI/Maf
 M1zxT5cp/C/NniKmCiJW0TWzG2o0xBTUlZ7lmJZppQ5gqUAc+TBNv0k9SXLPwqro+8cM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add Colibri SSP aka SPI support using the SPI4 instance.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index dbdf596dd151..b16e04dfa31f 100644
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

