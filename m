Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C16ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E5A20869
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PzoA3S7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E5A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeJVKAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 06:00:04 -0400
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:29801
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726633AbeJVKAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 06:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiXayKdxyIvHZw+l0/bBBx8UTunMHurhv6PfxzK6jwM=;
 b=PzoA3S7iSlX6zo3OSGEPi6lZ1iEBP9M/Awsag3f1SRkRYM0CyWZoZ66A8SnKxwJO7rPYs0nZk2/mYPgdnDagqdGL7XRP1erJnDLLlWYsLFDRokjnCHMocbYHjbPlU248BfrKNmxUyQJIhZP34ExoSjtkIvrb0vZywszT3WSMOU8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Mon, 22 Oct 2018 01:43:37 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4%3]) with mapi id 15.20.1250.028; Mon, 22 Oct 2018
 01:43:37 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] thermal: qoriq: add i.mx8mq support
Thread-Topic: [PATCH] thermal: qoriq: add i.mx8mq support
Thread-Index: AQHUQAfSxMPEgrN75UK17vsyUvyBu6TfWj4AgA6yI+CAPMTVkA==
Date:   Mon, 22 Oct 2018 01:43:37 +0000
Message-ID: <DB3PR0402MB39161B63E12A188E4ABC34BEF5F40@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1535595286-18371-1-git-send-email-Anson.Huang@nxp.com>
 <5b8e8a6d.1c69fb81.cdb61.0b30@mx.google.com>
 <DB3PR0402MB3916E21AC0E72E5F1EA0DF4EF51A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916E21AC0E72E5F1EA0DF4EF51A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3707;6:Dy3kym3QsX/zstmIwmdfMAJaewD6OmH69dDWi0SrO6W/oYNpOFXlIhmblrZnCC0a87DtfZGi9tz1gk9RuffvK2KPpXIUN3zNC1KOeiMv2OPGvJWD8+kdWkpKYiR2o+aMC0O71ygIJhYxuovHKDhccvk2hDPmjEPe4iXEFyKlliWzu3JaaZ8srYUKcd5Uzo3NB2fOJw749wu4Ayuby+YXUkqzWScmJ9FTKFJnXLN3sVMnJBssZOPgxdj9WEkQMpeQqskXX86UTdgxAv13YayPvt5q7hG9EYBFGzblWDaKOMD2qzX98pstFWE4xA+7DGxu4EAIvphpteo0MZOtUVQjhVbFkgFGej2DekvXkYezzmRsjdF3k5B3aPPiXDekB/1HabiXPGW1G3ODeCk6TTIuuESnClz+n6/wK6u4FjbXQPy7LkqFFmCocQcGdFo5coZZkWaFBJurDyRzNpHW+nBtaQ==;5:5MVjesRUb1rvFg2vXKgq5/eJvCf2ZpZUrrpnizUD/ZKW5YkZ8kEkLuLltr5O0Lsiw9omKmF+DHVOYhQmFHl6dLBV3UXlDmrQSrGoNTmwzMoPgaI8nZaqAo2lRSO3H7xXw9YKhk4WiFQtUtBKOfuTuu/WVIGfzUieA7UH2MDlRX0=;7:UMqxfn9tBtDaMjy34wUwwJLocRmqIl2iHhkyH1zcNtUkEdZWKDYF/J4X0ptOCCPIA+YQO4+dStdBLK6heXE+L3xMsiBsTd7TF0ycM4tWmS3VxyCTmHxot5gZ3VR900rUAmxi4tnVw4Xsz1glL4EIfnqBH+4wuf9da0ht/ECBj8KFKRyb8iClyxGuhFpFJxRQwHbvmockl0wwjA+72HTG60VWSDY2NQnmskx7vsqr5meZEG88ky2azEPt6V0bL3oN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: eaa54759-0f33-4fcf-a56f-08d637bfc96e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-antispam-prvs: <DB3PR0402MB370751039392DD0A266B8EFCF5F40@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(85827821059158)(180628864354917)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3707;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3707;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(366004)(346002)(136003)(189003)(199004)(13464003)(71190400001)(71200400001)(106356001)(86362001)(39060400002)(2900100001)(53546011)(478600001)(66066001)(256004)(14454004)(4326008)(229853002)(6116002)(6436002)(54906003)(3846002)(33656002)(53936002)(305945005)(6246003)(6916009)(99286004)(186003)(55016002)(74316002)(97736004)(316002)(5250100002)(68736007)(25786009)(2906002)(76176011)(11346002)(102836004)(476003)(6506007)(105586002)(44832011)(446003)(81156014)(7736002)(26005)(81166006)(7696005)(8676002)(8936002)(486006)(9686003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ftxfEVrtsZp1gXLZubQWsR2HIVT/0G3EG4/QZvyZLPoUz44/pc6FBeb5wIsXX5aNYeriXHprFP+Xpj0iuZvHtkO8fOa3qY5sfp24qHfjjH7AseySUJx+b2NkUHfbyaUiNbCEAQ/F5vgGnKndIjVJuW+QFpmjWNOi+gR9A3+jNWW4lWamdxvnrCZ96rczInGL0yno27ZwwjP7OsuYzxOmWvqnSjVkIfRiwnEzibdEgyUqssdEckPthxE6WvQS3sb/i/HZja805/m5B9annmI9hOexTW9sig3bIKzmd1xSTk6Z/9Zd1/gmZGs7yryC/KQmI8+AsEUVziL5VU2CTS92yWugLSzJoyt84UHfvcbtQLo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa54759-0f33-4fcf-a56f-08d637bfc96e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 01:43:37.6163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

Anson Huang
Best Regards!


> -----Original Message-----
> From: Anson Huang
> Sent: Thursday, September 13, 2018 5:44 PM
> To: 'Rob Herring' <robh@kernel.org>
> Cc: rui.zhang@intel.com; edubezval@gmail.com; robh+dt@kernel.org;
> mark.rutland@arm.com; linux-pm@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: RE: [PATCH] thermal: qoriq: add i.mx8mq support
>=20
> Gentle ping...
>=20
> Anson Huang
> Best Regards!
>=20
>=20
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, September 4, 2018 9:18 AM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: rui.zhang@intel.com; edubezval@gmail.com; robh+dt@kernel.org;
> > mark.rutland@arm.com; linux-pm@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH] thermal: qoriq: add i.mx8mq support
> >
> > On Thu, 30 Aug 2018 10:14:46 +0800, Anson Huang wrote:
> > > Add i.mx8mq specific compatible string.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 6 +++-=
--
> > >  drivers/thermal/qoriq_thermal.c                             | 1 +
> > >  2 files changed, 4 insertions(+), 3 deletions(-)
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>

