Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CDEC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6741620851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vhYkeRag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6741620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeLLHiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:38:16 -0500
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:62211
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbeLLHiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ka8VWjs0v+Np8ILoOot+AjOPzH3w7PS6Ozw5AiuZcE=;
 b=vhYkeRagEoN+7vVaXZvqjnLY6g78VcV95Zd07sD2CRow6xA6aSUvhx8qWvBluQ67JNKRpfZqAEO2FAN7ZadNbAuMT8Ddj2uG0klwNj+9eK2ylr5qDztJfb2dhYwaK2WlwWBVhiTE3ZMBuUBd3gRoMWrRf8PLgaVPxRBtSgG5AYs=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB5696.eurprd04.prod.outlook.com (20.178.126.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Wed, 12 Dec 2018 07:38:12 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::811d:1992:9a6a:bb3f]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::811d:1992:9a6a:bb3f%5]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 07:38:12 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Peter Chen <hzpeterchen@gmail.com>,
        "pawell@cadence.com" <pawell@cadence.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "sureshp@cadence.com" <sureshp@cadence.com>,
        "pjez@cadence.com" <pjez@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>
Subject: RE: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHUkIWPYiPxiKamv0Kw/89WiQfMk6V5dPgAgABym4CAAHVkgIAAUW2AgAAFjTA=
Date:   Wed, 12 Dec 2018 07:38:11 +0000
Message-ID: <VI1PR04MB5327B1CB6C6BC7D293701F1D8BA70@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-3-git-send-email-pawell@cadence.com>
 <87h8fkmfar.fsf@linux.intel.com>
 <BYAPR07MB47095110AF28CC11B4C9E144DDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
 <CAL411-ryK2LLZVg5_sLkCYOuhwdHLVm5XavSyC9nbEXZah_43w@mail.gmail.com>
 <877egfmdxk.fsf@linux.intel.com>
In-Reply-To: <877egfmdxk.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5696;6:hXtNbkbmD3P5YfvhZTZ7JrNIq/C2fGxjbhPBJEA6nfjfUP8mQsSeaCRuiI4M0Otsxmf08YfHZVd8pFSBYUa7hEgTxoIywanHaNGeCZ1NK3lUvA8z0xMtEiU7Gtx21a8iibl5JtPbHBe1RhVkMr69CuyeNNaShq6IbxXj13UbKvr9a9fwQEkOwL9nnsSnWgcFRdBqTFdj2PmGOTg/JjR1Yy283rQAVt/HZmun19qKKzEkgoYkgs3HRjaotsjsWFkr3McUEK2LK+YDrz5XJfrJ1HAoyp7XC+eXTikJgsH4TpkOUw9GBSYACNtH10J2zGw2Dg3hTpS2fpSlZ0+JdtOJjmHxw8OPHnX/CBNGnpZjNe5/rRmj0u7DKKYerHEm98SclXQDR/g4mSpa4WlIhN6Hvhz7VCAGoIo15OPKZx2UOxxCb/NDf12ZpOHkBbYNyxX5uA/5h/sDDVrYSuZAZ/M2Yw==;5:sc/4jJeySTrVarH/feu3/pfpkokuimzivhA/JhKyjJwlaa5JWCVxRgJJgGAwppiSl4d88GKlOy0E60z1BOJan71QMG5wNKij32tj4n5BPZf+Ve0ttWT8JJrxUFhZNc8jFTbFlAeYYvcPdR0FcwrAowfTP3dmmTUhOCQbVEkto9s=;7:2Qm6hvKdNgVKpm2+qFBXHwVjSn/FS1R99fh4YS6h4qemzsieBgC0V95mxAcdS6E3BkL8xW5zD+M6DF7fyeb+wCPMNY2jMM510xuHLogW5IiidQb/uYk7lBFFBzHUmAXsJ/rnBmd5K7pExF6x7omeZg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f92038ce-4af7-4096-4d55-08d66004c4ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5696;
x-ms-traffictypediagnostic: VI1PR04MB5696:
x-microsoft-antispam-prvs: <VI1PR04MB56967B97FFCABD9F2110A8808BA70@VI1PR04MB5696.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5696;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5696;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(396003)(39860400002)(189003)(199004)(2906002)(7416002)(76176011)(55016002)(8936002)(6246003)(81166006)(8676002)(53936002)(86362001)(478600001)(186003)(105586002)(81156014)(74316002)(9686003)(71200400001)(305945005)(6436002)(7696005)(229853002)(71190400001)(5660300001)(66066001)(99286004)(14454004)(93886005)(486006)(102836004)(7736002)(68736007)(33656002)(6506007)(256004)(54906003)(11346002)(476003)(44832011)(446003)(14444005)(3846002)(110136005)(25786009)(39060400002)(4326008)(2501003)(106356001)(97736004)(6116002)(316002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5696;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Z3HeMDQHu0JOO5zdx9VOx5jQMiiwHEaFzytHLFIkFrGHN16YsE7UMYSuVZlHIcqg+A6XnzpNlyTlZ/KpWs5aihDcN7XlyRkPCmOCS+XfAQV8/7PCo40M8MOTqWFF4SM7pKWuTXdJEpFc4j9D3wMu/WUxMuFApryisGNHt/P7SaSokn1f2Ir1VB+xLgS4PBEKTdbLqi1dgvzy7f7g/+V5ctLA7p/QMxDnljJqbDgKXVN4WbKuYyKJnvhSsZ0QiqoSG5H+hUd3eiKw+OpIP17rbFoNRwp/aFe6UUzFDyH3NYsYYtbP/bXh+GF0X8NMrCgo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92038ce-4af7-4096-4d55-08d66004c4ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 07:38:11.9264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> >> >> +                                           USB_CMD_STMODE |
> >> >> +
> >> >> + USB_STS_TMODE_SEL(tmode - 1));
> >> >
> >> >I'm 90% sure this won't work. There's a reason why we only enter the
> >> >requested test mode from status stage. How have you tested this?
> >>
> >
> > What's the reason?
> > It can work although the code is a little different with above, I
> > tested it using USBxHSETT tool at Windows.
>=20
> put a sniffer. Status stage won't complete
>=20

Ok, you mean sending test packet during the status completion handler?
I will see whether the status stage can complete next time when doing test.

> >> >> +    irqreturn_t ret =3D IRQ_NONE;
> >> >> +    unsigned long flags;
> >> >> +    u32 reg;
> >> >> +
> >> >> +    priv_dev =3D cdns->gadget_dev;
> >> >> +    spin_lock_irqsave(&priv_dev->lock, flags);
> >> >
> >> >you're already running in hardirq context. Why do you need this lock
> >> >at all? I would be better to use the hardirq handler to mask your
> >> >interrupts, so they don't fire again, then used the top-half
> >> >(softirq) handler to actually handle the interrupts.
> >>
> >
> > This controller may be ran at SMP environment, register and flag
> > access needs to be protected among CPUs running.
>=20
> in hardirq context? When interrupts are already disabled?

Interrupt handler (hardirq context) at CPU0, and process at CPU1, eg role s=
witch, unload module, etc.

Peter
