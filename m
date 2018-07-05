Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1961DC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A762405C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="DWXqACku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A762405C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbeGEJoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:44:32 -0400
Received: from mail-eopbgr720087.outbound.protection.outlook.com ([40.107.72.87]:8176
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753120AbeGEJoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAwLhfjOme1f7rj+MN+mcRlFKMHMq7UaEBOdl5cTMoA=;
 b=DWXqACkuJYiYSIfCi0jzNxvrOUpTg7TGXwHVl386XzD5jgsG7G+U8j5+m27fV9SxBoG3uE8BY/6N5aXwrRoFfjF6wTJKkgmFlOqmAiTojPVXjXqIxk+GTHOdUM7nPCNcf3OXaxNWSjBk5vaio4GvJS2yuyAFEhKQcB9DhxW5L1w=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4726.namprd07.prod.outlook.com (52.135.205.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Thu, 5 Jul 2018 09:44:28 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8caa:8afb:e029:8035]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8caa:8afb:e029:8035%4]) with mapi id 15.20.0906.027; Thu, 5 Jul 2018
 09:44:27 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>
Subject: RE: [PATCH 09/15] Introduce Cadence USBSSP DRD Driver - added debugfs
 files.
Thread-Topic: [PATCH 09/15] Introduce Cadence USBSSP DRD Driver - added
 debugfs files.
Thread-Index: AQHUEwg4kIeOQDoQwEyMtgZCm3lorKR+yQMAgAF7AaA=
Date:   Thu, 5 Jul 2018 09:44:27 +0000
Message-ID: <BYAPR07MB4709412C63D2D9947F8EEFF4DD400@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
 <1530647879-10007-10-git-send-email-pawell@cadence.com>
 <20180704091524.GB25518@kroah.com>
