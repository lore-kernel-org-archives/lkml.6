Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ADEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC337208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yP4PBYAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC337208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeH1Eme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:42:34 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41888 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbeH1Eme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:42:34 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7S0rDxw056061;
        Mon, 27 Aug 2018 19:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535417593;
        bh=JfuPp+vmzI86m554HGlHMssZfjB7AxXuNMv9YD6fFT4=;
        h=From:To:CC:Subject:Date;
        b=yP4PBYArIiFw/qqXWFmM9Ki41S+mbjVlvJ+svrNCAw3LuHwUfRV4N6bmWw3kgJMWj
         ZvpmAgYzN6hfebUWRpPZ4YATf8YTS9cyzPO86CI3zt24an0+pRF1IRPvayeJwfVz7+
         40xivc4swz0dfP9SyY87c1Z9qxUmMDr+IDNsLdqo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7S0rDgj030985;
        Mon, 27 Aug 2018 19:53:13 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 27
 Aug 2018 19:53:13 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 27 Aug 2018 19:53:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7S0rDUN019173;
        Mon, 27 Aug 2018 19:53:13 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>,
        <tony@atomide.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] drivers: mailbox: Make ti-msgmr driver depend on ARCH_K3
Date:   Mon, 27 Aug 2018 19:53:11 -0500
Message-ID: <20180828005311.8529-1-nm@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ti-msgmr driver can support K3 platforms as well.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Jassi,
Last of the patch series for K3 platform support for secure proxy..

Since we now have ARCH_K3 and Secure proxy support in v4.19-rc1,

The dependent patch to enable the driver when ARCH_K3 is selected.

 drivers/mailbox/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 841c005d8ebb..3eeb12e93e98 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -105,12 +105,12 @@ config STI_MBOX
 
 config TI_MESSAGE_MANAGER
 	tristate "Texas Instruments Message Manager Driver"
-	depends on ARCH_KEYSTONE
+	depends on ARCH_KEYSTONE || ARCH_K3
 	help
 	  An implementation of Message Manager slave driver for Keystone
-	  architecture SoCs from Texas Instruments. Message Manager is a
-	  communication entity found on few of Texas Instrument's keystone
-	  architecture SoCs. These may be used for communication between
+	  and K3 architecture SoCs from Texas Instruments. Message Manager
+	  is a communication entity found on few of Texas Instrument's keystone
+	  and K3 architecture SoCs. These may be used for communication between
 	  multiple processors within the SoC. Select this driver if your
 	  platform has support for the hardware block.
 
-- 
2.15.1

