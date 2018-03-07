Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933355AbeCGOSv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:18:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37535 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeCGOSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:18:49 -0500
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>, ymarkman@marvell.com,
        nadavh@marvell.com, stefanc@marvell.com
Subject: [PATCH net-next 0/2] net: mvpp2: Add Unicast filtering capabilities
Date: Wed,  7 Mar 2018 15:18:02 +0100
Message-Id: <20180307141804.348-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series adds unicast filtering support to the Marvell PPv2 controller.

This is implemented using the header parser cababilities of the PPv2,
which allows for generic packet filtering based on matching patterns in
the packet headers.

PPv2 controller only has 256 of these entries, and we need to share them
with other features, such as VLAN filtering.

For each interface, we have 5 entries dedicated to unicast filtering (the
controller's own address, and 4 other), and 21 to multicast filtering.

When this number is reached, the controller switches to unicast or
multicast promiscuous mode.

The first patch reworks the function that adds and removes addresses to the
filter. This is preparatory work to ease UC filter implementation.

The second patch adds the UC filtering feature.

Maxime Chevallier (2):
  net: mvpp2: Simplify MAC filtering function parameters
  net: mvpp2: Add support for unicast filtering

 drivers/net/ethernet/marvell/mvpp2.c | 320 +++++++++++++++++++----------------
 1 file changed, 173 insertions(+), 147 deletions(-)

-- 
2.11.0
