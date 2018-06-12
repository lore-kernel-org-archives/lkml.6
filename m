Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 73D83C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132A3208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JeyKewZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132A3208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933785AbeFLIvc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:51:32 -0400
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:10336
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933363AbeFLIv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOpJzMcmU2PQ7vTwJF6kBC7uMcTw6i3g/8X3MpJr6m0=;
 b=JeyKewZP/Ju/w8Hyf5kP4DwXCBPH3FhujE5puWS1quhr2poXxoozmBPVuFX8BUiO7SgPhxcjH5AhcgfT3Jh4dliMgh4HE3+7t7amXg4wXiVnFhl7VQgVBncS8XKBDgCwBil2NjOM8W/ALzqsIDMlqwBibep9jQOjTMJwGHeBwvo=
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2838.eurprd04.prod.outlook.com (10.172.247.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Tue, 12 Jun 2018 08:51:25 +0000
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::49a5:1040:801d:2b97]) by DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::49a5:1040:801d:2b97%2]) with mapi id 15.20.0863.010; Tue, 12 Jun 2018
 08:51:25 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
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
Thread-Index: AQHT+BiB2hXNm2lXyUydyOG4FdlBjqRWHnBAgABANgCABEvZ8IAAFd0AgAAehWCAAAtnAIAAAPSwgAFUQ+CAAAoIAIAAGBOg
Date:   Tue, 12 Jun 2018 08:51:25 +0000
Message-ID: <DB6PR0402MB28387FE79F2742C9BEBD4037997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180608145130.09f979f9@bbrezillon>
        <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611094616.5c8f82cf@bbrezillon>
        <DB6PR0402MB283825171DF93AD3C8590DD799780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611121618.40f4b609@bbrezillon>
        <DB6PR0402MB28388D9DEB86629BB58DD5E499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <DB6PR0402MB2838563F1BA71A9A21ABBE01997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180612091328.67734adb@bbrezillon>
In-Reply-To: <20180612091328.67734adb@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2838;7:fl7CoWOcI20ajpaySlGoZ9TDrh+Y7iRZcIQq9AJy+5nggGOl/5eCjBTXxPM4Vu/CDk2UfS0TRrMX3Dj+jdD9APsHNfH2gzhNkFhfgQxlh8OuZDgDcW4KKxAK+H9bxLZojRn9YJIK2sbMrVNCPPyrZ3ivQ55rKonTkjQfuCH5gwTw7gZLGwvzaiSuXbgCjfPuV6cQTl9BPwGRl3b3VQT/xAMAt1aw1iB1td1DhmIJx0FGUEXwIx3tUO1RCBzdCETw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2838;
x-ms-traffictypediagnostic: DB6PR0402MB2838:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-microsoft-antispam-prvs: <DB6PR0402MB2838016E1C90968D822DAE5B997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0402MB2838;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2838;
x-forefront-prvs: 07013D7479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(13464003)(189003)(199004)(81156014)(81166006)(3280700002)(5660300001)(3660700001)(6916009)(8676002)(7416002)(8936002)(2906002)(229853002)(478600001)(14454004)(55016002)(9686003)(93886005)(316002)(6116002)(3846002)(99286004)(54906003)(33656002)(6436002)(97736004)(105586002)(86362001)(74316002)(106356001)(575784001)(26005)(4326008)(186003)(7736002)(39060400002)(68736007)(11346002)(305945005)(446003)(7696005)(6246003)(102836004)(5250100002)(25786009)(6506007)(59450400001)(76176011)(53546011)(55236004)(66066001)(476003)(53936002)(2900100001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2838;H:DB6PR0402MB2838.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EVHu6+0y330AiRsCYRVScz4bCKDVha4gdySLeOpQYLm10WgjusGa0vJW4NvYLdzsQ0MvTfTls8vmy7qtn6rdEZtFG299zEJ6woh1VPB/TP1aMs3faqQcLRUnVGao5XabbQJr3bHJbq0UVIV6/avSrlz/7tZWfQTnmU6FwMcMk0rF4iqlUz0m8ewxO8oaqbBF
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 14fb666a-db9b-466c-b7a1-08d5d041ae47
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fb666a-db9b-466c-b7a1-08d5d041ae47
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 08:51:25.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2838
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

-----Original Message-----
From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]=20
Sent: Tuesday, June 12, 2018 12:43 PM
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc: richard@nod.at; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; Han Xu=
 <han.xu@nxp.com>; linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org;=
 marek.vasut@gmail.com; Frieder Schrempf <frieder.schrempf@exceet.de>; broo=
