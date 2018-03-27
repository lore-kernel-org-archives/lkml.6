Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754599AbeC0RSc convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:18:32 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:47454 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753371AbeC0RS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:18:27 -0400
From: Yan Markman <ymarkman@marvell.com>
To: David Miller <davem@davemloft.net>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: RE: [EXT] Re: [PATCH net-next] net: mvpp2: Use relaxed I/O in data
 path
Thread-Topic: [EXT] Re: [PATCH net-next] net: mvpp2: Use relaxed I/O in data
 path
Thread-Index: AQHTxe9Y+h9P4lgD90qvFtrscB3ykaPkUxXQ
Date: Tue, 27 Mar 2018 17:18:16 +0000
Message-ID: <75eee7d671594c0ea95bfb9f055b4714@IL-EXCH01.marvell.com>
References: <20180327144905.23499-1-maxime.chevallier@bootlin.com>
 <20180327.131624.64497520832369981.davem@davemloft.net>
In-Reply-To: <20180327.131624.64497520832369981.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.5.102.207]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-27_06:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=900 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803270174
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks David
We are aware and it is working properly
Yan Markman


-----Original Message-----
From: David Miller [mailto:davem@davemloft.net] 
Sent: Tuesday, March 27, 2018 8:16 PM
To: maxime.chevallier@bootlin.com
Cc: Yan Markman <ymarkman@marvell.com>; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; antoine.tenart@bootlin.com; thomas.petazzoni@bootlin.com; gregory.clement@bootlin.com; miquel.raynal@bootlin.com; Nadav Haklai <nadavh@marvell.com>; Stefan Chulski <stefanc@marvell.com>; mw@semihalf.com
Subject: [EXT] Re: [PATCH net-next] net: mvpp2: Use relaxed I/O in data path

External Email

----------------------------------------------------------------------
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Tue, 27 Mar 2018 16:49:05 +0200

> From: Yan Markman <ymarkman@marvell.com>
> 
> Use relaxed I/O on the hot path. This achieves significant performance 
> improvements. On a 10G link, this makes a basic iperf TCP test go from 
> an average of 4.5 Gbits/sec to about 9.40 Gbits/sec.
> 
> Signed-off-by: Yan Markman <ymarkman@marvell.com>
> [Maxime: Commit message, cosmetic changes]
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> David, this patch should not conflict with other the pending PPv2 
> series I sent earlier ("[PATCH net-next 0/2] net: mvpp2: Remove 
> unnecessary dynamic allocs")

Applied, but it is up to you to make sure the correct barriers are in place such that undesirable memory and IOMEM operation reordering does not occur.

Said another way, you get to keep the pieces if this breaks things :-)
