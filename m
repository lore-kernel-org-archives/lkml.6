Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF6BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B137A2082B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B137A2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeH2MKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:12 -0400
Received: from mout.perfora.net ([74.208.4.197]:54793 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbeH2MKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:11 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M5wXn-1fkGJi0lo1-00xukp; Wed, 29 Aug 2018 10:14:23 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 05/31] ARM: tegra: colibri_t20: add local-mac-address property
Date:   Wed, 29 Aug 2018 10:13:41 +0200
Message-Id: <20180829081407.11304-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:tJ/ZQTTfHw+2nGVJqG0caWCmE9UWIsfoz/Z1IBJOrmm0L8rFYV8
 Cogoe+nbNzAf8DToPk5NqoJLuOx7hzHywOtf58APFjbX97twvrPT2Djxe34eAnb9BErF8+6
 bkXhtpC0b/4Dakd5oi3huK7rYPV1gxkIlkO/ufIF7IcHKkY0iZqTc8qvaiGoM80oGSE3Z5U
 oLcGCNOzpqbunRNItmAJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qikC+N7ex0s=:iNg0VlQf6h9WJWoDnTPXwc
 zgnASDbVl88HSrqdjS3RasEo2CXH6Zeo1XeBV9Qdo5ym/VX/P3bdgdJUPifKkc9pSfS8hMrxq
 MXRudvaCfuLKPCW01EEQU+zg6uwcRPL6/8n/kRm8JJYvQlmpUEyQTmoxupkdAJVPTjBENFq8T
 9oeI+orhW9cqqPCfFnqHUSLH8MQSIZbtJK8Mq3+0IwvbSV93QbXWgVVCOnUPNMJNPEbnHKjO7
 AZjRUBWfVsbKaf+wS2HVbhTC8esL8Bcu5dbqeP/YBgUvHVdAg9saNwkqfIrF/JkghEnFUcVLQ
 NKn20tNcjxW0IngB7GCrLguUL2qgBVxYgbcmvbGNIDHUGVj8NlLXO9+SLpI0zObrzkj89ijU8
 GkxIn1JS3HCdetrTnvoOD0biM9gwHR9ShTm8JUQvjpkIj/f/9+lfFEjufAb8rEC1R0p5Xk1ap
 vacfDUMrdfbhkPyapKXJ+5yOS9ktAaeCp4nTfbDcHmqQBIf8cj0ExvKgjyl3SoIu6n8xKBbZe
 TbT0HE+FbKZ68V4jS3FZHBgxX4VA9iNUHSUjtkbbqR6eZAGpwefuCdK/rTy34OScoYaWG3FzB
 dHF5S2HO5Py1/GsiShbKMW3zx8SKdVeDPCzg6gj3Po0pDTJ1hFM1fQ/VsABO9HQxrbHWs5DPD
 UyQual/q4iv765FSWdAx/4dp2A9WijnzMbICOn/vkozJ5h01Ww9nQWq/2+VR6bwJmTRM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add empty local-mac-address property to be filled in by boot loader
(e.g. U-Boot).

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index e34ab4a76158..ad816fa827f7 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -482,6 +482,13 @@
 		status = "okay";
 		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
 			GPIO_ACTIVE_LOW>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		asix@1 {
+			reg = <1>;
+			local-mac-address = [00 00 00 00 00 00];
+		};
 	};
 
 	usb-phy@c5004000 {
-- 
2.14.4

