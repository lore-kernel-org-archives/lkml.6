Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154C5C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF88420844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y57b9OMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF88420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeKIITG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:19:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729031AbeKIHdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:41 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BA762146E;
        Thu,  8 Nov 2018 21:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714174;
        bh=nBQ21mAC01eNtyTiojA/P/FJA5SxiwcQ9Xf2NPoJOl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y57b9OMoDL4XkMsbQYxUYhkhjSuil89U1tLQvitA31v4ZjDK98thz+03MhvVmcZBc
         +vWh6J4jVUd81XPWTW0Pf/1+Cq6uF1zVIjyHj4n87choBppNzDAVOJKCyaGXNbxmef
         WRfmOBo0A+DxuQU88EiqkjJRupJAGCtmnb0AL+qw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abhilash Kesavan <a.kesavan@samsung.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kevin Hilman <khilman@linaro.org>,
        Tyler Baker <tyler.baker@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 079/144] ARM: dts: disable CCI on exynos5420 based arndale-octa
Date:   Thu,  8 Nov 2018 13:50:50 -0800
Message-Id: <20181108215101.023863635@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



