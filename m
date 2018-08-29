Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83897C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459DA2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459DA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeH2MKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:42 -0400
Received: from mout.perfora.net ([74.208.4.197]:34413 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeH2MKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:42 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M56vg-1fiKur33GA-00zI40; Wed, 29 Aug 2018 10:14:52 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 18/31] ARM: tegra: colibri_t20: iris: add uart-c
Date:   Wed, 29 Aug 2018 10:13:54 +0200
Message-Id: <20180829081407.11304-19-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:7IVsHsl4p7yumBAYecyfByaz0v3MHbovRu0c70szFF90cipDYa9
 BDM/lUxe3sp8ee89lTX/65CXv21hVnAb9Xz6A4y6+lQwVTzfyFJBY5g81bgjQCb7EMJ0QCe
 3z1f6nZiF5F2hxArtHs6oxVDo7NHtJ0ZXlrMU03oF118vngWokmAzvdi1yfUeAJHDV69mg7
 8m9PFA0rHRGonRT+jKJpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2MSdGFAV2N8=:bN+7L4i383Df93x7bhtpwA
 pQq05e0dc2NDugycZU1SsEBV32xSkZI5znnioSNosiQnpOnROfGxOybr38XLrxaEhv3hXggPZ
 z20iu+aXUpdoFQlTeoSIhLY3un13PQAoi4IzLSzmSlRSKckfmTB1ETFMMEvXmYJv8rVhhueG7
 E+6XsUi3agfdWr04ipaYFtYGgLpL2O/SIzS7X2PsBCJ7vCdCN1/tglvYIxNReB89ZidmwDu8z
 2DTFGqgyCMC/i1Qfva6i5+1aCgI1YmBemEgbqcjuKB9G+pr4j+LCeIIWNT4Q54guuCd5+TOm/
 CYu2f43VX3eLzM3E4H7VieziljQ0qG17PzXYTpjWLmcPsCzdVFZ7YVJ8jsba7u+6ZSw45qsEs
 GrvTHR7nili+mexqcad9JUn2EtEjSVlvsVu2cgpxa2bsf600KXPnmpVOGcsvbWSW5feK7tjZ6
 jL+4bZ+5ND7BsTeQlzKNCKMFmu1HJTlIruOJtVCW6h6PKIcqNnuIHDKLa/SCo9pUJrO1ryCIq
 NneucxOH1sBKvEcpZL3K/ZkG7S1giDO9+P6XHJ1vBe5brpZXyKjd3/RjidqlR+qlqBSvQCrRW
 CDgTCmMqpyyUCNXCeMwDX3yoc101OyP0lrVpLnl/8N5tsj1ceiZyeaDFPg+LQrHpfpxfBpZ01
 Xbo8UoYnonJmPKn2fBgvsIh9QwLlMOHm/0QHaKsGRQtSuRVaayl7Jy2pajHpDlL6aWN8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add UART-C.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 96d633622f94..a2364e39c131 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -103,6 +103,11 @@
 		status = "okay";
 	};
 
+	/* Colibri UART-C */
+	serial@70006040 {
+		status = "okay";
+	};
+
 	/* Colibri UART-B */
 	serial@70006300 {
 		status = "okay";
-- 
2.14.4

