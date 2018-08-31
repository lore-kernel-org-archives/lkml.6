Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB6EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5275F20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5275F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeHaUrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:18 -0400
Received: from mout.perfora.net ([74.208.4.197]:49331 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbeHaUrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:17 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MgvO2-1gHjAq3nqC-00M76b; Fri, 31 Aug 2018 18:38:53 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 14/34] ARM: tegra: apalis_t30: move dr_mode property from phy to controller
Date:   Fri, 31 Aug 2018 18:37:56 +0200
Message-Id: <20180831163817.23970-15-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:jOwhrR4teg6PMEBnMzm1EmXO/UAoiSXhCHvaA5R+FyguRwQhSYC
 sCN7cxXOsVV/7Rude8TAY8b6wmo2DLNv0k4ToDETxF3xcV1vUep9NnHfdzQcDvOps58dT3o
 24HjdKsXR7Gs/0WLgkRKqAEBDhcNyqxQngqFBX3sfdPQ9oI+9cpCMVfVhkGTQ26DMoLv4WN
 rvYDf8CLjuBgYmtzh62yg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ofyrKAKXahs=:0xXT3P8odnxg/KE91joebZ
 tJPLI9MXaNJvAV7j7n7kWw6m6rDV1l0sG2BYC/vBEUDgH7ADnaBO7iNm6NKwaRmVlnvyfbP4P
 5T9xvFR7hP11o8LmXiGB1ienXJK3riElujMdb7trGPJq0sEHie7jUKpOO3J4SE1kr+5imQog9
 LCR0OqfErmrlsP3t67kXnNwIIqwazcedAWShuD3tXOHpghmXGGsoOpntfFSmWR+qQ8feN/LQJ
 Ois0vQGa2cc62FCb5t5SzEBvoYG0Ha8413YMslzjM0y0UYltInw9lOPiGacRfkhh4Gjr8PaeE
 YBB2YXwRqFSrb8lfUeXboW7EPOf7xApLoyDVxt6dTlalQQ287IgU3VuuqlIKIEFQmogMWyd2X
 jqENDdGfNEVaLoSs+zi8h5gLvXZW0vKbg7taExjyNjyXviEsx8s5YAYKH38feGFiVjmiI/sr2
 MepKGWuSnVom50iCkz1LVb6wdlYZxb7tmHseU56HCvtGWJLkRBw1lOtWTxIvGVehJWjc6X14U
 kR9smIR0GIYBLJ+YbKktVPMS7pIQf978vzr5imeaWuW4xVnPV+r6TFAYWUo1H2dkEqfswt9pS
 CJU0l/QyxLXk+IDcVPLRtTl74xOG/l0KvlwwL0Jl1iO2E/+M8iph7T1pDNzIcAeFn7qDbv5+H
 KzecOtcMjUvjHt6jkxUrGerCT8VhB3vJ5sXbt1M3AotyhTd+CDOk9yW84w4EBDDUN0Es=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Move dr_mode property from USB PHY node to controller.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 15e9de06c59a..9f2392a05532 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -155,11 +155,11 @@
 	/* EHCI instance 0: USB1_DP/N -> USBO1_DP/N */
 	usb@7d000000 {
 		status = "okay";
+		dr_mode = "otg";
 	};
 
 	usb-phy@7d000000 {
 		status = "okay";
-		dr_mode = "otg";
 		vbus-supply = <&reg_usbo1_vbus>;
 	};
 
-- 
2.14.4

