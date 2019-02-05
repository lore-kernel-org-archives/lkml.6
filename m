Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BD9C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F5A2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549399645;
	bh=VTpmfTKGtHgWiwqIWajrR7SPRxKH4ZGo6w3sS37zYAk=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=zL5VXOcL2JuYERX42gLQwwgVJGC3hXJWOwAqgpmF3i04vANAKUatrO2k3vSOl2RxS
	 hHIExsDX6h563geWQmLkUhZVgifM1eLPIA3VOH4R/rIm2Dp9V2Mauqxj382WaIiyhO
	 tzHeDLyQOn4kjWLgKIfrkYI2ebF0bbx8KtDYbY9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfBEUrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:54558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfBEUrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:47:24 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BBDE2083B;
        Tue,  5 Feb 2019 20:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549399643;
        bh=VTpmfTKGtHgWiwqIWajrR7SPRxKH4ZGo6w3sS37zYAk=;
        h=Subject:From:To:Cc:Date:From;
        b=qu3tDq6+1EnQfvBIKgcxeOjs8949shMKJyWorrOVpDNIqT+z078CbjZ4X4XJeZf/4
         oqdwzget1KBG2FRk6P+JEwDmhxP8z7ytWgctPTF8kiI65RTuoxMpCLETTJEVxjcbVm
         9qm1x/wiCv2uHvzERX2C8pUlSBcVirPNIElsGK88=
Subject: [PATCH] net: Don't default Cavium PTP driver to 'y'
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Aleksey Makarov <aleksey.makarov@cavium.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 05 Feb 2019 14:47:21 -0600
Message-ID: <154939964148.34496.18016063453530224332.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

8c56df372bc1 ("net: add support for Cavium PTP coprocessor") added the
Cavium PTP coprocessor driver and enabled it by default.  Remove the
"default y" because the driver only applies to Cavium ThunderX processors.

Fixes: 8c56df372bc1 ("net: add support for Cavium PTP coprocessor")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/cavium/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/Kconfig b/drivers/net/ethernet/cavium/Kconfig
index 5f03199a3acf..05f4a3b21e29 100644
--- a/drivers/net/ethernet/cavium/Kconfig
+++ b/drivers/net/ethernet/cavium/Kconfig
@@ -54,7 +54,6 @@ config CAVIUM_PTP
 	tristate "Cavium PTP coprocessor as PTP clock"
 	depends on 64BIT && PCI
 	imply PTP_1588_CLOCK
-	default y
 	---help---
 	  This driver adds support for the Precision Time Protocol Clocks and
 	  Timestamping coprocessor (PTP) found on Cavium processors.

