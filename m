Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A86C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6BF240DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6BF240DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933157AbeGCPEG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:04:06 -0400
Received: from mout.perfora.net ([74.208.4.196]:60519 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932884AbeGCPEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:04:02 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LjKaf-1g7WGo4A2B-00dY0r; Tue, 03 Jul 2018 17:03:50 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-tegra@vger.kernel.org, linux-can@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RESEND PATCH] apalis_t30: fix can2
Date:   Tue,  3 Jul 2018 17:03:39 +0200
Message-Id: <20180703150340.29580-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:x30OH43eykKFksIgdKrmp5IbY1HRUglP7UVNfKhmiIKyhXKjFeh
 0MzLOShxVlG0xMP+zHb+eNeKKs1A6weoQvDZiwzVuNR5GZnxdAYmjbFShpZM+X8BnAW0vd0
 KWqVgImW0kJ/ic6R8x11Q87iRudCN1m6WXTiJ3/KbtGlXTJ5xj/HlamiJdIGMLq4XGBb7xp
 VNuJGeHt0Dfa0t+gzUOQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oIp3GhASvg4=:gMxItotTfZAQpPLRIeRx0I
 67BQax1DBJJDXbUSuMTZnWSXdeqJ/c7brm/c5ntD0V4IGKLxqlYdp54zvgQuG6y9q4Z9F6CXI
 00nrYZZC9njLAeQXSDWXI+j+nbxoJ3RLGfkvZLrddRDwl1D9ylaLeoKgL0SD6jndKgOBaoprB
 f+vwTIX93w0/3dLsfpeYjPBXDxdRsEiGxNM7sNheSUBDo8hHQfWAxWkB7/EH9afp7UPxgiKd3
 2CVoOb50WJtN5p2lut3Iv20TSTcFge/SK/k4+av1AC7YXYmEfAkvAHbT3aK2zs7TsKpwu5BOv
 LcxdmAs4G8PJuQD5LgEPnVxBzCZKgZ8JsfXFZr+qq3sICuPIC9w6j6BHLryy3ERxh0lKdzBAJ
 K7uf3ST/KQYxHsyFWHJL3zlNEgHKBPC1Xq/B4nXcC/YBM0G12d5/B65TGKFe6ns47IrYxKvTN
 gXWUAfn1zVeFyruksrSjmZqszzIig3xhaQ0RNVjtrkHZpnQPFf+IPkr0ep6xT1YufMUaXplc7
 RNpjm7wK13MOhdQHIoRoFuvrihg+L+XfOLO80J1uogpdFQENi8GqIvP4sP40D1re1XwWfjWjG
 qXxxVJTEKtHGdAWGzfoL1WEk0eYNM7wBcWDU3RQ/i0KG3FVK1Pwzuuhwi1MdkH/y8llAnNcf6
 kwRik4mtr1HrPd4+FeoSKf2iC/ExcM+deo6/8AAGHfSUqlBR7FNf1UTOm7jRBXlJ4sG8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

CAN2 currently fails on probe as follows:

mcp251x spi1.1: Probe failed, err=19

Fix this by enabling input on pin mux of resp. SPI4 pins.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index d1d21ec2a844..9ff6aafd72b3 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -118,6 +118,7 @@
 				nvidia,function = "spi4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			/* CAN_INT2 */
 			spi2_cs2_n_pw3 {
-- 
2.14.4

