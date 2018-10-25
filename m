Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77FDECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A598C2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+NFFibS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A598C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbeJYWxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730875AbeJYWxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:08 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 018612146E;
        Thu, 25 Oct 2018 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477211;
        bh=kZ5L9bCb2XBc8LgJY/nUEJvcb0N8PcXHe251ztlQ/TQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A+NFFibSRStKgJkBmsSwNobPXqSTeqZdSm+B0jlZXB/pww7DldN0ZNJNTB/UiVb4o
         sNKennt/+at6auqpvq0I04W2j6rqS0I/klbC03/uQ1TBGHZomeE+skYuanEoyxYuuh
         XccsorNKiR/yD44HmZg1got81lgwRr6omZQmYCcs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Abhilash Kesavan <a.kesavan@samsung.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 50/98] ARM: dts: disable CCI on exynos5420 based arndale-octa
Date:   Thu, 25 Oct 2018 10:18:05 -0400
Message-Id: <20181025141853.214051-50-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhilash Kesavan <a.kesavan@samsung.com>

[ Upstream commit 25217fef355174209eff68c0eb438a8af5d7b01c ]

The arndale-octa board was giving "imprecise external aborts" during
boot-up with MCPM enabled. CCI enablement of the boot cluster was found
to be the cause of these aborts (possibly because the secure f/w was not
allowing it). Hence, disable CCI for the arndale-octa board.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Tested-by: Kevin Hilman <khilman@linaro.org>
Tested-by: Tyler Baker <tyler.baker@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 4 ++++
 arch/arm/boot/dts/exynos5420.dtsi             | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index aa7a7d727a7e..db2c1c4cd900 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -372,3 +372,7 @@
 &usbdrd_dwc3_1 {
 	dr_mode = "host";
 };
+
+&cci {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 1353a092134f..9655a3efbd15 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -120,7 +120,7 @@
 		};
 	};
 
-	cci@10d20000 {
+	cci: cci@10d20000 {
 		compatible = "arm,cci-400";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.17.1

