Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19590C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03622087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03622087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389805AbeHPLDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:03:10 -0400
Received: from mout.perfora.net ([74.208.4.194]:44055 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387930AbeHPLDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:03:09 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M5O2r-1g4zcc0NQt-00zZ1r; Thu, 16 Aug 2018 10:06:09 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/2] ARM: dts: tegra20: restore address order
Date:   Thu, 16 Aug 2018 10:06:03 +0200
Message-Id: <20180816080604.29064-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:3xQ2YxewvfZr83lsmFHc7/U5FbYJ/+iyE0tIYNIy8QLZ3Q+Brep
 v2xB/ih7XKkjue/uMieUHdncZxN9gW2qWS1E4wJ28mWZIUNKudOd31dec18IFgSO7nttrfk
 krqzp4I55Zwtr8ERX9Jy3hg612Zw6LXO4a3eI1YWcRo2ywBPi0/UtKdIltX8OOTWMNO2jnq
 cVhthskcfDFuVSXG2RBPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jXOi7jnaHIU=:VBL47qcqwIlU5Jxryoui89
 i1ZvCdE0Qs9ChH91FTX+voAKAu0+IDBSuJQTJU/20pXfnWOknMWHFTI8GG6tnJZsh4/KzDRQk
 18JYCfgZWn38kCaR+lfBk8VOAbLXBn7k1LIYW8gqouFrLLnJkcmWK4yU9LZerJQoqIBPHdHP/
 JL56VKarqM/1hdcJAG0fTfQW+j0UiXzSuQE1nv/8OaD5VHeQEpa9rWs9K9FB7CYY4lbIsYAOU
 C1T+fwGi0S8/zV1vHlkOtKbIaLdTLU/+w3fIhGvYheay5Uzj0vEMwtUrinmijw8AzHx26wA/R
 Zuc1RbUTvai4zQU5HlJvglsyc9BS66KviSZgKhOd+FrWFS+GL4GGcAx/RPQve/jNCXrHke/gO
 kz6z9pMDIMwiUMMGp18mJ3hJBIjAjroXsb3JbfY/l4BKo37Zwd3N+Pv5k0aQ1Y++0sLo9+IFV
 ImmrQ5apAO63D/DW/OtPR1D5o2htIZgi7JUXazyhBApRX/c0KGbhp/0hxDcK1YhPBdL0NfZBt
 l7ARfKIgYA3QlpxfwT4TXDNYMb4dbMMndEYvegJg0AkSZAB9yBt5PC49ip0WIoqi7cIh9sl5m
 L5rMLEWnjHK2svoZEmY/uVr/Lz2vRHDebRZpwVRy6xnm7986n8zyi60tIBavUcDT04TH6jnQB
 KiqXzbAH74qFXMvXRN2Q5gvyMgW1ycAaQgVUoZew8qBZ9HnR7iGygSqJhGakFbXKXiBY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Commit 6c468f109884 ("ARM: dts: tegra: add Tegra20 NAND flash
controller node") introduced the nand-controller node. However, it got
added at the wrong spot not honoring the address order. Fix this.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 979f38293fe5..a22c6a8f8f83 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -419,19 +419,6 @@
 		status = "disabled";
 	};
 
-	gmi@70009000 {
-		compatible = "nvidia,tegra20-gmi";
-		reg = <0x70009000 0x1000>;
-		#address-cells = <2>;
-		#size-cells = <1>;
-		ranges = <0 0 0xd0000000 0xfffffff>;
-		clocks = <&tegra_car TEGRA20_CLK_NOR>;
-		clock-names = "gmi";
-		resets = <&tegra_car 42>;
-		reset-names = "gmi";
-		status = "disabled";
-	};
-
 	nand-controller@70008000 {
 		compatible = "nvidia,tegra20-nand";
 		reg = <0x70008000 0x100>;
@@ -447,6 +434,19 @@
 		status = "disabled";
 	};
 
+	gmi@70009000 {
+		compatible = "nvidia,tegra20-gmi";
+		reg = <0x70009000 0x1000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 0xd0000000 0xfffffff>;
+		clocks = <&tegra_car TEGRA20_CLK_NOR>;
+		clock-names = "gmi";
+		resets = <&tegra_car 42>;
+		reset-names = "gmi";
+		status = "disabled";
+	};
+
 	pwm: pwm@7000a000 {
 		compatible = "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
-- 
2.14.4

