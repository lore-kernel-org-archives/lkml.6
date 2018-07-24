Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6059CECDFBB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB0C20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB0C20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388751AbeGXLti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:49:38 -0400
Received: from mout.perfora.net ([74.208.4.197]:54739 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388296AbeGXLth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:49:37 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M90hv-1fraVM1qQP-00COTD; Tue, 24 Jul 2018 12:43:42 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 13/15] ARM: tegra: apalis-tk1: fix pcie switch vendor compatible
Date:   Tue, 24 Jul 2018 12:43:07 +0200
Message-Id: <20180724104309.21741-14-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724104309.21741-1-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:SsABZSjeDC95bqvUu01HWp8sR/SyHrU7JfOdOXs/s2ICjt1pu+V
 +VDKqgLdFkIKQ/V5tJ5ZkYPpbCxtzONzWq3TGXlnMFuusnK7XV9hyMArpC5wuWfGI9MKJ9R
 Nima496Uga/SmvHXfb7j6S4wm4XaTr/R/12jIxlax/d0dpe6ziqs5n7/ld61sd/RqPnYaef
 mmvC7IVkDkAcNu0pXdHHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DmpwThzNIPg=:Sgaohvhr7am8zCfId3If9b
 s/vssWVhgVxtTTQAUBg2rl4RKmbPyqfngwMhtG6fTJgUyrZQZKYxgor5c4zSK9sYdEbmfYy8I
 T8TWJ08InmoQ72EhKeOhBS6FSJIbqhpsKKFuwZjAve05J0+SjfglqFi+EEqO+OjhmyIJyUhHY
 DeSMO+4GzoJRxWG9n0KoRi7RwelRPZZGlNCUJSlxF+peINR3LGiodhOaq4DmDF/R0KqmevbTC
 LvqDTC5cabF5c+B8H0PYTd6QkVp35OOVZXAIIOMW3qzDFPrWwWWmvJm67K3x89kfWXs1IGLCR
 I2Kkum7K3vqxaQTPkc1Ej3xqYExP1PxqXVSad60mqPrSkL01jzh18pWydh4SOJ0rWH3ZqxRic
 SqwgP+LY549k8UGntKb7Q8xj2Vj7tvBjbydiIKaQMiZZmHVC4Tf1glG1U1yH9mbiSbdPoFogG
 BqanqLDYlBSreZyB4bHfxggNk1KAkM4Lci6uzgzZFwT2Iq9ngsQzK0d3ZTPM7ldEJT1kH7JDx
 uvkJkUhYYySn++uH/Nn6whBI2n8dFde2bL3+LdwxP7JU+2pVhiiwk7lwouWgLyQWY+ZyymmR7
 eP8m4OhB9eB1yaiyhGi9onzcaGrIC2UEWIiDWHgnyMocRoacoxIIwXctl2+V03cSeSFvSmSBW
 QyXgCB5+F0qWFEHfmlEKr4Trlf+66xoVdfWgpKSz2D9q3+a5LWC1hwJxP3AIqpgCO5sI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

PLX got bought by Broadcom therefore fix device tree compatible string
vendor which silences the following checkpatch.pl warning:

WARNING: DT compatible string vendor "plx" appears un-documented
 -- check ./Documentation/devicetree/bindings/vendor-prefixes.txt

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-eval.dts      | 2 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index d9805fc97f5e..84ab7dc9febb 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -109,7 +109,7 @@
 		clock-frequency = <400000>;
 
 		pcie-switch@58 {
-			compatible = "plx,pex8605";
+			compatible = "brcm,pex8605";
 			reg = <0x58>;
 		};
 
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
index 89783fe76f65..5319f88d3cab 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
@@ -74,7 +74,7 @@
 		clock-frequency = <400000>;
 
 		pcie-switch@58 {
-			compatible = "plx,pex8605";
+			compatible = "brcm,pex8605";
 			reg = <0x58>;
 		};
 
-- 
2.14.4

