Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAB1C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347812148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789336;
	bh=wlH9wEAogOx78rs8iYGXkonzD4rtn8Uet06PpgyZPbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z23l5pE+Pn71TBWg+IS2tTV7cqlw+Hdh626hHmln0lmEqm1b+iwsYmPus9Ypmekos
	 wh+e0aIF5fZZ7PHjnx66GnJjcSokpwGv6vpRblR4Pxhdmg7oSiwS8WSiPxS6x0nJop
	 yrMBvLkSnoj4LtvFDI0m0KQM1EYHYwpRME6NI+yA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347812148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbeLNMIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:08:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730560AbeLNMIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:08:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABCED2147D;
        Fri, 14 Dec 2018 12:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789331;
        bh=wlH9wEAogOx78rs8iYGXkonzD4rtn8Uet06PpgyZPbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ty8wFIrGVdpLVgRvC/iOTie+VFuAzfxcZlRuPFkQogkr4+YdyRZlQxVo08qSCTlGi
         qdR735xJxrjNTnB2Km0aOgNovEmqu+r2ySBi7D0DX1dxl5eZBpwuvo6XGSsxCvoDMs
         sLXRi2Ci30eatFd72nRYJsP/oolAcyMW92ntJ8rA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 19/89] ARM: dts: logicpd-somlv: Fix interrupt on mmc3_dat1
Date:   Fri, 14 Dec 2018 12:59:32 +0100
Message-Id: <20181214115730.623479854@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index c335b923753a..a7883676f675 100644
--- a/arch/arm/boot/dts/logicpd-som-lv.dtsi
+++ b/arch/arm/boot/dts/logicpd-som-lv.dtsi
@@ -123,7 +123,7 @@
 };
 
 &mmc3 {
-	interrupts-extended = <&intc 94 &omap3_pmx_core2 0x46>;
+	interrupts-extended = <&intc 94 &omap3_pmx_core 0x136>;
 	pinctrl-0 = <&mmc3_pins &wl127x_gpio>;
 	pinctrl-names = "default";
 	vmmc-supply = <&wl12xx_vmmc>;
-- 
2.19.1