nie@kernel.org; linux-mtd@lists.infradead.org; miquel.raynal@bootlin.com; F=
abio Estevam <fabio.estevam@nxp.com>; David Wolfe <david.wolfe@nxp.com>; co=
mputersforpeace@gmail.com; dwmw2@infradead.org
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI =
controller

On Tue, 12 Jun 2018 06:42:42 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> I have tried JFFS2 mounting with smaller partition size but still getting=
 failure.
> For partition size equal or less than 1MB, getting errors as
>     [   25.044930] jffs2: Too few erase blocks (4)
> Thus, need to have size more than 1MB.
>=20
> For 2MB partition size getting error message from jffs2_scan_eraseblock()=
.
>     root@ls1012ardb:~# cat /proc/mtd
>     dev:    size   erasesize  name
>     mtd0: 04000000 00040000 "20c0000.quadspi-0"
>     mtd1: 00500000 00040000 "rcw"
>     mtd2: 00a00000 00040000 "test"
>     mtd3: 00200000 00040000 "rootfs"
>     root@ls1012ardb:~#  mkdir /media/ram ; flash_eraseall /dev/mtd3
>     flash_eraseall has been replaced by `flash_erase <mtddev> 0 0`; pleas=
e use it
>     Erasing 256 Kibyte @ 1c0000 -- 100 % complete
>     root@ls1012ardb:~# mount -t jffs2 /dev/mtdblock3 /media/ram/
>     [   26.380989] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 n=
ot found at 0x00000000: 0x0dd0 instead
>     [   26.390509] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 n=
ot found at 0x0000004c: 0x7366 instead
>     [   26.399999] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 n=
ot found at 0x00000050: 0x736c instead

That's weird. Can you tell me on which platform you're testing?
lsxxx or vf610? Can you dump the NOR after the erase to make sure the memor=
y is actually erased (filled with 0xff)?

I am working on lsxxx platform. With further debugging, I found that my era=
se operation for second flash device is not working properly.
Need to have debugging for this in Frieder Patch.

When I have created multiple partition for First flash device, then JFFS2 m=
ounting and booting of Linux kernel from rootfstype=3Djffs2 is successful.
    root@ls1012ardb:~# cat /proc/mtd
    dev:    size   erasesize  name
    mtd0: 00500000 00040000 "rcw"
    mtd1: 00a00000 00040000 "test"
    mtd2: 02e00000 00040000 "rootfs"
    mtd3: 04000000 00040000 "20c0000.quadspi-1"
In above list, for MTD2 partition, able to perform JFFS2 mounting.

Below is logs of erase for both flashes:
    root@ls1012ardb:~# cat /proc/mtd
    dev:    size   erasesize  name
    mtd0: 04000000 00040000 "20c0000.quadspi-0"
    mtd1: 04000000 00040000 "20c0000.quadspi-1"
    root@ls1012ardb:~# mtd_debug erase /dev/mtd0 0x1000000 0x2000000
    Erased 33554432 bytes from address 0x01000000 in flash
    root@ls1012ardb:~#
    root@ls1012ardb:~# mtd_debug read /dev/mtd0 0x1000000 0xa00000 rp
    Copied 10485760 bytes from address 0x01000000 in flash to rp
    root@ls1012ardb:~# hexdump rp
    0000000 ffff ffff ffff ffff ffff ffff ffff ffff
    *
    0a00000
    root@ls1012ardb:~#
    root@ls1012ardb:~# mtd_debug erase /dev/mtd1 0x1000000 0x2000000
     [   25.023027] random: crng init done
    Erased 33554432 bytes from address 0x01000000 in flash
    root@ls1012ardb:~# mtd_debug read /dev/mtd1 0x1000000 0xa00000 rp
    Copied 10485760 bytes from address 0x01000000 in flash to rp
    root@ls1012ardb:~#
    root@ls1012ardb:~# hexdump rp
    0000000 1985 2003 000c 0000 b0b1 e41e ffff ffff
    0000010 ffff ffff ffff ffff ffff ffff ffff ffff
    *
    0040000 1985 2003 000c 0000 b0b1 e41e ffff ffff
    0040010 ffff ffff ffff ffff ffff ffff ffff ffff

--
Yogesh Gaur
