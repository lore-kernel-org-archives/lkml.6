Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7518C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5CD20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gTC/1Rhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5CD20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeLJSwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:52:23 -0500
Received: from mail-eopbgr1310107.outbound.protection.outlook.com ([40.107.131.107]:22016
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbeLJSwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1Z89I6W9NFiGfWV69yzhIZ7myvLqj0xBX4KVqCH8Ic=;
 b=gTC/1RhxcX9Ztf7eeZcpsiirxqVfNEE+fshfAAB6CUTSPbegfsym/N80S6RheQyBVNJ4Q7sllnMfk/xasdjL0rA+PqSwqXdkMXWsdCfdWG58iSa5Or2KdSBG/h+ubcJ5js4Ff/kySvuS6qWhWJh5oZ2HFrqgqkX/giRmoVYwADY=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0153.APCP153.PROD.OUTLOOK.COM (10.170.188.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.1; Mon, 10 Dec 2018 18:51:12 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4%5]) with mapi id 15.20.1446.006; Mon, 10 Dec 2018
 18:51:12 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Greg KH <greg@kroah.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
Thread-Topic: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
Thread-Index: AQHUi4rFN6Z/HleUYkCzgE4vkeOzJKVuMsmAgAAKDWCACYa0gIAAl5Hg
Date:   Mon, 10 Dec 2018 18:51:11 +0000
Message-ID: <PU1P153MB0169B173DA22C412772D4EBABFA50@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20181204153513.1e799336@canb.auug.org.au>
 <20181204074241.GB27141@kroah.com>
 <PU1P153MB01699DCE042ACB59AADCC8D3BFAF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181210094707.GA22095@kroah.com>
