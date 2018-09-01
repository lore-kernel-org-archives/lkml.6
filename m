Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30AAC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B8C2084A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B8C2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeIARRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:32 -0400
Received: from mout.perfora.net ([74.208.4.194]:52885 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbeIARRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:30 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LyTxo-1fsDQd1d1a-015rWC; Sat, 01 Sep 2018 15:05:21 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 03/19] ARM: tegra: apalis-tk1: reorder padctl properties
Date:   Sat,  1 Sep 2018 15:04:48 +0200
Message-Id: <20180901130504.14318-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:pT5Amx1X/yj31hUYkuSjkVRdNOj6JyCSOt0jITerkCqvVJ6RyxW
 0yhPqpZvHxkuHs27JXsthKCn3HZEPaJeSsvL33kHGPLycs+fm1fZUj3G3s8haBTQ7oOHrjD
 O88ThvJDVqgPSczR5tk2T8DIPmKxBZCjo2uoe9ERU2Rg0YrnAayhQtTUMRI4Auinv+8Vocc
 3MNavOZVdaLxBdtog7FoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OoI7IZwGKRw=:a7UIy6RuA5lhB+aiiaGF45
 wsbOyzhGxDDAFrXf3GR9/HnqEMZjRm3+wQa3N8EVgCqjQdm6hYkX/sBcTU+jRh8bUgiCaiwfj
 G7YK8rw7Ag+nVkIrcCT4EIG7xnV4qubwD288ixF1vdKSZ2XinR0+Ui4+WHJr/OrAr6IorgYY9
 tUQ5XBggVJuAFtQcjrCs15K+zV76q1Tb2lBDZEn2174e2XS5E8fk5QysQnsEbFteF7ROY2YCE
 HgZ1zdulXxzDoQUL9gfEBmEBIQBXehKTgeEcpkp2WkFrg+TaL/Y3qIn47FldnFk1TqMBmm22+
 0Mz0wN5yxuSzfrfjM8GDEG8KFp4GtjYgxAGWmp/6yFjYdiAltVi8MM9qGpelUmEKi/UGMbM9w
 BKqElobe8ACX/g0AoCHr6gyGXXr982WRFJUSHIlcrdRUVAoN3AAkX91bziVvRkB4WZSkdQzZ6
 AtAn02F4RnuYhdXnw/ZW8bWX09iVixL/zVCzodg0J8uwN8bq+lz8N1q1RRn18sOdAvuymcZ+t
 KLYL0+sq/CsrRvg5oRgmckVbLKGv5v5QP+O6f0oLX9GDWLz80/oOrpQ/lbp3g7s+AJ+9EkWwk
 iCV7Htm3YYNug/IWZoeVL5guT2dUQXdzw/drQfeetKx7VPTk1PGmpwhAiO+PNdBPAiRCwx425
 JYdFjVv85DV562+vRC+zJyR3wlwm0SZfaU2ywU6pIP7Co6ZbR949HNuqtfD1JtIXlxr8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder padctl properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 22 +++++++++++-----------
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 22 +++++++++++-----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 86768ba28d67..f6459588d845 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1815,18 +1815,18 @@
 
 				lanes {
 					usb2-0 {
-						nvidia,function = "xusb";
 						status = "okay";
+						nvidia,function = "xusb";
 					};
 
 					usb2-1 {
-						nvidia,function = "xusb";
 						status = "okay";
+						nvidia,function = "xusb";
 					};
 
 					usb2-2 {
-						nvidia,function = "xusb";
 						status = "okay";
+						nvidia,function = "xusb";
 					};
 				};
 			};
@@ -1836,28 +1836,28 @@
 
 				lanes {
 					pcie-0 {
-						nvidia,function = "usb3-ss";
 						status = "okay";
+						nvidia,function = "usb3-ss";
 					};
 
 					pcie-1 {
-						nvidia,function = "usb3-ss";
 						status = "okay";
+						nvidia,function = "usb3-ss";
 					};
 
 					pcie-2 {
-						nvidia,function = "pcie";
 						status = "okay";
+						nvidia,function = "pcie";
 					};
 
 					pcie-3 {
-						nvidia,function = "pcie";
 						status = "okay";
+						nvidia,function = "pcie";
 					};
 
 					pcie-4 {
-						nvidia,function = "pcie";
 						status = "okay";
+						nvidia,function = "pcie";
 					};
 				};
 			};
@@ -1867,8 +1867,8 @@
 
 				lanes {
 					sata-0 {
-						nvidia,function = "sata";
 						status = "okay";
+						nvidia,function = "sata";
 					};
 				};
 			};
@@ -1900,13 +1900,13 @@
 			};
 
 			usb3-0 {
-				nvidia,usb2-companion = <2>;
 				status = "okay";
+				nvidia,usb2-companion = <2>;
 			};
 
 			usb3-1 {
-				nvidia,usb2-companion = <0>;
 				status = "okay";
+				nvidia,usb2-companion = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 2c291d210677..8919213d8312 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1844,18 +1844,18 @@
 
 				lanes {
 					usb2-0 {
-						nvidia,function = "xusb";
 						status = "okay";
+						nvidia,function = "xusb";
 					};
 
 					usb2-1 {
-						nvidia,function = "xusb";
 						status = "okay";
+						nvidia,function = "xusb";
 					};
 
 					usb2-2 {
-						nvidia,function = "xusb";
 						status = "okay";
+						nvidia,function = "xusb";
 					};
 				};
 			};
@@ -1865,28 +1865,28 @@
 
 				lanes {
 					pcie-0 {
-						nvidia,function = "usb3-ss";
 						status = "okay";
+						nvidia,function = "usb3-ss";
 					};
 
 					pcie-1 {
-						nvidia,function = "usb3-ss";
 						status = "okay";
+						nvidia,function = "usb3-ss";
 					};
 
 					pcie-2 {
-						nvidia,function = "pcie";
 						status = "okay";
+						nvidia,function = "pcie";
 					};
 
 					pcie-3 {
-						nvidia,function = "pcie";
 						status = "okay";
+						nvidia,function = "pcie";
 					};
 
 					pcie-4 {
-						nvidia,function = "pcie";
 						status = "okay";
+						nvidia,function = "pcie";
 					};
 				};
 			};
@@ -1896,8 +1896,8 @@
 
 				lanes {
 					sata-0 {
-						nvidia,function = "sata";
 						status = "okay";
+						nvidia,function = "sata";
 					};
 				};
 			};
@@ -1929,13 +1929,13 @@
 			};
 
 			usb3-0 {
-				nvidia,usb2-companion = <2>;
 				status = "okay";
+				nvidia,usb2-companion = <2>;
 			};
 
 			usb3-1 {
-				nvidia,usb2-companion = <0>;
 				status = "okay";
+				nvidia,usb2-companion = <0>;
 			};
 		};
 	};
-- 
2.14.4

