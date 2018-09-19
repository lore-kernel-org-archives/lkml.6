Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCF0ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B34A2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="EQqTH2wo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B34A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbeISVrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:47:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35481 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731419AbeISVq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:46:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id o18-v6so7657659wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Uq4FaIIvqrNr/IUNG2rRPni+34lkVn2isOTam+arIuU=;
        b=EQqTH2woxXaacY9SSA0zIklzTlVBckcirQHcj3jEvdFzAAn64DEfYP6k6GQwycHZHc
         Dn6BsO+5m6vsaUYsGVKFZIDhiPaIrH6nbhtcweuSrltyvKdDFtGOY5d6JlBaaeoxXHbu
         G4UDX937Opu7TZl/YN+iMhvoBYIzY272h0k3ast6M8qDmvlQt8kCMsTdSQh8Ui1SKtvR
         ynuiR9MShdswE28UfbfKKkJgEZcnAI4TxiYfEceEaBDoGl5mJYy2I3dmbC/86r8msirR
         sOrcBLynJcutyRt0P6Ei9XQp/tD8x29TJSYFww/k776TZ+ze+0RKTNF5dBqInnxNbU2T
         6WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Uq4FaIIvqrNr/IUNG2rRPni+34lkVn2isOTam+arIuU=;
        b=QZnKAG5o8sgzKG4w2Fbov4RFx3W74EQA6XXILxnp31FqEz03qSVOjiBQ2smEYCZw5P
         ckD7VQt2yqF9GsDqOr5ppPnH8XQ8pVYuIogaVqp6QPm1U3+g95x/6o40q6g/GNiMWZGg
         KiQokX+EQffRhIaIgENax799V4QjBB73k9OgFD6Y9uJ/Yg8Ic6V/F3lHGXibfAFLeOii
         dH+j6kmNUFS+TlRYZz/evdezouGFM9rfKMRCcyqru4cFmgeGXZHQ9jzljWOs2/rw9Slb
         VtGUZaR8E68m6F7tpU8Dumf6dp9XXeRO/mgN14vqGMqmK6GzwKwNKLXMpXKcJbDkExjk
         oUFQ==
X-Gm-Message-State: APzg51DWpgIPaMKoOkF7ltgmfUlsJqqRBaDp0ote2YZA6FeaksfRXnpN
        b+CpNtflSeUxPyZmy7X2Bxwra0IgaLfCUQ==
X-Google-Smtp-Source: ANB0Vda6HmGce5Mf/Ezsnc1eeRcvdMsWL5bq1T2NXTYzp//3eXClAyeJE//z6sWoYvp1mSrtjeG7+A==
X-Received: by 2002:a7b:c1ca:: with SMTP id a10-v6mr20003754wmj.35.1537373302591;
        Wed, 19 Sep 2018 09:08:22 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id x16-v6sm15627822wro.84.2018.09.19.09.08.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 09:08:21 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        "Edgar E. Iglesias" <edgari@xilinx.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] net: macb: Clean 64b dma addresses if they are not detected
Date:   Wed, 19 Sep 2018 18:08:18 +0200
Message-Id: <0997a0e77b5e5c04c9a4d277d702d93a1a8a7448.1537373294.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear ADDR64 dma bit in DMACFG register in case that HW_DMA_CAP_64B
is not detected on 64bit system.
The issue was observed when bootloader(u-boot) does not check macb
feature at DCFG6 register (DAW64_OFFSET) and enabling 64bit dma support
by default. Then macb driver is reading DMACFG register back and only
adding 64bit dma configuration but not cleaning it out.

This is also align with other features which are also cleared if they are not
present.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/net/ethernet/cadence/macb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 16e4ef7d7185..79707dff3f13 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2163,6 +2163,8 @@ static void macb_configure_dma(struct macb *bp)
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
 			dmacfg |= GEM_BIT(ADDR64);
+		else
+			dmacfg &= ~GEM_BIT(ADDR64);
 #endif
 #ifdef CONFIG_MACB_USE_HWSTAMP
 		if (bp->hw_dma_cap & HW_DMA_CAP_PTP)
-- 
1.9.1

