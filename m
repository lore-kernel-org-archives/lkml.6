Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70682C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C05120821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="V2BvUpK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfBERdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:33:07 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:61915 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBERdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:33:07 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="23466280"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 10:33:06 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 10:33:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTqer/p01Qcl/l2aqwRseP0Rr+LSsp2kdn/8t3gKRmE=;
 b=V2BvUpK+1ooM0IQfhP9GHRY1Tb11iIgUOznzhjJnZfpNh2HDJcbyxYjH2zoZSXzECyE59O6KIcdMFUowR8YxrblqpIKsYr3hUFwwnaz6mk1DV6HW3+BqF9mIuuLsEUaHfbAiUgHJkI23+dBHjAudVD6MB3uqloCVHZy8o0AJ4V8=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1681.namprd11.prod.outlook.com (10.173.26.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 17:33:03 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 17:33:03 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v6 00/13] spi: atmel-quadspi: introduce sam9x60 qspi
 controller
Thread-Topic: [PATCH v6 00/13] spi: atmel-quadspi: introduce sam9x60 qspi
 controller
Thread-Index: AQHUvXjZDfiqbsVfBEmeDdSid1Uihw==
Date:   Tue, 5 Feb 2019 17:33:03 +0000
Message-ID: <20190205173254.16388-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0128.eurprd07.prod.outlook.com
 (2603:10a6:802:16::15) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1681;6:sNpmi7UHzfQy5Oao3TTpCh5J8OhgSMGD16+RU0EX+SEBy5AuYz9yVOH9yK/5g758f4D7YuQ1q3uucXP7JwUxwk6kf2BayeCr4azmYPIXvEU/IPqHBRxdGpv/l30FhNxVgVbJ/eyTkkDjlB9nqRODQDVedEAUj5dUuDEg8NzR3msGVECMD00vbOtovmA1zAW2BA6eb/SKktc/w8HAexgJhKnXoLWd47ghB+Cj+h3Gwd7RE0w8Z9kZp/3/YbdmBDDx2kvbYMZt/tJ3uHjTfvWE9ZbAoYx4OcabJpqYIILVPiZPQcOoM1vGXqDX5MdupOXGv/CmWqm2KYH/emRvGG02uZUEG0XnnU7P6A/5pdbmAANfRMoUKerWDFWu7gRR2kunzzEmzOmNi6HLGfkEOHzSc7TpTHRpx08w+K9ibeehxGZp1jJAmpwsQo43/tMVQYzczjkeILcWfX/xv35mwuekcA==;5:UVqBACtT4ja0Am9IHINu4eyAL81zCe8WmskdM5BxwHgVOkq8CL8F8LUO6bEnc7cT1c/2H8ykwjTussAaD7J3/EEQqy7rag3hTx/6ENUauNh6wURpmmalbRYro4F4bRHt+KHVSqoAtqouqhimKxe8elczpYR9qrznGb/zM+d/28yNpC5/hd1YS7dFE3Whl5cRr/BuXfmBQGwQaoxNSG/WKg==;7:TfR6t/DdPrP851jiupBH6kJ5qpXNh5AK7F+GNvOBFoW5E1skVlgiGYU7yULXIlGbqHRchxlvri2MT8SAZVuoXQFgUywvpAilij3hkid5TOq0ia/47xYpHA2lX+lkfzSq3NPhR4NHSVDCUAets+SMkw==
x-ms-office365-filtering-correlation-id: 5a2fc2c9-f24c-4a22-e74f-08d68b8ffb58
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1681;
x-ms-traffictypediagnostic: BN6PR11MB1681:
x-microsoft-antispam-prvs: <BN6PR11MB1681FBC4BC087977517FFDB3F06E0@BN6PR11MB1681.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(366004)(189003)(199004)(4326008)(186003)(1076003)(36756003)(26005)(110136005)(25786009)(6512007)(316002)(476003)(7416002)(54906003)(486006)(2616005)(86362001)(6486002)(6436002)(66066001)(478600001)(71200400001)(7736002)(97736004)(14454004)(71190400001)(14444005)(256004)(52116002)(3846002)(2501003)(305945005)(99286004)(6116002)(53936002)(72206003)(386003)(107886003)(8936002)(106356001)(81156014)(81166006)(105586002)(102836004)(50226002)(68736007)(6506007)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1681;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6nW60DvoU/I3XbVOp9qxMksFrdsCEyQb26C+7duc0NNbRBISRYxhLR3gKB3MqYwSlDhoa4qQvxaoa64NECvFhn5eBojFBRAf1qjM4BDRZWggFYntxFiReU8hbSegbmdehA7GR/lqoSP+3L54Bx66294ROphb9X8gmVNe6mr6R8NriDOSRBoHlWXQ7ZUtkhyMoTBd5vJEYCfcr53WsoIScRpQxEP7ejG/G5ybmS0omULvlGyi0ZjGKK5gHIkAiggZ7dn6/ZzvNW7jsvIP6QJu8vmZy6QOfN+q5iK4iRmw99uYdT1vpaRUpOTNZVDYlMCFBOIub9F09MzoEiZOHAWWvKry6RveWZqk1L3QQF20ECz3LoqP/FPH+dDEdPbxrAd7CtSd5GJEX5+WFg6I5CUXhJEZqKrTMkpwrZRfVusPUQA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2fc2c9-f24c-4a22-e74f-08d68b8ffb58
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 17:33:01.1527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1681
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

v6: patch 13/13: add a caps instance to the sama5d2 entry instead of
allowing caps to be NULL

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
 drivers/spi/atmel-quadspi.c                        | 270 +++++++++++++----=
----
 2 files changed, 184 insertions(+), 98 deletions(-)

--=20
2.9.5

