Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAADC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DF920658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DF920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeHaUq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:46:59 -0400
Received: from mout.perfora.net ([74.208.4.197]:44199 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeHaUq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:46:58 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MSK0j-1gK8gs0f3D-00TW2g; Fri, 31 Aug 2018 18:38:33 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 04/34] ARM: tegra: apalis_t30: reorder pcie properties
Date:   Fri, 31 Aug 2018 18:37:46 +0200
Message-Id: <20180831163817.23970-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:yP4DOuVHS39pZWpguvBA6cFQEaHvCraWugllGdhPXbZ618plk2h
 ni5zst1Z5RpoeE1CuuddChhGI9XRxdfL8xeAnl4uI5Nmgb40JgdkbLz1b19OtN/9ofWlDQz
 7in1qmLLVRgOfvOBdkRbp9xo0iIIKc0DnuL9qXsR8N/vF3Xo71lsWR8ZPP2ZycFXDVGC2HH
 gnwt/zP4ZWx2+OtFcIdKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PSvfw4YjG/8=:abxjwIbdoFQd/bhmo0+F4F
 tYC0PNE3yaxPFCeNiGpS5YZZuKQ4yRnJgJ+JZDo6Zbtt7Nv2QjbETXlY6+2UYMHZiqHfTXVxb
 xc3TSRDN2i3G5t7kMPZkNQlUCMUsVEUi2wbW2F5ElXCScbVqvhWt/cU+REecCHBkHx6rnCOKI
 N1rQuhk38wMxoMGNiIYg+SGflUU41Owb+i8HL9LXVDGkCHf4xJo8V8k8XIH8eXObCdBpfeMSh
 OzVvLPvbEcjhWLRweRMTYM48vWTUW1mYdNC5uq8c3WHfS0W2LIC//Zb+mls5UxUAChC6e3nz+
 8GyReGB78mFVLDpNS/T3NQmXgNfkK0a+wQfNXG8Nv2saa4G2h0V40dX+L34JRN+MVidCvBwrr
 a+AsMQQhtH8vmqGEwdE0wm4yyYaAct5Y2zrbRMlO0qVw/NTXvvyZhGFHJbphEj9BYKBQUk/AY
 iTt/7fA8fHNTauKfrHAjQDMj8GO0h+Jtuer7VsbWVy9F56tIAWNBqE+cZgcFRIxPzaaegALDh
 WPJ1eiA7zmBE6nj5fZdTxaJK7EyMiRqJYxjKFums8GJDPF+abozlgCykb06rkZ2S8sM76ZymX
 IOR1HCvhLzpG+XntLpHNOMRPUUmmQCoQSu0SxNy01EUw0MTb0LOlIl8+S1mj1xgCivT6HfQ8V
 5vc+VCha+hAacqihgKcQNumQyc4DebGL0IpA1nZypRI185nNRdQ29ny4sQYRoU5hiymg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder PCIe properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index f13df31b5e25..fc279a073ac5 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -16,13 +16,13 @@
 
 	pcie@3000 {
 		avdd-pexa-supply = <&vdd2_reg>;
-		vdd-pexa-supply = <&vdd2_reg>;
 		avdd-pexb-supply = <&vdd2_reg>;
-		vdd-pexb-supply = <&vdd2_reg>;
 		avdd-pex-pll-supply = <&vdd2_reg>;
 		avdd-plle-supply = <&ldo6_reg>;
-		vddio-pex-ctl-supply = <&sys_3v3_reg>;
 		hvdd-pex-supply = <&sys_3v3_reg>;
+		vddio-pex-ctl-supply = <&sys_3v3_reg>;
+		vdd-pexa-supply = <&vdd2_reg>;
+		vdd-pexb-supply = <&vdd2_reg>;
 
 		pci@1,0 {
 			nvidia,num-lanes = <4>;
-- 
2.14.4

