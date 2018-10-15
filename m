Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEB1C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC3420892
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n0A0COIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC3420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeJOTns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:43:48 -0400
Received: from mail-he1eur01on0077.outbound.protection.outlook.com ([104.47.0.77]:3674
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbeJOTnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FeGb5Msirz06Jo4MgJPEScC7iGY+8NmvrYE4dmguec=;
 b=n0A0COISaPt+rdleoYxE5zVf7teUVIrLohY/kehO3Eqk7B8rDh2sEb4geufLajFxn7QAyHAUjIelE7t6k8uxf6Mjc73RGY6be0+CU5cQcoYq2zQxoEyYpZJxNsmpvRLFpEBSqrnUuESJhl7AKhwV72+XeiWKWSldkklTExjS358=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5247.eurprd04.prod.outlook.com (20.177.51.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Mon, 15 Oct 2018 11:58:44 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 11:58:44 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/7] spi: add support for octal mode
Thread-Topic: [PATCH v2 0/7] spi: add support for octal mode
Thread-Index: AQHUZHzpgtbBSuVUOUKx5snYaQA8FqUgMpUAgAAA2/A=
Date:   Mon, 15 Oct 2018 11:58:43 +0000
Message-ID: <VI1PR04MB1038DA393DB625463800956699FD0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181015135408.49142c88@bbrezillon>
In-Reply-To: <20181015135408.49142c88@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5247;6:J+uTacgwSfIqyYawGBS7R6Otkd8VfDRJEcHHKyvZMPGx3j9J+UwfIKdPwwR+ENt7qDQp47Z+1ZK2cKudYDFgJUg5FNp+xGgAG58a+DD5UH4KniffOwI762oOGE2pGctOKsgXADS8cr7RK6b+qQ0EGMUX8jprWYwDLU3nufSEn8iMtuUUpI2vV3jXpU06pkE2k4QQQpTOORp0Nq6wpWFEC3zyyUSy+XsHj4A9NXPki3M4403/fr8iTdZTG5MAkFYkh7Z1ofHc49IICfDeRq1kIy0EACa7V1RwuV0+MtZo7lOgoAgxekHSPb/Zxdm0ysDkRXRCvGFjmfKWcKNg4bCWUF2kqnpDC61TxdUFbT8LhdmokKYTlXWrLeEQ/0RGc9bIkc5g4Cc9au87cNP+qqDaHzeptEzB8wFHb5/cO8IcTB09SHiYMN79rDkIp/5mAXs5QJtj/yARqFDl2DNOjKUdIQ==;5:hsPC977vNfLHQ+8yZvbXsHn64cI8jM3T2gstVFz6NLEPLHhbBit1CxodlcsBAh4mTi9cCGviWL+TQM1HHVXQKy4zUfC40OHDr9vyyZHy043XkaijJDyXdBqsJLzJaMoHdCptiLyuy5Kbq0dRYayHUatDB4xsIdXhsksfv+m9cIc=;7:sst6ckG+3Qe0Q92yt00Y0p5S0dLXzuK1zE3W0MJdlPPZU+P8yypKrNavJ+bY/L8O8kulKbWzHfq5cItbLCqHREJF+TkwH5Bjn24smD3RUmbUm8QLuC+VFD9j6TQmOYVmoxCBplEd61Sz6oOPaxPeqLGrnjihbx1MDnTQPTnUxdgyVGrsFCGskE1KbhwQfRXkbDsS9xgX7nDbHhBpY1rVwlYsrEW42diVyiIEO/zRoTnIfvGPFIsyDWZwjAOXyUme
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: aaea63e9-27c7-494c-cd4b-08d632958e67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5247;
x-ms-traffictypediagnostic: VI1PR04MB5247:
x-microsoft-antispam-prvs: <VI1PR04MB524747A091E855104D30898599FD0@VI1PR04MB5247.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(85827821059158)(31051911155226)(9452136761055)(180628864354917)(45079756050767)(189930954265078)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:VI1PR04MB5247;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5247;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(396003)(346002)(189003)(199004)(13464003)(55236004)(186003)(305945005)(74316002)(5250100002)(54906003)(7416002)(316002)(7736002)(76176011)(33656002)(478600001)(99286004)(3846002)(7696005)(106356001)(6116002)(97736004)(6506007)(105586002)(2900100001)(45080400002)(53546011)(486006)(2906002)(6916009)(78486010)(14444005)(256004)(446003)(11346002)(8676002)(476003)(66066001)(6246003)(9686003)(71200400001)(26005)(86362001)(71190400001)(39060400002)(14454004)(4326008)(575784001)(5660300001)(25786009)(68736007)(6436002)(8936002)(53936002)(102836004)(6306002)(55016002)(81166006)(966005)(229853002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5247;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nmkubuGSTgFJI1BTG9kQ6wBd75lzfuNigI57oovevqa9eNKmvh4zFzDBQxkskUs+Hr7Ba79MHSpE8EyLOgxSdlebNOk5UdpZR6Uj49giv+pCFlPcsBEwWbKMjEN+7vP3i8dJzrvXD/eD6VIS8t789cz6MONpepy0eh+ZOiIePYkVkH2zogpXA3OjALz3+3CkBRjt59LDiSWQ29DG820v0HpuZ9pXDPIgqqhVrIuw7XrGhXkkhfVxbt1rkc2HAqZ2IAhxN/JIL0ds1cbEfTaLur3xAR5Zm/7zk+xREAbqq8BWaGayskR1yobsbo3nyUEZNRrdPe/r1wcR72toAcNZTbD1X6GUzOldKklgbW1qNPQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaea63e9-27c7-494c-cd4b-08d632958e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 11:58:43.8445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5247
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, October 15, 2018 5:24 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; vigneshr@ti.com=
;
> linux-spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 0/7] spi: add support for octal mode
>=20
> Hi Yogesh,
>=20
> On Mon, 15 Oct 2018 11:47:55 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Add support for octal mode IO data transfer.
> > Micron flash, mt35xu512aba, supports octal mode data transfer and NXP
> > FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).
> >
> > Patch series
> > * Add support for octal mode flags and parsing of same in spi driver.
> > * Add opcodes for octal I/O commands in spi-nor framework, Read and Wri=
te
> proto for (1-1-8/1-8-8) mode.
> >   Opcodes are added as per octal data IO commands required for
> mt35xu512aba [1] flash.
> > * Add parsing logic for spi-mem framework and m25p80.c device file.
> > * Add mode bit required for octal mode in nxp-fspi driver [2].
> > * Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [=
2].
> >
> > Cherry pick below 2 patches (from:
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.=
ker
> nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbroonie%2Fspi.git&amp;da
> ta=3D02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C9af69996cae344b6e7b70
> 8d63294eaf5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6367520
> 12521352025&amp;sdata=3DeuwK9X2tael3Q69QO%2BirRznB%2BHKazDbumdAOp
> eZvxCc%3D&amp;reserved=3D0):
> >     c639f871febe6667d9afce28108c634e5636c735 spi: spi-mem: Fix inverted
> logic in op sanity check
> >     db122eb8a749a1eff038f9a282c620ab16c4be1d spi: spi-mem: Add extra
> > sanity checks on the op param
> >
> > Tested on LX2160ARDB target with nxp-fspi driver, below are Read
> > performance number of 1-1-1 and 1-1-8 read protocol.
> >
> >  root@lxxx:~# cat /proc/mtd
> >  dev:    size   erasesize  name
> >  mtd0: 04000000 00001000 "spi0.0"
> >  mtd1: 04000000 00001000 "spi0.1"
> >  root@lxxx:~# time mtd_debug read /dev/mtd0 0x0 0x1000000 0read
> > Copied 16777216 bytes from address 0x00000000 in flash to 0read
> >
> >  real    0m2.792s
> >  user    0m0.000s
> >  sys     0m2.790s
> >  root@lxxx:~# time mtd_debug read /dev/mtd1 0x0 0x1000000 0read
> > Copied 16777216 bytes from address 0x00000000 in flash to 0read
> >
> >  real    0m0.441s
> >  user    0m0.000s
> >  sys     0m0.440s
> >  root@ls1012ardb:~#
> >
> >  Flash device MTD0 configured in 1-1-1 protocol.
> >  Flash device MTD1 configured in 1-1-8 protocol.
> >
> > [1]
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa=
t
> > chwork.ozlabs.org%2Fproject%2Flinux-
> mtd%2Flist%2F%3Fseries%3D70384&amp
> > ;data=3D02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C9af69996cae344b6e
> 7b708d
> >
> 63294eaf5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636752012
> 521352
> >
> 025&amp;sdata=3Dldk0ny8vksO%2FayIsYX26M4akFUojtaP1YyOtpMEGJZA%3D&a
> mp;res
> > erved=3D0 [2]
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa=
t
> > chwork.ozlabs.org%2Fproject%2Flinux-
> mtd%2Flist%2F%3Fseries%3D70210&amp
> > ;data=3D02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C9af69996cae344b6e
> 7b708d
> >
> 63294eaf5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636752012
> 521352
> >
> 025&amp;sdata=3Dwq%2BCnrk4Ovx4itHrZfv%2FGH5raStF91hfjHBQmO9Sjq0%3D&
> amp;r
> > eserved=3D0
> >
> > Yogesh Gaur (7):
> >   spi: add support for octal I/O data transfer
> >   mtd: spi-nor: add opcodes for octal Read/Write commands
> >   mtd: spi-nor: add octal read flag for flash mt35xu512aba
> >   mtd: m25p80: add support of octal I/O transfer
> >   spi: spi-mem: add support for octal I/O data transfer
>=20
> Patch 5 should be moved before patch 4 (ideally in 2nd position) if you w=
ant this
> series to be bisectable.
>=20

Ok.
For now, order which I have selected is as per the comments from Vignesh. W=
ould resend again with the suggested order.

--
Regards
Yogesh Gaur

> Regards,
>=20
> Boris
>=20
> >   spi: nxp-fspi: add mode flag bit for octal support
> >   arm64: dts: lx2160a: update fspi node
> >
> > Changes for v2:
> >  Incorporated review comments of Boris and Vignesh.
> >
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
> >  drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
> >  drivers/mtd/spi-nor/spi-nor.c                     | 15 ++++++++++++++-
> >  drivers/spi/spi-mem.c                             |  9 ++++++++-
> >  drivers/spi/spi-nxp-fspi.c                        |  4 ++--
> >  drivers/spi/spi.c                                 |  6 ++++++
> >  include/linux/mtd/spi-nor.h                       |  8 ++++++++
> >  include/linux/spi/spi.h                           |  2 ++
> >  8 files changed, 52 insertions(+), 5 deletions(-)
> >

