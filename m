Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbeCDG7a convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 01:59:30 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:42192 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751793AbeCDG73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 01:59:29 -0500
From: Stefan Chulski <stefanc@marvell.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Yan Markman <ymarkman@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: RE: [PATCH net-next 1/5] net: mvpp2: use the same buffer pool for all
 ports
Thread-Topic: [PATCH net-next 1/5] net: mvpp2: use the same buffer pool for
 all ports
Thread-Index: AQHTsj18Q7zohIDi9EOdxXOWqy0sHKO8+ZSAgAKuY9A=
Date: Sun, 4 Mar 2018 06:59:20 +0000
Message-ID: <732b36eb681a4254b654f08636fa9204@IL-EXCH01.marvell.com>
References: <20180302154044.25204-1-antoine.tenart@bootlin.com>
        <20180302154044.25204-2-antoine.tenart@bootlin.com>
 <20180302170159.258bcdbc@windsurf.lan>
In-Reply-To: <20180302170159.258bcdbc@windsurf.lan>
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
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=944 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803040089
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> 
> On Fri,  2 Mar 2018 16:40:40 +0100, Antoine Tenart wrote:
> > +static struct {
> > +	int pkt_size;
> > +	int buf_num;
> > +} mvpp2_pools[MVPP2_BM_POOLS_NUM];
> 
> Any reason for not doing:
> 
> } mvpp2_pools[MVPP2_BM_POOLS_NUM] = {
> 	[MVPP2_BM_SHORT] = {
> 		.pkt_size = MVPP2_BM_SHORT_PKT_SIZE,
> 		.buf_num = MVPP2_BM_SHORT_BUF_NUM
> 	},
> 	[MVPP2_BM_LONG] = {
> 		.pkt_size = MVPP2_BM_LONG_PKT_SIZE,
> 		.buf_num = MVPP2_BM_LONG_BUF_NUM,
> 	},
> };
> 
> And get rid of:
> 
> > +static void mvpp2_setup_bm_pool(void) {
> > +	/* Short pool */
> > +	mvpp2_pools[MVPP2_BM_SHORT].buf_num  =
> MVPP2_BM_SHORT_BUF_NUM;
> > +	mvpp2_pools[MVPP2_BM_SHORT].pkt_size =
> MVPP2_BM_SHORT_PKT_SIZE;
> > +
> > +	/* Long pool */
> > +	mvpp2_pools[MVPP2_BM_LONG].buf_num  =
> MVPP2_BM_LONG_BUF_NUM;
> > +	mvpp2_pools[MVPP2_BM_LONG].pkt_size =
> MVPP2_BM_LONG_PKT_SIZE; }
> 
>  ?
> 

No, we can change it.

Stefan.
