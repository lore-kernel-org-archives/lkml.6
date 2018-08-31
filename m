Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1655C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746AA20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746AA20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbeHaUrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:33 -0400
Received: from mout.perfora.net ([74.208.4.194]:35175 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbeHaUrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:33 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M5vg7-1fgBRV0Gq1-00xuto; Fri, 31 Aug 2018 18:39:08 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 22/34] ARM: tegra: apalis_t30: add proper emmc vmmc and vqmmc supplies
Date:   Fri, 31 Aug 2018 18:38:04 +0200
Message-Id: <20180831163817.23970-23-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:XpEltlsYZiN2jZkL/JuDmVJbMzgptGEPe/y3zf8K5ZGH/zQHCel
 l3F0+mq+F9doI6mgZuuvVEgaQNqmZC8K6Lo20C8hKCrM9z6Y8JTnJThnr6HtmrFuFaOTj9/
 EXeId5DcGIICug6a00zPIKqBaPja4nBLRvBbOsCdvC0uG0u4U4d54GKUYEBJijCpXPeGQMw
 8qqax+5T84PcKRQHNSb9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n+zW955YQzk=:OK+STs380z3R5Tm5ilMjAy
 TlRNnUCC28vxydJ67bW1MetPDvQxE6avFW2Ktkbuy8rZQHSGvB0P7Qwuy9vEXMrBwXdW6WCJv
 e3pFsSzI40iXJPPIo1VvSfTmmQTLZt72ksRog7SpxqVE2Fo1RdzwuSfnpqWbVyiXkrbpwGMnh
 glwOzAKR5hT3GpjfazumjGHhnSVU6o0Hp4D8wecRXm3b+6xElbpJ1QVEhrwSKnP1QBD6e7HV6
 DPpOYLSaeEJDItKn3UdwFWz7neF9tPjqfXM2s0GQ2LqvPjQ9OfuPfv0NMx8ZXRkC9zxGz87I6
 WinOoFOUGgD1JPNiIR0mOcYqEjN9YsMlosXOuGw35t3CAzo2E/eYFApuVOUDN/UZHOmQiA1UK
 V6i2tl5i0cTUebB3DvRs2KpFkG8EZefg3QHXJ3V04IPU0A6zqwuOfXsYv7MVzgE52rcEkC89c
 Uu1RmR8yNxau6NEWCou/ertOInubDrJqkCHDYV5ft47baiGzBJ+GTTKs6YxSmM5Mzfk6iOMLV
 7W8AfczNE2AY03U5jS9chY8fX8y+ztLyTumAC9p8kpbvOYhcFgQvskZNrkxVkMT0Gkvk2qKNY
 2jSn3VwxjbcjSmHL3PJlZI91KkLyFbhz5pg3QubXc7pSaW3SAK6YZ078GjTpnsiqeHCiR6cXI
 ANSs4octtljUnofGkhC5WU+qkNNud0WkRklSYAj0IO3JSyQ35YJ3fWpeKd3DxFfL29bU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add proper eMMC vmmc and vqmmc supplies e.g. fixing signalling voltage.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 02d0117e9398..2e2cdd454fe3 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -1092,6 +1092,8 @@
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
+		vmmc-supply = <&reg_module_3v3>; /* VCC */
+		vqmmc-supply = <&reg_1v8_vio>; /* VCCQ */
 	};
 
 	clocks {
-- 
2.14.4

