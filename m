Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA59C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFF920866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="am4s0mnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFF920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392140AbeKVPwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:52:14 -0500
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:30502
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbeKVPwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWNlxw7kLIlDWuHfeyjyJmfSRpotXRaHtHa5e7Owcbg=;
 b=am4s0mnOo9b4sT+UJszDEnd0ebOWgXmuLJTwdSfjDxFfCw/nxjnZuubIHUMfbYeN00KIpMZ3kSBNCD7TKF9PCb7I1Luw5OF2a9e8zL2/CkJzv43qe7dii09G0kszt/AQu2FiYPFYFHG61tkOEFyCq4LXoBTcXSqge5qFdrHSG6w=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB3055.eurprd04.prod.outlook.com (10.170.228.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 05:14:25 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%3]) with mapi id 15.20.1361.016; Thu, 22 Nov 2018
 05:14:25 +0000
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
Subject: [PATCH v4 0/7] spi: add support for octo mode
Thread-Topic: [PATCH v4 0/7] spi: add support for octo mode
Thread-Index: AQHUgiI8agpi5BDj3kGll9E1sA3EtA==
Date:   Thu, 22 Nov 2018 05:14:25 +0000
Message-ID: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR01CA0106.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::32) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3055;6:B8N+nOF3ZlcE1z7lFkBmfn8ybFWGN2UPEI29pNl4xOaqDo3x5Q2mUN5ktsFm/SaJXGePTiWFI1BOVHXe9osP4Ivb53wF5FxfYdOq79xd+vQhg0TLcw4d9H1o0ryNH4+3qE4ZVSpCXkB3r/ENjVyQlX4AGXyLcmSlFK1HmwiQte3kf/WwWEb84OkfZHOtq2Ei6DGCVaj4wE/P/jmOTHQcZFUsEZzQbFm1N+J+9Nx5394AD12+bMwa32tXi0NsKDdbd5rLvWVIt7hkocI7pEIgvncWpah4dcnWHc6zRH7q7DyCOoxd+FWV3SV1Eeuqwgmkoc8VfHTWxxGprX0bpXyo9FcDypDO5Zmgm6312FT6x/c27yKm+mf/c8jkRzihPlc9qdbvndSHXyKs7DviVZzkwISe1V8p4JVs1+iSo43hiqz8WXieoksKdg6CFfwgFi5j6evTEK+eoRAyW+dm2JCTKA==;5:lT87aMnWwciyrXxCqsITFvCdZdIdZyym1wWdDbAmlPJrIjI9JpfwNm1B+WPgd1WHLrmI+25F0iNAJIVnEHOYmQIe2oGVKiPXilr7s0XX6HhUYFYS23JvbNI9AxXO08Vy6mn7xjHV2N5hOPRH7iw+nP+g/PtavvPw5nkKBftTH+k=;7:SDjSvZOZYW0DguV4OMyojZ0Rra10pC257ndUuWJOwd0Z6wPAzo84cP+YTN3eQKQuOw4d3ONlm8a2JJkUroRsaTDmAVwqzg6rokFguV53D0aizn58eJTT565ycoNwJwB2oCJ0Yw59NZ1oSZUPgpDmhw==
x-ms-office365-filtering-correlation-id: cd3d61b3-dbff-488f-d435-08d650395e8a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3055;
x-ms-traffictypediagnostic: VI1PR04MB3055:
x-microsoft-antispam-prvs: <VI1PR04MB30556FFC320DC8CB87FCD4E999DB0@VI1PR04MB3055.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3055;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3055;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(8936002)(25786009)(105586002)(316002)(2906002)(106356001)(52116002)(4326008)(14454004)(6436002)(6512007)(6306002)(6486002)(966005)(53936002)(39060400002)(68736007)(2616005)(476003)(486006)(99286004)(478600001)(36756003)(102836004)(54906003)(71190400001)(71200400001)(386003)(6506007)(66066001)(6116002)(3846002)(110136005)(26005)(256004)(186003)(14444005)(5660300001)(55236004)(81156014)(78486014)(97736004)(2900100001)(81166006)(8676002)(2201001)(2501003)(305945005)(86362001)(7736002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3055;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OV5v+asXdWvzqNxG656raZ40OwdwrWFCfJVcUcqb+lSg7T9hYtiIy98V0UBuOYiojM24bElkiBJjKkz5vENhTBfqqiGpGLYGr2+GMEbchn0Gm84ocCKaUtCMCFV78MZSJl7/dpfxxpjzUbgtT0VRTQ5+auu8D/+VU5G47PlsI4JxVKh6U6LZUN4awqOTsWel8TZfHEXz3S6k+EHyD+hiLXDrkZZvm6DScLPGE8XlTZke6WMJz80gWNIhExgri8JZNKnzziiGwW1N7q3izm70/SbPK7fi2CeBAN1eYs2725tvqJcbd4hmPMu+7Y9t2bIThWDkuJb1T8U0pSol0AYvo24l4sN6EgJbB/7LaeppnsQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3d61b3-dbff-488f-d435-08d650395e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 05:14:25.5424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3055
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

[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D70384&sta=
te=3D*
[2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D76402

Yogesh Gaur (7):
  spi: add support for octo mode I/O data transfer
  spi: spi-mem: add support for octo mode I/O data transfer
  mtd: spi-nor: add opcodes for octo Read/Write commands
  mtd: spi-nor: add octo read flag for flash mt35xu512aba
  mtd: m25p80: add support of octo mode I/O transfer
  spi: nxp-fspi: add octo mode flag bit for octal support
  arm64: dts: lx2160a: update fspi node

Changes for v4:
- Rebase on top of v4.20-rc2.
- Modify octo entries enum value in spi.h.
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
 include/linux/spi/spi.h                           |  4 +++-
 8 files changed, 57 insertions(+), 8 deletions(-)

--=20
2.7.4

