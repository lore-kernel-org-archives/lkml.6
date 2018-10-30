Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7014C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A858720827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A858720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeJ3SYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:24:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53432 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeJ3SYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:24:33 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1gHQNA-0003Lk-RP; Tue, 30 Oct 2018 10:31:40 +0100
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     Anirudha Sarangi <anirudh@xilinx.com>,
        John Linn <John.Linn@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Andrew Lunn <andrew@lunn.ch>,
        YueHaibing <yuehaibing@huawei.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 0/2] net: xlinx: mdio: recheck condition after timeout
Date:   Tue, 30 Oct 2018 10:31:37 +0100
Message-Id: <20181030093139.10226-1-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the Xilinx mdio wait functions may return false positives under certain
circumstances: If the functions get preempted between reading the corresponding
mdio register and checking for the timeout, they could falsely indicate a
timeout.

In order to avoid the issue, the condition should be rechecked in the timeout
case.

Kurt Kanzenbach (2):
  net: axienet: recheck condition after timeout in mdio_wait()
  net: xilinx_emaclite: recheck condition after timeout in mdio_wait()

 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c | 21 ++++++++++++++++-----
 drivers/net/ethernet/xilinx/xilinx_emaclite.c     | 20 +++++++++++++++-----
 2 files changed, 31 insertions(+), 10 deletions(-)

-- 
2.11.0

