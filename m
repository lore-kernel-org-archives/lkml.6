Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE8AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2532083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ch5NciSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2532083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeHaXWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:22:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38806 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbeHaXWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:22:20 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VJDR4i085347;
        Fri, 31 Aug 2018 14:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535742807;
        bh=xFhaMHpQvmYn1fikV0v77bUeyIBlPjcXBcnWgKDlBFg=;
        h=From:To:CC:Subject:Date;
        b=ch5NciSdd1LxlUGiRD3jsQWMRv1pPEC/I3CS6cMyVlSro8vPx6w9oPKONnq3/5Orl
         mArIIy/sNMniLn734vUoMyGQt/i95qPQMemB6Cb/kZ9LILETviRnHEcU7HGgl/wB5i
         8031ENtZjcjNPLEmGqCkPC/sNVWr9I42YtCPkW8U=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJDRwW014440;
        Fri, 31 Aug 2018 14:13:27 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 14:13:27 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 14:13:27 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJDREH008511;
        Fri, 31 Aug 2018 14:13:27 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VJDQx13195;
        Fri, 31 Aug 2018 14:13:26 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 1/5] gpio: davinci: Remove unused member of davinci_gpio_controller
Date:   Fri, 31 Aug 2018 14:13:22 -0500
Message-ID: <20180831191326.25106-1-afd@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was added as part of the patch in the fixes below, but was
not needed or used, remove this here.

Fixes: 8e11047b8f3c ("gpio: davinci: Add support for multiple GPIO controllers")
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 include/linux/platform_data/gpio-davinci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/platform_data/gpio-davinci.h b/include/linux/platform_data/gpio-davinci.h
index 57a5a35e0073..b8e4957e7568 100644
--- a/include/linux/platform_data/gpio-davinci.h
+++ b/include/linux/platform_data/gpio-davinci.h
@@ -43,7 +43,6 @@ struct davinci_gpio_controller {
 	void __iomem		*regs[MAX_REGS_BANKS];
 	int			gpio_unbanked;
 	int			irqs[MAX_INT_PER_BANK];
-	unsigned int		base;
 };
 
 /*
-- 
2.18.0

