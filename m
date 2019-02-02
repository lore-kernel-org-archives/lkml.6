Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD75C4151A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BB321479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="IikPHFbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfBBEHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:07:15 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:25474 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfBBEHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 23:07:14 -0500
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; 
   d="scan'208";a="25777616"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Feb 2019 21:07:13 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 21:07:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+K4qrmUG13QF8xawF1typSHjAy3QdbYQsMd+k3rAD9c=;
 b=IikPHFbh8Y+cVEJhvxzUjGjKvt6rEaa7JlRxHVUieJptM/pBpRy5fT16dbkyOqg8ltM1dfktLy7DvAJE18JtWDtU6ddlxzzIeaRkLA4NOK4Msx48SnzJ62v1KcC1gM0/ZG3rmPwNlyMUpZ8bcfl8LG2LE8hdYdQab6fYydhJ+vk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1300.namprd11.prod.outlook.com (10.173.26.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 04:07:11 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 04:07:10 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 00/13] spi: atmel-quadspi: introduce sam9x60 qspi
 controller
Thread-Topic: [PATCH v3 00/13] spi: atmel-quadspi: introduce sam9x60 qspi
 controller
Thread-Index: AQHUuqzF5TXyT2EVDU+lmQWhqx0xYg==
Date:   Sat, 2 Feb 2019 04:07:10 +0000
Message-ID: <20190202040653.1217-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0062.eurprd09.prod.outlook.com
 (2603:10a6:802:28::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1300;6:9J8lUHzCzmLFF3pz6NoouT0jz9vPk0ekTRx8+yIMiphWS8Ubb0wffY+EU8zgHX6N3lDbtqQ37oo3G4RDsLNq8qkJ/CriwG4PGZrom0fC92LvtxTLD3TsC7+U3McH9alcM1gEWom77Bqo8NphD7LG2F/B8Ioy60hiTBo5VMmxdLd8fce9KaN7ey4bW2qkSfms8GJjUhssGBUCFWFl37UwPk3gqBG8ENtwrkI643QMezz2lehORji+gxnNGN8Q4gra4jZcMYxvNe/2LgfsG9wcgiwqv8Z6WC+RfszGHhpTSvznrN8R4Xk4IUvJuvNUpuHqgWFcJ3haphc9gzJIcuDBjLZfh1zE1khXe1P5LlxFY7oUPqPidpvGCuuCQDc529ZTeA/9xuHuYMScp/oy3hofoD1d3xPYnw02AMdU8kL3+o2Uyu3OA0YfsW/9q2hrd+Rdmx+lbi7B+1jSUDHnnOf6Fg==;5:PRWxzhOxbpo69AgTN/3Ix+qSMJ0XOD8kyamuhW7Yhf58ayISfA8+g3sXVLQ3RP+fdPwJ8gxMFygxy1PeZseDgSCDG93Ju/4zuDzlKhKo+1KT26cp0xeQl2eYtYE7NDqNgC75EiN7lFxIQwgpP+LeOIgm16M8p7+yXLwJS8rUDO24WufI1OFZlF7cIbPVqzPKx/r/TPD1Xn506V8EnE27xw==;7:mnQDyrSEFsBUyC70iprPkl31ZJbJP+MnxIvlK5r6NRNqH6TrtA9f15GjEaNK8o49qpdJHEtfDTxs87kUHgF5XSVUpAmUg4q1V0IzdHNiFrvwfw75m/j6cUmux107UyIEhiU+1cXx9Wl6DLBcty5v2A==
x-ms-office365-filtering-correlation-id: 09c945a9-45a2-401e-274e-08d688c3e751
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1300;
x-ms-traffictypediagnostic: BN6PR11MB1300:
x-microsoft-antispam-prvs: <BN6PR11MB130093E76ECFC64C9B8C7DA6F0930@BN6PR11MB1300.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(14454004)(52116002)(50226002)(105586002)(6436002)(102836004)(72206003)(81156014)(81166006)(2906002)(26005)(7736002)(478600001)(3846002)(6116002)(53936002)(256004)(14444005)(106356001)(8936002)(68736007)(36756003)(97736004)(107886003)(4326008)(39060400002)(2616005)(99286004)(476003)(86362001)(66066001)(71200400001)(7416002)(71190400001)(6486002)(6512007)(316002)(110136005)(1076003)(305945005)(186003)(8676002)(2501003)(25786009)(486006)(54906003)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1300;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: coIbVsbgwFz7sAu3g4KopIkgmc2XLh47L7c86C73V41PGqM/luOXE/98vW0YcCxBwfvdLeKPfsSeWTSujNwhCFAKJHmq9+txVq3eKP9KroJ+mBnvLe0vxBiLqHPSzEvg+owsuhb6y+q3exfRuWl3iWw6MnmC3q0gF03DY8Mc89GYrqR87RtpDSMNwJTxYdUPW9VpJ8jzozRpj+twiikPnapcwFdRGIvtpGPddLZbrYbgg7burIzRoC2Yk/wOoM6shk4xdy/Hc7ZQb1Sob3D/EvfvZc0Y2pnTgu8651/3Dlp+D4YnXjDloqBTTv/5Wo2HSbEU/poH38MUMFzHOBJQw4XHHsCL3v8wpPYUSmOWyZGqXG41RWY+uAF+OY5Oc5xUtFZhx5et4E1KqLH9fuzdOLV1I9smGfGE5aGRIYSqNKA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c945a9-45a2-401e-274e-08d688c3e751
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 04:07:07.9862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1300
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Patches from 1 to 11 are minor fixes or cosmetics.
Patches 12 and 13 introduce the sam9x60 qspi controller.

sam9x60 qspi controller tested with sst26vf064b jedec,spi-nor flash.
Backward compatibility test done on sama5d2 qspi controller and
mx25l25635e jedec,spi-nor flash.

The patches are generated on top of for-next branch.

v3:
- update smm value when different.
- treat just regular spi transfers when introducing sam9x60 qspi IP.
  Mem transfers will be added together with dirmap support.
- reorganize the code and change ops functions pointers to avoid code
  duplication.
- rename aq->clk to aq->pclk to indicate that it's a peripheral clock.
- drop unused and NOP transfer macros.
- add Suggested-by tags, reword some commits.

v2:
- cache MR value,
- drop iomem wrappers,
- make "pclk" clock-name mandatory even for sama5d2,
- rework clock handling,
- reorder setting of register values in set_cfg() calls,
- collect R-b tags.

Tudor Ambarus (13):
  spi: atmel-quadspi: cache MR value to avoid a write access
  spi: atmel-quadspi: order header files inclusion alphabetically
  spi: atmel-quadspi: drop wrappers for iomem accesses
  spi: atmel-quadspi: fix naming scheme
  spi: atmel-quadspi: remove unnecessary cast
  spi: atmel-quadspi: return appropriate error code
  spi: atmel-quadspi: switch to SPDX license identifiers
  spi: atmel-quadspi: drop unused and NOP transfer macros
  dt-bindings: spi: atmel-quadspi: update example to new clock binding
  dt-bindings: spi: atmel-quadspi: make "pclk" mandatory
  spi: atmel-quadspi: add support for named peripheral clock
  dt-bindings: spi: atmel-quadspi: QuadSPI driver for Microchip SAM9X60
  spi: atmel-quadspi: add support for sam9x60 qspi controller

 .../devicetree/bindings/spi/atmel-quadspi.txt      |  12 +-
 drivers/spi/atmel-quadspi.c                        | 402 ++++++++++++++---=
----
 2 files changed, 288 insertions(+), 126 deletions(-)

--=20
2.9.5

