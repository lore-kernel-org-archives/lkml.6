Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CC4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D49F20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rp60VRRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfAICfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:35:43 -0500
Received: from mail-eopbgr140049.outbound.protection.outlook.com ([40.107.14.49]:64300
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727917AbfAICfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTx/Iuq2iAXOAwlosjqSkkejbNGhWHtG33eXLeOcazE=;
 b=Rp60VRRy48b03z20AER9pgcCNP6wPeg6aQrMbNd3vzMUMJ+OX1QUiR1yDZrTxatPLENDu8NSD6Pr0TuP6pT6l6fgAYaLtvz52CaYka1fpKpSyN+tDbTA5NIfnyf+eHruUQjU75dUzWPHZjNoH9RtsKWFcxRVLju0xsJ67O4zsLA=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2785.eurprd04.prod.outlook.com (10.175.41.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 9 Jan 2019 02:35:39 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 02:35:39 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: RE: [PATCH 3/3] drivers: usb :fsl: Remove USB Errata checking code
Thread-Topic: [PATCH 3/3] drivers: usb :fsl: Remove USB Errata checking code
Thread-Index: AQHUpxgE3SCqMwWaSU2qZS5l4UGPMKWlg+oAgAC1QQA=
Date:   Wed, 9 Jan 2019 02:35:39 +0000
Message-ID: <AM5PR0402MB2865E957248654E18E01ACC7F18B0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190108060426.11581-1-ran.wang_1@nxp.com>
 <20190108060426.11581-3-ran.wang_1@nxp.com>
 <20190108154434.GA20989@kroah.com>
In-Reply-To: <20190108154434.GA20989@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [223.104.3.158]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2785;6:89+sGdd0rrNE7PKUMZ1AfrV2A5cCzFUHD/j5Indp9dxMIk4LAG1h1wjLYKYvi/aznZthtiizMpvbXPGS06FtmnoN8W60dSSMnEupURjtGUx/FYqhE9JqUPOWFV0C/4e3xwJ+8EnLaabP7FbXvVvtQWhjNlzvslw+pv+rkdkQDNpWSw/JYCHiNkyMGLL4BUuv4jMYCFBU4VpnG3USPQeKpM7UxIIK5boiQbwNZKDafi7VT1VYKJuCI6QcnMrRlZJfTRl5gv3iwR/KTrsuwpZ/5GwLP6C8YGK0E2pueJX3zUNWyv8xK/HCT2mICTqSRUMVQhWITiDT/2beDt3fn/FIDgdng2FvI1wwmNpXuGwwrVRKemGys5vVqjG/GrvFkklnJaoYb2RcM+VkVqqDBrSVayQkAYMgbdVFodtZt9J9Gwa7G/8Abtu4p2lubDAhWW3bEDoWGpXDE1vfHcSiZbyrkw==;5:jXSz5NjlyTR6bizKdy1fWnBmJLcyL9kouDS5MYtuyG+AaJ/fg7iJgD9nRA1HFgqUs5GZYH0/R/y/VcYqDInun5xUyU0ytjHOdstcYWOd6Zgqkn1g6UzuJoAaTjFnkAuCNW7Qgyh9TW0QhDTugAhN+zN51l/Th0iH0iQkaYszHiuVPGpeT72fwp0Do4TXKCba4uCUxSVKEQLkhlgyoR3Pig==;7:os4x727kripSX6ZWkhXJCn6g7L4gYDdpAudOyiRx/dxa5sMtA2O/QZeaygNkiQJbNV+cV1Nhh+xnwu8PcJ1Li9TgZDR7F67DsSHqO1zLpXx9n8wrkT+7W1aAdOWQkEmS52deoICROl1FloFPOMTWXQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0ca8cc51-00f6-42e3-0cfe-08d675db24fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2785;
x-ms-traffictypediagnostic: AM5PR0402MB2785:
x-microsoft-antispam-prvs: <AM5PR0402MB27856FFC21728356851EE8DAF18B0@AM5PR0402MB2785.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM5PR0402MB2785;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2785;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(13464003)(25786009)(476003)(486006)(68736007)(229853002)(446003)(106356001)(105586002)(4326008)(11346002)(6246003)(71190400001)(71200400001)(66066001)(305945005)(53936002)(6916009)(54906003)(5660300001)(316002)(97736004)(7696005)(6506007)(53546011)(9686003)(102836004)(76176011)(99286004)(186003)(26005)(8936002)(81156014)(8676002)(81166006)(256004)(74316002)(6116002)(3846002)(14454004)(7736002)(55016002)(33656002)(2906002)(86362001)(478600001)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2785;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ECy3gUsGRUHIZJRus6l7haGr7Ry6skHLl3SJIwMaJrk0wCra3prFGBNzR7gRd5UBigW93KW7Y82m6NpNuqm1EMSUqxnk5/stBnmwMNJqaKXvjf6d8A8XX/033yFPmSIcs48fc+Jzz9JZofj8LjgkUVfSNXTP2ixpDgtJQFJ/r7Nq37uQ1Ab9cdXBOsdLsEJohNP/5Dpc2dI1IJRYtJKDb1OJ7zbhSWWD4VpFC+8ILgZlSpP4kLHYGb7SXF75lrTPbtSdGa8PEy2uf4mlHQohXAC0DNc0GWwqrZ25uYPzdFTiqXYqMOlpBsNsdiujn2bY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca8cc51-00f6-42e3-0cfe-08d675db24fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 02:35:39.7755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, January 08, 2019 23:45
> To: Ran Wang <ran.wang_1@nxp.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>; linux-usb@vger.kernel.org;
> linux-kernel@vger.kernel.org; Yinbo Zhu <yinbo.zhu@nxp.com>
> Subject: Re: [PATCH 3/3] drivers: usb :fsl: Remove USB Errata checking co=
de
>=20
> On Tue, Jan 08, 2019 at 06:04:29AM +0000, Ran Wang wrote:
> > From: yinbo.zhu <yinbo.zhu@nxp.com>
>=20
> I doubt Yinbo's name has a "." in it :)
>=20
> Can you please fix this up to have the correct name here?
>=20
> > Remove USB errata checking code from driver. Applicability of erratum
> > is retrieved by reading corresponding property in device tree.
> > This property is written during device tree fixup.
> >
> > Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> > Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> > Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
>=20
> And here.

Yes, this is a mistake (should be 'Yinbo Zhu'), I'll fix them in next versi=
on, thanks.

Regards,
Ran
