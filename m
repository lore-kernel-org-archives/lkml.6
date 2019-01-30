Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CF1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165A720989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="b7a4LgX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfA3PIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:08:32 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:13626 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfA3PIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:08:31 -0500
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="27058550"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jan 2019 08:08:31 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 30 Jan 2019 08:08:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpXbS9OZRX3oWgUoUuC0hMNL2D8csIhtfbn1sFcKWgQ=;
 b=b7a4LgX3NracZaDFYQvG5I9K0t7xh/xC0xx3lvVRT1+vyOX1WaCadrMZS2cNgu1+uyB4YkXw/uau2n6E6u4DVkmMKK5GZ1wrZOW2Khpx3T6bLRZHLk1lSNpXLvZEHrV5O6vE0SXC+I+kHSk+qIvnriaj/TJfMBiYuhwvybKMcIY=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1796.namprd11.prod.outlook.com (10.175.99.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Wed, 30 Jan 2019 15:08:27 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:08:27 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 0/9] spi: atmel-quadspi: introduce sam9x60 qspi contoller
Thread-Topic: [PATCH 0/9] spi: atmel-quadspi: introduce sam9x60 qspi contoller
Thread-Index: AQHUuK2nvvFYiCpvqUCIN9CcSw7iEg==
Date:   Wed, 30 Jan 2019 15:08:27 +0000
Message-ID: <20190130150818.24902-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::32) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1796;6:TDMbpK3ecsZXTP5hcI3mXxmDniV3YMdSwgCG3Zn03XmRGVUl4OJHn/StKGk/lxFcAN/vc9aiACRnPqd6+AQXMCna2gC/0zw07X/Qcvpjd0S/E2EWUKAN6a0tSWE/+v/B7b//3jXkhvgk4StaiasJOQ65NG23t72FBSwOAiuuJCuBmdNHwUyIZD2O7u0jWKRYZ742WrgJdfl7Ro/6x8TPDGZdn7/aJX0Cb7fGjv7sEd+OEczmCH2BXTZnq9xtMSoDftGoPNwfQz38YUX5jmWkjyWtsruaHbErLsbKXsmWvAFmEkSU3drENxFOH76G06Evj8/zeFE3i4pX4MqA9Wqk5DQ9jlhS/tDTLNgnYwD01c+rxa/YAftYm01ES2YydH8Dh852kiVDJwVXLBk1kbYFlPZrbLFvbInCBiPKplnGDe1vtYnSXX1UcUaVQNZOWH/mQcAxbFzyxAbvefbbj2d0YA==;5:j5HEPE2wHzoXRXS8qrrXZrdHe5hy+MxHgl63WOy5dLr8jYUgGo70hhHMq3hOTqlTAFy+IQb/HIRNjkNISBtroRW3BtebgmHykiBZE3kRFhu8daztt7fEJS2ghxFm4OlYZx5EsEPVrRCm39FFwa5Cqixx5Q+Nemy9eCmxPOt8TrBSKEtvxVRpNxwIRPhHI8Kk0FG5MHEp+ki7kMAAQd1sQQ==;7:A8jcXRJgl4q96tRT1C5Ok/wmALfyyJ1Yb8sg6va8htmG8yrVx9RTDjBR+a/gJd+yJJSS4oTtbBayuFrCXJRpuvV4KNPRlYTf9JCmls6z0IZYr0AXFl1Kvvf+2Zq48fxW9CuSYmb3kNFd5IRmxObHQQ==
x-ms-office365-filtering-correlation-id: 4f585e8c-6eb1-4a2e-8dcd-08d686c4c949
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1796;
x-ms-traffictypediagnostic: BN6PR11MB1796:
x-microsoft-antispam-prvs: <BN6PR11MB17965591C0733DFF281730B5F0900@BN6PR11MB1796.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(386003)(316002)(81156014)(2501003)(72206003)(81166006)(486006)(14454004)(476003)(110136005)(1076003)(8936002)(6116002)(4326008)(50226002)(52116002)(6506007)(2616005)(36756003)(3846002)(68736007)(6486002)(6436002)(53936002)(8676002)(54906003)(66066001)(6512007)(478600001)(99286004)(186003)(71200400001)(97736004)(86362001)(2906002)(256004)(71190400001)(14444005)(305945005)(6636002)(102836004)(105586002)(25786009)(7736002)(26005)(106356001)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1796;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dxhKBzKH3aEVidoszXmiLZ1IwuQwKyMHXkAdScoufvxVK7TsXqFRg5eAL5IQpU8RSx55mtEK9lF0ZMKzJHAEpCdNl3c3L/Jz6ARRcA37VQNqLxiwdkJT9e+jvznzMctjWef3QC2yMViW+VUK/VljDCI8uEmwRH6LbETiehv/MEJaNRgBNcCSxZOuhK7uLCCFBfIxGrTA0nkqBz6S2QllicOnTSyphWMzaLsFh7H+oqungiw2+xyg3zUsWzZAW0ST7Y8u5ksra/cnQSV9CySZ6mMneP4mYAr6IQ0/DVCJFmXXQ29n2jktqXH8eg6nbnGuTmq9/s1hkygPo0s8IC8hYhkz8wL/+J3KBYauXJ2kYmY3ZZobHsFYNORzYS0uz73sCQ2UlUU2HqKquseP+uLx38DQ8eYabBGBUZwPpD2HQws=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f585e8c-6eb1-4a2e-8dcd-08d686c4c949
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:08:25.4265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1796
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Patches from 1 to 7 are minor fixes or cosmetics.
Patches 8 and 9 introduce the sam9x60 qspi controller.

sam9x60 qspi controller tested with sst26vf064b jedec,spi-nor flash.
Backward compatibility test done on sama5d2 qspi controller and
mx25l25635e jedec,spi-nor flash.

The patches are generated on top of for-next branch.

Tudor Ambarus (9):
  spi: atmel-quadspi: optimize qspi init
  spi: atmel-quadspi: order header files inclusion alphabetically
  spi: atmel-quadspi: fix naming scheme
  spi: atmel-quadspi: remove unnecessary cast
  spi: atmel-quadspi: return appropriate error code
  spi: atmel-quadspi: switch to SPDX license identifiers
  dt-bindings: spi: atmel-quadspi: update example to new clock binding
  dt-bindings: spi: atmel-quadspi: QuadSPI driver for Microchip SAM9X60
  spi: atmel-quadspi: add support for sam9x60 qspi controller

 .../devicetree/bindings/spi/atmel-quadspi.txt      |  30 +-
 drivers/spi/atmel-quadspi.c                        | 406 ++++++++++++++++-=
----
 2 files changed, 336 insertions(+), 100 deletions(-)

--=20
2.9.5

