Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018C6C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A558A2458A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A558A2458A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934351AbeFVQJ5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:09:57 -0400
Received: from hermes.aosc.io ([199.195.250.187]:34723 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934045AbeFVQIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:08:16 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 099A9630E0;
        Fri, 22 Jun 2018 16:07:47 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/2] arm64: allwinner: a64: allow laptops to wake up from lid
Date:   Sat, 23 Jun 2018 00:06:31 +0800
Message-Id: <20180622160631.8578-2-icenowy@aosc.io>
In-Reply-To: <20180622160631.8578-1-icenowy@aosc.io>
References: <20180622160631.8578-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all ARM kernels will have s2idle enabled if CONFIG_SUSPEND is
present. In this case if the lid is closed, systemd-logind will enter
s2idle mode by default; however there's no possible wakeup source
defined, so the system will enter a forever idle.

Add the lid itself as a wakeup source, thus the system can wakeup when
the lid is opened.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
This patch is not related with the first patch, and have no dependency.

 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 58253d6f9be1..e6e5bf11b759 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -49,6 +49,7 @@
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_LID>;
 			linux,can-disable;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index 02fecc42440c..33f78e745815 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -38,6 +38,7 @@
 			gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_LID>;
+			wakeup-source;
 		};
 	};
 
-- 
2.17.1

