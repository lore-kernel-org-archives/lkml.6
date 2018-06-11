Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id M5bOMypNHlu2OAAAmS7hNA
	; Mon, 11 Jun 2018 10:21:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BACAF607BB; Mon, 11 Jun 2018 10:21:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vl2Rf77m"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0D5AB60385;
	Mon, 11 Jun 2018 10:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D5AB60385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932805AbeFKKV2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 06:21:28 -0400
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:16782
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932517AbeFKKV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 06:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H55RcGfAlVbxkFg7Zu+xTatLJA18PESHd1XMAMi++m4=;
 b=Vl2Rf77mROpRriq22ySLjZk1pzRui9BuvxLqLd7WHqyS62WjLE8181iRZa9S42285QOBqy9hAKfoQlSlw1IAyKPa8+HnthxpZOeb9WqzIuCJvYv5Kl0ZF3Xsg+1tqGcYDV7COj7fqmY2OkjTk1lRw37D0iQoQs4vxEfs2U/JdYQ=
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2694.eurprd04.prod.outlook.com (10.172.245.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Mon, 11 Jun 2018 10:21:23 +0000
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::b1ef:4344:2c6d:7ff0]) by DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::b1ef:4344:2c6d:7ff0%6]) with mapi id 15.20.0841.019; Mon, 11 Jun 2018
 10:21:23 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
CC: "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHT+BiB2hXNm2lXyUydyOG4FdlBjqRWHnBAgABANgCABEvZ8IAAFd0AgAAehWCAAAtnAIAAAPSw
Date: Mon, 11 Jun 2018 10:21:22 +0000
Message-ID: <DB6PR0402MB28388D9DEB86629BB58DD5E499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180608145130.09f979f9@bbrezillon>
        <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611094616.5c8f82cf@bbrezillon>
        <DB6PR0402MB283825171DF93AD3C8590DD799780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180611121618.40f4b609@bbrezillon>
In-Reply-To: <20180611121618.40f4b609@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com;
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2694;7:gCneQSIMC1rJLyzgFrVoyVZMpv/o5xKy1k+fioTHZ3OfGRJcv7jC9O9YhoF7/OVyJIDNBYkwQ7wQIJ8M6wknXf5d7wpZQjUzAh5xe9sRp3wWFT6cW5PkT3D8+xSqOcrSStl6jO5xrRIPqo7EEWXDiGmcU0Q3tgJaCWXGAfKbbBQlQBi+v5a2U4yz74oG+rpG1NUeJrYDcV9QlJBkBk2AAVKwAaCEt8LDKGnLiz2PIPb50mZKs9vFziwzFb4wrjNy
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2694;
x-ms-traffictypediagnostic: DB6PR0402MB2694:
x-microsoft-antispam-prvs: <DB6PR0402MB26949BDED81B9E1182FD075C99780@DB6PR0402MB2694.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0402MB2694;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2694;
x-forefront-prvs: 070092A9D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(39860400002)(396003)(366004)(13464003)(189003)(199004)(6116002)(3846002)(229853002)(55016002)(6436002)(478600001)(39060400002)(25786009)(2900100001)(33656002)(4326008)(14454004)(106356001)(9686003)(3660700001)(105586002)(66066001)(6246003)(53936002)(7736002)(68736007)(99286004)(305945005)(74316002)(8676002)(6916009)(7696005)(7416002)(11346002)(446003)(5660300001)(54906003)(93886005)(2906002)(81156014)(476003)(486006)(316002)(5250100002)(81166006)(97736004)(8936002)(186003)(102836004)(26005)(59450400001)(3280700002)(6506007)(53546011)(76176011)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2694;H:DB6PR0402MB2838.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Xo+CvvnlVMVzgAY0ZcuZ7TYLg5D8uQwlzOOnT3WLAYbfPuNeTqmjfiMrsfgfgFzgMiJhjVslZuB3c4lhE2mF2kgo2Hyv75e0w4LQR4781jIjLNpRbRAGSGeGB1I0o+Bq3UKfeFl+HwombOLV0UmO3VsKTirgjWVqkp4CRPLHRIl8ux9hgZjxa7dFpFTIX2ro
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 67cd3a1f-6370-4164-9402-08d5cf8514e0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cd3a1f-6370-4164-9402-08d5cf8514e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2018 10:21:22.9574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

