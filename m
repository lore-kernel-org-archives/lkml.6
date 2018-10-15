Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E22C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E18D20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xcU/TzIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E18D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeJOTc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:32:57 -0400
Received: from mail-he1eur01on0057.outbound.protection.outlook.com ([104.47.0.57]:40576
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbeJOTc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV0hiycAJLMmVlHjez8yxY34FbT306UqT/ayqdK6mDU=;
 b=xcU/TzIrFQCQ/zKvIAkaegWSoYCIrK3YmrwCGrCfkF0d7jXbNZuiSKKwh5fmaT3fQLg1fes5yupshQvNhWSTNdiCAWI19FPvG9UF2cj5z8CGVk0471/v+T7ILOQwoefmsaX4eE5iD/DkGw2tT3radP03Bcdy+2BY487RpH4r7hY=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1616.eurprd04.prod.outlook.com (10.164.84.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 11:47:55 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 11:47:55 +0000
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
Thread-Index: AQHUZHzpgtbBSuVUOUKx5snYaQA8Fg==
Date:   Mon, 15 Oct 2018 11:47:55 +0000
Message-ID: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1616;6:RrsOPx7cdngomF9BpIn9BetVY1yHMLyHB26vN3D+gOkhbdQnUvRq5GxfdCeegioTYeEupvKz31IZuaasVTQhKSsU/xTr63HjZtnpoOW8PrnvwwiG01zsu4Zol9M6IPcWS0pw8ffKJqWR0KqHYOtJ4il5N07r9zvKEmndqyuLevjWBQFIY4PzOOGUd1MF7g3egx7MV2Lvf3wjRsyJMyb3c0nh6GVKwWI88Jq32ydRGUPwTODI2RlK7YvYKe+GBXMRrFSfwaCF6nUXH1b3cIGRiaGltWqKYVGxXAHOuX1AytAdapyP5YP/cVjkfB4b40PWlP79CwmUPAuJTIbscEelfdgmS3+ZFLD53kEF5oWkkml/4Z5jIFZmJRnzZrxIyl4HS2IiSDgkZv4SIR1OpXZ+lfy2w5KY0rULL5hUXD8E/3bxXoa/T63uwg83xwrmUQOZE4zxhjbLSXxlwEFS3QpwduTCtWJIIqhJcIQWfkB3DEk=;5:tLygWeqLci63U7upBpXLkC8kFVJEH23/NqUxo2NwATyLlXlmXs/NN/YsFEbP8hMWsx4QBES5jup9Y2JZo4x9qdgjneN50Co3hSB5kf+oc1IgEeQjKIWrtyHtevhY/JQ1/yogd8B30jS2isgivP5Vus9iAAgJ6aNjq3/JxSl+Xq8=;7:HHhiiJiBcPY9PQeI++WLehapFBUgVkZyn3I6MX+k5zF6z/4Siy3wciPX8RoQyuJu7b3RFzgtpfWDMPeCZqLa1oFm8LS1rxsFFOxM0X3zHlwDSLMNOvpooCsmFgKPOM0290qXUvQeJT6D1HCGWu6TKPv5XDYdku3A14Q/n9kYGol6XmADvUT8S6qrt92LeYt2ebSRy0lLfYmwOTirbqTqb9NJUFHxMw9Xd/Va/BtDUd7viBHdR+7IzfSbU7q5v8kX
x-ms-office365-filtering-correlation-id: c71f47cf-df28-443a-9e71-08d632940b57
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1616;
x-ms-traffictypediagnostic: VI1PR04MB1616:
x-microsoft-antispam-prvs: <VI1PR04MB1616C3B0DA37CB038153E7E899FD0@VI1PR04MB1616.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:VI1PR04MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1616;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(81166006)(81156014)(8676002)(7416002)(8936002)(4326008)(2501003)(316002)(66066001)(5250100002)(2201001)(53936002)(7736002)(256004)(14444005)(6512007)(25786009)(6486002)(6436002)(86362001)(6306002)(68736007)(5660300001)(305945005)(52116002)(2906002)(6116002)(3846002)(54906003)(110136005)(99286004)(39060400002)(2900100001)(478600001)(476003)(2616005)(486006)(14454004)(106356001)(36756003)(186003)(26005)(55236004)(71200400001)(102836004)(966005)(386003)(71190400001)(6506007)(105586002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1616;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QjeHX10OV7Mc+HZUj4rv172b7SdKulhu/cci39iYaOlwAyBt3Hj4WubAxF9xTd7SquIcZJkwW8FRCQX9YjvjHE7BxvOGJDyDZMB7EbrC0WNjCj99APb/hs5Tl3xPXclZ0EOSIgU1Bw4+Deqp5tr2pqg8oqJCWcjUcBPxW6LN1fa2JA24LEszzuU/OfFzc6+ofPXnOsj2Kr3KYKTTMWiWDrnE6djCsatQAs+QOR2nDUh5ZR+x+t2wug5sC79VfdyteGNFEvr/G2/a11a2rTCz9sdCRaIc/9FJGwIasDNOeDTQriQ8utJw7jwxexloZ4dxiM9c9v5G3SHimeF0YOMjyLSaiPA7jiI/Ihs8atvD8dc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71f47cf-df28-443a-9e71-08d632940b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 11:47:55.5391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octal mode IO data transfer.
Micron flash, mt35xu512aba, supports octal mode data transfer and
NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).

Patch series
* Add support for octal mode flags and parsing of same in spi driver.
* Add opcodes for octal I/O commands in spi-nor framework, Read and Write p=
roto for (1-1-8/1-8-8) mode.
  Opcodes are added as per octal data IO commands required for mt35xu512aba=
 [1] flash.
* Add parsing logic for spi-mem framework and m25p80.c device file.
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
  mtd: spi-nor: add opcodes for octal Read/Write commands
  mtd: spi-nor: add octal read flag for flash mt35xu512aba
  mtd: m25p80: add support of octal I/O transfer
  spi: spi-mem: add support for octal I/O data transfer
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

