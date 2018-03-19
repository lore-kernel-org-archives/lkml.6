Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755488AbeCSM7M convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 08:59:12 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:33962 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755325AbeCSM7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 08:59:09 -0400
From: Stefan Chulski <stefanc@marvell.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
        Antoine Tenart <antoine.tenart@bootlin.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "kishon@ti.com" <kishon@ti.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Yan Markman <ymarkman@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
 interface to use in-band negotiation
Thread-Topic: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
 interface to use in-band negotiation
Thread-Index: AQHTvT77nBQG5ffkBEaqTn9C4RyF8qPXI08AgAAm5YCAAD44wA==
Date: Mon, 19 Mar 2018 12:58:24 +0000
Message-ID: <4e11135ba2644f76beb41a307c9d990a@IL-EXCH01.marvell.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk> <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
In-Reply-To: <20180319111205.GB2743@n2100.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [199.203.130.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-19_08:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=992 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803190152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > There is no inband negotiation like there is with 802.3z or SGMII,
> > > so this makes no sense.
> >
> > Oh, that's what I feared. I read some docs but probably will need more
> > :)
> >
> > Anyway, the reason to use in-band negotiation was also to avoid using
> > fixed-link. It would work but always report the link is up, which for
> > the user isn't a great experience as we have a way to detect this.
> >
> > What would you suggest to achieve this in a reasonable way?
> 
> The intention of this test in phylink_of_phy_connect() is to avoid failing
> when there is no requirement for a PHY to be present (such as a fixed link, or
> an 802.3z link.)  However, with 10G PHYs such as the 3310, we need the PHY
> so we can read the speed from it, and so know whether to downgrade the
> MAC to SGMII mode, or having downgraded the MAC, upgrade it back to 10G
> mode when the PHY switches to 10G.
> 
> I'm guessing that you're wanting this for the DB boards, but I don't see why.
> Do they not have PHYs?

New Solid Run board MACCHIATObin Single Shot doesn't has  3310 PHY either, like DB boards.
https://www.cnx-software.com/2017/12/20/solidrun-macchiatobin-single-shot-networking-board-launched-for-269-and-up/

Stefan,
Best Regards.
