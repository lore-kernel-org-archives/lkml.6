Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BD2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50262085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="1wNuWmOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388210AbfAaQP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:15:29 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:38337 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbfAaQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:15:28 -0500
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="23261553"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 31 Jan 2019 09:15:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:15:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe7RdTgelTscr8BGRznFJAPsc8DSTSeupFpv7obvyfg=;
 b=1wNuWmOf/u/YUirEJDNTkoYD44JDCWLO9S7Yq3g+W8XI7+RPRPDXPAIN5X+ZH0F6QVaVGmAxFThqQwEin7CsWrW6zWzWhoUfVT/19BYGuNupzxg1FdkrMhcslgqT67ZVoLvmcfdLipB7ILz7FFw4knD0M3klTL6jZuJpW5yYK+k=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1874.namprd11.prod.outlook.com (10.175.101.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 16:15:25 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:15:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 00/10] spi: atmel-quadspi: introduce sam9x60 qspi
 controller
Thread-Topic: [PATCH v2 00/10] spi: atmel-quadspi: introduce sam9x60 qspi
 controller
Thread-Index: AQHUuYAsoRWfA19y0k+PIqbEPZTkig==
Date:   Thu, 31 Jan 2019 16:15:25 +0000
Message-ID: <20190131161515.21605-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0046.eurprd02.prod.outlook.com
 (2603:10a6:802:14::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1874;6:rFZFfIn7M/z0Z1xHMFAz5R7jUBIOaDqPZtp+KsyodoDJDSIM3prTX0YFSHCvTVElcNRKxTB8qnzXoXsQGOOYqjXBlsx587WieqrRhE9BjtuUDhHAgzyuoaELNdwgm5t8d74PquKW3MV+3caeeg190jeUkU5xp+hPdVmm6tw/kmnAcwg5CrgMuAoiIQZ2gxHFuJZP0kwwnqyT3TRTSIqpj97V5gW0XXmCYCdQv0zJs1Vn/1t3ua70w9L+tRQfcSW+BUwM/JhMYRij1TQE/yMVsW3i0TO+c0TuciRN3koOGjwAjSL/AlzFOQpNu7HwC2F7GDdljPua22PDP5+RQyvoFT32eLjmzP7MREJ0P1LJ7n+DdVoFhO1kiDJkp5DbpdAnvfS2a9v3fQu1wvB8sC5mrsiDoN0aR3mjwheOXRdBXMm4MlyjvI1eHhZURcBpJifFe0sShraoz/a/rO5vOM9kCA==;5:Ynwy1Gg5UgHMUEkitaBmeXAx7b+McMPQkoId1dUpEu2h6FAQdH+PAPJS5Z+7Mu2nGCS0anTH/f8QXEmOteqC+lT+ndEmAbIETBt8xqy5tRSIdoWsoUKQT6oZtw7tVq/73VMhIqZpPow1cRoEPkuC82BR3QZEFVvYS8m+lroc0ZQgl4vz3iXnJomoYC86qeEP9XakALsG8PZXaKYdk/BsFQ==;7:PfEpZo6tZLJBuzjUCObF/G/LdH80sdt6/4PsgM5pigQtdkFRUTiLOjgsxhgLiqoj5Db48kquIKOmNUsBYpMCcNUttOcej2xxCak2/HBJAvms41R0caej3y8ta31nOL1/XBrKB6dQ8nIXHX+ofRbIsw==
x-ms-office365-filtering-correlation-id: 85b4ef26-e83a-4d62-5307-08d687974ee6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1874;
x-ms-traffictypediagnostic: BN6PR11MB1874:
x-microsoft-antispam-prvs: <BN6PR11MB18743F10068DDF9B74451CF1F0910@BN6PR11MB1874.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(366004)(189003)(199004)(186003)(107886003)(26005)(4326008)(68736007)(97736004)(14444005)(72206003)(478600001)(256004)(106356001)(105586002)(36756003)(99286004)(54906003)(50226002)(8936002)(7416002)(6116002)(3846002)(7736002)(8676002)(81156014)(81166006)(71200400001)(71190400001)(52116002)(2906002)(1076003)(305945005)(2501003)(14454004)(102836004)(6436002)(66066001)(25786009)(476003)(486006)(2616005)(110136005)(316002)(86362001)(53936002)(6486002)(6506007)(386003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1874;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 537jdphST5CvUVGciRZt09JduGoS4tVfXmmKVLmNp8XuGIlBNCXdA7602OHdt9iXVDCYX/Cmus1MmRrShztv7bD4R1JK97tzWghqDMpnz1NqwaB6R7zv9Qmo8mib35Ij9MKy8CkvZ3jp28pQsjJtXwkH26Z020KERDir+R1H4JqPrAkKhvFAgmUTpK2tOhxdG/85peYmCdqRch4txJvKtNdYd8NLC5znzizmWnrG+62JobkU+Vug9v0zhG5I7OPrsCauVJXSo+Z/xsqu1awpcpLERH/vLdhrn3zRTQ5JXNUy77PjGvlVNSQVHvywogJ/Z3srfUvQECQ0SqXWi3PbYwWWdzFdlY5b/qaGeZgzHPL4YiyEt4I772E0JpiP6evSYPlRsavanGnnLkoRgige+TouvxyRznfrJeQSD+80YSs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b4ef26-e83a-4d62-5307-08d687974ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:15:22.9472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1874
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Patches from 1 to 8 are minor fixes or cosmetics.
Patches 9 and 10 introduce the sam9x60 qspi controller.

sam9x60 qspi controller tested with sst26vf064b jedec,spi-nor flash.
Backward compatibility test done on sama5d2 qspi controller and
mx25l25635e jedec,spi-nor flash.

The patches are generated on top of for-next branch.

v2:
- cache MR value,
- drop iomem wrappers,
- make "pclk" clock-name mandatory even for sama5d2,
- rework clock handling,
- reorder setting of register values in set_cfg() calls,
- collect R-b tags.

Tudor Ambarus (10):
  spi: atmel-quadspi: cache MR value to avoid a write access
  spi: atmel-quadspi: order header files inclusion alphabetically
  spi: atmel-quadspi: drop wrappers for iomem accesses
  spi: atmel-quadspi: fix naming scheme
  spi: atmel-quadspi: remove unnecessary cast
  spi: atmel-quadspi: return appropriate error code
  spi: atmel-quadspi: switch to SPDX license identifiers
  dt-bindings: spi: atmel-quadspi: update example to new clock binding
  dt-bindings: spi: atmel-quadspi: QuadSPI driver for Microchip SAM9X60
  spi: atmel-quadspi: add support for sam9x60 qspi controller

 .../devicetree/bindings/spi/atmel-quadspi.txt      |  14 +-
 drivers/spi/atmel-quadspi.c                        | 374 +++++++++++++++--=
----
 2 files changed, 281 insertions(+), 107 deletions(-)

--=20
2.9.5

