Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBACC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124E52170A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124E52170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbeHNK0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 06:26:15 -0400
Received: from mout.perfora.net ([74.208.4.197]:51381 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbeHNK0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 06:26:15 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M2N6o-1g86kI1sf6-00sAX6; Tue, 14 Aug 2018 09:39:55 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>
Subject: [PATCH v2] ARM: dts: spear: fix stmpe811 interrupt properties
Date:   Tue, 14 Aug 2018 09:39:48 +0200
Message-Id: <20180814073949.27392-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:wr4LumbPFs4V51UpVSzotq6kGoxJFQ6uF4ewZ1Ax7CWASpR5uJH
 JYjXcqcBo6XeXf8DMO+QV7f89324DpAubIVyYBMRFz8rJ3KANzRzNIW/szy34jqrfZOwx+P
 2v07Ddk3Z1Szm5bsJW0cpfCa5wXFFK3yA13OBzS5soijCAU44APZmPQGLevujtL/JXktGyt
 ElChkbO9mk6wsqfc7tpKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E50FbTfOpYc=:A8ZaXwD7//TYCzYtZnxG2e
 MpVJmriplJYpYCpoGYaakvSGl6uNvPRle8ImDVq7ZX/bQ/yApspbWKDUKtIaLQf9LDNI6Vox/
 peWCFj8FWQ6xA8VLqwoiEO+X2CobVnEHrI2OGUYv1krD7pwZc1ND8ebMUNUcDv6HKXSpyk53w
 RWDpZToU4Uclu0s23SgKK53hUCUd4iTX/SIuqPm4IguS/+vVjNAUbAhyEUmQqMpndyUKHxig1
 K9LzOlv8U6ICBWvJHdCF8EKKNb49UVb3c5Ua3fwgAIFxnVCgOynuDNyXMQIhS0wtd0Xm+8/wM
 Y8kfMa+CfGJVeIUWEKt9TxhF5Z5Ai3AAKudhDgf4z3OVe4nQs4OpzZtStxkrB13hpeNF3nvcr
 NUtSlIJWUlKbtIjNE6MpJjK9zR0FahypWQMOkV6pRg1WSqleCetokzuovwbzJNhZ9VI7W6cKi
 oUlMCPgMFUW+dp3AeaIJmHhJY13rlsgtoM/9TZJwCah9RANdFNh1g18oKaDlb6XZYVyCmXoBv
 ljYXNvi/YUz9RUjL/QEO9Icu2DRIayrnBIXDWCzb4Co8haKg2Bt8RX/ZUGHqhnAKtVWGls7pA
 cpBmJQNazfNOCxPXWi7yHuib/DTPjs0eGHhdlF2taZVXXwWxsyYeZD8ASO27rXLvRtEec+cVF
 Ks43MvfcBUPud+5n5758IXAW8y6bRqJPqSiq7hBC93zDx2qeDppTTmoROXKM2VhdwErM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The property "irq-over-gpio" simply does not exist (this is nowadays
actually auto detected) and the property "irq-gpios" is actually called
"irq-gpio".

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Fix commit message as pointed out by Viresh.

 arch/arm/boot/dts/spear320-hmi.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/spear320-hmi.dts
index 0d0da1f65f0e..d2d1fe944407 100644
--- a/arch/arm/boot/dts/spear320-hmi.dts
+++ b/arch/arm/boot/dts/spear320-hmi.dts
@@ -241,8 +241,7 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <0x41>;
-					irq-over-gpio;
-					irq-gpios = <&gpiopinctrl 29 0x4>;
+					irq-gpio = <&gpiopinctrl 29 0x4>;
 					id = <0>;
 					blocks = <0x5>;
 					irq-trigger = <0x1>;
-- 
2.14.4

