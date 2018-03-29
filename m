Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeC2F7I convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 01:59:08 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:46936 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750716AbeC2F7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 01:59:06 -0400
From: Yan Markman <ymarkman@marvell.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Yelena Krivosheev <yelena@marvell.com>
Subject: RE: [EXT] [PATCH net-next v2 0/2] phylink: API changes
Thread-Topic: [EXT] [PATCH net-next v2 0/2] phylink: API changes
Thread-Index: AQHTxuZRRbaF+DVlk0OPaTwwQ7MVRqPmt83Q
Date: Thu, 29 Mar 2018 05:58:43 +0000
Message-ID: <98b31575864f474fa7177c39ff06f81b@IL-EXCH01.marvell.com>
References: <20180328224416.6981-1-f.fainelli@gmail.com>
In-Reply-To: <20180328224416.6981-1-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.5.102.207]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-29_03:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803290067
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian
Please keep CC 		Yelena Krivosheev <yelena@marvell.com>
for changes with 	drivers/net/ethernet/marvell/mvneta.c
Thanks
Yan Markman
Tel. 05-44732819


-----Original Message-----
From: Florian Fainelli [mailto:f.fainelli@gmail.com] 
Sent: Thursday, March 29, 2018 1:44 AM
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>; Thomas Petazzoni <thomas.petazzoni@free-electrons.com>; Andrew Lunn <andrew@lunn.ch>; David S. Miller <davem@davemloft.net>; Russell King <rmk+kernel@armlinux.org.uk>; open list <linux-kernel@vger.kernel.org>; Antoine Tenart <antoine.tenart@bootlin.com>; Yan Markman <ymarkman@marvell.com>; Stefan Chulski <stefanc@marvell.com>; Maxime Chevallier <maxime.chevallier@bootlin.com>; Miquel Raynal <miquel.raynal@free-electrons.com>; Marcin Wojtas <mw@semihalf.com>
Subject: [EXT] [PATCH net-next v2 0/2] phylink: API changes

External Email

----------------------------------------------------------------------
Hi all,

This patch series contains two API changes to PHYLINK which will later be used by DSA to migrate to PHYLINK. Because these are API changes that impact other outstanding work (e.g: MVPP2) I would rather get them included sooner to minimize conflicts.

Thank you!

Changes in v2:

- added missing documentation to mac_link_{up,down} that the interface
  must be configured in mac_config()

- added Russell's, Andrew's and my tags

Florian Fainelli (1):
  net: phy: phylink: Provide PHY interface to mac_link_{up,down}

Russell King (1):
  sfp/phylink: move module EEPROM ethtool access into netdev core
    ethtool

 drivers/net/ethernet/marvell/mvneta.c | 22 +++-------------------
 drivers/net/phy/phylink.c             | 32 +++-----------------------------
 drivers/net/phy/sfp-bus.c             |  6 ++----
 include/linux/netdevice.h             |  3 +++
 include/linux/phylink.h               | 17 +++++++++++------
 net/core/ethtool.c                    |  7 +++++++
 6 files changed, 29 insertions(+), 58 deletions(-)

--
2.14.1
