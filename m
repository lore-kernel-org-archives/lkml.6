Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AD5C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D55E2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788934;
	bh=0FEnkaRPeHDIKuTU6+k6+5iSuf1eGMYYhWDH7v3nvs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hjEw4xOuVpbqx/465CvX+Kiargq5BSyetuB560RsWyK/eiKbleqrqBFEUCPIj/DDO
	 S1KrvrvmoSnnHYYuSKMwysK1JoMhejvfLHVnYwfg1WRNfHdTKOMapOUWXx9MzskjSa
	 VVHQvAFVrNUDR2Xk55M9ir4sBuHx5q5J//nAnRYo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D55E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbeLNMCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729950AbeLNMCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 607CB2146E;
        Fri, 14 Dec 2018 12:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788929;
        bh=0FEnkaRPeHDIKuTU6+k6+5iSuf1eGMYYhWDH7v3nvs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1A/uox6+BFU8iIs/AzBW/JhBBBtkThTt18hj+Xv63W/WHS2jT76Wlu7CABmyTcnx
         1xbIqf/fqzk4gkdLp4Edg52MvTVS9PH4UvdfN7cWQAncupn1ZeFE+81sxrwrRxZ/q/
         yVC6uJgfehRHc8b7Oy1EWpJw338f+NcJhS4jOF6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 028/142] ARM: dts: LogicPD Torpedo: Fix mmc3_dat1 interrupt
Date:   Fri, 14 Dec 2018 12:58:33 +0100
Message-Id: <20181214115748.184049219@linuxfoundation.org>
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

[ Upstream commit 6809564d64ff1301d44c13334cc0e8369e825a20 ]

When the Torpedo was first introduced back at Kernel 4.2,
the interrupt extended flag has been set incorrectly.

It was subsequently moved, so this patch corrects Kernel
4.18+

Fixes: a38867305203 ("ARM: dts: Move move WiFi bindings to
logicpd-torpedo-37xx-devkit") # v4.18+

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
index 9d5d53fbe9c0..c39cf2ca54da 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
@@ -35,7 +35,7 @@
  * jumpering combinations for the long run.
  */
 &mmc3 {
-	interrupts-extended = <&intc 94 &omap3_pmx_core2 0x46>;
+	interrupts-extended = <&intc 94 &omap3_pmx_core 0x136>;
 	pinctrl-0 = <&mmc3_pins &mmc3_core2_pins>;
 	pinctrl-names = "default";
 	vmmc-supply = <&wl12xx_vmmc>;
-- 
2.19.1



