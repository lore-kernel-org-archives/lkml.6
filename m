Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id a1yCOA9DHlukdgAAmS7hNA
	; Mon, 11 Jun 2018 09:38:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CE204607A4; Mon, 11 Jun 2018 09:38:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zg1REsiu"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E574960351;
	Mon, 11 Jun 2018 09:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E574960351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932691AbeFKJiT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:38:19 -0400
Received: from mail-db5eur01on0068.outbound.protection.outlook.com ([104.47.2.68]:40852
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932109AbeFKJiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcnHlOUY+kL1DKKZu+m5NpbJ4U3zRHCB1vhAeHvTF3o=;
 b=Zg1REsiuH7ifcOo1Q+zto3aTT5jxCr7uqopEh7UCAEp9IXn/Ft+qOK2378HAZIpyAVmtMcdno+iQ7JOA/ajjSGIa2SUQRnbNj2Uxzz16GqzfM2RYegKxnHNW4wwCnMFHOVGW7r1pOFR9bFWe5P4cngK4fYWSh62yJh80Egj0KeE=
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2821.eurprd04.prod.outlook.com (10.172.246.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.13; Mon, 11 Jun 2018 09:38:14 +0000
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::b1ef:4344:2c6d:7ff0]) by DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::b1ef:4344:2c6d:7ff0%6]) with mapi id 15.20.0841.019; Mon, 11 Jun 2018
 09:38:14 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
CC: Frieder Schrempf <frieder.schrempf@exceet.de>,
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
Thread-Index: AQHT+BiB2hXNm2lXyUydyOG4FdlBjqRWHnBAgABANgCABEvZ8IAAFd0AgAAehWA=
Date: Mon, 11 Jun 2018 09:38:14 +0000
Message-ID: <DB6PR0402MB283825171DF93AD3C8590DD799780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180608145130.09f979f9@bbrezillon>
        <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180611094616.5c8f82cf@bbrezillon>
In-Reply-To: <20180611094616.5c8f82cf@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com;
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2821;7:ViLAmnBw/7s8O9/xhaMiFwWlboRw2CBpuhgXy6ua8kOeR+ANsJutKTiGvZlrcVh4sNQsNUstrO5NXeiCXF6DzPwgMNvor3959MJWuDcXdeG0vfnnFHV3wBEVxWyodZQ56HdWzPizeUDJbkV2pIr6igrWwMxGCD6hcH+3J6L3H+YW+md/3zSpkDPdAiThjrpCjLP3KpGeGUd4Qa4VEIsEinvW1jLY1IWeGJUX9K6JRuvnhTLEi04ViCXoJ2JMKqax
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2821;
x-ms-traffictypediagnostic: DB6PR0402MB2821:
x-microsoft-antispam-prvs: <DB6PR0402MB2821E03776893634329565A699780@DB6PR0402MB2821.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(85827821059158)(258649278758335)(84791874153150)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0402MB2821;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2821;
x-forefront-prvs: 070092A9D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(39380400002)(396003)(366004)(376002)(189003)(199004)(13464003)(7736002)(5250100002)(7416002)(6246003)(186003)(102836004)(59450400001)(6506007)(53546011)(2900100001)(86362001)(105586002)(5660300001)(3660700001)(68736007)(14454004)(3280700002)(106356001)(2501003)(2906002)(93886005)(74316002)(305945005)(316002)(54906003)(25786009)(446003)(110136005)(476003)(486006)(99286004)(11346002)(6116002)(3846002)(4326008)(7696005)(76176011)(966005)(33656002)(478600001)(8936002)(45080400002)(9686003)(97736004)(26005)(39060400002)(66066001)(229853002)(6436002)(6306002)(55016002)(53936002)(81156014)(81166006)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2821;H:DB6PR0402MB2838.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ydHh9yIeto7LtBYoZqoT/doONctgkLQb9zl6pDILURlXjUWp0eRAc/faBuSIcFu1l1lrw9VZ6kpkfVDUAip+144pruun6gCgpGIHhgvdIolydUjezdH7jM1yskLeOcx5m4X6gy1BkARfT82uVa/j33QVe2MPvsikVCFi+NB3IGmVu56iiiKZRcDkUg1apS19
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fda6cc85-1bb3-4ccf-e4d3-08d5cf7f0dc4
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda6cc85-1bb3-4ccf-e4d3-08d5cf7f0dc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2018 09:38:14.0816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

