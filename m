Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E324BC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 03:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8592073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 03:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g7RjFN+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8592073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeI2JdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 05:33:05 -0400
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:64780
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727248AbeI2JdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 05:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWbxq3gCGbPYFXDJ5VDfr54amV8g7caBLRP7ofT7RYU=;
 b=g7RjFN+Yks0QYsL3B039KVVFH4AzYiw50W56zJoHc8bsG8ZnW4oL+9++Ki2+jNG4aL+cj5r57JLSfv3dhumri8wpOb4fbnORnf0pQb2tl+HYRmHvDSqLcyDZuLYrtc9Qr//GJx3aQEYFFZck2XFoDnWXZNlQSLgtQzj0LAuCcxM=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.133.18) by
 VI1PR0401MB2334.eurprd04.prod.outlook.com (10.169.133.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Sat, 29 Sep 2018 03:06:19 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::984e:2d7e:1a9c:c1b9]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::984e:2d7e:1a9c:c1b9%7]) with mapi id 15.20.1185.022; Sat, 29 Sep 2018
 03:06:19 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging/
Thread-Topic: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging/
Thread-Index: AQHUVlODYLzUr6TXRkCk3Aso2dGK1KUEHlyAgAEqd6CAADRngIABD/MA
Date:   Sat, 29 Sep 2018 03:06:19 +0000
Message-ID: <VI1PR0401MB22372C3094F743054679C53CF8ED0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20180927111228.46118-1-yangbo.lu@nxp.com>
 <20180927132507.GB23375@lunn.ch>
 <VI1PR0401MB223737CACE4E4064AE8325A4F8EC0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
 <DBXPR04MB3490DB9A1EF2D814568843B94EC0@DBXPR04MB349.eurprd04.prod.outlook.com>
In-Reply-To: <DBXPR04MB3490DB9A1EF2D814568843B94EC0@DBXPR04MB349.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0401MB2334;6:OlSfTgZQmPthDvYkdQDwDKPVfagvfTossz/oqbMvCzjXslA2kIcEKT/qoN0VPE6QPU+2l04nuDid+NNxRfGt1KYe8/RTU06ezkErdfWfSPZo29e1/lwXvK1dKc6A5Qqv6HnFxhrSfYEHJogMnY6h3zHwaoJ2p8eOM+vH7dRlmgURJ5W9ALy8iapoo0EPSNYZNCZkj2GWh/Y9HaSNV29thHRaXJu3xwSxVorpBy6L0muPjPsMRBpyRT3fFQzNkLSFcarWhjnW8US4tlDyGDL9Xhzx9sEFf91erDPJl/EnrtBXbefgdGIiQfTeFj8rFqtnqyblxmsgfggVc4tdkU9yIvEHgbHnzKdtQmUMd2+1MIpgjJlHf6lGHSh8fMSxeEtB9OjKe8JqE559f+XsJhDJi57JFJyNrBUEB4UAmkXsbOhPiVuONQc3ooUHFR/HVxJU+7OgZPJrVtvaOp84CBSG5g==;5:F4u8GscfPKKli1fUiCdOHFGI2MOj6KPAtibB6l7UnSBnRaUu4MMNO9A6zLUDahYUwe55nEczOCXaJ9PKeY/EXB1mOBRjEzcZh3GdFtSiHiS6NKToj1pijpZSWbff6+dAGN2nxHQyC/xo4c8AfKw+Y15rrclw58H2uhYY4/IOIQU=;7:g/7MAe/iS4kn0LzvMiRmeAE9hqeZBdevcNKByrpOVwPCU//CMECrq8WVg78gh72YbTcduhMldwvffLM2WlqUlgR8GAPfPPL8ljyMDwYy0BV3YdCe6L33fc+RYKv3JSsKlxQakkAvkg0IHoTOpNRIX0NKekaMBt3pHNhX9JAdwo6s824LuxYMfb5bnpKeyy+ES4rmQKQs6ACIxCAjiMGHYsxzPDCtXHMlpGh8HbtbnU5Iyi0x1Cur5voN/sw1qHuc
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 731109ae-a199-4570-ff66-08d625b8876f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2334;
x-ms-traffictypediagnostic: VI1PR0401MB2334:
x-microsoft-antispam-prvs: <VI1PR0401MB23343913A98AB61F0229013FF8ED0@VI1PR0401MB2334.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR0401MB2334;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2334;
x-forefront-prvs: 0810818DA0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(13464003)(54906003)(8936002)(76176011)(97736004)(106356001)(33656002)(5660300001)(26005)(8676002)(105586002)(256004)(110136005)(66066001)(7736002)(4326008)(7696005)(305945005)(25786009)(99286004)(5250100002)(74316002)(316002)(39060400002)(2900100001)(6246003)(6436002)(102836004)(68736007)(81166006)(3846002)(6506007)(86362001)(53936002)(486006)(34290500001)(9686003)(81156014)(55016002)(446003)(93886005)(71200400001)(71190400001)(11346002)(229853002)(6116002)(14454004)(476003)(478600001)(53546011)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2334;H:VI1PR0401MB2237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ytLVH1vMUrrcvVLwXtEM7DyZ+SGu7kIc8Ojcl5Wow050ZcXHzP/QbCMK7UCvBDMBgsY6a+MdbAWDA5oVZGNv13qm/MC9pIh1XJ1vhJYS2ta9A7gOz3uOBkbinVMLpjLYybqAOmUH9RUQXmZyi+gJhM2z0r1VVf3GeuQCC7aqcvF8ELks704DqjEkJN7cWiv3jJbWb/5ZLhB7Eb+CoA/wAECKn28ckqL2UmLrrQji7tnDE27AI9N4mDKVcUx/WP+alDxE1/1u4mW59k+UMJvpBurd54unoR+wx6ajL2eQ7MHAOqvo+kkwW4EWwzxHoT/UpxAvVBI/83+qpeT0aGk9KpntYAAfgNlz2Gu6FEWizJo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731109ae-a199-4570-ff66-08d625b8876f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2018 03:06:19.4884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ioana,

