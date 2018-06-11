Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lcZiDi8XHlvxAgAAmS7hNA
	; Mon, 11 Jun 2018 06:31:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 20BA360792; Mon, 11 Jun 2018 06:31:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DM/BSd1z"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EB671605A5;
	Mon, 11 Jun 2018 06:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB671605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754034AbeFKGbH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:31:07 -0400
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:16736
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753913AbeFKGbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WEjpeyqsZvbmxQ7JstfXw23aAxuqKQXaLqQwF7eRdE=;
 b=DM/BSd1zcrcHhGO8LRGOkVzTjT5oKUGMSIgMYJX7LLjigyd4mhJ1/zH7sScMT83dLZqwQEHJjQK93iSw4049eP2cKQFJWDSeE0JZ0WD5J68FV7JRTyZqThU0D2RDtaQvdytr4vUDX4gTfssBgDL86DoM/tD8yTRnlKus36COLlk=
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2758.eurprd04.prod.outlook.com (10.172.246.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Mon, 11 Jun 2018 06:31:01 +0000
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::b1ef:4344:2c6d:7ff0]) by DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::b1ef:4344:2c6d:7ff0%6]) with mapi id 15.20.0841.019; Mon, 11 Jun 2018
 06:31:01 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
CC: Frieder Schrempf <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
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
Thread-Index: AQHT+BiB2hXNm2lXyUydyOG4FdlBjqRWHnBAgABANgCABEvZ8A==
Date: Mon, 11 Jun 2018 06:31:00 +0000
Message-ID: <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180608145130.09f979f9@bbrezillon>
In-Reply-To: <20180608145130.09f979f9@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com;
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2758;7:x9Hw1bbkqNVQn+1eXGgp2pWo4mszNKeYA5hlZEZYxboZExt8fN3MExX6rA+1jlNyrRA58B3/UP/TxyMb2aiL0+26NMW7Ys3IjWwIiQ59jFtaJqsnJI1J1R70HN2AREUTrjsMCKUqMYOoDwd+e1segKFP5kSD2LzwE1cofW6Oaob7raM7txGFY4ba+mtGam1UVXoVQogFlwnWzPBAJZt6sHoliUn8TuozxyJ07tCD+Hnbq7/LX5q2lcdg7nDX0oRJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2758;
x-ms-traffictypediagnostic: DB6PR0402MB2758:
x-microsoft-antispam-prvs: <DB6PR0402MB275886E8E4DAA28A16089BDE99780@DB6PR0402MB2758.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335)(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0402MB2758;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2758;
x-forefront-prvs: 070092A9D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(376002)(39380400002)(189003)(199004)(13464003)(8936002)(3280700002)(3660700001)(55016002)(54906003)(9686003)(6306002)(6916009)(99286004)(6436002)(7416002)(6116002)(3846002)(68736007)(5660300001)(66066001)(2906002)(25786009)(39060400002)(6246003)(53936002)(4326008)(229853002)(14454004)(478600001)(93886005)(316002)(8676002)(966005)(2900100001)(97736004)(106356001)(55236004)(81166006)(33656002)(7736002)(11346002)(476003)(486006)(446003)(74316002)(81156014)(105586002)(305945005)(5250100002)(6506007)(53546011)(102836004)(86362001)(59450400001)(186003)(26005)(76176011)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2758;H:DB6PR0402MB2838.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zT1fS0wANPpccCZyWG99Yt7zr34Yqr7mWtkVIo2Qxd0nkgSV3LuyxCuGPB0xtSOc0NyYPtndJ9/dyy+pVEP18WqIx6muQt2vOiUx7kDo8qGb7kRZy1YgcCw27V7pi8LkQTlhl/bUhjnJDk3wLAwbSATq4zMAnGX1+ke7XuRtAZrw0NxySVK35VfEVD5y+JVn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7770eac1-7c3b-4a5d-10f3-08d5cf64e653
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7770eac1-7c3b-4a5d-10f3-08d5cf64e653
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2018 06:31:00.9885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2758
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


-----Original Message-----
From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]=20
Sent: Friday, June 8, 2018 6:22 PM
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc: Frieder Schrempf <frieder.schrempf@exceet.de>; linux-mtd@lists.infradea=
d.org; linux-spi@vger.kernel.org; dwmw2@infradead.org; computersforpeace@gm=
ail.com; marek.vasut@gmail.com; richard@nod.at; miquel.raynal@bootlin.com; =
broonie@kernel.org; David Wolfe <david.wolfe@nxp.com>; Fabio Estevam <fabio=
.estevam@nxp.com>; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; Han Xu =
<han.xu@nxp.com>; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI =
controller

