Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbeCDGaN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 01:30:13 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:40332 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751427AbeCDGaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 01:30:12 -0500
From: Stefan Chulski <stefanc@marvell.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        Yan Markman <ymarkman@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, "mw@semihalf.com" <mw@semihalf.com>
Subject: RE: [PATCH net-next 3/5] net: mvpp2: use a data size of 10kB for Tx
 FIFO on port 0
Thread-Topic: [PATCH net-next 3/5] net: mvpp2: use a data size of 10kB for Tx
 FIFO on port 0
Thread-Index: AQHTsj192xJjJ5DFzUShqEYMfMH8kaO8/C6AgAKgx/A=
Date: Sun, 4 Mar 2018 06:29:59 +0000
Message-ID: <bd3a0e716e1c44938b7a216ea54b9c7e@IL-EXCH01.marvell.com>
References: <20180302154044.25204-1-antoine.tenart@bootlin.com>
        <20180302154044.25204-4-antoine.tenart@bootlin.com>
 <20180302171117.2344a893@windsurf.lan>
In-Reply-To: <20180302171117.2344a893@windsurf.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.5.102.207]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-04_03:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=712 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803040083
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri,  2 Mar 2018 16:40:42 +0100, Antoine Tenart wrote:
> 
> > -/* Initialize Tx FIFO's */
> > +/* Initialize Tx FIFO's
> > + * The CP110's total tx-fifo size is 19kB.
> > + * Use large-size 10kB for fast port but 3kB for others.
> > + */
> 
> Is there a reason to hardcode 10KB for port 0, and 3KB for the other ports ?
> Would there be use cases where the user may want different configurations
> ?
> 

Design requirement are 10KB TX FIFO for the 10Gb/sec and 2.5KB for the 2.5Gb/sec.
Since only port 0 support 10Gb/sec and ports 1&2 support up to 2.5Gb/sec.
I don't see any reason to change this configurations.
Also TX FIFO size could be set only during probe.

> It's just that it feels very "hardcoded" to enforce specifically those numbers.
> 
> Also, does it make sense to mention the CP110 here ? Is this 19 KB limitation
> a limit of the PPv2.2 IP, or of the CP110 ?

PPv2.2 IP is part of 110 communication processor.
Next communication processor will has different Packet processor or next generation of PPv2.x
Limit is PPv2.2 TX FIFO.

Stefan.
