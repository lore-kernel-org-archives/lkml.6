Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 022E3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899B22086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SScSdaEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899B22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932996AbeFLGms (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 02:42:48 -0400
Received: from mail-ve1eur01on0060.outbound.protection.outlook.com ([104.47.1.60]:32736
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932637AbeFLGmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 02:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLARyIhZAuXY1xumeRCHP2vvuwBAiFKMGf7mMoSinFI=;
 b=SScSdaEbo4h4h4L78Gq7CO4afD2FUnuqKRqg9msOGoYwZTYAlCMeZx4X5WS0MJzPzH4wSP2Bqg9oxc8cH1D0cxqGTg3uAyt+fKRXLh1eZZuxFN11jtys1SjXiFZ1bxzmmaPmf2PtYXDPQ5pxKhObcOLncAEd8XIDB/cNzLyqcqA=
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2888.eurprd04.prod.outlook.com (10.172.248.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Tue, 12 Jun 2018 06:42:43 +0000
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::49a5:1040:801d:2b97]) by DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::49a5:1040:801d:2b97%2]) with mapi id 15.20.0863.010; Tue, 12 Jun 2018
 06:42:43 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "richard@nod.at" <richard@nod.at>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Wolfe <david.wolfe@nxp.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: RE: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHT+BiB2hXNm2lXyUydyOG4FdlBjqRWHnBAgABANgCABEvZ8IAAFd0AgAAehWCAAAtnAIAAAPSwgAFUQ+A=
Date:   Tue, 12 Jun 2018 06:42:42 +0000
Message-ID: <DB6PR0402MB2838563F1BA71A9A21ABBE01997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
 <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180608145130.09f979f9@bbrezillon>
 <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180611094616.5c8f82cf@bbrezillon>
 <DB6PR0402MB283825171DF93AD3C8590DD799780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180611121618.40f4b609@bbrezillon>
 <DB6PR0402MB28388D9DEB86629BB58DD5E499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB28388D9DEB86629BB58DD5E499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2888;7:EpSMNbWlEyTU4CyfP6VwjkwMsjjwrqpOz01MtYVtHA10ZF0peDx/NPkcaETLWrl4C/dydl4HCUyp+8vfn7yXCXAgoIXEons0DUH1arSD2h5OEHWTh6BeB0Xg4WIM99vQCpusM7y+1+R2heNnmdW8NBrmWtCsZyksUyXgKupv31nSG8iFNkb49vRgXHkcPfeD99vdgPFS1XysIGwSuwQpe6giyQAhzpQLmLn7EU9azb+Dz90dPzAWyKa5DCQT9NRT
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2888;
x-ms-traffictypediagnostic: DB6PR0402MB2888:
x-microsoft-antispam-prvs: <DB6PR0402MB2888D6831B8524AADC72B340997F0@DB6PR0402MB2888.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(85827821059158)(258649278758335)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0402MB2888;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2888;
x-forefront-prvs: 07013D7479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(13464003)(189003)(199004)(26005)(106356001)(476003)(81166006)(81156014)(7416002)(25786009)(486006)(93886005)(53546011)(446003)(59450400001)(575784001)(86362001)(6506007)(76176011)(305945005)(102836004)(6306002)(6246003)(74316002)(55016002)(8936002)(9686003)(105586002)(68736007)(11346002)(39060400002)(53936002)(5660300001)(8676002)(4326008)(7736002)(97736004)(2900100001)(3846002)(99286004)(2906002)(478600001)(7696005)(54906003)(66066001)(3280700002)(110136005)(229853002)(14454004)(966005)(6436002)(5250100002)(3660700001)(33656002)(6116002)(316002)(45080400002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2888;H:DB6PR0402MB2838.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AgesX0j1QI8luKpv26ugk06dPSdmZkNA4avQcmy4Co2fslP06bUPqXsNL0WOdL4PbfCVIGXW0jVQdSMb7IjYBbT4qE7pNC0vzizib/Z9ov8PhAfXaJMYOJVnkFgphYSg7Ku7DET61tJh6hya8NAi8s0f/CkDrpkjKnPefhd0y0IqV3gd440yTH3azbjqZigz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ea06ccc6-203a-481c-3d94-08d5d02fb349
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea06ccc6-203a-481c-3d94-08d5d02fb349
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 06:42:43.1348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2888
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

-----Original Message-----
From: linux-mtd [mailto:linux-mtd-bounces@lists.infradead.org] On Behalf Of=
 Yogesh Narayan Gaur
Sent: Monday, June 11, 2018 3:51 PM
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: richard@nod.at; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; Han Xu=
 <han.xu@nxp.com>; linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org;=
 marek.vasut@gmail.com; Frieder Schrempf <frieder.schrempf@exceet.de>; broo=
nie@kernel.org; linux-mtd@lists.infradead.org; miquel.raynal@bootlin.com; F=
abio Estevam <fabio.estevam@nxp.com>; David Wolfe <david.wolfe@nxp.com>; co=
mputersforpeace@gmail.com; dwmw2@infradead.org
Subject: RE: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI =
controller

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

>> Did you try to create a smaller partition? Maybe we have a problem when =
accessing addresses higher than X with the new driver (X to be determined).

> Would try and update you.

I have tried JFFS2 mounting with smaller partition size but still getting f=
ailure.
For partition size equal or less than 1MB, getting errors as
    [   25.044930] jffs2: Too few erase blocks (4)
Thus, need to have size more than 1MB.

For 2MB partition size getting error message from jffs2_scan_eraseblock().
    root@ls1012ardb:~# cat /proc/mtd
    dev:    size   erasesize  name
    mtd0: 04000000 00040000 "20c0000.quadspi-0"
    mtd1: 00500000 00040000 "rcw"
    mtd2: 00a00000 00040000 "test"
    mtd3: 00200000 00040000 "rootfs"
    root@ls1012ardb:~#  mkdir /media/ram ; flash_eraseall /dev/mtd3
    flash_eraseall has been replaced by `flash_erase <mtddev> 0 0`; please =
use it
    Erasing 256 Kibyte @ 1c0000 -- 100 % complete
    root@ls1012ardb:~# mount -t jffs2 /dev/mtdblock3 /media/ram/
    [   26.380989] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not=
 found at 0x00000000: 0x0dd0 instead
    [   26.390509] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not=
 found at 0x0000004c: 0x7366 instead
    [   26.399999] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not=
 found at 0x00000050: 0x736c instead

--
Regards
Yogesh Gaur

> > >     [  187.128159] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x19=
85 not found at 0x013c0004: 0x7a3b instead
> > >     [  187.137641] jffs2: jffs2_scan_eraseblock(): Magic bitmask
> > > 0x1985 not found at 0x013c0008: 0xb10f instead
> > >=20



______________________________________________________
Linux MTD discussion mailing list
https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.i=
nfradead.org%2Fmailman%2Flistinfo%2Flinux-mtd%2F&data=3D02%7C01%7Cyogeshnar=
ayan.gaur%40nxp.com%7C0b09ae57f2dc4363cae408d5cf852b37%7C686ea1d3bc2b4c6fa9=
2cd99c5c301635%7C0%7C0%7C636643093224060418&sdata=3DLCcPBI5JVKF6FfJQjm%2B5W=
lUIUG%2BTtJwg4%2BHWZiU%2Fh%2BE%3D&reserved=3D0
