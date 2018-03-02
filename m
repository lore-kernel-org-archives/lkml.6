Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946156AbeCBPpj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:45:39 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36283 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424488AbeCBPpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:45:16 -0500
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 0/5] net: mvpp2: jumbo frames support
Date: Fri,  2 Mar 2018 16:40:39 +0100
Message-Id: <20180302154044.25204-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series enable jumbo frames support in the Marvell PPv2 driver. The
first 2 patches rework the buffer management, then two patches prepare for
the final patch which adds the jumbo frames support into the driver.

This is based on top of net-next, and was tested on a mcbin.

Thanks!
Antoine

Antoine Tenart (1):
  net: mvpp2: enable UDP/TCP checksum over IPv6

Stefan Chulski (3):
  net: mvpp2: use the same buffer pool for all ports
  net: mvpp2: update the BM buffer free/destroy logic
  net: mvpp2: jumbo frames support

Yan Markman (1):
  net: mvpp2: use a data size of 10kB for Tx FIFO on port 0

 drivers/net/ethernet/marvell/mvpp2.c | 231 +++++++++++++++++++++++++----------
 1 file changed, 165 insertions(+), 66 deletions(-)

-- 
2.14.3
