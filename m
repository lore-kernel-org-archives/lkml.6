Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806B9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3274021925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RsGmTBIu";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="GuwUGyDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbfBORYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:24:03 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:59308 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbfBORYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:24:03 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FHKoP3028001;
        Fri, 15 Feb 2019 09:23:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=pgxeMF6A++EWzAhLt2EKtLP+cVZoWPiHXa3TZdvDBEE=;
 b=RsGmTBIuRKI6tvNkDzMofjgBKXs6g+1ODdFb0M+xBTF9WxNiD5fBRoMrvDNKNAzDYMkK
 94HjMBM7MnS40me6EhCTSPuOIXWOlK9XoQUmCSXdRMX/Ppgx19bFx68V0tflLchchutf
 Akt+AoZrXdLlVtvGIrFI1klht8HyNIDr7rXMGyez2fSab/ln8B8XNEMySWd9ZBtvQJyG
 SmLNmTv3+9Z5Za7ywZzI7lFg5FaMfvEx5UqJ09K36w9SdSnwSa2qJvrG3iyqJHUsp4Vh
 hOXXxpOj6Z/SoSl9vUw9T0uf+xgSHBNyd1uvN/XATnjsvdP3QxCraI9QiTDOc4AnaNK+ sQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qp1r78098-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Feb 2019 09:23:49 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 15 Feb
 2019 09:23:47 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.51) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 15 Feb 2019 09:23:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgxeMF6A++EWzAhLt2EKtLP+cVZoWPiHXa3TZdvDBEE=;
 b=GuwUGyDtZRRfnoo4Bftnu7KfaGsTLoztcA2v5h3vioDt7ILszYXIDu3ZC7rV+jPwQp1ajcXktmDqRFMXhxZgdhO3RAB3w26laSOFlolWWvo4dsPuoBOQJGFekLjyQ8115oP6MXFMgYPBZT/4Jyvn7YAURnTdn+00PnQaMSuGt98=
Received: from DM5PR18MB1067.namprd18.prod.outlook.com (10.168.118.137) by
 DM5PR18MB1163.namprd18.prod.outlook.com (10.168.119.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 17:23:45 +0000
Received: from DM5PR18MB1067.namprd18.prod.outlook.com
 ([fe80::6855:16f9:7163:6aaa]) by DM5PR18MB1067.namprd18.prod.outlook.com
 ([fe80::6855:16f9:7163:6aaa%12]) with mapi id 15.20.1622.016; Fri, 15 Feb
 2019 17:23:45 +0000
From:   Stefan Chulski <stefanc@marvell.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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
        "mw@semihalf.com" <mw@semihalf.com>
Subject: RE: [PATCH net-next 10/13] net: mvpp2: reset the XPCS while
 reconfiguring the serdes lanes
Thread-Topic: [PATCH net-next 10/13] net: mvpp2: reset the XPCS while
 reconfiguring the serdes lanes
Thread-Index: AQHUxVGvqT4TyHidm0uZQ68Gq2cTYqXhGjCg
Date:   Fri, 15 Feb 2019 17:23:44 +0000
Message-ID: <DM5PR18MB1067DE98EAEEEF202674820AB0600@DM5PR18MB1067.namprd18.prod.outlook.com>
References: <20190215153241.6857-1-antoine.tenart@bootlin.com>
 <20190215153241.6857-11-antoine.tenart@bootlin.com>
 <20190215171224.sjfrid5csseywuks@shell.armlinux.org.uk>
In-Reply-To: <20190215171224.sjfrid5csseywuks@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.126.48.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c06d90c-a500-499b-6a1e-08d6936a56bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:DM5PR18MB1163;
x-ms-traffictypediagnostic: DM5PR18MB1163:
x-microsoft-exchange-diagnostics: 1;DM5PR18MB1163;20:n2Eihc3yYB1eKi8/NgO9WTyh0uINpynI0tF7eq5w98p6GapKGySSGauNJf3E3Oj+A1jqFyjr34puldPMFz44VUAqqJCvLdvWxrKfuxv1ahVtawLeyZoQXfkjsdy9q/ooFDDhLCk5Rtq8R5N+XNGwNBFZ7F1lxJF9A2ZTpzBt4sg=
x-microsoft-antispam-prvs: <DM5PR18MB116314B13F8851128637DD63B0600@DM5PR18MB1163.namprd18.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(39860400002)(396003)(346002)(199004)(189003)(106356001)(8676002)(81156014)(81166006)(26005)(99286004)(8936002)(105586002)(76176011)(7696005)(2906002)(97736004)(102836004)(478600001)(305945005)(3846002)(6116002)(186003)(110136005)(54906003)(316002)(7416002)(14454004)(74316002)(446003)(66066001)(256004)(71200400001)(6246003)(6436002)(11346002)(33656002)(229853002)(7736002)(68736007)(71190400001)(4744005)(53936002)(6506007)(25786009)(86362001)(55016002)(486006)(476003)(9686003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB1163;H:DM5PR18MB1067.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4iTKJyRiqipRQ70iNG09yLX1I0Wjuu3fBQH8lD/colBIKDtvR+eJ+xlHIa8Nagibbo2uz78I9gVOmL5kq0Tu5LWx5RXOVGimchHbDNxTXxrGLTFX7XpZOXLTW1aGG+WG2In57pIBlc0jW7DriGn74acQwl55ufkzzw8R2YuOKWsGy7PSPhyEd4KybW+HK9XQfOkzjTzP++g+43VYL1bQXRnES6S9+bOI6Udi3CU7oiaID9Us3vk5TgASWqGTMmpEcFJjKbfIzbClml8oSUf44QvvGCgkC9+YTemf7FK5jlTE41PKVS0GqhMVTBc9kG4LIULLSfBnErGn2suTN5yPMwy1SKNbH5n8/euGrz4xKFosyCh3Q1+qNvZAksH5t8tnItlBkAIx7lApgDVg2hnQgQmfVTzLb6XjCPw/rNESDZM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c06d90c-a500-499b-6a1e-08d6936a56bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 17:23:44.8653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1163
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_13:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=735 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Feb 15, 2019 at 04:32:38PM +0100, Antoine Tenart wrote:
> > The documentation advises to set the XPCS in reset while reconfiguring
> > the serdes lanes. This seems to be a good thing to do, but the PPv2
> > driver wasn't doing it. This patch fixes it.
>=20
> Hmm.  That statment seems to have some ambiguity in it - we do two
> "reconfigurations" - one may be upon initialisation, where the lane is al=
ready
> configured for 10Gbase-KR, and we're re-initialising it for the same mode=
.
> The other case is when we're switching between 10Gbase-KR and SGMII, or
> as will be the case with 2.5G support for the Alaska PHYs, 2500base-X.

Exist one mode that we should add to PPv2&COMPHY 5Gbase-KR(5GBASE-T).

Stefan,
Best Regards.