-----Original Message-----
From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]=20
Sent: Monday, June 11, 2018 3:46 PM
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc: marek.vasut@gmail.com; Frieder Schrempf <frieder.schrempf@exceet.de>; l=
inux-mtd@lists.infradead.org; linux-spi@vger.kernel.org; dwmw2@infradead.or=
g; computersforpeace@gmail.com; richard@nod.at; miquel.raynal@bootlin.com; =
broonie@kernel.org; David Wolfe <david.wolfe@nxp.com>; Fabio Estevam <fabio=
.estevam@nxp.com>; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; Han Xu =
<han.xu@nxp.com>; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI =
controller

On Mon, 11 Jun 2018 09:38:14 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> > > Observation 3:
> > > As we can support JFFS2 filesystem on NOR flash, so we can expect JFF=
S2 commands should work fine on NOR flash.
> > > But with this driver change my mount command is not working.
> > >=20
> > > In my target there are 2 flash slave devices connected, and I have gi=
ven argument to create MTD partition like "mtdparts=3D20c0000.quadspi-1:5M(=
rcw),10M(test),46M(rootfs) " for 2nd flash.
> > > Below is output for /proc/mtd commands
> > >     root@ls1012ardb:~# cat /proc/mtd
> > >     dev:    size   erasesize  name
> > >     mtd0: 04000000 00040000 "20c0000.quadspi-0"   --> First 64MB flas=
h
> > >     mtd1: 00500000 00040000 "rcw"                               --> S=
econd 64 MB flash device, 3 MTD partition are created for it.
> > >     mtd2: 00a00000 00040000 "test"
> > >     mtd3: 02e00000 00040000 "rootfs"

When I do mtd1 + mtd2 + mtd3, I end up with 0x3d00000 instead of 0x4000000.=
 Is that normal? Do you reserve a bit of space at the end or is it that rcw=
 is not starting at 0?

I have given partition size n bootargs as mtdparts=3D20c0000.quadspi-1:5M(r=
cw),10M(test),46M(rootfs)
5 + 10 + 46 =3D=3D> 61M i.e. 0x3d00000.
I have just reserve the bit at the end, we can modify these settings also.

> > >=20
> > >     root@ls1012ardb:~# mkdir /media/ram ; flash_eraseall /dev/mtd3
> > >     flash_eraseall has been replaced by `flash_erase <mtddev> 0 0`; p=
lease use it
> > >     Erasing 256 Kibyte @ 0 --  0 % complete [   18.299929] random: cr=
ng init done
> > >     Erasing 256 Kibyte @ 2dc0000 -- 100 % complete
> > >     root@ls1012ardb:~# mount -t jffs2 /dev/mtdblock3 /media/ram/
> > >=20
> > > This command didn't finish successfully and there are lot of messages=
 coming on console mentioning failure in jffs2_scan_eraseblock()
> > >     [  187.118677] jffs2: jffs2_scan_eraseblock(): Magic bitmask=20
> > > 0x1985 not found at 0x013c0000: 0x2886 instead

Did you try to create a smaller partition? Maybe we have a problem when acc=
essing addresses higher than X with the new driver (X to be determined).

Would try and update you.

--
Regards
Yogesh Gaur

> > >     [  187.128159] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x19=
85 not found at 0x013c0004: 0x7a3b instead
> > >     [  187.137641] jffs2: jffs2_scan_eraseblock(): Magic bitmask
> > > 0x1985 not found at 0x013c0008: 0xb10f instead
> > >=20
