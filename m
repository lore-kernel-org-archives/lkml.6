Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96781C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A0B2170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="RbBBx6b4";
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="hOo6L6SV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A0B2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ericsson.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbeHUNMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:12:21 -0400
Received: from sessmg23.ericsson.net ([193.180.251.45]:50756 "EHLO
        sessmg23.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeHUNMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=ericsson.com; s=mailgw201801; c=relaxed/simple;
        q=dns/txt; i=@ericsson.com; t=1534845167;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gojlLsDa+ZL6cbytA093v2XM85Nuc3PSMLj7FAIzLS0=;
        b=RbBBx6b4PYGys0tHgR2IWghKmachj3JyBL8hwtGNPpM477B9ACMxEip4WJzKLQ3D
        80oDnnm8RiG/Oe8yBQdoZl8gvNkbJCqfuvv1J2Lb3GhHr+m+dfhVRaoMVdolnaZa
        bWS763qi/JecRFYuh59rdR5JzG5qZRUteyMpLOMJjU0=;
X-AuditID: c1b4fb2d-20bff700000055ff-e3-5b7be0efbb05
Received: from ESESSMB504.ericsson.se (Unknown_Domain [153.88.183.122])
        by sessmg23.ericsson.net (Symantec Mail Security) with SMTP id B6.6B.22015.FE0EB7B5; Tue, 21 Aug 2018 11:52:47 +0200 (CEST)
Received: from ESESSMB503.ericsson.se (153.88.183.164) by
 ESESSMB504.ericsson.se (153.88.183.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3; Tue, 21 Aug 2018 11:52:46 +0200
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (153.88.183.157)
 by ESESSMB503.ericsson.se (153.88.183.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3 via Frontend Transport; Tue, 21 Aug 2018 11:52:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gojlLsDa+ZL6cbytA093v2XM85Nuc3PSMLj7FAIzLS0=;
 b=hOo6L6SVZtxjpZx6jQbNszvMrnNOVeKzeBzprQMmg0OiWVJdfxDVkBj66BgbKzhF/lLcTRnp55vjobt6diDaa9T8tcvJaarFv3pBEWy77xX4FEwR+UXOql412yACcpFeYpM2YReJGOiwB7a5LaEcsEVGv+JMEgMoApAkLGuLSBQ=
Received: from DM5PR15MB1513.namprd15.prod.outlook.com (10.173.225.146) by
 DM5PR15MB1322.namprd15.prod.outlook.com (10.173.210.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.19; Tue, 21 Aug 2018 09:52:43 +0000
Received: from DM5PR15MB1513.namprd15.prod.outlook.com
 ([fe80::c024:d1b8:10c5:6620]) by DM5PR15MB1513.namprd15.prod.outlook.com
 ([fe80::c024:d1b8:10c5:6620%5]) with mapi id 15.20.1059.023; Tue, 21 Aug 2018
 09:52:43 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     David Miller <davem@davemloft.net>,
        "Haiqing.Bai@windriver.com" <Haiqing.Bai@windriver.com>
CC:     "ying.xue@windriver.com" <ying.xue@windriver.com>,
        "zhenbo.gao@windriver.com" <zhenbo.gao@windriver.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tipc: fix issue that tipc_dest neglects of big-endian
Thread-Topic: [PATCH] tipc: fix issue that tipc_dest neglects of big-endian
Thread-Index: AQHUOHRD/OknqKHZI0eOIwm+4Lc7BqTJeiiAgAB89VA=
Date:   Tue, 21 Aug 2018 09:52:43 +0000
Message-ID: <DM5PR15MB1513428048EE31705DA273549A310@DM5PR15MB1513.namprd15.prod.outlook.com>
References: <1534760761-30206-1-git-send-email-Haiqing.Bai@windriver.com>
 <20180820.192031.1137174206399090141.davem@davemloft.net>
In-Reply-To: <20180820.192031.1137174206399090141.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-originating-ip: [92.220.68.146]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1322;6:rVLEcmV6YLgvitvAlE+ZPuccxhKeOoLkiKaB1TXY+omgHObt0J+aKGzkKSpWj1MKXMUEGnWshyehCTIE8hK0wyKmTfxBKXBH1OJ9CuFtT88P1Ujy3WvPQ1vWo2kGKEjOuETwFewL07m2H6egwVlPBjuXlMtPDS9IhBvT75Hb+2wj5QaRj3nZs8cNPVgPaeuKDxWFP5CeoFD/d9k21T8tYCwE9qsVpRALx51fd81ze6D/x1Voy5AoAY/gFBFvXnI/N61J9VrZkI/wMeh4NJ1Ov6IreIHyvJ/XKGynZ0SB4Pw/16t1qVH2KH1hxC97NG91cZyvrQhKeaiZ5dNsx5yn9kgdmxF8HA6uicifNE3qJ51jz9hFMpQ+6g6x9ZB7Q/tXkP6pV+1YJX0nGGShdYUYMeFfWk+cC9BoPlxYl4VIW/Aik9mjoRihMyAqoU2dIu+1eNgFiJiqQ1XIiy1ywTunqw==;5:7lT4KiNgSoPlsB5OrEAYYpjfxUys0CdtW5fOgBFpcUCQRMswI2yNuxFxKo7wcPMA//+TyU2NU0tOC1Rfe0neAA8vYIBvfQ0JsTN89L6diKOHsLUcC7XcFg98xqCZ/2ZG+RAgmKuhtewLv0ajIa8WGX6isgV//1ZC0mgO1Fmt3Uc=;7:2tZIpEXWQ1P+PWxlTc8Q1jbjErJxLcZxnknzzA620bsGmxeFG6GIp46tYEilpPdDhMntyxLecV2yEPLeWNKvDcsr4aFFdM8ZLCAipbeEgpkSGc8DGGAEfX73Fjjjsf376I3MMKfKpFWa6GtnoNLaertAbiK56or7z9MpLw4pvlOzWxrLhuOeJZWnqvBFOs8IapXyPQkVq4JdJicFTCkVqqjsobisvfz2vWlfox6dIErvUZA9G+1N/ADo32h1Rr3o
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2c047538-da4c-4bf6-5682-08d6074bd76a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1322;
x-ms-traffictypediagnostic: DM5PR15MB1322:
x-microsoft-antispam-prvs: <DM5PR15MB1322FBE5F6DD09CBB8CA04F59A310@DM5PR15MB1322.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(158342451672863)(9452136761055)(248295561703944);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM5PR15MB1322;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1322;
x-forefront-prvs: 0771670921
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(13464003)(186003)(26005)(102836004)(105586002)(53546011)(316002)(6506007)(110136005)(54906003)(2900100001)(2906002)(8676002)(81166006)(4326008)(81156014)(14454004)(106356001)(6116002)(7736002)(8936002)(5660300001)(3846002)(305945005)(97736004)(74316002)(68736007)(476003)(478600001)(66066001)(14444005)(99286004)(55016002)(7696005)(6436002)(256004)(76176011)(9686003)(5250100002)(86362001)(44832011)(25786009)(446003)(2501003)(6246003)(11346002)(486006)(33656002)(229853002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR15MB1322;H:DM5PR15MB1513.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: G+6ey4aJPzSq/Jl455G8hO6RZw0Puoxf14xbkQSHof/GmiljGEsGyDmxoXkL5sdu6dNDCcPkxxuJxpWOvXWyfIvzkp3ip4Enf6PcPFIdryO9inP+aiROkVDDUO1t5LQUgZFrAKCmBosXiLfxScfciKaU25D/0LNk1qqf6Rw6AwzysMrovehpfs3FQJdxnLxl2kOkf++PdAbD5bpmAZWTyadQtUX7fJw2Shc/AawDZmSSGtupRfftdo4E3pIPQg+rFbv9dfwaoHUuIzCQnksnbe7GBu1IA2+byMfmeJ3phb9QPa6+uxswalmklY7eCdQNBMERQb9KGeS9TOID1QHF2IEJs0cmfOOK8uWo+uuGJGU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c047538-da4c-4bf6-5682-08d6074bd76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2018 09:52:43.6265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1322
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTURjGObt3291oeJpfL4pSoyI1La1ghH39oVgaffxTalHLXVTUzXZN
        UslmujIlU8lostj8wGqZiamZijBj9iUudGkLZ6ZbJWpZkhGG5bwT+u/3vM/znvNwOBQh1nH9
        qFRFFq1SyNIlPCGpPfEkN/TbeF7itsftHlKdpYiUfmiwcqRDnTqetM/gI50cGSGkC9YmYh8v
        pvW+jRMz3xIY86i1jXOESBBGyun01GxatXXPGWFKs/kvJ/MudWHUqeap0RdeCaIowDvgqe5o
        CRJSYmxGYHGM8lixgGBe95PDinoO6PsKCJcgcTkBD7vecFnn5rLT2ejemVje0Y+RJUhA8fBm
        mLpVjFzshWXwR+8kXSECOxA8u82GPPFBsPfPEGwoFgYcs27eBVcrbXwXk3gjLOoK+a62InwS
        nLP+7GUaBHrNu5W8AEfDDVMDx8UI+8CvV40rTGBfeO/QrzBgDPXdFoJlb5iaXOK6zkQ4Hl47
        49nxeujXVLkjATCoL0Us9/DBXBTOcijMVa1mDkFtYfPKswB+jmBpqNhtBIO67QrJchoslZrR
        KlcOV7v7BILx+keyHIVX/1eV5S1g6PrBYzkEGmqmCReL8Fp4qXWQBkQakTdDM0xGcsT2MFqV
        msQwSkWYgs5qQct/xtS6GNqBHkzv70WYQpI1ost1eYliriybycnoRUAREi9RrWV5JJLLcnJp
        lfK06nw6zfQif4qU+IrCjN0JYpwsy6LTaDqTVq26HErgp0a0PQpHyqN3zpRlJFWWTZT50RG4
        w6PAJD82bLZpJr5eDCiZLR6K8xx/O+b5yVj3e13iXEi+Rneq6ECcMi3v0mdBY5D9RdQ97vCm
        gd2GO3NNgzHS0YqKa+ahCOtUX5BAH1djbD+397spX9kzWLChxarvtkkX+Nrj4+qz9ljt4RwJ
        yaTIwoMJFSP7B41eyFYvAwAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,=20
Please hold this one for now.=20

///jon

> -----Original Message-----
> From: David Miller <davem@davemloft.net>
> Sent: Monday, 20 August, 2018 22:21
> To: Haiqing.Bai@windriver.com
> Cc: Jon Maloy <jon.maloy@ericsson.com>; ying.xue@windriver.com; zhenbo.ga=
o@windriver.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] tipc: fix issue that tipc_dest neglects of big-endia=
n
>=20
> From: Haiqing Bai <Haiqing.Bai@windriver.com>
> Date: Mon, 20 Aug 2018 18:26:01 +0800
>=20
> > The tipc multicast demo in tipcutils fails to work on big-endian hardwa=
re.
> > The tipc multicast server can not receive the packets sent by the multi=
cast
> > client for that the dest port is always zero after tipc_dest_pop, then =
it
> > is found that the struct tipc_dest fails to take big/little endian into
> > account.
> >
> > Signed-off-by: Haiqing Bai <Haiqing.Bai@windriver.com>
> > Signed-off-by: Zhenbo Gao <zhenbo.gao@windriver.com>
>=20
> Jon and Ying, please review.
>=20
> thank you.
