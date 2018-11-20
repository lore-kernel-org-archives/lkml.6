Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB547C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84755206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aSe14d2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84755206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeKUE3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:29:54 -0500
Received: from mail-eopbgr140081.outbound.protection.outlook.com ([40.107.14.81]:11105
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbeKUE3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+pd0Nf/arjVYtDm6bZWpO3vUY0/cv2A30P5A+cFSWY=;
 b=aSe14d2O5GtJo8GyKlHRJlbGdieSz96TzU8zP0+8DjMhqNteaLYnbEMW4HkWMxvSKWWvV2i6/9gY0xPqaBYg+hgeppdxD/sDUVCfmA3Auqd3Ub9y1LOR2a4uaCr3pv4ggtpLQoavJErp+XTrUWmzo68y+GzQ1zY9Y/doAOJTKvU=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3837.eurprd04.prod.outlook.com (52.134.16.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.31; Tue, 20 Nov 2018 17:59:26 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9%7]) with mapi id 15.20.1294.045; Tue, 20 Nov 2018
 17:59:26 +0000
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
Thread-Index: AQHUgOdDaPiLexuoCUeDRyxH1kY+eaVY4AQAgAAPQtA=
Date:   Tue, 20 Nov 2018 17:59:26 +0000
Message-ID: <VI1PR0402MB2800989D7FB9856EA9D2A083E0D90@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1542728371-6972-1-git-send-email-ioana.ciornei@nxp.com>
 <1542728371-6972-3-git-send-email-ioana.ciornei@nxp.com>
 <20181120164850.GC27531@kroah.com>
In-Reply-To: <20181120164850.GC27531@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3837;6:xnycdUZ2wJKhTvZleWx/uPAzeFO2AV0/sGVk6xpNebhZ4DviPNymwPizND5TJPkK85ulxwLyp2W+faq25jDVW2jHaL3vyJVmxm/h9d90bA2D1mOO/nf/bIchdbX4C15YIV/Ibh75bVqJslLgZnHMGJeh8t55GJMQwaV1lA7Ks12pLbonFeDGQ9Xn4lTznJVaO2wO1Ui0i3vJYCY9//kV6JfzFVNrrvlg5ILPu47nFzOxUatSy69cEUL/QlBLe4785pUx5s9AEF2i45UWsUd/YYUEnLXnD7sq/5dz4b3wNHxm4ly0thSQDbr9+OAMWp2+F9nsA6yqrjxGd/r3is53aksOUdp/oMhFGq3eRhs1CplaAviBxYXFvfws1MwNmaqJBQ/RJsYFqUjHy2o7XL7xniA5fOcANCg5XOVLU7mTLOuFuzhcJw/fd0j3PB12BUZ3uC0Ht66V0/BGWQ7aj+Dmqg==;5:EIk+lIRUl9K41WhMIsswSlA5w9bX1R6LyRWh8iKiHcHcuZ7SHw4XGxdlkJvqr039xlBPAJFTqJIPDpoxiMY1ma8yhWDQiDUHHOQuLD83ZNu1SuosA/XWKZ1hUZeEqQF5RAvwvJXoyS4MY+wYef+O6JyAYFK5JrgI26A68qDZjss=;7:c3upOpBD6woDFlRJEoMmTNha3BmoQ0gGFALwMlWQ/RfkvSnQlaVnfgTEA233XVo5aZaUXSwdMeBHV6HWIZF2E2ECp6Lf8xI/396ysiWmWgJsC/r0HYOux/doYyvmOtC08I/suLyRVK0b+pcNgoOQ7w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7fbf8263-3039-440d-e015-08d64f11e934
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3837;
x-ms-traffictypediagnostic: VI1PR0402MB3837:
x-microsoft-antispam-prvs: <VI1PR0402MB3837ED44F81981E31BA372A0E0D90@VI1PR0402MB3837.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3837;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3837;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(366004)(136003)(199004)(189003)(97736004)(316002)(54906003)(3846002)(6116002)(33656002)(25786009)(2900100001)(4326008)(6246003)(229853002)(26005)(6916009)(14444005)(102836004)(256004)(68736007)(2501003)(76176011)(5660300001)(7696005)(6506007)(9686003)(476003)(11346002)(486006)(14454004)(44832011)(1730700003)(8936002)(478600001)(86362001)(8676002)(81156014)(71190400001)(71200400001)(2351001)(81166006)(7736002)(446003)(53936002)(74316002)(305945005)(66066001)(186003)(2906002)(99286004)(106356001)(6436002)(5640700003)(105586002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3837;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zU7bslAhY0xwsdzD3vQNgKP9b/zCyxS9G2etUOplIl+QD16VR5q1/VT7IKPHSUw59fZHa/+pjXFJJwyTg2MhQKsLj4DYyfv3pl3YIDNC7m9DrAO8F9ux4UMzui3vUi6NkS47mFTCWyp02fAOklPB9gPKuhCt5euctSefr33tLUhKR9pqdcu7yxgO650IorDL4Ki6PlaQNXVFrzY8vKr0zkCIpQWq7ku7rVPfInHg9/L88UBegM3dmDCAclbEq5/Bh8fGKsxLm8QKc58DeayXhLmLusFRJcGcxcD8/U3sRtmtIK0NGzWBpyowOyc6vovMPuqJblG2oMHAovVu0akwxpV3A9g+YHnF10KurAcV0MM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbf8263-3039-440d-e015-08d64f11e934
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 17:59:26.3807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static int fsl_mc_uapi_send_command(unsigned long arg,
> > +				    struct fsl_mc_io *mc_io)
> > +{
> > +	struct fsl_mc_command mc_cmd;
> > +	int error;
> > +
> > +	error =3D copy_from_user(&mc_cmd, (void __user *)arg, sizeof(mc_cmd))=
;
> > +	if (error)
> > +		return -EFAULT;
> > +
> > +	error =3D mc_send_command(mc_io, &mc_cmd);
> > +	if (error)
> > +		return error;
> > +
> > +	error =3D copy_to_user((void __user *)arg, &mc_cmd, sizeof(mc_cmd));
> > +	if (error)
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
>=20
> I know you said that "the firmware will properly verify the command"
> already, but given that I used to be a firmware developer a long time ago=
, I can
> almost guarantee that this will cause problems in the future.
>=20
> Want to make a friendly bet about this?
>=20
> What is the odds that your firmware api/interface has been properly fuzze=
d such
> that all possible combinations of bad commands will really not do horribl=
e things
> to the hardware/system?
>=20
> Are you all willing to bet the system intregrity on this?  If so, ok, it'=
s your systems
> :)
>=20
> Personally, I think you need to add a "known whitelist" and do some sort =
of
> sanity checking here.
>=20

I can add a whitelist on the command ids that can be received from userspac=
e but
leave the parameter parsing to the firmware to process and interpret depend=
ing on the
current system settings.

Would that be a viable option from your point of view?

Ioana C

> thanks,
>=20
> greg k-h
