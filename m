Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB390C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80FF20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="eaDYgebL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80FF20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404159AbeKVNmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:42:14 -0500
Received: from mail-eopbgr710079.outbound.protection.outlook.com ([40.107.71.79]:60732
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404090AbeKVNls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+M/B+x9j5azJ4WYGs7FYfu5TgAC0tC8cmwSKzlVtjOM=;
 b=eaDYgebLDbQBxU18LhGzLgNYCWI7ImLuvX2/pJProWXN51AH8tac2INdSsc+s4DHv42pWdN+16lUiTO+qK8V+3Y0JyXuXfLEN5GGUDTqS1BAMDreH1i9AgtinFesOdvIgusjpkp6ihX9N8ShMBDDH755WAjMAb2TVHOgv1f0AfE=
Received: from BN7PR07MB5298.namprd07.prod.outlook.com (20.176.177.92) by
 BN7PR07MB4260.namprd07.prod.outlook.com (52.135.243.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 03:04:27 +0000
Received: from BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::2c4f:febb:78f0:8747]) by BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::2c4f:febb:78f0:8747%3]) with mapi id 15.20.1339.026; Thu, 22 Nov 2018
 03:04:27 +0000
From:   "Kulkarni, Ganapatrao" <Ganapatrao.Kulkarni@cavium.com>
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        "Lomovtsev, Vadim" <Vadim.Lomovtsev@cavium.com>,
        Jan Glauber <Jan.Glauber@cavium.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: [PATCH v8 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
Thread-Topic: [PATCH v8 0/2] Add ThunderX2 SoC Performance Monitoring Unit
 driver
Thread-Index: AQHUghAU6wLhTw1iZ0G4pTMYoN/YFQ==
Date:   Thu, 22 Nov 2018 03:04:27 +0000
Message-ID: <20181122030354.13570-1-ganapatrao.kulkarni@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0103.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::19)
 To BN7PR07MB5298.namprd07.prod.outlook.com (2603:10b6:408:2d::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [111.93.218.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR07MB4260;6:kAAZUuR4Glz6GEzOhFkFPBmid2X7lDjYN7FUY6f4pIbkAz+R8bdsouIDaGt0Rf3FQNgvn3ooSNMiewJmnl6e9FdsBQMEbAOwB5bklomNJRsnbtXGmPJqcuyepDRfu9S1gT3+r8fmY59i7iY0V61Jr6JvOS5fMpAee59GlBgLmeSxmkcwm9/1eQcV6/GL5HkoTPKEmk3Y1RK5FXPlqFMyu7lQl4AtGzcDVq4Oj746PXpGEPCzj7U64IPpymryiifWFKMp9n/GhFsOt0P6Lk2ryIf7Cp8206B9HDwN83BqoEe/kjEekmoI+phTwwABoeUNkdWgZvtbLWnythIT3SpZSg37kzOEGmbnlC9WZSxlHjlFSj2yzN9s0GEw3B52sVeHJ07CmqiuNhyIjqiQyv3e+fbWjSbD3zcfZ0pGZ9PTtGCv7yKlU0WJ7VEz+dd1jQu18oRvQPCokNDCx04bHXGUcA==;5:39gXhlgJFfGz79R6wftXxwUDqYTI+VTPypexwxHLTXLm8HqCQ7ChB0hqkypQ1KHMIP95fhoO9oTs+8UxyTMKSgYJql+8DFj0EIg2zArG5pCxQX23NagyxWeceUWjB03Enl5s8tKR5hND+V4J3gtIQ7r1t8QdcfsimsJ7NiToImk=;7:lsXAj6qVCoM9NquvaMEE2/pUZyYm7BR5kK2CEZEJDPtwOjaWMSLQAv2Q71gU7JqLv4tqHYuLsPXadNZiXK54L4UThXvrEUdXg2eS51dkhpSdDwy+4QwWfPUYMAgP5/DdmRWsCP+3GB+Ws1HFrmDQ8Q==
x-ms-office365-filtering-correlation-id: adbb56c6-7af8-4df7-a3bb-08d65027366d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4260;
x-ms-traffictypediagnostic: BN7PR07MB4260:
x-microsoft-antispam-prvs: <BN7PR07MB42601FBDDA1CBD8A39E0F98983DB0@BN7PR07MB4260.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231442)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN7PR07MB4260;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4260;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(106356001)(6512007)(386003)(2906002)(102836004)(6506007)(105586002)(316002)(7736002)(36756003)(186003)(486006)(4326008)(2201001)(39060400002)(305945005)(86362001)(26005)(78486014)(25786009)(81156014)(81166006)(52116002)(99286004)(1076002)(6306002)(8936002)(53936002)(966005)(478600001)(66066001)(256004)(14444005)(6486002)(97736004)(68736007)(72206003)(476003)(2900100001)(2616005)(5660300001)(2501003)(14454004)(6436002)(3846002)(6116002)(110136005)(54906003)(71200400001)(8676002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4260;H:BN7PR07MB5298.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VIIFmuLGbeMVkMMuxxzsTdZl5FvsXVQWZdgqxOEStxYacgIfWL3zKJZzplPvdSNP+Q48JF7Ci+oO2jN8ijjkVlXL2WG9H9Q62SmyJVZ2J5LhFM7RZ6n/uAn/xjYyMnQbQXMByJrbRYHnqce8BWI8c81iaur6klPjz5jafDiCBx20GWXeyTzJDEBBXw9VSjAJLR/oPMwGSh/dmuQPVUzCb4oA/0eBbUv+LkyT10aNm9/CW6661X/b/jFNWutgwC0T8BaThMXjGuN7vT/W/xocYzOZqTKreb1mUBt1yuPxhMtjayYLgjwxFiwW8OpR6L5oAN/ZpOBNObvfr8EMbLDkASQVDgDdRUggvibKmfL5xvY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbb56c6-7af8-4df7-a3bb-08d65027366d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 03:04:27.3949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
The SoC has PMU support in L3 cache controller (L3C) and in the
DDR4 Memory Controller (DMC).

v8:
	Updated with Comments [4]

[4] https://lkml.org/lkml/2018/10/25/215

v7:
	Incorporated review comments [3].
	Modified driver as loadable module.
	Updated Documentation with Event description.
	Removed per-channel(no SMC calls) sampling implementation(
	Since DMC and L3C channels are interleave, we have decided to
	sample channel zero and prorate it to account for a Device).

[3] https://patchwork.kernel.org/patch/10479203/

v6:
	Rebased to 4.18-rc1
	Updated with comments from John Garry[3]

[3] https://lkml.org/lkml/2018/5/17/408

v5:
	Incorporated review comments from Mark Rutland[2]
v4:
	Incorporated review comments from Mark Rutland[1]

[1] https://www.spinics.net/lists/arm-kernel/msg588563.html
[2] https://lkml.org/lkml/2018/4/26/376

v3:
	Fixed warning reported by kbuild robot

v2:
	Rebased to 4.12-rc1
	Removed Arch VULCAN dependency.
	Update SMC call parameters as per latest firmware.

v1:
	Initial patch


Ganapatrao Kulkarni (2):
  perf, uncore: Adding documentation for ThunderX2 pmu uncore driver
  ThunderX2, perf : Add Cavium ThunderX2 SoC UNCORE PMU driver

 Documentation/perf/thunderx2-pmu.txt | 106 ++++
 drivers/perf/Kconfig                 |   9 +
 drivers/perf/Makefile                |   1 +
 drivers/perf/thunderx2_pmu.c         | 869 +++++++++++++++++++++++++++
 include/linux/cpuhotplug.h           |   1 +
 5 files changed, 986 insertions(+)
 create mode 100644 Documentation/perf/thunderx2-pmu.txt
 create mode 100644 drivers/perf/thunderx2_pmu.c

--=20
2.18.0

