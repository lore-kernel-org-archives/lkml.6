Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF72C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10634217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="TknBGKQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfBEPnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:43:10 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:50726 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbfBEPnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:43:10 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="27303245"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 08:43:08 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 08:43:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUWKtF+0GPBZRn6Ubu9Tg5xZg1//s3B9N//Q6/0gWQM=;
 b=TknBGKQ5sRih6l0vGdxwR1Js4KiyPrT6ZegGV1vo5sYrMevsKfbMMUE+TdsFMDJuZnufcAkIArSp/sR/Dvv2biATrYA8NDHoPpKU4U1qUsU60Z7Jhj64ZaaQ7rQsxtrwULms4esgP4u8r66TW0VVPKhMj+lknhGULUiC+w+Q6Cg=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB2019.namprd11.prod.outlook.com (10.173.27.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Tue, 5 Feb 2019 15:43:07 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 15:43:07 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v5 00/13] spi: atmel-quadspi: introduce sam9x60 qspi
 controller
Thread-Topic: [PATCH v5 00/13] spi: atmel-quadspi: introduce sam9x60 qspi
 controller
Thread-Index: AQHUvWl9wyILmolywkepVYs5liddgA==
Date:   Tue, 5 Feb 2019 15:43:07 +0000
Message-ID: <20190205154257.29529-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB2019;6:sTlJgRHcHug+dG/PEBGNS583i3sVSZsFm8JwBb27HATc3/CgtgFK/ZtuImNgljhB+EE1Pdks1fMCzXN9S+WZJ8yosH9RyHXYwfVjzbY+C3AdH6y9MojBoapLuygj9D4YuGMDC5TSyznzJ8/LPllDF4FzjWzbOjNWAdgBjQxLj0qITQ/7VZvJwCJL4zqPV0qusMpFWfy3EMLXsgkNeroL9a5283KMX8yMnz7LxhdTs04vmISZ1gsKTLQXAIrp3LBepZjs6FpDwCtfAOxrF0cblVrOlfQtSqHkPCwWN3UTWC5nZMea8/Nszs0oLx4t7VqfFNFnlGIAeqyVPrMziqXkcBsxII6QvR/5H/5huSAQhR+dALbeU87PDY+Je8MrDaUaQWCzS7Dvwsdn2+ZxOLeVzxeUnTaPPs7uZdJdK5WStzTXnY/gHIUCVoOnOCmr4krtLUFZdvvNSJ7RUBCsGVaCcQ==;5:gE2EWdIPG2jzmstDjt+VGx7/yjtPI7ssDYP+Rrq4M1YiNz3V6koZTd1x6ntcnd1VAxQ4erK2LOtFn4VbiEwUj/4HCKG3JlIbp78a3nreMrVu3ysvXd/EmrdLwu1eFelmJmvT31/68mRGCsg/s8TKuHbE7GsqpPyBaVAjW5ikY4vrOvvcxPPP39q9pZETdJQaWv/VDBFkv7oJbpAFZ0yQmA==;7:qA7O5whcJI0LVF/oWmXGpLajGNnYWGPF3qpxPQiqgepuZg17gdDTZEHN7DdG9nHWy7cKVD4RwcgATXBI47PLPPxhdfzxsDGEkuDqEWtEN+0sW2L7JPaF2cgzgV7kkfIYyid8HURDmjokGg3YUcvPfw==
x-ms-office365-filtering-correlation-id: fe554ff3-bf50-4534-0a55-08d68b809f71
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB2019;
x-ms-traffictypediagnostic: BN6PR11MB2019:
x-microsoft-antispam-prvs: <BN6PR11MB20191E2199FE7A06CE4571B7F06E0@BN6PR11MB2019.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(366004)(199004)(189003)(7416002)(72206003)(478600001)(8676002)(81166006)(71190400001)(71200400001)(256004)(14444005)(97736004)(305945005)(186003)(86362001)(6486002)(53936002)(52116002)(2501003)(8936002)(6512007)(6436002)(50226002)(110136005)(25786009)(1076003)(54906003)(68736007)(102836004)(6506007)(316002)(386003)(81156014)(105586002)(4326008)(106356001)(7736002)(486006)(6116002)(36756003)(3846002)(26005)(2906002)(476003)(14454004)(107886003)(66066001)(99286004)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB2019;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LUsEQ24w1b+Pq/g6h0RsfXovU0TcASZ9Js/S6HrI+QeZjo5Dx6OV1BTP/1MUpwURm1rY25sNuNNBxayHpczLAywN72nXfyAMxGY8IJAqjLIhwWtHaqXTdQ/E3q7Exq/l7JjTmwjD7ef9x1DHGudT3wu+W9kWAn90u4WUuJg1x6DBF0YdzLmVbdWgYUvjCjOCiDlQU81qB/BXA7zdJa2u8sfSyte63qhg0lnXmdbO6kOYtDO3eWYT3lrB+2TyPuGXxK+TV60XS7Ce/ygtvMUgE3fBwPdXPMac0lX3C8H/Vz+nZnv1XEAEwDKVfqOqqzY4tjwyLGPK0JUIo9+mPLgjUM87nAcYDdR+ezsyQMulJzxuXii6lEtTmvK91XRKudgB2S1Hn86oMJSN+t4/lUYvkLOLMjExHVAeOMjFWUm+A5M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe554ff3-bf50-4534-0a55-08d68b809f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:43:04.0322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2019
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

v5:
- use WICR for sam9x60
- remove ops hooks and introduce caps->has_ricr
- get rid of the cfg struct
- group IO accesses together in atmel_qspi_set_cfg()

v4:
- s/smm/mr, init controller in serial memory mode by default
- drop local variables that kept aq->regs and &pdev->dev, the compiler
  should be smart enough to store them in a register
- introduce QSPI_IFR_TFRTYP_MEM
- add comment saying QSPI_IFR_APBTFRTYP_READ is defined in sam9x60
- s/sama5d2_qspi_modes/atmel_qspi_modes, modes are the same both
  controllers
- fix kernel doc header
- move comment in function body
- collect R-b tags

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
  spi: atmel-quadspi: rework transfer macros
  dt-bindings: spi: atmel-quadspi: update example to new clock binding
  dt-bindings: spi: atmel-quadspi: make "pclk" mandatory
  spi: atmel-quadspi: add support for named peripheral clock
  dt-bindings: spi: atmel-quadspi: QuadSPI driver for Microchip SAM9X60
  spi: atmel-quadspi: add support for sam9x60 qspi controller

 .../devicetree/bindings/spi/atmel-quadspi.txt      |  12 +-
 drivers/spi/atmel-quadspi.c                        | 261 +++++++++++++----=
----
 2 files changed, 175 insertions(+), 98 deletions(-)

--=20
2.9.5

