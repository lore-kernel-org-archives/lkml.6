Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAAAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF92220851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ER2skwTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF92220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbeLDIr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:47:29 -0500
Received: from mail-eopbgr1320135.outbound.protection.outlook.com ([40.107.132.135]:19426
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725613AbeLDIr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+s+R9nxwYtLfOQbcDBHLH7SFkRxwFAF0KN1U+TJFr5g=;
 b=ER2skwTdjh+ZFI6DjpjS4WMlxw3g5L3rmlcI+TrItkcj2Hd9TJGUORYlSDGazV6ejGSkltb58oCvmdfZ1aBnfEkSnqnzMJ00rDg/8O1hR0DVesHsxowWfftz6gVCJhNIybV8fDI60VLC5qPQA+dOLr9YLJfq/HFiRDpCq7JR60Q=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0107.APCP153.PROD.OUTLOOK.COM (10.170.188.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.2; Tue, 4 Dec 2018 08:46:41 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b%8]) with mapi id 15.20.1425.005; Tue, 4 Dec 2018
 08:46:41 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
Thread-Topic: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
Thread-Index: AQHUi4rFN6Z/HleUYkCzgE4vkeOzJKVuMsmAgAAKDWA=
Date:   Tue, 4 Dec 2018 08:46:41 +0000
Message-ID: <PU1P153MB01699DCE042ACB59AADCC8D3BFAF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20181204153513.1e799336@canb.auug.org.au>
 <20181204074241.GB27141@kroah.com>
In-Reply-To: <20181204074241.GB27141@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-12-04T08:46:39.0065344Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2601:600:a27f:df20:5093:849f:84f8:6bf4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0107;6:0uqHJcmakG+Ml0ec+aSZCFuCqdgdKivDNc5ke4FDyrSwcczGRD8hmLeO6fBARYcj/Waf77l0Pf5BoCrhszmGWyXDQ03l4OW81VivYnSNi29vO1YWtH1yKws97o8ZUevzQvLMEvA9RrgJMCHBFtRu/7g4Gf8rypIFCZPKGB9Q2tTDrQ3pEGwI5DYKIpSzWNiAycqpLQjWJ5bwmQNLYOVxRptlXieHQdwXjbVqLXU/Hm/8AgG0zOemZI1IilwW5+WEqF16xbt4ksz/nBy+U1IJyH3GBL8yOt66O1rLrTjt4vbFmGZmkmZ8ObvQA9tEik6YRmesTnddB+ExSSegz6xBoaxh7YE7sUUE6ZQFJ/xycDSW7WPJyVXPxiLO0+GDyylY548Sdl2Nm1f5BnUm84FloMlNI+LFgVWnddAZIvKV/FTnlWa2u/+9l4ecaGcj3yBXiBMRdTzdDixyc06oW/t3hw==;5:CRY3KnlmTgjBxNbgRzR79RlgLcLwilwEHgmsCRizhRK3P3OTosK9XeYS3mhtARLkBZbc6sbVErxAyWUTHULsbef76ef17Gn1kjmEMDJsfio40tK05LG5nNvPtMsO7RPJCVpFEF/VQde+Ramaorm30lb5oOVJ9pctj7wzzIpluM4=;7:RbS59TUd3Y0ADLEap73O1es2MFDBUBuuYFgQ/x0K8S4+yDxYa8yHQBKE38visgCF2/31OR+HMNoWC7Nw9zQPOEksnwjSvzvQmFfi3cAGxR0xzC9VHSd3i0DAIV0F8zwvuYokR6M0nwg26C3ZsMfpOw==
x-ms-office365-filtering-correlation-id: 026b9087-f482-402d-aa06-08d659c5033a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0107;
x-ms-traffictypediagnostic: PU1P153MB0107:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-microsoft-antispam-prvs: <PU1P153MB01077B80838BFF5804C3135BBFAF0@PU1P153MB0107.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(8220035)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(3231455)(999002)(944501505)(2018427008)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0107;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0107;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(396003)(376002)(346002)(53754006)(199004)(189003)(186003)(14454004)(102836004)(46003)(6506007)(81166006)(81156014)(8676002)(55016002)(7736002)(8990500004)(9686003)(74316002)(8936002)(33656002)(2906002)(305945005)(105586002)(53936002)(478600001)(6116002)(10290500003)(106356001)(54906003)(110136005)(97736004)(68736007)(476003)(256004)(14444005)(6246003)(107886003)(71200400001)(71190400001)(486006)(5660300001)(10090500001)(86362001)(575784001)(25786009)(99286004)(11346002)(22452003)(446003)(229853002)(76176011)(7696005)(4326008)(86612001)(6436002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0107;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CXIYx3US7ip4aRZy0whwQjs2+cw44sAsdutGwcUNqKlabvYVbhn3+/KQDIDJ4lmuNgaqV1a5Smr+3JluTNUxDIB9MiCTYtkNTwNSWyG68WnpScbKC/48z7TZkFI5yQfNZfKGnr7yKEoxU8BjiQh642KjBRG9g1WE8YsQgrkHP5qlp36eDBkoNCck9ROFDPvjUaPrvXkw+fxylzxe8PM1r1P6hQ4Fsg9AF29ypc/VcrFaDS0xetXcHe6vNn3BSKIiqWkIrZCba+Ttk0qO+3Y6/aHCXX0hZP0ZQgV5SLnkRqEj/kBQd8LGqfY7vewPv5T8XW8kWBdDL7P/3R+4JjUxwFa3BfZn6XMPhcMUVHpoWvU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026b9087-f482-402d-aa06-08d659c5033a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 08:46:41.3376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg KH <greg@kroah.com>
> Sent: Monday, December 3, 2018 11:43 PM
> On Tue, Dec 04, 2018 at 03:35:13PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the char-misc tree got a conflict in:
> >
> >   drivers/hv/channel_mgmt.c
> >
> > between commit:
> >
> >   37c2578c0c40 ("Drivers: hv: vmbus: Offload the handling of channels t=
o
> two workqueues")
> >
> > from the char-misc.current tree and commit:
> >
> >   4d3c5c69191f ("Drivers: hv: vmbus: Remove the useless API
> vmbus_get_outgoing_channel()")
> >
> > from the char-misc tree.
> >
> > I fixed it up (I used the former version where they conflicted) and can
> > carry the fix as necessary. This is now fixed as far as linux-next is
Hi Stephen,=20
Thank you! I can confirm your rebase for next-20181204 is correct:
37c2578c0c40 ("Drivers: hv: vmbus: Offload the handling of channels to two =
workqueues")

> > concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the conflictin=
g
> > tree to minimise any particularly complex conflicts.
>=20
> Yeah, this is a mess, I'll wait for the hyper-v developers to send me a
> fixup patch for handling this merge issue, as they know it is happening
> :(
>=20
> greg k-h

Since Stephen has fixed the merge issue correctly, I guess I may not need t=
o send a fixup
patch for linux-next.git. If I didn't get it right, please let me know whic=
h tree/branch I
should work on to send a fixup patch.

It looks the conflict here happened because the two related patches, which =
modify
the same functions, went into different branches of char-misc.git. I didn't=
 realize this
could happen... Sorry. The lesson I learnt is that I should not submit an u=
rgent fix
with an unimportant clean-up patch at the same time, when they can cause a =
conflict.

Thanks,
-- Dexuan
