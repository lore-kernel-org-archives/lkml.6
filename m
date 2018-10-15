Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5BAC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010A92083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rURGY39d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010A92083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbeJOT7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:59:04 -0400
Received: from mail-db5eur01on0043.outbound.protection.outlook.com ([104.47.2.43]:35328
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbeJOT7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApW3JgH1cQeKpQc8S24f1+jlufOPuPnSH9dAmZJov7w=;
 b=rURGY39d1R3noZFmy9m3/a5H8oxWguuQ81VvTKqm9F+yrdxJmraO+GZNR9TdgjQIUDofAc964C4xPGVzYAMojifktSGWru2YckdOZei/iXe3TvFW7TpcM4V6VaCneCf/qI5nbNBGZI0sMsOjX75MfuY2XB2vInZlMTiTouCCo3E=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4240.eurprd04.prod.outlook.com (52.134.31.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Mon, 15 Oct 2018 12:13:57 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 12:13:57 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
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
Subject: [PATCH v2 0/7] spi: add support for octal mode
Thread-Topic: [PATCH v2 0/7] spi: add support for octal mode
Thread-Index: AQHUZICMj9na8RY3aESpiAu8NFV+KQ==
Date:   Mon, 15 Oct 2018 12:13:57 +0000
Message-ID: <1539605534-22302-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4240;6:ZgIPHCHdIE8a8Kfbk+x0McyoTgPpDyBQq+rtxFQlQMTYjcmUuH5kYaVFm2z4Emd2ZjN2gds/pFBjPDjKrIvJPgl7UL7eM7M932Iw+7I5Kw5ovv0bQ0tcJGLLaPww0kPTC3OS3csGdINziUhodr/V7IeuMYGBx3MUpX7rb73j/TZm7idXvVb9vaAY0fjtIz451jkcuYUAU4KJ7Aqg6TlDtEYC4KhyFddhEpHMB+uZqOaWkkwg1Dkzn5l0ADOXppVQPwTBPLYFCDr76yN7F2dOpkzDjLW/4Wgcw1y9X7+Y7XP41UKhYO7yFmEfhedIO19884NRev3loPiiSsrpdnl2mx4Nvhd2QF29GeHmeHwvFIVnlNO3/BZqFArqBEFW0RHy26i9h94Cq0XdLLGpuT68udTxma0tMPebDF390yhQfOAj1ueJ9qeNDooLwl2m0Xmv+/mBg38sAd1T0MquYIOkfQ==;5:q+NLubKDuTA4t5SkF4eUlJLWHlMaMkqXh2rhhmoNlwJ87sfO710qNmRQzw09YcSUOkgfBOR3gO1fbr1oGLf2lm1AwFQs7bac0VKX6dUV89oEl3XuwnhimoVVqx9ucgCeFs85kGWkr88yGLahfk1tcPXskL6Ug2Jp7kXWTnnvzf4=;7:RKbnwZYM5Wl0LjPHpslUaNkclZnINrAO6XX7StR6jTORzK7y7eDauMmrr5ms6dXRCKqXCBLH4ivaoq50EXE8V65T5vhYi+3n5GUxW0jglO/DE0w2M85P99cw0ZjAqNHMWPF0M6oZ4Xi7KF9xPsyPQbWIkOKahfKuQ/VGPUo9leD58CC6n6UKNj/yJFLF/ZdrrtDk/aMLHmMOyYDpIsDWWM+RJjgCDGweidpAO2nZsDLFkkdp/5ilfFot46F39kui
x-ms-office365-filtering-correlation-id: 73c79c08-e4ad-487d-de31-08d63297ae67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4240;
x-ms-traffictypediagnostic: VI1PR04MB4240:
x-microsoft-antispam-prvs: <VI1PR04MB4240B52C4CCB7244B5A2CF2D99FD0@VI1PR04MB4240.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR04MB4240;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4240;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(189003)(86362001)(102836004)(106356001)(99286004)(105586002)(6486002)(39060400002)(26005)(6436002)(476003)(71190400001)(71200400001)(2201001)(186003)(5660300001)(66066001)(486006)(2616005)(14454004)(97736004)(305945005)(55236004)(52116002)(478600001)(6306002)(4326008)(5250100002)(36756003)(966005)(81156014)(81166006)(54906003)(7736002)(53936002)(6512007)(68736007)(2501003)(8676002)(8936002)(6506007)(386003)(14444005)(256004)(2906002)(110136005)(7416002)(316002)(2900100001)(25786009)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4240;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7MlgGYKV5HzGRlauAaNiMR03uy3x3Z/g3NUftbxZwy6fazh3VHNk9qBiTV9O+emOIRthXBpAtCqCKpgcgI8DRBxnsbZJtPg3491l4tZ0VUsrXeuoZGGoDXGRy4apvjlQeThsn7gDnXXY3Kw4Y/oTV0HhyKUD3aLXRXFT2vFydyRezKGCCkhqnIwTRiDlnTeoqFLcW5BtBM4kK8Wf+hrJae3hHCVxcP2BMisDUzvzBPkmw8aApHD/GFbWgYS//K8UbkPxPB2iFHcIeBgwzU//oq6uS6KaGdU5nsMax9mR9RDbo63Ou+Tp/8ONMQvRlHRh1Sr/3EH/M2iphmJ7mXwzOu/1n7P3c98ImtL1CWaW7g0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c79c08-e4ad-487d-de31-08d63297ae67
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 12:13:57.5663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octal mode IO data transfer.
Micron flash, mt35xu512aba, supports octal mode data transfer and
NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).

Patch series
* Add support for octal mode flags and parsing of same in spi driver.
* Add parsing logic for spi-mem framework and m25p80.c device file.
* Add opcodes for octal I/O commands in spi-nor framework, Read and Write p=
roto for (1-1-8/1-8-8) mode.
  Opcodes are added as per octal data IO commands required for mt35xu512aba=
 [1] flash.
* Add mode bit required for octal mode in nxp-fspi driver [2].
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
[2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D70210

Yogesh Gaur (7):
  spi: add support for octal I/O data transfer
  spi: spi-mem: add support for octal I/O data transfer
  mtd: spi-nor: add opcodes for octal Read/Write commands
  mtd: spi-nor: add octal read flag for flash mt35xu512aba
  mtd: m25p80: add support of octal I/O transfer
  spi: nxp-fspi: add mode flag bit for octal support
  arm64: dts: lx2160a: update fspi node

Changes for v2:
 Incorporated review comments of Boris and Vignesh.

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
 drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
 drivers/mtd/spi-nor/spi-nor.c                     | 15 ++++++++++++++-
 drivers/spi/spi-mem.c                             |  9 ++++++++-
 drivers/spi/spi-nxp-fspi.c                        |  4 ++--
 drivers/spi/spi.c                                 |  6 ++++++
 include/linux/mtd/spi-nor.h                       |  8 ++++++++
 include/linux/spi/spi.h                           |  2 ++
 8 files changed, 52 insertions(+), 5 deletions(-)

--=20
2.7.4

