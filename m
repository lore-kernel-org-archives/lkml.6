Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586C2C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3AB20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UQ/f7eU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3AB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbeJWSAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:00:45 -0400
Received: from mail-he1eur01on0070.outbound.protection.outlook.com ([104.47.0.70]:21493
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728439AbeJWSAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iirpL35QbtX4gvLbA/Jhlg8Gk9n22bn+2/UlMKswf7c=;
 b=UQ/f7eU/8fI/Bh+aIE0erBIM3Bf4woLsoV7kH1nd5G553F+ERe2TLuNnxnJfa3d176NLuCQ26UDGliCn2gMcYb/rJYYGdu2HjIlJuFhYg87aXa+5tpGcEjsdyePjvL4tkVgnMOLzBpmyA5VghVkU95XtBNPRn+y5yS2bqvYpgYs=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5022.eurprd04.prod.outlook.com (20.177.50.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 09:37:00 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 09:37:00 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v3 0/7] spi: add support for octo mode
Thread-Topic: [PATCH v3 0/7] spi: add support for octo mode
Thread-Index: AQHUarPy2Onn3VDDqEW4evXD57qOxw==
Date:   Tue, 23 Oct 2018 09:37:00 +0000
Message-ID: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0141.apcprd04.prod.outlook.com
 (2603:1096:3:16::25) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5022;6:miNjnmwJpVIkla9i9oF4KLfzMKBQO7b0F60lTMfwdUlYQVdeMs5AQYjehswJoe/ZrVXiqd76uJsnqPEPc698hHs7Ml2MxHHgcaiGRNpGkKVVVCv+xlkge+FzzrF6C9+Z9GsxmeqFgBR8XFxiW9Nx0nqS3MQPjzRHtZ5Yte2odoFnFGSwjiUMRZjEfX6s5xZj9Cr31YzPlU3xaE6e82xZW37INly2loXsZeafxY2LjDVBpglAhNd1OtR+vLOInPTtBxdbcNM1NjNBNW/b75YR1WARE3B7aw2BkZ1Kh6XZKdE1dVnUmkfitDc/Yta/JndUnJp1rtSeKL8fMmRiQjZR6vYsELaBbGYjvAEXZHi8W8NsN6oiMQu0jwPo2TsEplK3bGnZ5NhJHupS+3L+DNeOn8E1zwoOwnx2tjW54H4JwVdR6rrbiJm37V/R9CyH/UDjyZyYx22TvQsTcxCZUlPAnA==;5:wCItDIkuTbbAVph+ybTBOlWYNwrpt25pm+JZh+6wTr8tnc4a/p/xGOTUTQE3bvbw4mkLrLaOCunlRljeJS/IyDvzmc0Z1ihPMCgikkVwkVDEdrzhE3FtSB/c+LDkLgBCD8tFzEIlJz1dfoYb2j5KutXGLO4yiDWHFtqJ9wiD1RU=;7:YbLGLGla9Jky5rdyMhLsENnw4JePE5afjWsFkasXzGMvw52ze9M2w39pEy4ULLZciLuRrA5XpPCiDvXR1nBukz7HQOLHKvcQ73tZ20sx4Vsm54rDPJ6SPBfJq4YsGx7JQGXsOuJMlo1xLIn6qtA750BLhVlYX6zZnAEtbP9mV+HY3DCKiaQhxVJW180dQjALJgXxTOt+yPctSVmIYHs1ojfk096yn+/gXJshqWK2nIzuv3x1+3MOComNJHw6bDVh
x-ms-office365-filtering-correlation-id: 87cf1c97-f489-41b3-fddc-08d638cb14b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5022;
x-ms-traffictypediagnostic: VI1PR04MB5022:
x-microsoft-antispam-prvs: <VI1PR04MB5022458FA7E3E5885684166C99F50@VI1PR04MB5022.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5022;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5022;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(8936002)(256004)(6512007)(106356001)(102836004)(53936002)(6306002)(71190400001)(4326008)(71200400001)(2616005)(54906003)(2906002)(26005)(55236004)(110136005)(476003)(105586002)(99286004)(3846002)(81156014)(7736002)(6436002)(305945005)(81166006)(7416002)(6486002)(2201001)(86362001)(186003)(6506007)(386003)(2900100001)(52116002)(478600001)(14454004)(6116002)(8676002)(66066001)(486006)(36756003)(97736004)(966005)(5660300001)(39060400002)(316002)(2501003)(5250100002)(14444005)(68736007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5022;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: G7maPjdzlokfAvxS1ZKmga9qw9iojTx6FdwQ1jbtKe7RYaIuJrrZtfp97WeOZsQIgXxSbxIUYRdmTfXxfUM7//r+Qe+g8jAblxvKvQHoYfrtUBXmd2P/hdy0YICFvAVa4PVH5PNkwKsICkuMyn6o+6pOQM6zXXoM3jwdYh9SNlqg0Cergk929fF1IprSErj5eNzEoS8r6U8slB80jiEDMeEGJxUxY1fskxs98o3rrdJ+BrdgswxbW+zoS/adA+ydnSk1O3yuS7kOABE75N0zaD25e5MtuW9UaXDaiQXR3+BfYo+DIcMXGkrNzDV/lcQtfHR2olZZXzzry0OcyjYONgzJnIOFb45Cb+UyDX79p3w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cf1c97-f489-41b3-fddc-08d638cb14b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 09:37:00.4486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octo mode IO data transfer.
Micron flash, mt35xu512aba, supports octal mode data transfer and
NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).

Patch series
* Add support for octo mode flags and parsing of same in spi driver.
* Add parsing logic for spi-mem framework and m25p80.c device file.
* Add opcodes for octo I/O commands in spi-nor framework, Read and Write pr=
oto for (1-1-8/1-8-8) mode.
  Opcodes are added as per octal data IO commands required for mt35xu512aba=
 [1] flash.
* Add mode bit required for octo mode in nxp-fspi driver [2].
* Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].

