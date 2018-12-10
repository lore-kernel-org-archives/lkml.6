Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2585FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC8B2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HTDWcZgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC8B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeLJK77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:59:59 -0500
Received: from mail-eopbgr140074.outbound.protection.outlook.com ([40.107.14.74]:62822
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbeLJK77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQHnOjd0nOLBTCbKKcSzvv9DZWgk2F88kRp5wosEwlY=;
 b=HTDWcZgFXdzXeLwuc1InjKs6rYyedXZ6GjbFPpDU6+bteaKKenyEQfEwQt3QOqAIHmLk5s5Lu57nPZUbbELsz0fthNeggmnXi2tncYaetZybW347zy+rRHh7TV4AW/fDb+YSwHFPD8aQ+5OJBW29TaYzZRVav5UzXxz4Mr4UNI8=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB1373.eurprd04.prod.outlook.com (10.163.166.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Mon, 10 Dec 2018 10:59:54 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 10:59:54 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Topic: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUfZ10PwLsFrd7X0a81BAspcUxiKVxj0sAgAZCwzCAABZKgIAAALyggAAH5ICAAAC6EA==
Date:   Mon, 10 Dec 2018 10:59:54 +0000
Message-ID: <VI1PR04MB5726F0DDAC84F1AEC20B56DF99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1542366701-16065-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <eb8a31d8-2ba6-f27c-addf-545c77921b77@kontron.de>
        <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <20181210111909.35384eee@bbrezillon>
        <VI1PR04MB57268740CA806FFB164780EB99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181210115001.6c7af1d7@bbrezillon>
In-Reply-To: <20181210115001.6c7af1d7@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1373;6:8NlfNcuHsz+PM3gg+wC0Be27SGj4fpLYOOOW7wklBqRvmyPP0lSH4OURzf0XFRtGMEnt6hIwCUCHZ2BcbEDXrYJR0B4e0zXV4AykoTEq1Zr9RXLcqg7sVGt9KAH9rL4D/d8k3uDiVggYDQUPT27o1FIO1DF7iRvGiMyONe+jp2NZmioorLMeezKpDhxbst+z3x4HY95TbblfVAe62dbTkHjRn8+poAMCigsDqIFfgJ2kGk3A1V2O0m60z8/0K93gdLeAQLDMa74gUyDjH1Mx00sIEWe2eN8LySXnoq/U+jmAOK19bUSIHjGPXSdEigR3jWXVues7pIDF3w1DKyvP5k4aLCSBUZK12ZwviKkmbrMfq0NpJcHGJ0OrrjmD0zzqgcO2mZRmfh9pvsU7t+hsyZvhK4QbiObx4zB/2JJxWyft7xcOcSw2owbRSrZsicKa7dECdPPv9N/nt7PO/8b1S7SgpAk1AnzHCzLbHwKyTtY=;5:Qq/9KsHrGDTJwsw0+2ClNcpbHvGEUZB+K3p2af8PBsg3wibFU5lQFYKAQPJoV0o6tPYVCyi0v4EwwMFY/YT7eW6AERhqaMJPo32vR86D/4n4+JtrmUuRbN30Pa4vKG2AIdp2fs3+ERmeUK3UuFFyUj6uwVIOlineqATZfx0NR6U=;7:2Vb1ZPoJAfnPbmhKy9YmAbA1rL7RfmVo0jqbJCc0pozEGZKzLAQtKnBYHLak+CyAYN5/S1kS1Lw9jPz1NUR6q9wdchT5HndLODQKwxNWfwlJyi/DQVSiC8L5dpwhTRBHhE6p9/xz7VYHB67DWOa42g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5914d969-f50d-4822-e0b2-08d65e8e9da1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1373;
x-ms-traffictypediagnostic: VI1PR04MB1373:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-microsoft-antispam-prvs: <VI1PR04MB13730A71CB1447B0DCFDD35699A50@VI1PR04MB1373.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231472)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB1373;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1373;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(13464003)(54906003)(68736007)(86362001)(3846002)(5660300001)(478600001)(305945005)(6116002)(476003)(66066001)(106356001)(105586002)(6436002)(316002)(74316002)(71190400001)(71200400001)(486006)(11346002)(446003)(97736004)(14454004)(6916009)(8676002)(99286004)(55016002)(229853002)(76176011)(8936002)(256004)(55236004)(78486014)(7696005)(14444005)(53546011)(6506007)(53936002)(7416002)(93886005)(33656002)(26005)(6246003)(186003)(25786009)(81156014)(102836004)(81166006)(9686003)(39060400002)(2906002)(4326008)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1373;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zE7AlBXUKFqeffTrvAmNu35bIJYu5XliyMuXiHdyRp/4uFJfQn8Lgc/ybJwrq1cwsuKf/4aawP9QmaxcJM7kksJBBQW4aeUtp4UaxbOFkCsjeyqMow9KiuzxINqDA9HShll0rwSrfWr4ktbHRBWT116kE3XWRidb9DZ5prvOoufGsSrhwLumsSwIZLdszARwgtAw4Uia6sD9JgVxQl6P/j0w9IsmZ7bYvppfbPhFP5KPxsommBEJlop0vytZUkumV3H9FiwXH0Y1JxGGUF92nyJg+1Ii+IY/v2qRW8SSy/icFVRfbSrZ+hpXXY9wx1ls
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5914d969-f50d-4822-e0b2-08d65e8e9da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 10:59:54.1772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, December 10, 2018 4:20 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Schrempf Frieder <frieder.schrempf@kontron.de>; linux-
> mtd@lists.infradead.org; marek.vasut@gmail.com; broonie@kernel.org; linux=
-
> spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI cont=
roller
>=20
> On Mon, 10 Dec 2018 10:43:56 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > > > Thus, in LUT preparation we have assigned only the base address.
> > > > Now if I have assigned ahb_buf_size to FSPI_FLSHXXCR0 register
> > > > then for
> > > read/write data beyond limit of ahb_buf_size offset I get data corrup=
tion.
> > >
> > > Why would you do that? We have the ->adjust_op_size() exactly for
> > > this reason, so, if someone tries to do a spi_mem_op with
> > > data.nbytes > ahb_buf_size you should return an error.
> > >
> > Let me explain my implementation with example. If I have to write data =
of size
> 0x100 bytes at offset 0x1200 for CS1, I would program as below:
> > In func nxp_fspi_select_mem(), would set value of controller address sp=
ace
> size, memmap_phy_size, to FSPI_FLSHA2CR0 and rest all FSPI_FLSHXXCR0 as 0=
.
> > Value of memmap_phy_size is 0x10000000 i.e. 256 MB for my LX2160ARDB
> target.
> > Then in nxp_fspi_prepare_lut(), I would prepare LUT ADDR with address l=
ength
> requirement 3/4 byte for NOR or 1/2/3/4 bytes for NAND flash.
> > Also for LUT_NXP_WRITE would program data bytes as 0.
> >
> > Then inside func nxp_fspi_do_op(), set register FSPI_IPCR0 as the
> > address offset i.e. 0x1200 and in register FSPI_IPCR1 program the data
> > size to write i.e. 0x100
> >
> > If, as suggested if I tries to mark value of register FSPI_FLSHA2CR0 eq=
ual to
> ahb_buf_size (0x800), then access for address 0x1200 gives me wrong data.=
 This
> is because as per the controller specification access to flash connected =
at CS1
> can be performed under range of FSPI_ FLSHA1CR0 and FSPI_ FLSHA2CR0.
>=20
> Don't you have a way to set an offset to apply to the address accessed th=
rough
> the AHB? And if you don't, how will it work if your mapping is smaller th=
an the
> flash size?

Write operations are triggered using IP commands instead of AHB command.
For Read AHB command is used and in this we are adding the offset when perf=
orming memcpy_fromIO operation
      memcpy_fromio(op->data.buf.in, (f->ahb_addr + op->addr.val), len);

AHB/IP operations are independent of the way how CS got selected. CS select=
ion depends, e.g. CS1 on the value of register FSPI_FLSHA1CR0 and FSPI_FLSH=
A2CR0.

Mapping can never going to be smaller than the connected flash size as per =
discussion with the Board design team and if it's possible by user manually=
 changes the non-soldered part then flash area beyond complete mapping is n=
ot accessible.
On LX2160ARDB, with mapping of 256MB, for now we are having 4 flash devices=
 connected with size as 64 MB. If user wants he can have only one single fl=
ash with flash size of 256MB.

--
Regards
Yogesh Gaur
