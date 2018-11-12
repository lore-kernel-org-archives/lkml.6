Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36413C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF572223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AjJjbSWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF572223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbeKLWgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:36:52 -0500
Received: from mail-eopbgr810074.outbound.protection.outlook.com ([40.107.81.74]:47472
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727319AbeKLWgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrfvSTXsBxStDXt7hD/I9yk/4jc1KIDWwz7ZbUI584g=;
 b=AjJjbSWZvuNh0YfHzClyyG4iEpjUXCjlnhf3/MLlw4Uldy6BakUldF82DTRKdJ2BGgBiZ42RGxjHnsjT6E2N8Pe5kg1+mBsII5pe8pi/BGCOh+rItn9b6MaXsSPhuHBChoU3NijKC+QSbKO+vuGU/CXSknlepq2civnsPiXg4Ns=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2767.namprd02.prod.outlook.com (10.175.49.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Mon, 12 Nov 2018 12:43:41 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::b072:267e:772b:ec2c]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::b072:267e:772b:ec2c%6]) with mapi id 15.20.1294.044; Mon, 12 Nov 2018
 12:43:30 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Lund <martin.lund@keep-it-simple.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHUd+lSRlJXewM/lk6msOyQbhKEh6VL/KgAgAAAuACAAB1I4A==
Date:   Mon, 12 Nov 2018 12:43:30 +0000
Message-ID: <MWHPR02MB2623C672241900608C181CD6AFC10@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <CAB7pii1WbALtH1AHjocpC976ytrCV5gM6JGXawoN--scvEx8Mw@mail.gmail.com>
 <20181112115810.6f931cfb@bbrezillon>