In-Reply-To: <20181210094707.GA22095@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-12-10T18:51:09.1452378Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:3:9a50:b37a:cb0e:e4a6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0153;6:3y6taXPRpble7FbhvcWkaH9HCagOEGUUFY8ioifJkUjrzxvEQbEVRhacENOp2/0x5SgyFcjbh5T6tINr/COThc9EGGElYnGUozK+JhaArYQirD3PSsJGWstvx98fOc1KTXXg+0rjupyFiiLXyvbYFsBpCCaURRuWuuk1p4sD/p7H28lb4922bwG3NvfQmS23QAMKd8wDaLm5FVl/wBqqgwe33TSNxCCiQusAVjqjzxEkf7DTRe/9Z74HqhVkv5UjZs+UL0ckzzY4PMYUcxgFJKWZEtHGwTg18n5XRz01p8YfFi0OV/2MO6qbSfy3KP3e6ZtlLq61veqh0kQQzHijhU2nDliPoGt2Q0hZFA2J90n/Y5eBYlrsBjBf7rns+bGopn/KYmOO7meahL6Dk1anCGLvq5l1+Uz2ZQYYasu+FdiC0Ys2FmaclPLXWU3e7DT7QJjXatg2oN05NAloVZ6Kuw==;5:nNvLJ7oBxuvOj2KhwMk3CWTDZwPe+SFk2GlHC/rRXzkQiSaHn7QQrX7M6jOWE6TI7v3A1DD55nHl+rXlBmrDIvidkbOaIGhwpmV6+BdKl+lK/xagpJoPjipHVOjECem0xpDXdMkwrc7X1mR/sJovkJ5j6ll1HLf7hL2i4Zbj1Lo=;7:0OxCzLISsl+eHdhqyl0wrwY4R8gGOTv3kcdTgXIUqJUXd6dpCi394WZeb4/lue9Zpxnu3NmEcYWPaI5W1ppHlbdgkesSn1bIPP7bGTYLgrgj8YO2Hnh/HAdgBb1NobjGxrvq5CwfdBFXM5b8uRbSww==
x-ms-office365-filtering-correlation-id: 7a882b55-3535-46e7-4894-08d65ed0748d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0153;
x-ms-traffictypediagnostic: PU1P153MB0153:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-microsoft-antispam-prvs: <PU1P153MB01530DAA1A35D58117EC230CBFA50@PU1P153MB0153.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(8220035)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231472)(944501520)(2018427008)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0153;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0153;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(39860400002)(396003)(53754006)(199004)(189003)(7696005)(256004)(6506007)(93886005)(53936002)(6916009)(46003)(8676002)(99286004)(14454004)(76176011)(8936002)(14444005)(8990500004)(55016002)(229853002)(9686003)(10290500003)(7736002)(2906002)(4326008)(25786009)(33656002)(81156014)(186003)(6246003)(81166006)(102836004)(107886003)(478600001)(305945005)(6116002)(10090500001)(5660300001)(6436002)(575784001)(86362001)(68736007)(54906003)(22452003)(74316002)(71190400001)(71200400001)(97736004)(486006)(11346002)(446003)(105586002)(476003)(316002)(106356001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0153;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SIVJ5KFwwrzbBJPMqBhj4ZEfCKvHscDD/SNRkqe4jZOkmkhOWvs4qO3m7fPX+9Ek23XemerItLWJcFZqi6SD+fI+sm4tq0OcVh8Umoi8QRCi9/pEsFrNaRWyMCvSSO0O1N8RygydH1pfyGrP/hogF/yhhNOELIh8wl7aMnntfCsFASvl1RJB59FGcS6VDPea0YN+GOoNuVeleMISQQkSQ5AUf35fQfawDAjquskHBN4879oaE1ZmjtnlET+HFxQjR5OsCxSQbzcsffmURP72P1/cb6Kj4Cc24CRfmmja1nVFB4Ry4ef8qxUDlfyqGG8f
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a882b55-3535-46e7-4894-08d65ed0748d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 18:51:11.6295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg KH <greg@kroah.com>
> Sent: Monday, December 10, 2018 1:47 AM
> On Tue, Dec 04, 2018 at 08:46:41AM +0000, Dexuan Cui wrote:
> > > From: Greg KH <greg@kroah.com>
> > > Sent: Monday, December 3, 2018 11:43 PM
> > > On Tue, Dec 04, 2018 at 03:35:13PM +1100, Stephen Rothwell wrote:
> > > > Hi all,
> > > >
> > > > Today's linux-next merge of the char-misc tree got a conflict in:
> > > >
> > > >   drivers/hv/channel_mgmt.c
> > > >
> > > > between commit:
> > > >
> > > >   37c2578c0c40 ("Drivers: hv: vmbus: Offload the handling of channe=
ls
> to
> > > two workqueues")
> > > >
> > > > from the char-misc.current tree and commit:
> > > >
> > > >   4d3c5c69191f ("Drivers: hv: vmbus: Remove the useless API
> > > vmbus_get_outgoing_channel()")
> > > >
> > > > from the char-misc tree.
> > > >
> > > > I fixed it up (I used the former version where they conflicted) and=
 can
> > > > carry the fix as necessary. This is now fixed as far as linux-next =
is
> > Hi Stephen,
> > Thank you! I can confirm your rebase for next-20181204 is correct:
> > 37c2578c0c40 ("Drivers: hv: vmbus: Offload the handling of channels to =
two
> workqueues")
> >
> > > > concerned, but any non trivial conflicts should be mentioned to you=
r
> > > > upstream maintainer when your tree is submitted for merging.  You m=
ay
> > > > also want to consider cooperating with the maintainer of the confli=
cting
> > > > tree to minimise any particularly complex conflicts.
> > >
> > > Yeah, this is a mess, I'll wait for the hyper-v developers to send me=
 a
> > > fixup patch for handling this merge issue, as they know it is happeni=
ng
> > > :(
> > >
> > > greg k-h
> >
> > Since Stephen has fixed the merge issue correctly, I guess I may not ne=
ed to
> send a fixup
> > patch for linux-next.git. If I didn't get it right, please let me know =
which
> tree/branch I
> > should work on to send a fixup patch.
> >
> > It looks the conflict here happened because the two related patches, wh=
ich
> modify
> > the same functions, went into different branches of char-misc.git. I di=
dn't
> realize this
> > could happen... Sorry. The lesson I learnt is that I should not submit =
an urgent
> fix
> > with an unimportant clean-up patch at the same time, when they can caus=
e a
> conflict.
>=20
> I have done the merge in my char-misc-next branch, can you verify that I
> got it correct?
>=20
> greg k-h

I checked the branch and everything is correct. Thanks a lot!

Thanks,
-- Dexuan
