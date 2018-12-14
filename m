Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365DDC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF022146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788937;
	bh=+rXu5PzA1ai6TprqTZjUcUvHXy5Olkm6B8xoQlrL7GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sP0wsebGuCSjQxpYW2l7HCva3uGTH1DhFkeMhxTj/rdHfIMd+CFCFI3N254DHu6mv
	 0+3lhldda9CD4fhSwKmZPYg02mC0SCyfjSVDPgjGFcmSzHaO2C3qxs4UKYmj6qDZQ4
	 LyDcvgrSAQBGqu7W16F9GBDrht2NwKiOodDB1Mss=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF022146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbeLNMCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729969AbeLNMCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC3EE2146F;
        Fri, 14 Dec 2018 12:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788932;
        bh=+rXu5PzA1ai6TprqTZjUcUvHXy5Olkm6B8xoQlrL7GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jG95+VbsNtEUrHVTxxYSFWS6RfActorg7Rk+QUtwAy434pqjouf6k+DpWIy1/ltcQ
         UQhZD5gFk1blXAD+uKVjHd6xOAag0dxODzwIsQFGWVcM0ew7aHysW0Mklo8uwYhM+H
         AuufjMUodqqvxCn4B6JzwKhJUMKyEppbVwnVuY18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 029/142] ARM: dts: logicpd-somlv: Fix interrupt on mmc3_dat1
Date:   Fri, 14 Dec 2018 12:58:34 +0100
Message-Id: <20181214115748.221048649@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3d8b804bc528d3720ec0c39c212af92dafaf6e84 ]

The interrupt on mmc3_dat1 is wrong which prevents this from
appearing in /proc/interrupts.

Fixes: ab8dd3aed011 ("ARM: DTS: Add minimal Support for Logic PD
DM3730 SOM-LV") #Kernel 4.9+

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/logicpd-som-lv.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/logicpd-som-lv.dtsi b/arch/arm/boot/dts/logicpd-som-lv.dtsi
index ac343330d0c8..98b682a8080c 100644
--- a/arch/arm/boot/dts/logicpd-som-lv.dtsi
+++ b/arch/arm/boot/dts/logicpd-som-lv.dtsi
@@ -129,7 +129,7 @@
 };
 
 &mmc3 {
-	interrupts-extended = <&intc 94 &omap3_pmx_core2 0x46>;
+	interrupts-extended = <&intc 94 &omap3_pmx_core 0x136>;
 	pinctrl-0 = <&mmc3_pins &wl127x_gpio>;
 	pinctrl-names = "default";
 	vmmc-supply = <&wl12xx_vmmc>;
-- 
2.19.1



