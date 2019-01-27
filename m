Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729A2C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 05:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F30320882
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 05:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FCZf3kH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfA0FoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 00:44:10 -0500
Received: from mail-eopbgr730137.outbound.protection.outlook.com ([40.107.73.137]:35779
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725835AbfA0FoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 00:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ojWqKLVj03WAYMQmAyJiWRojPOz9X3a4Y6B7cs2SfY=;
 b=FCZf3kH74NGzuldymGBVwjF6TOh9gCQf1H1bsWmBX6WFA1Cci8lnhveiObwU61tLvWxK3a2XtIobBEyBGqLcHVs6dXbDLOn671bbuLT8N2vR4MUiJQ0B4vsiPkZ9EnMjwRCmIk7ye2cfzm22994HyoV6MSpzH9H5S/V+CO4HVTo=
Received: from BL0PR2101MB0914.namprd21.prod.outlook.com (52.132.23.151) by
 BL0PR2101MB1090.namprd21.prod.outlook.com (52.132.24.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.4; Sun, 27 Jan 2019 05:44:06 +0000
Received: from BL0PR2101MB0914.namprd21.prod.outlook.com
 ([fe80::1ddd:6847:e2cc:804f]) by BL0PR2101MB0914.namprd21.prod.outlook.com
 ([fe80::1ddd:6847:e2cc:804f%6]) with mapi id 15.20.1580.004; Sun, 27 Jan 2019
 05:44:06 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>
Subject: RE: [PATCH] nfit: add Hyper-V NVDIMM DSM command set to white list
Thread-Topic: [PATCH] nfit: add Hyper-V NVDIMM DSM command set to white list
Thread-Index: AdSzXEwehYqXUZ6BQmeL43zJlZYVRgCpp/LA
Date:   Sun, 27 Jan 2019 05:44:06 +0000
Message-ID: <BL0PR2101MB0914497BA7822B54B9B5A0F3D7950@BL0PR2101MB0914.namprd21.prod.outlook.com>
References: <PU1P153MB0169DF967C5BAAC8334FCC42BF990@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169DF967C5BAAC8334FCC42BF990@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-23T20:51:11.1241746Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=234646a1-2759-4925-a905-7ae51d13057a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;6:ZLfTCXP5pFyBoA+hmBmITvswY/lgYER1uwNxY+J9T4SbRcgaMNM3mKOZK6RnNZDawKq1COMTaNr87O0GegSFdUL36RxxbHLUxJdciTP6X1bZcgh6MrLeMJQgsHhCoEPD8mxg0sDPqfPwSLHxXxsRvOyDJSoyr6ma11g1kFv5zNJU/f1Tz2pqfDtYj7Nt1nCoujWGa+g74z+s+/T9/usm1QUQ6POw12Dj8V8L1H5QcHihu0hJTGaLRw8831DoAbyZJHSFHn/NtTJ+N4NL8JWCS2mGFYfnwmvQvM0rLp+gqoiy6QTSqhUPO24SPtuJarIfrDUzWXOC86PpxiaisrqqZFHjwC8Mm6zCRjcLCdvC2IBEdUDsw9eQTqHW6sDiplA1znOmAR16lbg10OFvdo9qMn9dScfSLN6+uliji72ZBZea51e08AsTeUIzA3F+S2HJR46O8/T/noThb8jjUabsQw==;5:5DOZw5sL3fHOWyCPdqqCP6XBzn+nBs1rV72lJ3kc+9mOHLRKwOhkqcEyC6GF0Kk1W5ZiTySqq2bl3mpKhAf/zAJ/2EBz2IUl/Q7zG1zjcoXKJ2LAs4jrod26LYilaTegSgr+FrdqV/X6XD3zdxVMljyRsBxWO/fO1cuhC5u6tGm5spLzVJwgeFPdqB0wdUtz4xARdxdQWOEKHSAGGR3+CQ==;7:++HNAS7rwMfrir8jaK1NQPx2S7Pi163zxTa8MBMB+dDBWBOu+op0EGVsLX2T4O8tTIAcb7ZONl32UVFIRF8Q9ecewXeUr7ox6V2Ax7KD0kJDomqt889iXgwnvpTjaVttx2z9GovHEQufvNvBH3A6gg==
x-ms-office365-filtering-correlation-id: c154822d-a7bc-4532-01b9-08d6841a7394
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BL0PR2101MB10901481BA58C8FD09BDBD1BD7950@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-forefront-prvs: 0930AAFAD9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(105586002)(106356001)(446003)(11346002)(476003)(486006)(6506007)(1511001)(66066001)(68736007)(26005)(97736004)(102836004)(33656002)(55016002)(6246003)(10290500003)(2906002)(478600001)(4326008)(86612001)(86362001)(25786009)(966005)(229853002)(186003)(316002)(6436002)(6306002)(4744005)(14454004)(9686003)(256004)(10090500001)(305945005)(8936002)(74316002)(7736002)(54906003)(110136005)(71190400001)(7416002)(22452003)(71200400001)(8990500004)(8676002)(81156014)(81166006)(99286004)(7696005)(2201001)(76176011)(217873002)(53936002)(3846002)(6116002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB0914.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /CDDhJCRRmI1JFCa6BhZnbWoHP0Y6EyBAhlMPTLS662ADeqTUnk5wCfo+DDg4mxIUSznavKvPvRbNQwDZMoeg6keJvuUD8k2CA62Vusx0Mwpb4Qg5RP+sprtfM9GstHp7PWIhzm7enOsDjg4KMbcafsc3qyQ6Amo3DMDjBbnMDi/cdYCVPbu1K2y9yadPzPsSdHsAklu+eLSv8ca0rXQMIOJJZ6OVx8LBV1n2L39fExDruoPcOwjJqky1+C+wUxi5oWMJjKuqori+EsSFN7bFpSo10vSEx+I1qDMFiB65VwpK50Fsa2J5Vt7BhZ6WIDxyF+VUtXyU+Aa1P9Io6puR1HIS9CZm+v1dAiVPcJaUQrfNFJpXWGCSBfQ68ujgb0nw890XjdgyBuNCwnIpJszR4pW2G/Un8u1b8UVzx78iVc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c154822d-a7bc-4532-01b9-08d6841a7394
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2019 05:44:06.1150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>  Sent: Wednesday, January 23, 2019 1=
2:51 PM
>=20
> Add the Hyper-V _DSM command set to the white list of NVDIMM command
> sets.
>=20
> This command set is documented at
> http://www.uefi.org/RFIC_LIST (see the link to "Virtual NVDIMM 0x1901" on=
 the page).
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> I'm going to change the user-space utility "ndctl" to support Hyper-V Vir=
tual NVDIMM.
> This kernel patch is required first.
>=20
>  drivers/acpi/nfit/core.c   | 5 ++++-
>  drivers/acpi/nfit/nfit.h   | 6 +++++-
>  include/uapi/linux/ndctl.h | 1 +
>  3 files changed, 10 insertions(+), 2 deletions(-)
>=20

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
