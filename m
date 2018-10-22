Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EA0C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1724A20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wfm/UrE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1724A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeJVUCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:02:01 -0400
Received: from mail-db5eur01on0046.outbound.protection.outlook.com ([104.47.2.46]:1655
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728428AbeJVUCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EszMfh6JYSb0VK2sBWhSK7J551nJ/yc7m/urVwuWSbI=;
 b=Wfm/UrE/UwN1ovLFgCsY/528XvbA1bwZa8L3Mi/BNoLcHDvSviq073KG7NsvSts+icmD5W5926tg/biOrQIujf1VHo+A9bHjykRfn3K8SVcL+0qk9yW/B+URViZDA5qQZytgkzT9YmGyl7cGC+WU21oZ68v+qJzTQtUBPnBqb94=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4974.eurprd04.prod.outlook.com (20.177.49.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Mon, 22 Oct 2018 11:43:41 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Mon, 22 Oct 2018
 11:43:40 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Topic: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUYVGd5DVkmoaJwk6a/YXF+Itp3qUrNb6g
Date:   Mon, 22 Oct 2018 11:43:40 +0000
Message-ID: <VI1PR04MB1038034CFABEE936C6892D7D99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4974;6:ws6FibhbMwSIHhnXwc066j4NM5HsPLi5c+HWG/ez26SDb3re3EV3XI0XgQ62lsGguciYZj9UxjCNYc84+eW6htL8I8uWWQhQcVqxdfX9f2fqYn6393xinpPJrNLsoYHYeSUrMmW877uiXyfe+0ZevipoUqBFimJP0urCRKaQoaWvSL8uggPO2hSr9b3a6EAlfpR+gVKqviMrfysLyRaoEY33pxZyM8euRPLiETrKN/yGyci9S7xIii9s11EcHls5HihWgS2EVhAg4x9fL+DGmLs5EeNcZZhxpYFMmiH1Ze1yTgw6Mm2ftfeVUKTn6Do3JFB1GIsKv9FFN4/ZSLxc1DSWo7tOOARv5LXAVkp5FmPBYC+FYyIT5ygPymNUWn9BGLtnr49MUQEpK1UNd+HVfowJI5yktB7F8RyeyuwiL/Ls/GtHJKFtsk6RKy5JSc6Xhnoe8HLmwhQN9oCYZI1ezw==;5:AT4R5Tljrb+HiQuCHrfvZcsdCFWWtQqoGXzQeJfMX1mXbqRbA4T6sBqHf3Pwpl6pWAQj0n7IQUxWrMdjb7KbWJVZsoOJ+c0Tgj4/0elrZ+Hj06dwGJNOkpY4Dm+hbnlLspChwxzESN9YJoSWrTPceLgggp2OoWqEGFfD0Kin5xU=;7:gP2TRDnVG+uujJ85Y7UwLzLOo8JJb+Vxp2i4z0EacNniumoJ6FiM473H+SXWFnPgP/uNWl5ksHPjwqH3UrmTfMlxiLBlT4MMUSDepkEfGDumDNxB4mqrgCWd3ADznte65LP9TpXo3UOG27t2We4r/KJ8nHzLtsrmOhmb66ittNeAX3oG04px4AOdAqlruU+otC5BXwtI+p/sJ4ulKc12hCIvU2c9o9hyXNRM8NSVv4ZGwxUNU22Anga4/u6xdENO
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: efb08add-33b9-42d4-8fbb-08d638139d0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4974;
x-ms-traffictypediagnostic: VI1PR04MB4974:
x-microsoft-antispam-prvs: <VI1PR04MB49744F2488587BB6F25829F799F40@VI1PR04MB4974.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(258649278758335)(85827821059158)(9452136761055)(180628864354917)(264314650089876);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4974;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4974;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(13464003)(4326008)(99286004)(110136005)(6306002)(6506007)(53546011)(3846002)(2900100001)(476003)(2906002)(11346002)(66066001)(55236004)(102836004)(446003)(105586002)(55016002)(106356001)(8936002)(6436002)(486006)(25786009)(54906003)(26005)(39060400002)(76176011)(81166006)(256004)(186003)(81156014)(53936002)(7736002)(6246003)(86362001)(14454004)(229853002)(8676002)(74316002)(68736007)(316002)(966005)(33656002)(2201001)(305945005)(7696005)(71200400001)(71190400001)(478600001)(2501003)(9686003)(5660300001)(5250100002)(7416002)(97736004)(6116002)(78486010);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4974;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lNkNDIjHCPl58VttcEEfJgchP2M4zwLLsO1i2nrFCOJCLI8PgNlEeWh6i+6n1lhPueTTAjbxKhjVzpp96t0kmL8AjCHfYGEqZDu/3UkdSkL26isvNQ39r1zpZd+2Z5l3/T6vDBJBRFFIEHale97zkiwvXBOdbpk00okmSlDvJGHYtIeCqMKE1bY1xPpY03xN7S6abHEHH9O44um83RBBFmLwO7PkQJ8ALuQ3/DSTAO3dyrzKhZWe0ZD98e15pgMXPIxKwVZk4LkN/Nrg8FxX3RCMoIFKUiSkWPAzBUAEG6cez8RjPRejY+0PUqjVs1vfsPy59DyJnEU+w7ne81GTGeRtQ2DBpyc7lMItEYOFZk0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb08add-33b9-42d4-8fbb-08d638139d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 11:43:40.7848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4974
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Mark Brown

Complete patch series[1]
[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D70210

--
Regards,
Yogesh Gaur

> -----Original Message-----
> From: Yogesh Narayan Gaur [mailto:yogeshnarayan.gaur@nxp.com]
> Sent: Thursday, October 11, 2018 4:30 PM
> To: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com;
> marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org
> Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; linux-
> arm-kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org; Yogesh Narayan
> Gaur <yogeshnarayan.gaur@nxp.com>
> Subject: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI controll=
er
>=20
> - Add driver for NXP FlexSPI host controller
>=20
>  FlexSPI is a flexsible SPI host controller [1], Chapter 30 page 1475,  w=
hich
> supports two SPI channels and up to 4 external devices.
>  Each channel supports Single/Dual/Quad/Octal mode data transfer (1/2/4/8
> bidirectional data lines)  i.e. FlexSPI acts as an interface to external =
devices,
> maximum 4, each with up to 8  bidirectional data lines.
>=20
> - Tested this driver with mtd_debug(Erase/Write/Read) utility and JFFS2
> filesystem mounting and booting on NXP LX2160ARDB[2] and LX2160AQDS
> targets.
>  LX2160ARDB is having two NOR slave device connected on single bus A  i.e=
. A0
> and A1 (CS0 and CS1).
>  LX2160AQDS is having two NOR slave device connected on separate buses  o=
ne
> flash on A0 and second on B1 i.e. (CS0 and CS3).
>  Verified this driver on following SPI NOR flashes:
>    Micron, mt35xu512aba[3], [Read - 1 bit mode]
>    Cypress, s25fl512s, [Read - 1/2/4 bit mode]
>=20
> [1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf
> [2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=3D=
26689
> [3] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D70179
>=20
> Yogesh Gaur (5):
>   spi: spi-mem: Add driver for NXP FlexSPI controller
>   dt-bindings: spi: add binding file for NXP FlexSPI controller
>   arm64: dts: lx2160a: add FlexSPI node property
>   arm64: defconfig: enable NXP FlexSPI driver
>   MAINTAINERS: add maintainers for the NXP FlexSPI driver
>=20
> Changes for v4:
> - Incorporated review comments for
>   patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> - Incorporated binding file review comments.
> Changes for v3:
> - Incorporated review comments for
>   patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> Changes for v2:
> - Incorporated Boris review comments and drop below patches as per the
> comments.
>  - Patch 'spi: add slave device size in spi_device struct'
>  - Patch 'spi: add flags for octal I/O data transfer'
> - Incorporated DTS and Binding file review comments of Shawn Guo and Rob
> Herring.
>=20
>  .../devicetree/bindings/spi/spi-nxp-fspi.txt       |   39 +
>  MAINTAINERS                                        |    6 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  |   22 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   12 +
>  arch/arm64/configs/defconfig                       |    1 +
>  drivers/spi/Kconfig                                |   10 +
>  drivers/spi/Makefile                               |    1 +
>  drivers/spi/spi-nxp-fspi.c                         | 1158 ++++++++++++++=
++++++
>  8 files changed, 1249 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.tx=
t
>  create mode 100644 drivers/spi/spi-nxp-fspi.c
>=20
> --
> 2.7.4

