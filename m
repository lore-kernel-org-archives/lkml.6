Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC43CC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8CA20883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzKLzAxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8CA20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbeKIHv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730525AbeKIHqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:46:05 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B20820989;
        Thu,  8 Nov 2018 22:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714914;
        bh=rvxajRP6aUrCmNUlgvxW0bbiNMzVbPuZQHtTPdbISGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzKLzAxRASxhWFTxwOcuOENWOVO84nrp6wxb8NRxc3c6jDiSuM6Y4kfB3Kfg0CPyr
         qj5YY126pLj4/MujOHgGsttq3UAR/3OWfn4cP+zVXmnw4fToI3YT4eje9gIe0bBTBO
         lTifKaChYOgJx0AWyPOXyjMSb4edAT+m7U6rdJ3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 06/31] Revert "ARM: tegra: Fix ULPI regression on Tegra20"
Date:   Thu,  8 Nov 2018 13:52:30 -0800
Message-Id: <20181108215130.205999642@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
References: <20181108215129.641434673@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit b39ac54215190bc178ae7de799e74d327a3c1a33.

The issue was fixed by upstream commit 5d797111afe1 ("clk:
tegra: Add quirk for getting CDEV1/2 clocks on Tegra20").

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/tegra20.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 2780e68a853b..914f59166a99 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -706,7 +706,7 @@
 		phy_type = "ulpi";
 		clocks = <&tegra_car TEGRA20_CLK_USB2>,
 			 <&tegra_car TEGRA20_CLK_PLL_U>,
-			 <&tegra_car TEGRA20_CLK_PLL_P_OUT4>;
+			 <&tegra_car TEGRA20_CLK_CDEV2>;
 		clock-names = "reg", "pll_u", "ulpi-link";
 		resets = <&tegra_car 58>, <&tegra_car 22>;
 		reset-names = "usb", "utmi-pads";
-- 
2.17.1