-----Original Message-----
From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]=20
Sent: Monday, June 11, 2018 1:16 PM
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; marek.vasut@gmail.com
Cc: Frieder Schrempf <frieder.schrempf@exceet.de>; linux-mtd@lists.infradea=
d.org; linux-spi@vger.kernel.org; dwmw2@infradead.org; computersforpeace@gm=
ail.com; richard@nod.at; miquel.raynal@bootlin.com; broonie@kernel.org; Dav=
id Wolfe <david.wolfe@nxp.com>; Fabio Estevam <fabio.estevam@nxp.com>; Prab=
hakar Kushwaha <prabhakar.kushwaha@nxp.com>; Han Xu <han.xu@nxp.com>; linux=
-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI =
controller

Hi Yogesh,

On Mon, 11 Jun 2018 06:31:00 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

>=20
> >=20
> > Observation 2:
> > I have observed data sanity issue after performing read/write=20
> > operations using MTD interface. Explained below
> >=20
> > root:~# mtd_debug erase /dev/mtd0 0x1000000 0x40000
> > Erased 262144 bytes from address 0x01000000 in flash                   =
   --> Erase at address 0x1000000 of erase size 0x40000
> > root:~# mtd_debug read /dev/mtd0 0x0 0x100 rp
> > Copied 256 bytes from address 0x00000000 in flash to rp                =
   --> Read 0x100 bytes from flash from address 0x0 in file rp
> > root:~# mtd_debug write /dev/mtd0 0x1000000 0x100 rp
> > Copied 256 bytes from rp to address 0x01000000 in flash                =
   --> Write 0x100 bytes to flash address 0x1000000 from file rp
> > root:~# mtd_debug read /dev/mtd0 0x1000000 0x100 wp
> > Copied 256 bytes from address 0x01000000 in flash to wp                =
  --> Read 0x100 bytes from flash from address 0x1000000 in file wp
> > root:~# diff rp wp                                                     =
                                      --> compare both rp and wp files, if =
they are different output comes on console stating file are different
> > Files rp and wp differ
> > root:~# hexdump wp
> > 0000000 aa55 aa55 0000 8010 541c 4000 0040 0000
> > 0000010 0000 0000 0000 0000 0000 0000 0000 000a
> > 0000020 0000 0030 0000 0000 11a0 00a0 2580 0000
> > 0000030 0000 0000 0040 0000 005b 0000 0000 0000
> > 0000040 ffff ffff ffff ffff ffff ffff ffff ffff
> > *
> > 0000100
> > root:~# hexdump rp
> > 0000000 aa55 aa55 0000 8010 541c 4000 0040 0000
> > 0000010 0000 0000 0000 0000 0000 0000 0000 000a
> > 0000020 0000 0030 0000 0000 11a0 00a0 2580 0000
> > 0000030 0000 0000 0040 0000 005b 0000 0000 0000
> > 0000040 2403 0000 0000 0000 0000 0000 0000 0000
> > 0000050 0000 0000 0000 0000 0000 0000 0000 0000
> > *
> > 0000070 0011 0000 09e7 0000 0000 4411 9555 0050
> > 0000080 0000 0000 0000 0000 f9bc afa1 0404 31e0
> > 0000090 0000 0000 0400 31e0 0000 2010 08dc 31eb
> > 00000a0 2880 0050 1300 31eb 4e20 8010 0000 80ff
> > 00000b0 0000 0000 beef dead beef dead beef dead
> > 00000c0 beef dead beef dead beef dead beef dead
> > *
> > 0000100
> > root:~#
> >=20
> > In hexdump output of the file which being read from address 0x1000000,w=
p, it can be observed that only first 64 bytes (0x40) are written on the fl=
ash.
> >=20
> > Observation 3:
> > As we can support JFFS2 filesystem on NOR flash, so we can expect JFFS2=
 commands should work fine on NOR flash.
