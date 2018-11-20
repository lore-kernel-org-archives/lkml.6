Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C923C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351AB20685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VS7pSOvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351AB20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbeKUDVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:21:16 -0500
Received: from mail-eopbgr20047.outbound.protection.outlook.com ([40.107.2.47]:35360
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbeKUDVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FCtPTY9gCSfLnXD62XyhNmA20I24/PL/Qj6IFlM12U=;
 b=VS7pSOvY+DF9H9YfshDQqJRvlQC8qq5Sm1myZuMoqvI15/wtd8/ItuCBn7hJ7JGeW/9GBOGAvvTshRM9d/fWLeDT+qgZaQZXBWb1+V3KhNGRKYn5W+dyo3UUT9XY7g1Yc+6vyl8x6wU/eYBX3rQO/+NlKu10DZw0sujkdbrWypY=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3743.eurprd04.prod.outlook.com (52.134.15.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 20 Nov 2018 16:51:08 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9%7]) with mapi id 15.20.1294.045; Tue, 20 Nov 2018
 16:51:08 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH v3 2/4] bus: fsl-mc: add fsl-mc userspace support
Thread-Topic: [PATCH v3 2/4] bus: fsl-mc: add fsl-mc userspace support
Thread-Index: AQHUgOdDaPiLexuoCUeDRyxH1kY+eaVY3r4AgAAASnA=
Date:   Tue, 20 Nov 2018 16:51:07 +0000
Message-ID: <VI1PR0402MB2800CF10719D11DD21F47356E0D90@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1542728371-6972-1-git-send-email-ioana.ciornei@nxp.com>
 <1542728371-6972-3-git-send-email-ioana.ciornei@nxp.com>
 <20181120164416.GB27531@kroah.com>
In-Reply-To: <20181120164416.GB27531@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3743;6:r3/bghweo/S2khuesDmJZdcI7MRHDvhzPdPoPQsxgnhgiYj0mv1+sdeTjtbwmjZ9Nc0W668mT8QZiWxG6/jFKvmU10BuYUqYzcHNqXaf1Lujz86lfb94+a/W161/3hnjKJ8m8z2Ig6nnipOdGJTsWtmWER6m2axC3DACP3YyuNVT/j9hSyx6oEmu7VbQiZNwIf5ksGXFjIY6OSfPiQymS4nGat8prikRDUIPSXtkiZUUQg7hWc98LGzUO+aZw2h41HFPHF2uItbXj50FWt9QWuMaz8J6XGduw2Fycaqz1XUKnjnuUrYNWmE551+xqZw16OaNXYgrJgP9iwJ7eqe38m865x4+OabvVpnFQ5jodl5syef8zgSB8lPOFhGxQNJ/Wb11BOa0NLkv8cg2U8175MnzZM4VsMv0AW6Y2swRSVJ+db30aQdx1Tea1Fj6peCG5pkhg7XD3wQrGVkoM/tJAw==;5:zFo8b93uZtUFd5/20gbavU4cU/RTjXZUHBY55dFXP/cUwyKalN5f99H9jIP7T0OV8f6nvNyhCTaqtGR9Y4Joh80MrcRMbuzoP86xJsHw7J34/67oA9Sm4q11meRDs9iL7XADuyq7yqpChLPgdcxcqj2vubMl2kGAlrrJwz5ibdw=;7:SyFJefKnMoewh4koDzuo3K4zGflu2Br4wLm46HH/zn4ZIuMWL0S811OUak2aXjrgDx8RYr843nOt4P/XiONONh79+WeBIZf0R2jqJwi3+MypRJilGk5LcHSYJNKbCtgHmxYpn/oebsN4aidg6t1MkQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 90cd518b-364a-4846-5200-08d64f085e52
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3743;
x-ms-traffictypediagnostic: VI1PR0402MB3743:
x-microsoft-antispam-prvs: <VI1PR0402MB37431402800D70044484FCFFE0D90@VI1PR0402MB3743.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3743;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3743;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(366004)(189003)(199004)(31014005)(478600001)(33656002)(105586002)(5660300001)(106356001)(2906002)(6436002)(5640700003)(4326008)(25786009)(6246003)(53936002)(316002)(9686003)(55016002)(54906003)(2501003)(66066001)(14454004)(186003)(76176011)(97736004)(2351001)(305945005)(7736002)(99286004)(6506007)(74316002)(11346002)(3846002)(6116002)(486006)(476003)(2900100001)(7696005)(102836004)(26005)(1730700003)(44832011)(68736007)(8676002)(6916009)(81166006)(446003)(71190400001)(71200400001)(256004)(229853002)(86362001)(8936002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3743;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: U8QSR3JCn1xj2SbUDLywzZDGGaRnKVJp535YCc58FofJpG4jb6/3V4idsFF4K2uTFH2lhdeEeMu6JHYuCsKkydCC+wqixpTgy4I7BFz2D6H/6458/SHGgMT3Fe0W7mmnS/ubsz2CVq5ii8cEYEbrim0u+I/H9XUJFQQlXWvEwdLiJNInXx0/+c7y/fcQGrJ7dP3Q8sUQGDnGjTJXeU7QdB11JpOvrL3m59M0SiqP1A1pK05ryP339X6Gcys3jNR1VC3owW2R6KNPxstX8q6DMSskENGJZcdovSWodn+jRhMxq5Y/+8Pz9bw7BY2m0xv67DWGghQiaZf9FZjlFrqHoEPyXJ/dbwI0KSIMlcY7F+A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cd518b-364a-4846-5200-08d64f085e52
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 16:51:07.8488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3743
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Nov 20, 2018 at 03:39:45PM +0000, Ioana Ciornei wrote:
> > +
> > +			error =3D fsl_mc_uapi_create_device_file(mc_bus);
> > +			if (error < 0) {
> > +				error =3D -EPROBE_DEFER;
> > +				goto error_cleanup_msi_domain;
> > +			}
>=20
> What error could occur here that would be somehow fixed if you defer and =
try
> this all again?  Shouldn't you just return the error given (as something =
really went
> wrong here, it's not a "something else needs to start up first issue), an=
d abort?
>=20

It's really a "something else needs to start up first" type of issue. The f=
sl_mc_uapi_create_device_file fails only if the misc_register fails and thi=
s could really happen when the misc char driver is not yet initialized.

Initially, I have used the register_chrdev API and you suggested to use a m=
isc device and just defer probe if it's not yet initialized.

Ioana C


> thanks,
>=20
> greg k-h