Cherry pick below 2 patches (from: https://git.kernel.org/pub/scm/linux/ker=
nel/git/broonie/spi.git):
    c639f871febe6667d9afce28108c634e5636c735 spi: spi-mem: Fix inverted log=
ic in op sanity check
    db122eb8a749a1eff038f9a282c620ab16c4be1d spi: spi-mem: Add extra sanity=
 checks on the op param

Tested on LX2160ARDB target with nxp-fspi driver, below are
Read performance number of 1-1-1 and 1-1-8 read protocol.

 root@lxxx:~# cat /proc/mtd
 dev:    size   erasesize  name
 mtd0: 04000000 00001000 "spi0.0"
 mtd1: 04000000 00001000 "spi0.1"
 root@lxxx:~# time mtd_debug read /dev/mtd0 0x0 0x1000000 0read
 Copied 16777216 bytes from address 0x00000000 in flash to 0read

 real    0m2.792s
 user    0m0.000s
 sys     0m2.790s
 root@lxxx:~# time mtd_debug read /dev/mtd1 0x0 0x1000000 0read
 Copied 16777216 bytes from address 0x00000000 in flash to 0read

 real    0m0.441s
 user    0m0.000s
 sys     0m0.440s
 root@ls1012ardb:~#

 Flash device MTD0 configured in 1-1-1 protocol.
 Flash device MTD1 configured in 1-1-8 protocol.

[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D70384
[2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D72181

Yogesh Gaur (7):
  spi: add support for octo mode I/O data transfer
  spi: spi-mem: add support for octo mode I/O data transfer
  mtd: spi-nor: add opcodes for octo Read/Write commands
  mtd: spi-nor: add octo read flag for flash mt35xu512aba
  mtd: m25p80: add support of octo mode I/O transfer
  spi: nxp-fspi: add octo mode flag bit for octal support
  arm64: dts: lx2160a: update fspi node

Changes for v3:
- Add octo mode support in spi_setup().
- Rename all patches with 'octal' string modified as 'octo'.
Changes for v2:
- Incorporated review comments of Boris and Vignesh.

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
 drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
 drivers/mtd/spi-nor/spi-nor.c                     | 15 ++++++++++++++-
 drivers/spi/spi-mem.c                             |  9 ++++++++-
 drivers/spi/spi-nxp-fspi.c                        |  4 ++--
 drivers/spi/spi.c                                 | 12 ++++++++++--
 include/linux/mtd/spi-nor.h                       |  8 ++++++++
 include/linux/spi/spi.h                           |  2 ++
 8 files changed, 56 insertions(+), 7 deletions(-)

--=20
2.7.4

