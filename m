Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD77C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640EF20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640EF20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbeHaUrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:02 -0400
Received: from mout.perfora.net ([74.208.4.197]:44121 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeHaUrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:01 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LsRIM-1fko8p1r4a-0121Vt; Fri, 31 Aug 2018 18:38:27 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 01/34] ARM: tegra: apalis_t30: fix mmc1 cmd pull-up
Date:   Fri, 31 Aug 2018 18:37:43 +0200
Message-Id: <20180831163817.23970-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Gu5Eb8M2rU8C24cW9yEHFAB7Ud7iO8+UmYq22Zjvi/1EnUCHyfi
 T995Go+JxazTLqn69GnpzuMt7Isxq+JbRWsdITEIup/D4u5rDJEAq/bqkN3PRgZK+sYhri/
 goMX4/eALppFkZLa1Vw0OMQrRprs4QbxCJI6InnSXBJ7qQmS92RdsoOMnsPuI7Gbt6dEvsO
 2QWT6uKzWm5dB6HrlQH0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LJUzShtj/3g=:dbnqiNiXzdkBlLaiZheNVM
 TaXM4PADf7mOfv3FxdFRT77ySyqPeII+MZD4F08bZ+nIjHqU37xBX5VBtAoK6OgHB93J1vzSL
 cak1OKE+gFMDEUGQeexnrm+MitpWdnTSZHgL0N9q5KlilRexA5O9pqoojA5dq5sXy/v1xLlBn
 bwFxKVY6lasSKug2Q1kqNlT3YHUZ35c2owmuE6ud9kenB14l4Lvt6xCNTu6Q0EiSKMRrU6vaN
 SJMA9MTCJ9zedme9SlXemqBpXrL1/P8T80sXDE3uKIqd/84yj6Hp0sbhH61qfywm+0O3UMWgb
 jt1Nh7eSgj0jH7GNAU+dOUMTW7CGoFZN8UO7B98kBy22T/teSagLuI/fG1GrawlcAtz98qB27
 YW4Rur0dvPYc/hRUa6IIdtCKC3IUOmFiGTH7tb3neZlbmX+vmBnoLP2slOHBlK8ajPDit8dlN
 r5ZpopYhXV3PJSNvXg4NMXeC4ywpKx4aYY+ZnU6kog/b02JqxCr6LFOUf2dmJL3ya4wRzb8S3
 JHD0MigdIW72j/ihvmAjP/S3NyDuLGIP2z6llMhMGyZlNm1OZGRA3SUYAhP5fktkNeTNC23JN
 0kn65GoMtclA05KZzXMLQaSy5EXrwaEyaTZkvk8xsqqKAZpig6VKt3w53tDRhKhZQs9hM2phb
 pVUmKoONQAkqtzOqGI/U+68dBw2MbBQWHv8wOKem7SE+9ZeLKZIs5/3vra9O890B/BOI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix MMC1 cmd pin pull-up causing issues on carrier boards without
external pull-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 2f807d40c1b7..e749e047db7a 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -171,14 +171,14 @@
 
 			/* Apalis MMC1 */
 			sdmmc3_clk_pa6 {
-				nvidia,pins = "sdmmc3_clk_pa6",
-					      "sdmmc3_cmd_pa7";
+				nvidia,pins = "sdmmc3_clk_pa6";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc3_dat0_pb7 {
-				nvidia,pins = "sdmmc3_dat0_pb7",
+				nvidia,pins = "sdmmc3_cmd_pa7",
+					      "sdmmc3_dat0_pb7",
 					      "sdmmc3_dat1_pb6",
 					      "sdmmc3_dat2_pb5",
 					      "sdmmc3_dat3_pb4",
-- 
2.14.4