In-Reply-To: <20180704091524.GB25518@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMDk5MDE0MTktODAzOC0xMWU4LTg3MGYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDA5OTAxNDFhLTgwMzgtMTFlOC04NzBmLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjQ0OSIgdD0iMTMxNzUyNTc0ODEyMTg0NzA4IiBoPSJxYU9sQ0tpaDNPMHJtb0k0NndYdExnYVg2REk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pawell@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4726;7:e6JL4cD03FE+E0yzTWReuwFFFvaXIxaoLu14XFin/kuhJ6yTluAIu8Gnd6cTQ1mTT71gMLiioExv9+DRtzfOPqWwgiLwKMMyBX68LNVnAnSn5As/ffEQ8QXWN+09V0QZH7rrCvAK0LAG03EzO79FFzNjzd9GFgCEOS1zyD6RkGy/87O9uT8wqn6xYqPv6/Auv/ZE2AcvhWqGVUphNpq14icTtXo+8jEzp1lIPM/hfOUX5x/wK7Aw4t6kH2vBugdl;20:hfBYpuJBt11pP7ywc11LM3PCjDp/ZQqnojBaSOcMS5aBkNDlCoGIOmH92/VxLwr/kbTgkQnnl9IcoMMCYQY1CYpAa0Jfys/omPP7ETPo92PvkT4E4LQnmm5tNbXsHAXjlAaa9T3VMfbk9zK0FCeHBR+1KgKLUC5OWu4FCMUasMwH8xE6aIEXb3YqmE3abU5d/C0Bcwg9uChFoNrB4jNGMsa5Sx18FSHM3x4pVHYh5FnZQFjAwW8YGIkyXYZK0LNZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(366004)(54534003)(189003)(199004)(36092001)(446003)(186003)(11346002)(97736004)(105586002)(8936002)(26005)(2906002)(106356001)(486006)(316002)(6506007)(81166006)(6116002)(3846002)(9686003)(25786009)(86362001)(76176011)(7696005)(575784001)(8676002)(81156014)(54906003)(4326008)(55016002)(476003)(99286004)(5660300001)(68736007)(14454004)(66066001)(6246003)(478600001)(6436002)(107886003)(305945005)(229853002)(5250100002)(53936002)(256004)(102836004)(7736002)(2900100001)(33656002)(6916009)(74316002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4726;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 95d626f9-5a6b-4c3b-4bf9-08d5e25be603
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4726;
x-ms-traffictypediagnostic: BYAPR07MB4726:
x-microsoft-antispam-prvs: <BYAPR07MB4726455C3DA7DB529C57922FDD400@BYAPR07MB4726.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4726;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4726;
x-forefront-prvs: 0724FCD4CD
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uNgdmp8Zzd11m3iHXfYQfxhvUnNl1Cq++qZ2c9H+Ac45KGsk0QzwLek26D1E2aRTk2ojdWkdTeXVqON55pZndMPyJSDw27a2hb0/QMtMDeh2FRkBYjHpN2GZyJc6AVwvCwS9H9yZl2zUS2SzXNyucDWs559Oc22sd85bDYrTEUJ+wx1jTe/63EU1LJYXyjp5ob2VJ05NrsA4ve4uLLmXhsMdhrKMeKv4oTPm/9P5DmBZcJG1SqqVQcYpzQdJ6yAtPhzn2+wx6pJCayzAGZMfvPFJNvw86KzCurzt2IlJ5jjpm2YcW5rnWZd1YoLYCGD4RLrLDVy2NIeCjkplpg/sDgqjaG+7e8jLUBoBynhrtvA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d626f9-5a6b-4c3b-4bf9-08d5e25be603
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2018 09:44:27.0699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Signed-off-by: Laszczak Pawel <pawell@cadence.com>
> > ---
>=20
> Again for all of these, you need a changelog text.
>=20
> >  drivers/usb/usbssp/gadget-debugfs.c | 514
> ++++++++++++++++++++++++++++
> >  drivers/usb/usbssp/gadget-debugfs.h | 137 ++++++++
> >  2 files changed, 651 insertions(+)
> >  create mode 100644 drivers/usb/usbssp/gadget-debugfs.c
> >  create mode 100644 drivers/usb/usbssp/gadget-debugfs.h
> >
> > diff --git a/drivers/usb/usbssp/gadget-debugfs.c
> b/drivers/usb/usbssp/gadget-debugfs.c
> > new file mode 100644
> > index 000000000000..c0d1e96728e6
> > --- /dev/null
> > +++ b/drivers/usb/usbssp/gadget-debugfs.c
> > @@ -0,0 +1,514 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * USBSSP device controller driver
> > + *
> > + * Copyright (C) 2018 Cadence.
> > + *
> > + * Author: Pawel Laszczak
> > + * Some code borrowed from the Linux XHCI driver.
>=20
> What code was borrowed?  Please acknowledge that copyright.

USBSSP controller is very similar to XHCI controller and=20
is mostly  compliance with XHCI specification. =20
In result, driver for device mode based on=20
drivers/usb/host/xhci* driver.=20

Especially xhci.c, xhci-ring.c, xhci-mem.c , xhci-debugfs.c
and xhci-trace.h was re-used. By borrowed I means that these=20
files have been taken from xhci driver and have been adopted
in such way that it can be use for the device side.=20
Probably this sentence should looks like:=20
" A  lot of code based on Linux XHCI driver" ?

You know, the most of algorithm for handling transfer and
memory management are the same as for XHCI driver.

Because the USB gadget API in kernel completely different=20
from Host USB API, so files had to been changed very much.=20

What do you think by "Please acknowledge that copyright" ?

"
The standard header for xhci driver looks like:=20
// SPDX-License-Identifier: GPL-2.0
/*
 * xHCI host controller driver PCI Bus Glue.
 *
 * Copyright (C) 2008 Intel Corp.
 *
 * Author: Sarah Sharp
 * Some code borrowed from the Linux EHCI driver.
 */
"
Should I add In my header:
Copyright (C) 2018 Cadence.=20
Copyright (C) 2008 Intel Corp.

or something like this:
....=20
A  lot of code based on Linux XHCI driver
Origin: Copyright (C) 2008 Intel Corp

Thanks very much for all advice and comments.=20
Pawel Laszczak