Hi Yogesh,

On Fri, 8 Jun 2018 11:54:12 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Frieder,
>=20
> I have tried to validate your patch on fsl,ls2080a target having 2 Spansi=
on NOR flash, S25FS512S, as slave device.
> Below are my observations:
>=20
> Observation 1:
> In Linux boot logs after driver probing is successful, getting below log =
messages
> [    1.435986] m25p80 spi0.0: found s25fl512s, expected m25p80
> [    1.441564] m25p80 spi0.0: s25fl512s (65536 Kbytes)
> [    1.446972] m25p80 spi0.1: found s25fl512s, expected m25p80
> [    1.452548] m25p80 spi0.1: s25fl512s (65536 Kbytes)
>=20
> IMHO, we need to correct message as 'found s25fl512s, expected m25p80' as=
 final underlying connected flash device is s25fl512s.

Not sure what you mean here. What would you like us to fix exactly?

>=20
> Observation 2:
> I have observed data sanity issue after performing read/write=20
> operations using MTD interface. Explained below
>=20
> root:~# mtd_debug erase /dev/mtd0 0x1000000 0x40000
> Erased 262144 bytes from address 0x01000000 in flash                     =
 --> Erase at address 0x1000000 of erase size 0x40000
> root:~# mtd_debug read /dev/mtd0 0x0 0x100 rp
> Copied 256 bytes from address 0x00000000 in flash to rp                  =
 --> Read 0x100 bytes from flash from address 0x0 in file rp
> root:~# mtd_debug write /dev/mtd0 0x1000000 0x100 rp
> Copied 256 bytes from rp to address 0x01000000 in flash                  =
 --> Write 0x100 bytes to flash address 0x1000000 from file rp
> root:~# mtd_debug read /dev/mtd0 0x1000000 0x100 wp
> Copied 256 bytes from address 0x01000000 in flash to wp                  =
--> Read 0x100 bytes from flash from address 0x1000000 in file wp
> root:~# diff rp wp                                                       =
                                    --> compare both rp and wp files, if th=
ey are different output comes on console stating file are different
> Files rp and wp differ
> root:~# hexdump wp
> 0000000 aa55 aa55 0000 8010 541c 4000 0040 0000
> 0000010 0000 0000 0000 0000 0000 0000 0000 000a
> 0000020 0000 0030 0000 0000 11a0 00a0 2580 0000
> 0000030 0000 0000 0040 0000 005b 0000 0000 0000
> 0000040 ffff ffff ffff ffff ffff ffff ffff ffff
> *
> 0000100
> root:~# hexdump rp
> 0000000 aa55 aa55 0000 8010 541c 4000 0040 0000
> 0000010 0000 0000 0000 0000 0000 0000 0000 000a
> 0000020 0000 0030 0000 0000 11a0 00a0 2580 0000
> 0000030 0000 0000 0040 0000 005b 0000 0000 0000
> 0000040 2403 0000 0000 0000 0000 0000 0000 0000
> 0000050 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0000070 0011 0000 09e7 0000 0000 4411 9555 0050
> 0000080 0000 0000 0000 0000 f9bc afa1 0404 31e0
> 0000090 0000 0000 0400 31e0 0000 2010 08dc 31eb
> 00000a0 2880 0050 1300 31eb 4e20 8010 0000 80ff
> 00000b0 0000 0000 beef dead beef dead beef dead
> 00000c0 beef dead beef dead beef dead beef dead
> *
> 0000100
> root:~#
>=20
> In hexdump output of the file which being read from address 0x1000000,wp,=
 it can be observed that only first 64 bytes (0x40) are written on the flas=
h.
>=20
> Observation 3:
> As we can support JFFS2 filesystem on NOR flash, so we can expect JFFS2 c=
ommands should work fine on NOR flash.
> But with this driver change my mount command is not working.
>=20
> In my target there are 2 flash slave devices connected, and I have given =
argument to create MTD partition like "mtdparts=3D20c0000.quadspi-1:5M(rcw)=
,10M(test),46M(rootfs) " for 2nd flash.
> Below is output for /proc/mtd commands
>     root@ls1012ardb:~# cat /proc/mtd
>     dev:    size   erasesize  name
>     mtd0: 04000000 00040000 "20c0000.quadspi-0"   --> First 64MB flash
>     mtd1: 00500000 00040000 "rcw"                               --> Secon=
d 64 MB flash device, 3 MTD partition are created for it.
>     mtd2: 00a00000 00040000 "test"
>     mtd3: 02e00000 00040000 "rootfs"
>=20
>     root@ls1012ardb:~# mkdir /media/ram ; flash_eraseall /dev/mtd3
>     flash_eraseall has been replaced by `flash_erase <mtddev> 0 0`; pleas=
e use it
>     Erasing 256 Kibyte @ 0 --  0 % complete [   18.299929] random: crng i=
nit done
>     Erasing 256 Kibyte @ 2dc0000 -- 100 % complete
>     root@ls1012ardb:~# mount -t jffs2 /dev/mtdblock3 /media/ram/
>=20
> This command didn't finish successfully and there are lot of messages com=
ing on console mentioning failure in jffs2_scan_eraseblock()
>     [  187.118677] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 n=
ot found at 0x013c0000: 0x2886 instead
>     [  187.128159] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 n=
ot found at 0x013c0004: 0x7a3b instead
>     [  187.137641] jffs2: jffs2_scan_eraseblock(): Magic bitmask=20
> 0x1985 not found at 0x013c0008: 0xb10f instead
>=20
> If I remove this patch series and check with older implementation, JFFS2 =
mounting is working fine.

