Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1691C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA3020651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LqJ5uk5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfAOKFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:05:10 -0500
Received: from mail-eopbgr150047.outbound.protection.outlook.com ([40.107.15.47]:50304
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727221AbfAOKFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfetV4oObnO1Ao5RbL6IITR6kJNQu+C/k/NNrDfS4Bc=;
 b=LqJ5uk5VNHFwOp5E4camaegjLMo4x3cSU4EStSZirCx3BGe/aAhn10mLPGXSnIvRWfzDGtjho+Wf7tE2K/rANEo6V2DOAMATNKEPxBHlf5+ZTIoLrti9iWQxnNqxGkIkiJjnfkv5/4pbf1HB2qI69AZ4/Ahqgpy2kuJotDzLRWs=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5087.eurprd04.prod.outlook.com (20.177.50.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 10:05:04 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 10:05:04 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v7 0/5] spi: add support for octal mode
Thread-Topic: [PATCH v7 0/5] spi: add support for octal mode
Thread-Index: AQHUrLnIBDiZYyCHy06MvUHHePk4aQ==
Date:   Tue, 15 Jan 2019 10:05:04 +0000
Message-ID: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0123.apcprd06.prod.outlook.com
 (2603:1096:1:1d::25) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5087;6:+AA4twgacw401yP2TQN2gzgFtsenCGjGU/nIiAQQ+7RqDb1P89JsKh036X7fweVjaTqDNsd62IOW+Yn1yGiChR9IbSnUCtxrf4Y1oNBDj8IgWSEZmmnm3q5iCXjrGCtZL/SPLplcup5k5iBW+orYGnSBiiJg0bkrVoIOOa3h7jmdolniJ1jC30n7Gv3Hl8RIkHcBm5GY2qGZGUcrkhAkRRpkiiMjEJvD98YQxgEmj9Z81ZBJDrRNVsSPDYFEChS1PY8APOXQbvxzb2AKirfK3v/QQG+/9xQ8LOiPpEItCsbDswgG9y/sKTXJlH6g/MJCOnAVUNE3E4f1bnNOnFhBFcN+dE3LpFIjUsINGpmhbTtPoivYA73ohonm9mpRYAyBheCDCt4A4CrQYkOerjERziAeXjV1RHWym6KkwMfz+HAHQZVdRwHC3HU7jrcWZ9kOylrYceKSzDRQlWE/Rv7YIQ==;5:F8HOqrX7Xen+G9Va6Xg2B0uThXEkq2VKKMuJE5YcE0dmpX4YAk4BZ6ZHaN1HRtbrKuQ8Za0i9AW71Ng/OcDFxIXItxanqa4Jmx9BunX7U6GAHUBE6vkJjSeS8A+o4E3rjpgt3MDrSQwsmQMEIWAszGqUV2oOLfJc6yQtwiynoE/grz+VW6tdEnu8ZZmh823IHvhQuzSfM/X+HQUuoZ8Xgg==;7:gwFwk/FO77ih9SG1rNiq4CEyslnY8T7zAMP6X310L/CuQolqBRysFT9LovIk/QDtj4HKC2HkiU8iCqcgzsK0V7qyHMJF7P2HI0rGmDo5NFysYG2JJpx6e6DzZ974Y3PSZVFZmxM7L/px92KwJV882A==
x-ms-office365-filtering-correlation-id: 29f030f7-b819-4b41-26ac-08d67ad0eb22
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5087;
x-ms-traffictypediagnostic: VI1PR04MB5087:
x-microsoft-antispam-prvs: <VI1PR04MB50872485C07B4494DC881D9699810@VI1PR04MB5087.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39860400002)(136003)(189003)(199004)(6436002)(486006)(68736007)(4326008)(6486002)(476003)(6306002)(53936002)(25786009)(52116002)(186003)(26005)(2616005)(6512007)(256004)(14444005)(2201001)(39060400002)(71190400001)(86362001)(6506007)(6116002)(55236004)(3846002)(102836004)(386003)(71200400001)(78486014)(2906002)(478600001)(966005)(99286004)(305945005)(7736002)(14454004)(7416002)(81166006)(8676002)(81156014)(8936002)(5660300001)(2501003)(50226002)(106356001)(36756003)(54906003)(105586002)(97736004)(316002)(110136005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5087;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9Vlci7K4RsdpjbH4r62GipI+V/+kfIz4cGUXr0yz0u1fWND+AXwRZhf73ZBWaylx1l6RofO0a8NpmUDXJaBI7d/dLxikTecvkqPwROFdGEnSI7rIbjd3FRxmTm79iR0EhcmzhJWwItAVS/7n7KpuTFQUVq3M5ymwzHhRtq2f8elFRUI8p6QAH8y43yDKXZwlg+Jj01FrTva1I0aqbjPpgXexwbBRRq7JQ7h9yDOBTbZWgQekUPNqR8WVjIMPT6xgYxGZJ2rVGEh2JnltCge3v2DQCs1Cb7Q1Zhrwf5rgNsf9ZD4yCJvjODyxedZ+IEmocY14ocqz1dFWr6w9IdFInM13bxxaKV6QRg+Sd3Jxyc7sZeOqxnjrI3bopto+psqA81dCmvoAVdTwyEEi2AgeqrFCx2ppM6W9QpSsKf8l7us=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f030f7-b819-4b41-26ac-08d67ad0eb22
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 10:04:58.1172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octal mode IO data transfer.
Micron flash, mt35xu512aba, supports octal mode data transfer and
NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).

Patch series
* Add parsing logic for m25p80.c device file.
* Add opcodes for octal I/O commands in spi-nor framework, Read and Write p=
roto for (1-1-8/1-8-8) mode.
  Opcodes are added as per octal data IO commands required for mt35xu512aba=
 flash.
* Add mode bit required for octal mode in nxp-fspi driver [1].
* Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [1].

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

[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D86130

Changes for v7:
- Rebase on top of SPI tree
  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/
  branch: for-next
- Drop below patches from series as these have already been applied.
  'spi-add-support-for-octal-mode-I-O-data-transfer.patch' and
  'spi-spi-mem-add-support-for-octal-mode-I-O-data-tran.patch'
- Add r-o-b tag of Tudor Ambarus for
  patch 'mtd-spi-nor-add-opcodes-for-octal-Read-Write-command.patch'
Changes for v6:
- Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
- Rebase on top of v4.20-rc5.
Changes for v5:
- Modified string 'octo' as 'octal' in all patches.
Changes for v4:
- Rebase on top of v4.20-rc2.
- Modify octo entries enum value in spi.h.
Changes for v3:
- Add octo mode support in spi_setup().
- Rename all patches with 'octal' string modified as 'octo'.
Changes for v2:
- Incorporated review comments of Boris and Vignesh.

Yogesh Narayan Gaur (5):
  mtd: spi-nor: add opcodes for octal Read/Write commands
  mtd: spi-nor: add octal read flag for flash mt35xu512aba
  mtd: m25p80: add support of octal mode I/O transfer
  spi: nxp-fspi: add octal mode flag bit for octal support
  arm64: dts: lx2160a: update fspi node

 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |  4 ++++
 drivers/mtd/devices/m25p80.c                  |  9 ++++++++-
 drivers/mtd/spi-nor/spi-nor.c                 | 19 ++++++++++++++++---
 drivers/spi/spi-nxp-fspi.c                    |  4 ++--
 include/linux/mtd/spi-nor.h                   | 16 ++++++++++++----
 5 files changed, 42 insertions(+), 10 deletions(-)

--=20
2.17.1

