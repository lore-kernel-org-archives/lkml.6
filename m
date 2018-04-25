Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756465AbeDYSXJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:23:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46398 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756256AbeDYSV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:21:26 -0400
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net v2 0/2] net: mvpp2: Fix hangs when starting some interfaces on 7k/8k
Date: Wed, 25 Apr 2018 20:21:15 +0200
Message-Id: <20180425182117.28826-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Armada 7K / 8K clock management has recently been reworked, see :

commit c7e92def1ef4 ("clk: mvebu: cp110: Fix clock tree representation")

I have been experiencing overall system hangs on MacchiatoBin when starting
the eth1 interface since then. It turns out some clocks dependencies were
missing in the PPv2 and xmdio driver, the clock rework made this visible.

This is the V2 series, that adds support for the missing 'MG Core clock' in
mvpp2, and fixes an issue with the error path for the axi_clk.

Thanks to Gregory Clement for finding the root cause of this bug.

V2 : Remove all DT patches from this series, they will be merged through
     the mvebu tree.

Maxime Chevallier (2):
  net: mvpp2: Fix clk error path in mvpp2_probe
  net: mvpp2: Fix clock resource by adding missing mg_core_clk

 drivers/net/ethernet/marvell/mvpp2.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

-- 
2.11.0
