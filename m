Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2E0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCC8222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549993608;
	bh=+aLi1Mj+ukT9miFPUjUt8Rw47GkkDlguW8I6eiJU3bs=;
	h=From:To:Subject:Date:List-ID:From;
	b=TLrNHIoX6XTuIZQGV2mIKETC7E84RYti5a3QTeU97LyfJx8dvk3eIGedBYuAc1P5w
	 ex3heJQ1lghxMwm8cCgbSlkb6KRkz1kxJTo3tORsBG4ognWM4JkPztWRn6RLUvXu+Z
	 MCO8H+I92LA5BMwf6QbVFPUQRds06qr7HP/lmoUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbfBLRqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfBLRqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:46:44 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 806DC20842;
        Tue, 12 Feb 2019 17:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549993604;
        bh=+aLi1Mj+ukT9miFPUjUt8Rw47GkkDlguW8I6eiJU3bs=;
        h=From:To:Subject:Date:From;
        b=GPU1/5jE/0txxNO/ntk59TWnYzrFJ/ZteIqAAWj8uBZ/KTLC73tn1daq1cIUscoZQ
         hTwLGbGNCwxPBTWCB53C50ZX0nKurnw26uFZPa66OVyhnUc/trVqRU4mr22Qt2e8tP
         Ly+4tPimY+geDfNKYhWexaq4KBOJ8Vm805eUiEDk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: Document regulator used by ADC on Odroid U3
Date:   Tue, 12 Feb 2019 18:46:38 +0100
Message-Id: <20190212174638.4582-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ADC node to Odroid U3 with its regulator, purely for documentation
purposes.  The ADC stays disabled because it is not used (all inputs
grounded).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 2bdf899df436..88891ff5f238 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -66,6 +66,11 @@
 	};
 };
 
+&adc {
+	vdd-supply = <&ldo10_reg>;
+	/* Nothing connected to ADC inputs, keep it disabled */
+};
+
 /* Supply for LAN9730/SMSC95xx */
 &buck8_reg {
 	regulator-name = "BUCK8_P3V3";
-- 
2.17.1