> > But with this driver change my mount command is not working.
> >=20
> > In my target there are 2 flash slave devices connected, and I have give=
n argument to create MTD partition like "mtdparts=3D20c0000.quadspi-1:5M(rc=
w),10M(test),46M(rootfs) " for 2nd flash.
> > Below is output for /proc/mtd commands
> >     root@ls1012ardb:~# cat /proc/mtd
> >     dev:    size   erasesize  name
> >     mtd0: 04000000 00040000 "20c0000.quadspi-0"   --> First 64MB flash
> >     mtd1: 00500000 00040000 "rcw"                               --> Sec=
ond 64 MB flash device, 3 MTD partition are created for it.
> >     mtd2: 00a00000 00040000 "test"
> >     mtd3: 02e00000 00040000 "rootfs"
> >=20
> >     root@ls1012ardb:~# mkdir /media/ram ; flash_eraseall /dev/mtd3
> >     flash_eraseall has been replaced by `flash_erase <mtddev> 0 0`; ple=
ase use it
> >     Erasing 256 Kibyte @ 0 --  0 % complete [   18.299929] random: crng=
 init done
> >     Erasing 256 Kibyte @ 2dc0000 -- 100 % complete
> >     root@ls1012ardb:~# mount -t jffs2 /dev/mtdblock3 /media/ram/
> >=20
> > This command didn't finish successfully and there are lot of messages c=
oming on console mentioning failure in jffs2_scan_eraseblock()
> >     [  187.118677] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985=
 not found at 0x013c0000: 0x2886 instead
> >     [  187.128159] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985=
 not found at 0x013c0004: 0x7a3b instead
> >     [  187.137641] jffs2: jffs2_scan_eraseblock(): Magic bitmask
> > 0x1985 not found at 0x013c0008: 0xb10f instead
> >=20
> > If I remove this patch series and check with older implementation, JFFS=
2 mounting is working fine. =20
>=20
> Problems 2 and 3 should definitely be fixed. That's weird because I remem=
ber that Frieder tested the new driver with a NOR chip, maybe not with JFFS=
2 though.
>=20
> For write issue, it would be happening due to the changes pushed in spi-m=
em framework.

Now I understand why Frieder didn't face this issue: he was testing on an i=
mx6 which has a 512 bytes TX FIFO, while you're probably testing on a vhybr=
id or layerscape platform which only has a 64 bytes TX FIFO.

I think it's time to accept having partial page writes. This has come up se=
veral times (last time was [1]) and it looks like the fsl quadspi driver wa=
s already doing this sort of things (well hidden in the probe path [2] :-))=
.

Marek, any comment on that?

Regards,

Boris

[1]https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
chwork.ozlabs.org%2Fpatch%2F905507%2F&data=3D02%7C01%7Cyogeshnarayan.gaur%4=
0nxp.com%7C6f2e208553754619956f08d5cf6f71f6%7C686ea1d3bc2b4c6fa92cd99c5c301=
635%7C0%7C0%7C636642999952927107&sdata=3DGrexQ%2FjjJVU282cKr4CuVnYg5NvBL9ZZ=
DFeIcBSBB6k%3D&reserved=3D0
[2]https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Feli=
xir.bootlin.com%2Flinux%2Fv4.17%2Fsource%2Fdrivers%2Fmtd%2Fspi-nor%2Ffsl-qu=
adspi.c%23L1106&data=3D02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C6f2e2085537=
54619956f08d5cf6f71f6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63664299=
9952927107&sdata=3DkIrwvaYA4RrhghhNx6iXsGcEE2j2KY%2BhMJdRRIuu8vo%3D&reserve=
d=3D0

I have send the patch[1] based on shared patch for review, this patch is ba=
sed on the git[2]
With this change, my write is start working for data size requested bigger =
than TX FIFO size but JFFS2 mounting is still failing.

--
Regards
Yogesh Gaur.

[1] https://patchwork.ozlabs.org/patch/927587/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=
=3Dfor-4.18
