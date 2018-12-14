Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AFAC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862EF2147D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789494;
	bh=ZffgK3P3iT2suedrkI2+t8g3aOoPwJarQ0rTwDXV4bE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qut0dypNAZm6pSqcgo5vMludfzrf4/B9MzzOVtj5xzJKaYQpwyGfYj50ERflAg7r6
	 GOyC7/IAlszbzRB8I8H2pDSc0ehL20v6zov8w3zKqm5uySB4U6QzCaeHVTlmHRcB0h
	 BUck3NnuNCX28ECRO/A1geA1NloGYI5WgGO80vLc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862EF2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbeLNMLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:11:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730793AbeLNML1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:11:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0E8521473;
        Fri, 14 Dec 2018 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789487;
        bh=ZffgK3P3iT2suedrkI2+t8g3aOoPwJarQ0rTwDXV4bE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cv1gKMLN0tmKZq4mKrPuApnIcgkHtUpxkhSq2RzyEQRko9br04qqZ/vd8xRR9JFez
         DpXlAwNv16g+sZODlisaXF0+HQz6MZGZvUieJHhHfM7gwt6XCoZ2kBGPIv6bf/Lwqa
         IT+lTEbCB4mKpCu5l9b9cPZaoDdiPdJa1Oo6vHIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 12/51] ARM: dts: logicpd-somlv: Fix interrupt on mmc3_dat1
Date:   Fri, 14 Dec 2018 13:00:14 +0100
Message-Id: <20181214115714.407187332@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index e262fa9ef334..876ed5f2922c 100644
--- a/arch/arm/boot/dts/logicpd-som-lv.dtsi
+++ b/arch/arm/boot/dts/logicpd-som-lv.dtsi
@@ -122,7 +122,7 @@
 };
 
 &mmc3 {
-	interrupts-extended = <&intc 94 &omap3_pmx_core2 0x46>;
+	interrupts-extended = <&intc 94 &omap3_pmx_core 0x136>;
 	pinctrl-0 = <&mmc3_pins &wl127x_gpio>;
 	pinctrl-names = "default";
 	vmmc-supply = <&wl12xx_vmmc>;
-- 
2.19.1



