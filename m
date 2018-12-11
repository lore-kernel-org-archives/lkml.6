Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18EBC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8E820851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="a79PaNth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8E820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLKVLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:11:54 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:51314 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726134AbeLKVLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:11:54 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBBLBNiw019434;
        Tue, 11 Dec 2018 13:11:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=VzAAcXXXr4RsY8zVF9upsYkyLfjDudUX53nFrCF4JVU=;
 b=a79PaNthuU+qAOH2n2AA211Mvo9LtB4C5gD1f5iml1baZNAma8IYViQsGrLQJ5UNtP/7
 oWKGWAwr3uogZmzjb7IGdGUTFyjb9UwSz7QB17ye0eAhkRpadX3TJ9r7sG1zozeZuTfB
 14upkd9tecRZRUd2A+Fh+CfyGDebb1jZ/2KRopW4JUSrcZPuuvavFE1vLY2mwRXzL/e8
 KoSuwOxr2cY+t59gv+4vBockYUVgm6783ZbawL/3dqpwU4NlVQ9xjkL7WnbiFRM1BE/8
 xeNYA/NiTglCj4cuoYAbssMpeRxomylgIoDAn+iGF7t+SuH5SQ9IY4ruV8GBOIUFkGN9 Aw== 
Received: from il-exch01.marvell.com ([199.203.130.101])
        by mx0a-0016f401.pphosted.com with ESMTP id 2paa3dua2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 11 Dec 2018 13:11:35 -0800
Received: from IL-EXCH01.marvell.com (10.4.102.220) by IL-EXCH01.marvell.com
 (10.4.102.220) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 11 Dec
 2018 23:11:32 +0200
Received: from IL-EXCH01.marvell.com ([fe80::5d63:81cd:31e2:fc36]) by
 IL-EXCH01.marvell.com ([fe80::5d63:81cd:31e2:fc36%20]) with mapi id
 15.00.1367.000; Tue, 11 Dec 2018 23:11:31 +0200
From:   Stefan Chulski <stefanc@marvell.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Antoine Tenart <antoine.tenart@bootlin.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Yan Markman <ymarkman@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        Baruch Siach <baruch@tkos.co.il>
Subject: RE: [PATCH net] net: mvpp2: 10G modes aren't supported on all ports
Thread-Topic: [PATCH net] net: mvpp2: 10G modes aren't supported on all ports
Thread-Index: AQHUkW/CrCkST3x9K0e6qPjMgD/EIKV6CGbQ
Date:   Tue, 11 Dec 2018 21:11:31 +0000
Message-ID: <7b61c1fbf51a409684568216e799ebe3@IL-EXCH01.marvell.com>
References: <20181211163228.26130-1-antoine.tenart@bootlin.com>
 <20181211163635.GG30658@n2100.armlinux.org.uk>
In-Reply-To: <20181211163635.GG30658@n2100.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [199.203.130.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org>
> On Behalf Of Russell King - ARM Linux
> Sent: Tuesday, December 11, 2018 6:37 PM
> To: Antoine Tenart <antoine.tenart@bootlin.com>
> Cc: davem@davemloft.net; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; thomas.petazzoni@bootlin.com;
> maxime.chevallier@bootlin.com; gregory.clement@bootlin.com;
> miquel.raynal@bootlin.com; Nadav Haklai <nadavh@marvell.com>; Stefan
> Chulski <stefanc@marvell.com>; Yan Markman <ymarkman@marvell.com>;
> mw@semihalf.com; Baruch Siach <baruch@tkos.co.il>
> Subject: Re: [PATCH net] net: mvpp2: 10G modes aren't supported on all
> ports
>=20
> On Tue, Dec 11, 2018 at 05:32:28PM +0100, Antoine Tenart wrote:
> > The mvpp2_phylink_validate() function sets all modes that are
> > supported by a given PPv2 port. A recent change made all ports to
> > advertise they support 10G modes in certain cases. This is not true,
> > as only the port #0 can do so. This patch fixes it.
> >
> > Fixes: 01b3fd5ac97c ("net: mvpp2: fix detection of 10G SFP modules")
> > Cc: Baruch Siach <baruch@tkos.co.il>
> > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> > ---
> >  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > index 125ea99418df..88aa488054a8 100644
> > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > @@ -4405,12 +4405,14 @@ static void mvpp2_phylink_validate(struct
> net_device *dev,
> >  	case PHY_INTERFACE_MODE_10GKR:
> >  	case PHY_INTERFACE_MODE_XAUI:
>=20
> Are these modes supported on anything except port 0?  If not, you should =
be
> rejecting these, rather than just treating them as RGMII.

In CP115(which has PPv2) PHY_INTERFACE_MODE_10GKR supported on ports 0 and =
1
PHY_INTERFACE_MODE_XAUI/PHY_INTERFACE_MODE_RXAUI supported only on port 0.

Best Regards.