Problems 2 and 3 should definitely be fixed. That's weird because I remembe=
r that Frieder tested the new driver with a NOR chip, maybe not with JFFS2 =
though.

For write issue, it would be happening due to the changes pushed in spi-mem=
 framework.

I have added my comment in that patch[1].

[1] https://patchwork.ozlabs.org/patch/869629/

>=20
> Observation 4:
> With previous driver, we can read content of flash directly using=20
> devmem command Like devmem 0x20000000  "Flash is connected at this Quad-S=
PI address"
>=20
> But with new driver devmem interface reporting in-correct value.

This one is clearly not something we should fix. What you were doing is uns=
afe (accessing the direct mapping from userspace without making sure you're=
 the only one to access the device), and making it even more broken is IMO =
a better thing. You want to access the memory from user-space, just use the=
 standard MTD interface (/dev/mtdX).

Let me check how devmem interface is working.

--
Regards
Yogesh Gaur

[...]

> +
> +static void fsl_qspi_prepare_lut(struct fsl_qspi *q,
> +				 const struct spi_mem_op *op)
> +{
> +	void __iomem *base =3D q->iobase;
> +	u32 lutval[4] =3D {};
> +	int lutidx =3D 1, i;
> +
> +	lutval[0] |=3D LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
> +			     op->cmd.opcode);
> +
> +	/*
> +	 * For some unknown reason, using LUT_ADDR doesn't work in some
> +	 * cases (at least with only one byte long addresses), so
> +	 * let's use LUT_MODE to write the address bytes one by one
> +	 */
> +	for (i =3D 0; i < op->addr.nbytes; i++) {
> +		u8 addrbyte =3D op->addr.val >> (8 * (op->addr.nbytes - i - 1));
> +
> +		lutval[lutidx / 2] |=3D LUT_DEF(lutidx, LUT_MODE,
> +					      LUT_PAD(op->addr.buswidth),
> +					      addrbyte);
> +		lutidx++;
> +	}
> +
>=20
> For ADDR filling in LUT we should use LUT_ADDR only, needs to find out th=
e reason for the issue and we shouldn't use LUT_MODE here.

Just try with a 16-bit address and you'll see it does not work. I don't kno=
w why, and it's more something you should ask to someone working at NXP ;-)=
.

> I have few more comments regarding same, mentioned below.
>=20
> +	if (op->dummy.nbytes) {
> +		lutval[lutidx / 2] |=3D LUT_DEF(lutidx, LUT_DUMMY,
> +					      LUT_PAD(op->dummy.buswidth),
> +					      op->dummy.nbytes * 8 /
> +					      op->dummy.buswidth);
> +		lutidx++;
> +	}
> +
> +	if (op->data.nbytes) {
> +		lutval[lutidx / 2] |=3D LUT_DEF(lutidx,
> +					      op->data.dir =3D=3D SPI_MEM_DATA_IN ?
> +					      LUT_FSL_READ : LUT_FSL_WRITE,
> +					      LUT_PAD(op->data.buswidth),
> +					      0);
> +		lutidx++;
> +	}
> +
> +	lutval[lutidx / 2] |=3D LUT_DEF(lutidx, LUT_STOP, 0, 0);
> +
> +	/* unlock LUT */
> +	qspi_writel(q, QUADSPI_LUTKEY_VALUE, q->iobase + QUADSPI_LUTKEY);
> +	qspi_writel(q, QUADSPI_LCKER_UNLOCK, q->iobase + QUADSPI_LCKCR);
> +
> +	/* fill LUT */
> +	for (i =3D 0; i < ARRAY_SIZE(lutval); i++)
> +		qspi_writel(q, lutval[i], base + QUADSPI_LUT_REG(i));
> +
> +	/* lock LUT */
> +	qspi_writel(q, QUADSPI_LUTKEY_VALUE, q->iobase + QUADSPI_LUTKEY);
> +	qspi_writel(q, QUADSPI_LCKER_LOCK, q->iobase + QUADSPI_LCKCR); }
> +