> -----Original Message-----
> From: Ioana Ciocoi Radulescu
> Sent: Friday, September 28, 2018 6:21 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>; Andrew Lunn <andrew@lunn.ch>
> Cc: linux-kernel@vger.kernel.org; devel@driverdev.osuosl.org;
> netdev@vger.kernel.org; Richard Cochran <richardcochran@gmail.com>;
> David S . Miller <davem@davemloft.net>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Subject: RE: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging=
/
>=20
> > -----Original Message-----
> > From: Y.b. Lu
> > Sent: Friday, September 28, 2018 11:04 AM
> > To: Andrew Lunn <andrew@lunn.ch>
> > Cc: linux-kernel@vger.kernel.org; devel@driverdev.osuosl.org;
> > netdev@vger.kernel.org; Richard Cochran <richardcochran@gmail.com>;
> > David S . Miller <davem@davemloft.net>; Ioana Ciocoi Radulescu
> > <ruxandra.radulescu@nxp.com>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>
> > Subject: RE: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of
> > staging/
> >
[...]
> > >
> > > It seems like there is a lot of code in dprtc.c which is unused.
> > > rtc.c does
> > nothing
> > > with interrupts for example. Do you plan to make use of this extra
> > > code? Or can it be removed leaving just what is needed?
> >
> > [Y.b. Lu] Currently the ptp/rtc driver is not full-featured. The extra
> > code is being planed to be used.
>=20
> Are there any interrupts associated to the real time clock module that wi=
ll
> actually be used by the driver? Also, I don't think the create/destroy fu=
nctions
> are meant to be used by the PTP kernel driver, even though MC exposes the
> APIs for them.
>=20
> Generally speaking, I think it's better to remove unused code from the cu=
rrent
> driver and re-add it along with the feature actually using it.

[Y.b. Lu] Yes. We need to implement these interrupts to support ptp_clock_e=
vent() of common ptp_clock driver.
This is mainly to support 1588 timer external signals.
I get your point, and will remove unused code before using them.

>=20
> >
> > >
> > > struct dprtc_cmd_get_irq - Putting pad at the beginning of a struct
> > > seems
> > very
> > > odd. And it is not the only example.
> >
> > [Y.b. Lu] This should depended on MC firmware and APIs I think. Once
> > the MC improves this, the APIs could be updated to fix this.
>=20
> These structures map the command format expected by the MC firmware. I
> agree that some of the command layouts are less than inspired, but I'm no=
t
> sure we can expect MC to "improve" them without a good reason, as this
> would break backward compatibility.
>=20
> I also want to bring up the question of where the dpaa2 ptp driver should=
 be
> located. The qoriq_ptp driver (which targets previous gen Freescale/NXP
> architectures) is located in drivers/ptp. I'm not sure if the dpaa2 ptp d=
river
> should be moved there as well or it's better suited for the currently pro=
posed
> location.

[Y.b. Lu] Actually the ptp timer is to provide hw timestamping support for =
ethernet.
Ptp clock driver together with ethernet hw timestamping driver provide the =
method to support 1588 software application.
It's ok to put ptp clock driver near to ethernet driver. And most ptp clock=
 drivers in kernel are together with ethernet driver.
You may see there are gianfar_ptp and dpaa_ptp before. Considering they cou=
ld reuse the code, I created the ptp_qoriq for them to use the one driver.

>=20
> Thanks,
> Ioana
