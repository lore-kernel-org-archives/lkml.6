Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B8BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7B922537
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onelaird.onmicrosoft.com header.i=@onelaird.onmicrosoft.com header.b="fjesI5j4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7B922537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lairdtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbeGDNnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:43:53 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:61650
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932995AbeGDNlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onelaird.onmicrosoft.com; s=selector1-lairdtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuFkuLeC8gvdLqIp5ZwiaF7aq5g/JGg861H2EaV8fMU=;
 b=fjesI5j4wb1hb6rZgSFqxDrl0GEgWmEi1QGnKhQ0emcqtLH2plaLakMlkLVDBC2S/tmFiec9PJMOZLyIFZOX+CB4+31EmhiaxyYinhkzTrcJrhupvMjuUwifgjPDRTz1T3cShf3aA09+/hwlfnGK05Cr0fPDouIzjdblYpQGRlU=
Received: from BY1PR02MB1114.namprd02.prod.outlook.com (10.162.108.140) by
 BY1PR02MB1259.namprd02.prod.outlook.com (10.162.109.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Wed, 4 Jul 2018 13:41:43 +0000
Received: from BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::d5c4:ef81:b513:f5da]) by BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::d5c4:ef81:b513:f5da%4]) with mapi id 15.20.0906.026; Wed, 4 Jul 2018
 13:41:43 +0000
From:   Ben Whitten <Ben.Whitten@lairdtech.com>
To:     Mark Brown <broonie@kernel.org>,
        =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?iso-8859-1?Q?Michael_R=F6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        Steve deRosier <derosier@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "LoRa_Community_Support@semtech.com" 
        <LoRa_Community_Support@semtech.com>,
        Hasnain Virk <Hasnain.Virk@arm.com>
Subject: RE: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Thread-Topic: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Thread-Index: AQHUESvvwSr5pLbXbkmh3lgaa2XdVqR8HL0AgAAWvYCAAWSEAIAABWIAgAAGJICAABNMgIABP2uAgAAdtsA=
Date:   Wed, 4 Jul 2018 13:41:42 +0000
Message-ID: <BY1PR02MB1114BC0F12654B1E7C614108E7410@BY1PR02MB1114.namprd02.prod.outlook.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <20180703145022.GA13744@sirena.org.uk>
 <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
 <20180703153137.GB13744@sirena.org.uk>
 <3f6289f9-d345-39a7-f0dd-9d5fa7c86e82@suse.de>
 <20180704114355.GB11693@sirena.org.uk>
In-Reply-To: <20180704114355.GB11693@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Whitten@lairdtech.com; 
x-originating-ip: [146.200.117.72]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR02MB1259;7:KF79xK0is6RosTQztYl22fwRE1MUFu09VQiKNlnPurRpAJEV1fqlJnOeHZhM5s7BApcpJfq0UdapEgt4/OYIqSIrqf2IOcSyKcQwYGQzSGyOaSSSdf1RBlSUFGzCmc8w5+qwSuaCjpuy4z3ztd3s2sgQVsYNpyUkBt+mzOccoBFQ9ZFFxfZN+wgRukOG9CQp7/v93p9oDbXvJoUkuQ12Hm/fKQaVt7gUJreaocIlsiTOzuxcLfVD2xHVTJHe4XMk
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3a351dc9-1897-4f34-5e53-08d5e1b3e101
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY1PR02MB1259;
x-ms-traffictypediagnostic: BY1PR02MB1259:
x-microsoft-antispam-prvs: <BY1PR02MB12592BC10D3BDE2D7A813C7BE7410@BY1PR02MB1259.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY1PR02MB1259;BCL:0;PCL:0;RULEID:;SRVR:BY1PR02MB1259;
x-forefront-prvs: 0723A02764
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(366004)(39860400002)(189003)(199004)(229853002)(14454004)(7696005)(6436002)(305945005)(7736002)(3846002)(86362001)(7416002)(76176011)(6116002)(97736004)(256004)(2900100001)(25786009)(5024004)(55016002)(55236004)(102836004)(26005)(6506007)(33656002)(74316002)(186003)(5250100002)(446003)(11346002)(72206003)(9686003)(476003)(93886005)(5660300001)(486006)(99286004)(478600001)(8936002)(8676002)(39060400002)(4326008)(53936002)(110136005)(2906002)(316002)(81156014)(81166006)(66066001)(6246003)(68736007)(106356001)(105586002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY1PR02MB1259;H:BY1PR02MB1114.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lairdtech.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rTIxxqGNtt7t+YXcwPAr4Sxbi8rrXujUmTGZPnNuYvdaCOEczaYnxA0tybhbhgFaVp7CYaYQOoL9g1CR0ZR0zvTMRdKsSXNMe0DlXuTd5a+FkrZ3AsdWZ8Vpb5CL27DOKBjMeRubeflg639egK7wEjl0szrvPnAEO4zMk2Ie+y6p3HYlb9iXaXPOcpMbtrzGRcyLNOFNPAu7vnp4CMXZzyGR8hBKbGcqPa5J/RDq0hm1TyqL2J2J6tBJi2Y09QgyFcQ2FXXZF0oc+rIKT4mPTAoekO5B6uormjqxNxCTTIJfQ2uhf9LBtMUVp1RyBuQNNfuqSdmAuA5fHmCJra1WRKpjtNiWM7wntL1LdaiSHgI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: lairdtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a351dc9-1897-4f34-5e53-08d5e1b3e101
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2018 13:41:43.0819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4d27a54-2db1-4088-a044-1a83c778ad1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB1259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
>=20
> On Tue, Jul 03, 2018 at 06:40:41PM +0200, Andreas F=E4rber wrote:
>=20
> > Do you have an alternative solution for abstraction? A regmap would see=
m
> > to require putting everything into a monolithic SX1301 driver despite
> > those connected chipsets actually being regular, external SPI chips tha=
t
> > could also be attached to non-SX1301 SPI masters.
>=20
> I'm suggesting a regmap for those external SPI chips.  It doesn't matter
> what the host uses.

Currently in my testing drivers I have used regmap for both the SX1301 and =
the downstream SX1257.
In my SX1257 driver currently the regmap is backed via SPI with devm_regmap=
_init_spi, please correct me if I am wrong but if I understand correctly th=
is could be split out to regmap backed by SPI in the case of a direct host =
connection, and a regmap backed by the SX1301's regmapped strobing register=
 interface, regmap_bus?
Is there a precedent to this I can examine?
