Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51510C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA9C20815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Dd36opHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfBCRjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 12:39:14 -0500
Received: from mail-eopbgr1320093.outbound.protection.outlook.com ([40.107.132.93]:23527
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726490AbfBCRjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 12:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAq26uO54W4+ps+1DUt/vQjRN+cFTJyBGg5FKUCCBlo=;
 b=Dd36opHD+RLO/TG01gqXvwsscO2Y0RmZe/1x1nVDpqXAOLLcUcQWhQt6p1aC/PXeSbo9roaghk1+GIjKht4EVSQnFAMU6DrC7dXnv1Hc3xwOiRTNNZ6ViRJAZ9rLLA0dnOI3vQbDZYlUauK/7hwaR/9Pz4gt3V8fiygGNh9W8ts=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0153.APCP153.PROD.OUTLOOK.COM (10.170.188.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.3; Sun, 3 Feb 2019 17:39:06 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1622.000; Sun, 3 Feb 2019
 17:39:06 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kbuild test robot <lkp@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM family
Thread-Topic: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM
 family
Thread-Index: AQHUu84f5K6nrmtQjEilkfvm/cd9XaXOVk1w
Date:   Sun, 3 Feb 2019 17:39:05 +0000
Message-ID: <PU1P153MB016955790091DDD469B23E40BF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <154915640488.3541628.4947340559510114602.stgit@dwillia2-desk3.amr.corp.intel.com>
 <201902032230.og6GVIra%fengguang.wu@intel.com>
In-Reply-To: <201902032230.og6GVIra%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-03T17:39:04.6693456Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1b69fd4b-5a9a-41e4-8578-303dc5189808;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [73.53.115.85]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0153;6:3xXGbPkELGgfgXSZvKCAHqoxvF5rp/CmtfAOeBg+40UndfuCuJnvY2jofiiLNpSCD5Z+eQ4e0MhQ0Z9YfaTPFNVbo+b5DTAyChrgiimHwanA2SGysYr3BGELqAechOOC56T9a2vzt7o+Lcx6yglr2rh+06gtLJWoEbVusrS2ivktmZ2wyPbH/xHB7pJr9TczmOfOv3sfI95Gl7IlDg63x37OOIRFyvia0dccWYIwJcQ///0bP9U4JuLHhiMZJvAHo56Z4hdwjar8GlqK6f4ND0Q4W3AOwBEh1TcXBCkofM3gKoPKLXfd+IhLlFuJduI+IcOVIshs0Ye0Qrw9PM0FAz/rSxtw0IksAXg24zob5wOynHMQCCy+wzFvH0nGDrmGThTMAtXbMM9/uPq1NbgqbZMJXMV4rRiigdHRWWvLVLjcW47Xm/K+3ke75FoU9SBswmfJtkqy7BVaXA1ZhR8z3Q==;5:556gPvi5IV+P1wxuznAY2RxgDl4DLCX0YT/DBYW5AmXsp5+LtZt1b4kXt4liloh2HN6AiAzne3944zeJs9iAEOr97tZFfsCXWneRmgy4wb2szYFkYUF9/bUddsgKSss+bnx9WoVyT4EtLK0YsIYU20xtySn+YLUMW722EyOWioRXMr3m7//GNKuhFhRWe05HnSZplCODNGzuJf8KMnyOFA==;7:eFmCryFr3h/Hvu1ZWbsEb18Y0Ox9FZDyQXWM6m0HL7q5VK28kPH6I4bBPVJ5AWkYiqm0VWRFzSPtJRpoS04fX9s6jAkRFTvNO4rc386AfPPuzbN+KzncijJv46pcyYD0dzgHpL+JhzE6YIg0KADPUA==
x-ms-office365-filtering-correlation-id: d05e41ca-a646-44b8-3e48-08d689fe7edd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0153;
x-ms-traffictypediagnostic: PU1P153MB0153:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <PU1P153MB015325D9462F399C26AC58E4BF6C0@PU1P153MB0153.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0937FB07C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(396003)(136003)(376002)(366004)(199004)(189003)(186003)(6346003)(26005)(6506007)(102836004)(53546011)(478600001)(106356001)(66066001)(97736004)(68736007)(11346002)(486006)(446003)(476003)(14454004)(8936002)(81166006)(8676002)(14444005)(256004)(81156014)(966005)(305945005)(7736002)(105586002)(10290500003)(229853002)(76176011)(8990500004)(7696005)(2906002)(99286004)(74316002)(25786009)(6246003)(55016002)(6116002)(3846002)(6436002)(9686003)(4326008)(6306002)(86612001)(22452003)(86362001)(33656002)(110136005)(71200400001)(71190400001)(10090500001)(54906003)(53936002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0153;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0vnCRVkfS6zD7cNJ+upBewsB2gPVsu71naE70JCdfv6zKDbth1hhU3AxYtc7k/b9wQ21ayPmhi/+/jMduLSTyIKmDTD/BNM2m33Ipzj0lODCE0Ypkf/TcnqOeJpPYlDcmYGR/0MjCcuUU3Jf7No9wXSuMMlB/rukHpgne4TESAnBt0pcNBO49bfzPQiu1nQPMUsX6n4n3vLgOdiqejBnIm0KQSi9QL5MC32+U9hyc/QMv3x63gUzBcCvAZeQ5OuVTkHUR/O2pGP9av98HpBIW4AxMmIsVSGSEdeCk5SEGz6VnpLmPSxB8N/QtZeMNLK8VQs3bOWSFoWhgbiGB1csdVyxZerGvj/9Vy69i0Q3Fn7QUmasMXqsvQQDVJIu5YUXGB7QAaYops9lj2foSG1breWhlqKG0BaKu3YzVbv3rvg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05e41ca-a646-44b8-3e48-08d689fe7edd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 17:39:05.8743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: kbuild test robot <lkp@intel.com>
> Sent: Sunday, February 3, 2019 6:32 AM
> To: Dan Williams <dan.j.williams@intel.com>
> Cc: kbuild-all@01.org; linux-nvdimm@lists.01.org; Dexuan Cui
> <decui@microsoft.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM
> family
>=20
> Hi Dan,
>=20
> I love your patch! Yet something to improve:
>=20
> [auto build test ERROR on linux-nvdimm/libnvdimm-for-next]
> [also build test ERROR on v5.0-rc4 next-20190201]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system]
> ...
> All errors (new ones prefixed by >>):
>=20
>    drivers/acpi//nfit/core.c: In function 'acpi_nfit_register_dimms':
> >> drivers/acpi//nfit/core.c:2003:27: error: 'NVDIMM_FAMILY_HYPERV'
> undeclared (first use in this function); did you mean 'NVDIMM_FAMILY_HPE2=
'?
>       if (nfit_mem->family =3D=3D NVDIMM_FAMILY_HYPERV)
>                               ^~~~~~~~~~~~~~~~~~~~
>                               NVDIMM_FAMILY_HPE2
>    drivers/acpi//nfit/core.c:2003:27: note: each undeclared identifier is
> reported only once for each function it appears in

This is a false alarm. The patch is only for
https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/log/?h=3Dli=
bnvdimm-pending
where we have the dependant commid
1194c4133195 ("nfit: Add Hyper-V NVDIMM DSM command set to white list")

Thanks,
-- Dexuan
