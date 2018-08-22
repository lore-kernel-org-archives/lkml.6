Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C25C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1255C208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1255C208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeHWAKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:10:03 -0400
Received: from shell.v3.sk ([90.176.6.54]:53297 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbeHWAKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:10:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 880FBB5B98;
        Wed, 22 Aug 2018 22:43:36 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NY7SLGES-mN4; Wed, 22 Aug 2018 22:43:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 6878CB5B8C;
        Wed, 22 Aug 2018 22:43:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P3EuydLc0dgj; Wed, 22 Aug 2018 22:43:12 +0200 (CEST)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 23363B5B8A;
        Wed, 22 Aug 2018 22:43:12 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 05/14] ARM: ttc_dkb: add an instance of pxa-usb-phy
Date:   Wed, 22 Aug 2018 22:42:58 +0200
Message-Id: <20180822204307.13251-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will replace the ttc_usb_pdata.phy_{de,}init()>

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/ttc_dkb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index c7897fb2b6da..767dcb23ee1c 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -282,6 +282,10 @@ static void __init ttc_dkb_init(void)
 				 sizeof(struct pxa_gpio_platform_data));
 	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
 
+#if IS_ENABLED(CONFIG_PHY_PXA_USB)
+	platform_device_register(&pxa168_device_usb_phy);
+#endif
+
 #if IS_ENABLED(CONFIG_USB_MV_UDC)
 	pxa168_device_u2o.dev.platform_data = &ttc_usb_pdata;
 	platform_device_register(&pxa168_device_u2o);
-- 
2.17.1