[...]

> +static int fsl_qspi_exec_op(struct spi_mem *mem, const struct=20
> +spi_mem_op *op) {
> +	struct fsl_qspi *q =3D spi_controller_get_devdata(mem->spi->master);
> +	void __iomem *base =3D q->iobase;
> +	int err =3D 0;
> +
> +	mutex_lock(&q->lock);
> +
> +	/* wait for the controller being ready */
> +	do {
> +		u32 status;
> +
> +		status =3D qspi_readl(q, base + QUADSPI_SR);
> +		if (status &
> +		    (QUADSPI_SR_IP_ACC_MASK | QUADSPI_SR_AHB_ACC_MASK)) {
> +			udelay(1);
> +			dev_dbg(q->dev, "The controller is busy, 0x%x\n",
> +				status);
> +			continue;
> +		}
> +		break;
> +	} while (1);
> +
> +	fsl_qspi_select_mem(q, mem->spi);
> +
> +	qspi_writel(q, q->memmap_phy, base + QUADSPI_SFAR);
>=20
> SFAR should have the actual address where we are doing operation.

Not with the new approach. SFAR is now automatically reconfigured at each a=
ccess, and it works because we're not using a LUT_ADDR instruction but a LU=
T_MODE one. Sure, I'd prefer to go for the clean solution with a LUT_ADDR a=
nd the address passed through SFAR (+AHB offset), but it does not work with=
 anything that is not 24 bits or
32 bits wide, which means it does not work when you need to access a SPI NA=
ND device (on which some addresses are 16 bits wide).

>=20
> For e.g. If reading from flash-0 offset 0x100000 than SFAR should have ad=
dress as 0x20100000.
> As for 'read/write' request 'from/to' respectively been saved in struct s=
pi_mem_op [op.val] this should be added to q->memmap_phy.

You're still thinking as if the driver was only controlling a NOR device wh=
ich can be directly addressed. This is not the case for NAND devices where =
you first have to load the data in the NAND internal cache and then read da=
ta from the cache.

>=20
> In LUT preparation for ADDR, we should use ADDR_WIDTH as 3-byte or 4-byte=
 addressing only.

Please have a look at SPI NAND datasheets and you'll see it's simply not po=
ssible. So, either NXP doesn't want his QSPI controller to interface with a=
nything except NORs or we have to use the trick we have here (LUT_MODE inst=
ead of LUT_ADDR).

> Start address should be saved in SFAR register.
>=20
> +
> +	qspi_writel(q,
> +		    qspi_readl(q, base + QUADSPI_MCR) |
> +		    QUADSPI_MCR_CLR_RXF_MASK | QUADSPI_MCR_CLR_TXF_MASK,
> +		    base + QUADSPI_MCR);
> +
> +	qspi_writel(q, QUADSPI_SPTRCLR_BFPTRC | QUADSPI_SPTRCLR_IPPTRC,
> +		    base + QUADSPI_SPTRCLR);
> +
> +	fsl_qspi_prepare_lut(q, op);
> +
> +	/*
> +	 * If we have large chunks of data, we read them through the AHB bus
> +	 * by accessing the mapped memory. In all other cases we use
> +	 * IP commands to access the flash.
> +	 */
> +	if (op->data.nbytes > (q->devtype_data->rxfifo - 4) &&
> +	    op->data.dir =3D=3D SPI_MEM_DATA_IN) {
> +		fsl_qspi_read_ahb(q, op);
> +	} else {
> +		qspi_writel(q,
> +			    QUADSPI_RBCT_WMRK_MASK | QUADSPI_RBCT_RXBRD_USEIPS,
> +			    base + QUADSPI_RBCT);
> +
> +		if (op->data.nbytes && op->data.dir =3D=3D SPI_MEM_DATA_OUT)
> +			fsl_qspi_fill_txfifo(q, op);
> +
> +		err =3D fsl_qspi_do_op(q, op);
> +	}
> +
> +	mutex_unlock(&q->lock);
> +
> +	return err;
> +}

[...]

>=20
> Also we should add more debug print messages under dev_dbg() like in func=
 like fsl_qspi_prepare_lut() etc.
>=20

Would you mind giving more details about where you'd like this traces to be=
 placed exactly and what information you'd like to display?

Thanks,

Boris
