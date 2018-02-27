Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeB0Rs4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:48:56 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:48126 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751682AbeB0Rsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:48:54 -0500
From: Yan Markman <ymarkman@marvell.com>
To: Antoine Tenart <antoine.tenart@bootlin.com>,
        David Miller <davem@davemloft.net>
CC: "mw@semihalf.com" <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        "thomas.petazzoni@free-electrons.com"
        <thomas.petazzoni@free-electrons.com>,
        "gregory.clement@free-electrons.com"
        <gregory.clement@free-electrons.com>,
        "miquel.raynal@free-electrons.com" <miquel.raynal@free-electrons.com>,
        "Nadav Haklai" <nadavh@marvell.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/3] net: mvpp2: adjust gso stop wake thresholds
Thread-Topic: [PATCH net-next 2/3] net: mvpp2: adjust gso stop wake thresholds
Thread-Index: AQHTr+5gMacKWYOS1E2MXCJCRoeif6O4hm5g
Date: Tue, 27 Feb 2018 17:48:44 +0000
Message-ID: <87f896cb9e774ee083227ddd2f1c88ea@IL-EXCH01.marvell.com>
References: <20180226141427.31536-1-antoine.tenart@bootlin.com>
 <20180226141427.31536-2-antoine.tenart@bootlin.com>
 <20180227.111306.790069240486489244.davem@davemloft.net>
 <20180227171352.GD21643@kwain>
In-Reply-To: <20180227171352.GD21643@kwain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.5.102.207]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_08:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802270220
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will make this tomorrow.
Thanks for attention!
Best regards
Yan Markman
Tel. 05-44732819


-----Original Message-----
From: Antoine Tenart [mailto:antoine.tenart@bootlin.com] 
Sent: Tuesday, February 27, 2018 7:14 PM
To: David Miller <davem@davemloft.net>
Cc: antoine.tenart@bootlin.com; Yan Markman <ymarkman@marvell.com>; mw@semihalf.com; Stefan Chulski <stefanc@marvell.com>; thomas.petazzoni@free-electrons.com; gregory.clement@free-electrons.com; miquel.raynal@free-electrons.com; Nadav Haklai <nadavh@marvell.com>; maxime.chevallier@bootlin.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: mvpp2: adjust gso stop wake thresholds

Hi David,

On Tue, Feb 27, 2018 at 11:13:06AM -0500, David Miller wrote:
> From: Antoine Tenart <antoine.tenart@bootlin.com>
> > From: Yan Markman <ymarkman@marvell.com>
> > -#define MVPP2_MAX_TSO_SEGS		300
> > +#define MVPP2_MAX_TSO_SEGS		100
> >  #define MVPP2_MAX_SKB_DESCS		(MVPP2_MAX_TSO_SEGS * 2 + MAX_SKB_FRAGS)
> >  
> >  /* Dfault number of RXQs in use */
> > @@ -5810,7 +5810,7 @@ static int mvpp2_txq_init(struct mvpp2_port *port,
> >  		txq_pcpu->tso_headers = NULL;
> >  
> >  		txq_pcpu->stop_threshold = txq->size - MVPP2_MAX_SKB_DESCS;
> > -		txq_pcpu->wake_threshold = txq_pcpu->stop_threshold / 2;
> > +		txq_pcpu->wake_threshold = txq_pcpu->stop_threshold - 100;
> >  
> 
> This number 100 is a magic constant.  If it is related to 
> MVPP2_MAX_TSO_SEGS, please use that define.  Otherwise define a new 
> one which is descriptive.

I agree. I'll ask Yan about it and update if possible.

Thanks!
Antoine

--
Antoine Ténart, Bootlin (formerly Free Electrons) Embedded Linux and Kernel engineering https://bootlin.com
