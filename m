Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1229BC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FF221905
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RIodGQf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbfBLTGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:06:53 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9682 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731197AbfBLTGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:06:51 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c63194d0000>; Tue, 12 Feb 2019 11:06:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Feb 2019 11:06:50 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Feb 2019 11:06:50 -0800
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Feb
 2019 19:06:50 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Feb 2019 19:06:49 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.70]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c63194a0000>; Tue, 12 Feb 2019 11:06:50 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>,
        <skomatineni@nvidia.com>
CC:     <wsa@the-dreams.de>, <peda@axentia.se>, <digetx@gmail.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>
Subject: [PATCH V19 4/7] i2c: tegra: update maximum transfer size
Date:   Tue, 12 Feb 2019 11:06:45 -0800
Message-ID: <1549998408-9137-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
References: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549998413; bh=mj9RLeBGW229Orfa7BBHI4zJOQRq0llTuBlu50V2f2s=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=RIodGQf9+2KDW+fOaNvbZ8QYi0Oi6HYgaPGXpi3hixarSJOXaFBvzynaXWyQAoBpT
         Igp8KkFvLaZ+m0ejHevXL2K63lax9wsn0HfG09zLxrzmNPXd5d4jxVw3RPOIUVjyVW
         /WMTZoChA6iG38vp50Sh7pVazMAS1HLartSUvrPdlTFvsd1WP/DAHw9fjEisNN7v6G
         n6kA3uNwhAHFBBuQJMEgbra5rrMgtSDNxzPJgwZ81bs3xthS0/qIpVsbB/LZ3xAGF8
         Yi068nJJfEpa/i7frMVnAXzSaJq63eVojE0uecVY7k7NjOvre93Y2KsRNnEL6TcfXT
         AWdBOsLNteSrw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 supports maximum 64K bytes per packet including 12 bytes of
packet header irrespective of PIO or DMA mode transfer.

This patch updates Tegra194 max write length to account for packet
header size for transfers.

Cc: stable@vger.kernel.org # 4.20+

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V19]	: Splitted maximum transfer limit patch into 2 separate patches to
	  allow the fix to be applied for old Tegra chips and for Tegra194.
 [V18] 	: Using Max of SZ_64K (65536) size for dma buffer instead of 65535
 [V16/V17] : I2C core max message size is 65535. So, max_read_len of 65535 is NOP.
	  Removed it leaving max_write_len
 [V15]	: This is new patch in this series.

 drivers/i2c/busses/i2c-tegra.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 036cab795426..f8265bd5d02c 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -125,6 +125,9 @@
 #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
 #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
 
+/* Packet header size in bytes */
+#define I2C_PACKET_HEADER_SIZE			12
+
 /*
  * msg_end_type: The bus control which need to be send at end of transfer.
  * @MSG_END_STOP: Send stop pulse at end of transfer.
@@ -900,12 +903,13 @@ static const struct i2c_algorithm tegra_i2c_algo = {
 /* payload size is only 12 bit */
 static const struct i2c_adapter_quirks tegra_i2c_quirks = {
 	.flags = I2C_AQ_NO_ZERO_LEN,
-	.max_read_len = 4096,
-	.max_write_len = 4096 - 12,
+	.max_read_len = SZ_4K,
+	.max_write_len = SZ_4K - I2C_PACKET_HEADER_SIZE,
 };
 
 static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
 	.flags = I2C_AQ_NO_ZERO_LEN,
+	.max_write_len = SZ_64K - I2C_PACKET_HEADER_SIZE,
 };
 
 static struct i2c_bus_recovery_info tegra_i2c_recovery_info = {
-- 
2.7.4

