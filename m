Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AB0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9AB20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9AB20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeHaUrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:14 -0400
Received: from mout.perfora.net ([74.208.4.196]:51827 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbeHaUrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:10 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MhkKj-1gI01I1ud9-00MwS6; Fri, 31 Aug 2018 18:38:43 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 09/34] ARM: tegra: apalis_t30: annotate uarts and move compatible to board
Date:   Fri, 31 Aug 2018 18:37:51 +0200
Message-Id: <20180831163817.23970-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:6EtBwtVfz1PmSVYs8QB5VQrhJMXfkPhpiXOlH1x/utBTRjh4ZAK
 uftSoShwyUp1ncNZQL5yat6VYC/du/iJhgHit8Ne4IBA83aIIG4mUnsbmXxaNzhzIUyC4ud
 ETkclmHWs09k9y80jiVwB7qxze2x3042EflvYGEQdKD4cFUZ6oyPxRLtheQjNr9Lucr5SzK
 C5FYyDnBkkGv1lYE4MTOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+pPRzLKCWdw=:AB2aUAlodzPL8B455J8JaE
 zmgXLl8B1n1cO1kK60twFzGodC5iyX7MMssZtRKEl9whR6arxMI2tkJOqtxEerjPHmuQHWWmO
 1QACaLMAcHOURdTDdm7MFUWDfvxr128KFtcNiM6BZpl0+oBm1fgCDSWtv90nwTBx/EHJtg3Bq
 KMNY2ZM8DOSgEWQK12kkHfUzXdMCt9YxSvpIVjXrxXUgKG8JpJH8IHNm1i9n43tXs129f7eDN
 ZMfdsuPcriOrhDvCaPE/LBef4tTiY4670LITNIFX8aMkheikAYphvTgls4ngRuRDw2TNM/Vsg
 FEUXeIqy4zogh6rat0vsEfOtba2uPHX4EidZapRdYA328B7JK9I6YjhttuIovq/ZvC281yWKE
 uoHHvcjYux2MiTx6uN36NHs0TMbjKb3EwVHH2uuTHbyybCmxzzkMNayPWmijuVm2jWpcgwYB7
 YIRBKwCUdVGflho/ZWpcx99nB/WkCiXvXBeOjDZKirwFC7DYDQADaYnjrtvjKPJAtYaijVdAb
 m8IbrMYYDDr9vAoVtejWeDPGbPkgzQTF2ujYU9VQP2lv5apvvc8E7mJBn9Hv+/wnh6+8ZtvH7
 PjSDJsMZ3kMpmOMv+Ub6QQpwjhNFVhvUivnuV/ZVj3Ejp3ZUC1SMRMPtGFXsCVAZKjYgo9TpM
 KsfyhrmpFQxvCtCpSHVxT+JrWvdBMqXCmnDxniq8gKSMSTT8FNDk9gXatyOgNznz9uu4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate UARTs and move the serial UART "nvidia,tegra30-hsuart"
compatible definitions from the carrier board to the module level device
trees. One could still override this in a custom carrier board device
tree if required.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Also move serial UART "nvidia,tegra30-hsuart" compatible to module
  level device trees.

 arch/arm/boot/dts/tegra30-apalis-eval.dts |  7 ++++---
 arch/arm/boot/dts/tegra30-apalis.dtsi     | 12 ++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 14a62b5111ec..cd4e45759ac8 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -45,22 +45,23 @@
 		};
 	};
 
+	/* Apalis UART1 */
 	serial@70006000 {
 		status = "okay";
 	};
 
+	/* Apalis UART2 */
 	serial@70006040 {
-		compatible = "nvidia,tegra30-hsuart";
 		status = "okay";
 	};
 
+	/* Apalis UART3 */
 	serial@70006200 {
-		compatible = "nvidia,tegra30-hsuart";
 		status = "okay";
 	};
 
+	/* Apalis UART4 */
 	serial@70006300 {
-		compatible = "nvidia,tegra30-hsuart";
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 3b2e15519e4b..7e9d1b022982 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -449,6 +449,18 @@
 		};
 	};
 
+	serial@70006040 {
+		compatible = "nvidia,tegra30-hsuart";
+	};
+
+	serial@70006200 {
+		compatible = "nvidia,tegra30-hsuart";
+	};
+
+	serial@70006300 {
+		compatible = "nvidia,tegra30-hsuart";
+	};
+
 	hdmiddc: i2c@7000c700 {
 		clock-frequency = <10000>;
 	};
-- 
2.14.4

