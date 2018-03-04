Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeCDJmt convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 04:42:49 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49130 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751831AbeCDJmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 04:42:47 -0500
From: Stefan Chulski <stefanc@marvell.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
CC: Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Yan Markman <ymarkman@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: RE: [PATCH net-next 5/5] net: mvpp2: jumbo frames support
Thread-Topic: [PATCH net-next 5/5] net: mvpp2: jumbo frames support
Thread-Index: AQHTsj18um8XkydR1EKUeFQympSTGqO8/daAgAKiLNCAABBKAIAAItKg
Date: Sun, 4 Mar 2018 09:42:39 +0000
Message-ID: <7d2e6deeb8a8435593b5c08615b192e1@IL-EXCH01.marvell.com>
References: <20180302154044.25204-1-antoine.tenart@bootlin.com>
        <20180302154044.25204-6-antoine.tenart@bootlin.com>
        <20180302171713.54beaad0@windsurf.lan>
        <31a2c6c988bd4d5190e1fb3332f3bc35@IL-EXCH01.marvell.com>
 <20180304102828.1437fbc3@windsurf.home>
In-Reply-To: <20180304102828.1437fbc3@windsurf.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.5.102.207]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-04_05:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=756 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803040124
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > To perform checksum in HW, HW obviously should work in store and
> forward mode. Store all frame in TX FIFO and then check checksum.
> > If mtu 1500B, everything fine and all port can do this.
> >
> > If mtu is 9KB and 9KB frame transmitted, Port 0 still can do HW checksum.
> But ports 1 and 2 doesn't has enough FIFO for this.
> > So we cannot offload this feature and SW should perform checksum.
> 
> So perhaps the real check should not be "port 0", but whether the MTU is
> higher or lower than the TX FIFO size assigned to the current port.
> This would express in much better way the reason why HW checksum can be
> used or not.

I really don't want involve MTU size here, for each packet we should add to MTU overhead added by HW(offset, CRC, DSA tags and etc).
I prefer just to check: port TX FIFO size is 10KB -> port can support HW checksum offload.
Do you suggest to keep some shadow table with ports TX FIFO sizes for this?  

Thanks,
Stefan.
