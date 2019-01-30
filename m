Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13724C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E1D20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="llcwP0Xq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbfA3UCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:02:49 -0500
Received: from mail-eopbgr1310094.outbound.protection.outlook.com ([40.107.131.94]:33753
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728446AbfA3UCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjhgeM/MpEA3nMdo3eTx6WlQPozU1pQUhiBgxLi+O5k=;
 b=llcwP0Xq7Da6nrg5HmKYUSX6WtVLUbEQBWJiAJTjudtP/6uk7Lq3MALEy5sKzTtipjp/IwwuwrqdwHg0bJtGwAzY8ZB8eJcDz3nIPcstK0mrhy9CwkGzk86v+Xdu2v084xDmrIeZYJg2QXRLcTCBA4rfB/DAz0ye3+0e2hpsmFE=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0170.APCP153.PROD.OUTLOOK.COM (10.170.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.7; Wed, 30 Jan 2019 20:02:36 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1601.008; Wed, 30 Jan 2019
 20:02:36 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Josh Poulson <jopoulso@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH] nfit: Collect shutdown status for NVDIMM_FAMILY_HYPERV
Thread-Topic: [PATCH] nfit: Collect shutdown status for NVDIMM_FAMILY_HYPERV
Thread-Index: AdS4zD5pzoRrhLrvR3mTKoQx0ZwP5AABwuYAAAB92nA=
Date:   Wed, 30 Jan 2019 20:02:36 +0000
Message-ID: <PU1P153MB01696669DA81578B11734765BF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01691690696D8F83FC1872C7BF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190130193752.GA21181@kroah.com>
In-Reply-To: <20190130193752.GA21181@kroah.com>
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
x-microsoft-exchange-diagnostics: 1;PU1P153MB0170;6:8M7eoRZn3Qv9HUyksDkhKxMGvERq9KXIWeevPus2vGBeAylDuBq7tMNmbG7WcUZwk3ESwCqb/1tst4PbKynt1f3CscbyhwrtHN1b8HDERLYEKBCh+8PV6omkuDx7zHU+WcwWLo1iuYt9+X5wkYxO8JYUM30SbgrGpumYmIbe4BAOBW7K80K1Ri08TJjh0NpYiVFZsQkt8f5d9i3pI1NGcf6ThgFhYACM1XMhV49/DCf8U7VQr1+rNIc6eaTJkdbT3ux08vm6XyIuWhNSWiX53W2i8YruCEHNAV3yNJ87Z+rOhxkWsxjsfkkH4iI/Uj2FkwMQMgA9mHp9+yVszEmBYe+AWI/rlfJHFYQFVQ7RT3q/SghLWFPdmnZ1t1tQTuxU5TpJyOc9rKnq8UNKGl1i2biKtxvBMRirHL6a15Wh7Cn5dgWz7YAk/VpLDMAub2Jv+ETXnWpcZ5nCJnTXFlhkVw==;5:8QV+Q/dskMdgFvR5a530gaczZKVSRIK3dfWkk+PilMNJ6/B1QZ16VTr9oFavpQaMIbU5PLHoLdnpYqrgiRxvUWUprHOg/uBb9U3leK9/vZljUkQz5PLe/3ZkOMelaJMbz9495wzysN4AS+s6WZRvaJuL9wd7ay27k4ZV2gstdFMZA/iduoGnmxhpMk/Jl2y73MYnVHo6hffQ7l9wOR3P0w==;7:iei2KRM5j3OXDJoMuf0S2r//kNw1aFTKokPY1ikuermjlU9vMmVq0C3qVsurPEO8NBV8lie6CGhiVG1sjrHorrzqxE3m/hYDID+p8hxcUcP17j3u3UBL+Suz8WoU4Ymras7HImWCo89/GqnSTk613Q==
x-ms-office365-filtering-correlation-id: 8bd46111-4958-4c4d-5e1c-08d686ede16c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0170;
x-ms-traffictypediagnostic: PU1P153MB0170:
x-ms-exchange-purlcount: -3
x-microsoft-antispam-prvs: <PU1P153MB0170BAA77408A14E7EA04F08BF900@PU1P153MB0170.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(346002)(39860400002)(136003)(199004)(189003)(71190400001)(97736004)(71200400001)(86612001)(316002)(6916009)(4744005)(54906003)(86362001)(33656002)(68736007)(8990500004)(105586002)(10090500001)(106356001)(14454004)(14444005)(76176011)(446003)(7696005)(53936002)(486006)(6506007)(229853002)(7416002)(6436002)(2906002)(99286004)(55016002)(102836004)(186003)(8676002)(107886003)(4326008)(476003)(11346002)(46003)(7736002)(9686003)(6246003)(25786009)(74316002)(8936002)(22452003)(305945005)(81166006)(6116002)(81156014)(256004)(478600001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0170;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CTH9IfORT3Z9eYJmJ1QQ322D2Y+vUBb8YMfe2EF4lHFKF4D+j003SC9jv55pPIuJy9OXiI9HlFtWh60wOFqhUCiQWjbyaGiZUEwi6SReNWO8iwmQESgMK6weJlSgFSwPMildWwQdn7grgLsJ0iQ1tfNHKsAeCLC5jNf0jfJ3AjBfdfi7El2ojUZUSzdBajP8gI5+0cfznBImX6uWmvTseXDvRpyoJ3Pgr+1jzsJglotXcE8xi13rg/NU6AyPOqaDS6cHGQIEDKQ6MWDnSxAtbh+k2eoQylq7rgfpqLVzfFcjRB4ad4WfQ4EDQ7n4OEPbqTUgrIGmVqxloDW/mC/XR1QqEn5E6AnA4D/OXqojmOb4noFGo0HV86erooSazs7yemDwF7hW4VQGMLoxt7fNKCEi5HGU14th/lELuvPef2k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd46111-4958-4c4d-5e1c-08d686ede16c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 20:02:36.1503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, January 30, 2019 11:38 AM
>=20
> On Wed, Jan 30, 2019 at 06:48:40PM +0000, Dexuan Cui wrote:
> >
> > Let's expose the info to the userspace (e.g. ntctl) via sysfs.
>=20
> If you add a new sysfs file, you need to add a new Documentation/ABI/
> update as well :(

It's an existing sysfs node, which was originally added by Dan in Sep 2018:=
=20
/sys/bus/nd/devices/nmem0/nfit/dirty_shutdown.=20

Before this patch, the node doesn't appear when Linux runs on Hyper-V,
and with this patch, the node can appear now.

However, indeed, the node and the other related nodes have not been
documented in Documentation/ABI/testing/sysfs-bus-nfit yet.

I suppose Dan would add that?

Thanks,
-- Dexuan