In-Reply-To: <20181112115810.6f931cfb@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2767;6:zf11a3IDMsT/QAXwaDU//6cpbBHZfxHcjeMa6gfpp+xhg7gKF7Jni7Y4u9aF4I3EuCyyLrOoay4ChGgSF2J/SwXatYLWAtsDk9/MK2LXCN5jxd49qURuhUwX7Yr3lDgnzZXOY3YDL8mrEIM239tbMtmd/LAN43tq5kGXSF7dvR0Td0GGplyqVRqFJu3qZkzYP2JGq81Qy2yuPg4XtLFU1CZx/xWoHT9dQSHsmLP53FnzAKZtZgo7PLRMXUihpp7qnaAeKzn8Fg0juJanJgDdYKhMhqL/oj2OBzA8SNYw+HRWGxowOi1XdtkEiB0q4wt7L4Z/eIgBuUFXhDJegAVeaUP3DhHhFHirW11Mt6Q1XfFCyTNA4xDzeEQNy1YJrG0AUQB1sh38a2Cj5GjIEP8QGdZNQJFMpPf2S3v87Z31DmugcRs7KA5phpO7fxcss6D1GN9msXOOpLNuYp6fK+tERg==;5:Gv6vK580lVIeD+VHCAYASphT/MXNmbIecX18AZi7tDnxzV/nR7AwMJHlnJZ72DdHMboPfgeREaODBUI+GADqeO5C2o39vy/N7TEWWuXRB373uHwG2GAGfazJ2/AlVuDunb08+kTNLsGvwLUWywiksL1P73tZrETUAv3Jt5odvlY=;7:doiFU8uRvlmTixdG5ycAJCqdSIw8agXAEZcz3zAQmM6pBy5aHqlFj+xoI7XSndK9Gh86723E4+EID9sbfpThAsP2RairFsfYfPPn22QwDhrgK7Y32G1lpWElHs1bsLweS709vfzP/IH0Ly0tC2VJjw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(366004)(396003)(346002)(13464003)(189003)(199004)(81156014)(14444005)(256004)(217873002)(2906002)(6436002)(106356001)(26005)(81166006)(229853002)(74316002)(76176011)(486006)(11346002)(8936002)(71200400001)(54906003)(71190400001)(68736007)(93886005)(446003)(6246003)(316002)(476003)(39060400002)(8676002)(2900100001)(110136005)(305945005)(86362001)(102836004)(5660300001)(4326008)(97736004)(7416002)(99286004)(25786009)(186003)(478600001)(14454004)(55016002)(3846002)(6506007)(6116002)(7696005)(105586002)(66066001)(53936002)(9686003)(53546011)(7736002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2767;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: ff2da7b8-02a5-49ae-db8a-08d6489c7388
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2767;
x-ms-traffictypediagnostic: MWHPR02MB2767:
x-microsoft-antispam-prvs: <MWHPR02MB276704F0DBF11FD4DDEE2057AFC10@MWHPR02MB2767.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(258649278758335)(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2767;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2767;
x-forefront-prvs: 0854128AF0
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: L//DCZyfpeuHwnkVhFDfZefdAJq0tnT7duLjpEJlGvad0FuZLYx2GK/GFpJVbPrxv1RJREFTBsm1Lptebl0gsqbLtH6bD1cg9jHYUUZoHAgaMWAC8u0sDB5cw5MpPJI0oh9ahpA8kNrSTHeTWbJnk8x74NnfTKOr+DRuICCJU2TKDWVcf1SFAdQMjGRGlPSSejtnCJQUa83poBlJlx02b3RFmVIS0e5uZa2V9NEmC+DgSSSWR+I+wVf+qCTh9fLDOsYKADi5okidZe2tbnPzku+DKXcB8+chwWRE/L/ASATmVv5JgJ7FF+z49tlgZar//empTPyIciDHTRk4ReBfH5sCG/Rx2mnC64PMW2b1Lzk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2da7b8-02a5-49ae-db8a-08d6489c7388
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 12:43:30.7668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris &  Martin,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, November 12, 2018 4:28 PM
> To: Martin Lund <martin.lund@keep-it-simple.com>
> Cc: Naga Sureshkumar Relli <nagasure@xilinx.com>; miquel.raynal@bootlin.c=
om;
> richard@nod.at; dwmw2@infradead.org; computersforpeace@gmail.com;
> marek.vasut@gmail.com; Michal Simek <michals@xilinx.com>; nagasuresh12@gm=
ail.com;
> linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org; robh@kernel.=
org
> Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for =
Arasan NAND
> Flash Controller
>=20
> On Mon, 12 Nov 2018 11:55:36 +0100
> Martin Lund <martin.lund@keep-it-simple.com> wrote:
>=20
> > Hi Naga,
> >
> > Just a few review comments for the v12 version.
> >
> > On Fri, Nov 9, 2018 at 6:00 AM Naga Sureshkumar Relli
> > <naga.sureshkumar.relli@xilinx.com> wrote:
> > > +#define PKT_OFST               0x00
> > > +#define PKT_CNT_SHIFT          12
> > > +
> > > +#define MEM_ADDR1_OFST         0x04
> > > +#define MEM_ADDR2_OFST         0x08
> >
> > For the sake of readability I think *_OFFSET is preferred, especially
> > since the driver already includes short macro names. I think this is
> > similar to the EVNT vs EVENT point.
> > The majority of drivers in the Linux kernel do not shorten OFFSET -> OF=
ST.
> >
> >
> > > +static void anfc_rw_pio_op(struct mtd_info *mtd, u8 *buf, int len,
> > > +                          bool do_read, int prog, int pktcount, int
> > > +pktsize) {
> > > +       struct nand_chip *chip =3D mtd_to_nand(mtd);
> > > +       struct anfc_nand_controller *nfc =3D to_anfc(chip->controller=
);
> > > +       struct anfc_nand_chip *achip =3D to_anfc_nand(chip);
> > > +       u32 *bufptr =3D (u32 *)buf;
> > > +       u32 cnt =3D 0, intr =3D 0;
> > > +
> > > +       anfc_config_dma(nfc, 0);
> > > +
> > > +       if (pktsize =3D=3D 0)
> > > +               pktsize =3D len;
> > > +
> > > +       anfc_setpktszcnt(nfc, pktsize, pktcount);
> > > +
> > > +       if (!achip->strength)
> > > +               intr =3D MBIT_ERROR;
> > > +
> > > +       if (do_read)
> > > +               intr |=3D READ_READY;
> > > +       else
> > > +               intr |=3D WRITE_READY;
> > > +       anfc_enable_intrs(nfc, intr);
> > > +       writel(prog, nfc->base + PROG_OFST);
> > > +       while (cnt < pktcount) {
> > > +               anfc_wait_for_event(nfc);
> > > +               cnt++;
> > > +               if (cnt =3D=3D pktcount)
> > > +                       anfc_enable_intrs(nfc, XFER_COMPLETE);
> > > +               if (do_read)
> > > +                       ioread32_rep(nfc->base + DATA_PORT_OFST, bufp=
tr,
> > > +                                    pktsize / 4);
> > > +               else
> > > +                       iowrite32_rep(nfc->base + DATA_PORT_OFST, buf=
ptr,
> > > +                                     pktsize / 4);
> > > +               bufptr +=3D (pktsize / 4);
> > > +               if (cnt < pktcount)
> > > +                       anfc_enable_intrs(nfc, intr);
> > > +       }
> > > +       anfc_wait_for_event(nfc);
> > > +}
> >
> > Throughout the driver all calls to anfc_wait_for_event() ignores the
> > timeout return value. It would be nice to see some error handling in
> > case it times out - at minimum consider printing out an error message
> > since timeout on NAND operations are fairly critical and should
> > generally not occur. Perhaps even an argument can be made for
> > returning -ETIMEDOUT in case of timeout.
>=20
> Yes please, check anfc_wait_for_event() return code and propagate the err=
or to the upper layer.
Ok, I will update

Thanks,
Naga Sureshkumar Relli
