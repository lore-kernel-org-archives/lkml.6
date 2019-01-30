Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CACAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4CD2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YODIA2HI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733307AbfA3ULG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:11:06 -0500
Received: from mail-eopbgr1300092.outbound.protection.outlook.com ([40.107.130.92]:30741
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728446AbfA3ULF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs376ddiR5+zhci/7Igob9dxePLVyqTZXdtMZ40ZSmM=;
 b=YODIA2HIbWlEMF3layfEw69+Ilc9h58WLNWPJwaw9c6mOWq7DcGr+pykJl/9Y4T5wpDC/7btZKAVwW0NR/kEuJ6Ds4InFtYSJzi213nKg/19mVvRZZlA1kwt2k3MkXVsM9crxYG744egiqfRuo+1La8v8/Kf26WL0/ebQ9VnV24=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0188.APCP153.PROD.OUTLOOK.COM (10.170.190.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.4; Wed, 30 Jan 2019 20:10:50 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1601.008; Wed, 30 Jan 2019
 20:10:50 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     Josh Poulson <jopoulso@microsoft.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Len Brown <lenb@kernel.org>
Subject: RE: [PATCH] nfit: Collect shutdown status for NVDIMM_FAMILY_HYPERV
Thread-Topic: [PATCH] nfit: Collect shutdown status for NVDIMM_FAMILY_HYPERV
Thread-Index: AdS4zD5pzoRrhLrvR3mTKoQx0ZwP5AABwuYAAAB92nAAAJmKgA==
Date:   Wed, 30 Jan 2019 20:10:49 +0000
Message-ID: <PU1P153MB01698684AC3E12B2F3DD09AEBF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01691690696D8F83FC1872C7BF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190130193752.GA21181@kroah.com>
 <PU1P153MB01696669DA81578B11734765BF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB01696669DA81578B11734765BF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-30T20:02:34.4739242Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f8604085-5e6e-4891-82e8-f0a79bbdc5b5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:9:e07a:40bd:14fc:76ab]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0188;6:RaWjEa0enxXUbY8IrSjIo+pH7S9tZVHMJ9iBaIx3gXqMCQ4wg5fRD0Hn1B7Ne0UCWqqtSsdoqI/aWPdH7Zn3qSANqB8l1u94EIWd9MjF7XiPaKUDnkdUUKWQ1XPzO1lOahXip9J6cMdVNcYUk9CXkpieGq3jqyvjLsJ8Xwadvfn3DDqEs0DTPRM/4vt0/hoh8bACl4yU/uy0cynkOvWdLhxxDBaUAqJbngYCJOyOJrb8smJH9h5lWBtljt2/9mXU55XnJdRVzVTjQOwOAgPKxvoB5US2pnpw3Wu30t3pVCDMAKbIfW5pRjwUtkXjFz7OexharPqiGaaV0Y8asakiAzAApgEqh1FvUt7ItboD+Bnzp0+ix2KqGoqAu02RE2cuOSiIxrMh2ufF7K26bCrXWKacyxO9L+WER7z4j9MLjt42ErDM5P/MWqQzPcwF/vGfJpNXIy8kIMNBf8DhX9aPkw==;5:y0E8gRJf//CLs4fBSyugLLnPPVYeCnSpDCs9e8Xe4UzvofG4jo8jtAGWyyMR6JrTQa2eX3gG/iJRQS5hueeQEva+4jyXEBWvsYUyRHG/gk8arXCoQlTM45Vge8tUAvf936PbI4ZrfX8fQqgSh5AstoCNHscEss6zE1yQfbcOHjhfhTImVblKI+rtjXMz8wH62Q2VA8p4ht4sHijX/4GYcA==;7:2tfitNHNxItFUIp5iau9Q6n0aZ42NoGv2u/QrbMFE5s30oCVUvbc01wCshwAaESk1mRhSRcXBLiacN1BNWjZzeSi0HRpGcMwKLTDdcbU6bxhy/fIyEp4psDyKpXI0V48y7ET1v8CyJohiw5nGwUtvw==
x-ms-office365-filtering-correlation-id: 1ae51daa-138b-46d5-3743-08d686ef0797
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600126)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0188;
x-ms-traffictypediagnostic: PU1P153MB0188:
x-ms-exchange-purlcount: -3
x-microsoft-antispam-prvs: <PU1P153MB0188A813A1D37BA970E8B8D3BF900@PU1P153MB0188.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(136003)(189003)(199004)(51914003)(55016002)(9686003)(4326008)(6436002)(446003)(46003)(99286004)(186003)(93156006)(6116002)(86362001)(229853002)(486006)(7696005)(102836004)(11346002)(76176011)(25786009)(86612001)(476003)(6506007)(53546011)(71190400001)(6246003)(110136005)(71200400001)(316002)(2940100002)(22452003)(97736004)(478600001)(54906003)(53936002)(68736007)(106356001)(10090500001)(105586002)(33656002)(8990500004)(256004)(74316002)(81156014)(14454004)(2906002)(10290500003)(8936002)(14444005)(7736002)(8676002)(305945005)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0188;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TDfWh9mdh6l1HZfRT7xrHL6zTJ9IPBJj4yL6jgb6hetB69/06jhPz5JZ63BGpvpHgJKjhHHOEpQtFXX48PtuweOsgozRcaF1soS+tNZWS95B4ii4oOvmMmYwI7nMvTLucL72y5z/VE80RXAoNPyX3w5qHxAUPfZk01p/dHY3IbVZzZd9C9u45vbIODeB9QNvnFZ65d6f+uD9knT/cf8sjxA/dS9pM16fH0F11dnCelkYei3E+fc7XDHaWESe7p5ONytviyUfaca5zfSrhsyWIK+msWQpwo2b8fYGXldbWjzmX9y+iYMwzYu6RyICcsxYhOUzvpNRazeF8744gY4BWpt8QRyQyxWbJjC9HiD87YnyghKAEb21uBt0FRpY4JvDR5sw2UyN/bJY2RlMPH4uKpPax8E8EBhSAqcf5KnjF/w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae51daa-138b-46d5-3743-08d686ef0797
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 20:10:49.7063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Linux-nvdimm <linux-nvdimm-bounces@lists.01.org> On Behalf Of
> Dexuan Cui
> Sent: Wednesday, January 30, 2019 12:03 PM
> To: Greg KH <gregkh@linuxfoundation.org>
> Cc: Josh Poulson <jopoulso@microsoft.com>; linux-nvdimm@lists.01.org;
> Haiyang Zhang <haiyangz@microsoft.com>;
> driverdev-devel@linuxdriverproject.org; Rafael J. Wysocki
> <rjw@rjwysocki.net>; linux-kernel@vger.kernel.org; Michael Kelley
> <mikelley@microsoft.com>; Sasha Levin <Alexander.Levin@microsoft.com>;
> linux-acpi@vger.kernel.org; Ross Zwisler <zwisler@kernel.org>; Stephen
> Hemminger <sthemmin@microsoft.com>; Len Brown <lenb@kernel.org>
> Subject: RE: [PATCH] nfit: Collect shutdown status for
> NVDIMM_FAMILY_HYPERV
>=20
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Wednesday, January 30, 2019 11:38 AM
> >
> > On Wed, Jan 30, 2019 at 06:48:40PM +0000, Dexuan Cui wrote:
> > >
> > > Let's expose the info to the userspace (e.g. ntctl) via sysfs.
> >
> > If you add a new sysfs file, you need to add a new Documentation/ABI/
> > update as well :(
>=20
> It's an existing sysfs node, which was originally added by Dan in Sep 201=
8:
> /sys/bus/nd/devices/nmem0/nfit/dirty_shutdown.
>=20
> Before this patch, the node doesn't appear when Linux runs on Hyper-V,
> and with this patch, the node can appear now.
>=20
> However, indeed, the node and the other related nodes have not been
> documented in Documentation/ABI/testing/sysfs-bus-nfit yet.
> I suppose Dan would add that?
Actually the other nodes have been documented, and only the
"dirty_shutdown" is missed.=20

It should be straightfoward. Let me make a patch for this.

Thanks for the reminder, Greg!
=20
Thanks,
-- Dexuan
