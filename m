Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B69FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD3720831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="AbVKn9nX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD3720831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJYOab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:30:31 -0400
Received: from mail-by2nam03on0084.outbound.protection.outlook.com ([104.47.42.84]:61024
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726973AbeJYOab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nx9zFhIW0SHHTyFWFMqYVorpuP1P34Rt58QBznPDr6U=;
 b=AbVKn9nXL/MppTXG8CtfDHGx7ve6XsdcLLgnp/sSgfbWpiPu3LAYNzV1E656aE+UIVxbFuf4w5IadFO1EgbrhyqJKJ/dwIRiS5YA9qbavnlYDNa2B2oh8w7AR8uc+QWx31PVRoDna6z/d4e0GJ6Xa1NiSxiZwehILZoUfPYlecs=
Received: from BN7PR07MB5298.namprd07.prod.outlook.com (20.176.177.92) by
 BN7PR07MB4626.namprd07.prod.outlook.com (52.135.249.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 05:59:16 +0000
Received: from BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::c8bd:3664:252e:316e]) by BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::c8bd:3664:252e:316e%3]) with mapi id 15.20.1273.019; Thu, 25 Oct 2018
 05:59:16 +0000
From:   "Kulkarni, Ganapatrao" <Ganapatrao.Kulkarni@cavium.com>
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        "Lomovtsev, Vadim" <Vadim.Lomovtsev@cavium.com>,
        Jan Glauber <Jan.Glauber@cavium.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: [PATCH v7 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
Thread-Topic: [PATCH v7 0/2] Add ThunderX2 SoC Performance Monitoring Unit
 driver
Thread-Index: AQHUbCfcnEzJAObRSEKFUSz45Gi1Og==
Date:   Thu, 25 Oct 2018 05:59:15 +0000
Message-ID: <20181025055833.28471-1-ganapatrao.kulkarni@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::26) To BN7PR07MB5298.namprd07.prod.outlook.com
 (2603:10b6:408:2d::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [111.93.218.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR07MB4626;6:Cr0/vc8AK+3qKEoJEaf3XYYAO2qafPRAXWXI/dShtOgn0mJXOJNO3slGS8CPqcvW+3NAHrDqm2mx6qCKfinikS9s9mJLjVeU4k3mlrGH/hxkCZ0P2IKKZWDTYa+GytlQnov4gb7wPY8s8LunUJJVKrVHgN4CM1r9atM789qjIVBdWitd0lHL6P+UrALqrhqc8rdeYboorePaNij8FSymjoRUuEAvcclT4FoBVWYQv/iH8KWYflDRrJbBbpDcyPBaW2o96l1oQ3bUY3C/ytsu+ACBy0wzONfpjff6d9QmHbLI2pY0qrVHHESnZgMQLU3dgtN1c9tGIFP1YybtWlpiS07/YfHDQ/sMq3+qa+vsE6BX2Cu5GMIHAYduvTHqgisO09M0oDajkXaIDBdZOAycOouv6H2qnYsHhhZ4p365Yfs3+pQK7EC9cYgtInT03FAl3APylqLUJFr7n35ZHb9onA==;5:4hR1kQ+pBUY/Ym1rZglmiDZWQjKgcAbV0cRKugZ1UDscyoC7XcWJO8D/8QvqGBLRcnq7HRYhqzuZZ3+mnqwXVRxEDW5v5TBZ0z+YFlokG89xQ6cRH7AYB3W0mgsS1F+MLIh85aK/OqkcHjqF/rNwXm/PLGDw8YeJGKu98kp15aI=;7:weFeup3kAmfAd0/hSHitw+c0esYvFZE+yfHvzZgaqxDxUtg3GTtfiZ0Qf6JtUHxuRwoRPoWr5kTMAoawHzWwTRK1wyw37z43NqgbvYYK59z0hX1XImjwQ9nl6Ai1qNiddPfufKkp8w3YslyMPIjxiGDZtk/LgiJSQdMugDCiciMNXvQLmpTqLipg0xyK2yspD1EhSZBLBwMLg7oB2J8vHk6yS8YGZk8y9mcB/9gsgUiz+pIzf8HHuDEkkPc30rjS
x-ms-office365-filtering-correlation-id: 0a10562c-9f71-429f-392d-08d63a3efdfe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4626;
x-ms-traffictypediagnostic: BN7PR07MB4626:
x-microsoft-antispam-prvs: <BN7PR07MB4626A0EB4888C956712080B783F70@BN7PR07MB4626.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN7PR07MB4626;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4626;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(186003)(71200400001)(3846002)(256004)(305945005)(106356001)(2900100001)(26005)(1076002)(97736004)(8676002)(4326008)(14444005)(6506007)(386003)(53936002)(36756003)(6486002)(25786009)(6116002)(81166006)(81156014)(6436002)(316002)(52116002)(2501003)(105586002)(5250100002)(478600001)(39060400002)(7736002)(71190400001)(66066001)(476003)(99286004)(2616005)(86362001)(72206003)(486006)(5660300001)(2906002)(966005)(6306002)(6512007)(8936002)(102836004)(110136005)(68736007)(14454004)(2201001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4626;H:BN7PR07MB5298.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NL7ynFdP78QvBbjApTxdEZwrldXK4JTU3hCv5Aq0wwy2JviXiblAJUG5yoluaAi7bUqwQYJqtkQK+TYRA3rM5VpWKI/b4CJyV4t8SBfHnyKMJPQC8IaBCd4IZhlk6bHVEbsWhg4Eup1kABw5mc2GnFalQaWHi13kCTjTvst1g5Lcz5EbQOC0qAAV5PFfYBlEW5g4qOGTD4V5Plpva4GRlJg5zNzml9sh1ff0dzG6VaYKxUyagugqIaxxLeee9jBhYJRGOb1YsTCAWo9G5JAr2/cuVpYec6SdokLLfgUofuzNBVm8l1i5pcrE96GwQq1+i8Qdusm+w5hCAAeF5xZ3IdbiyAgLaoxW3VkLxeXVkeU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a10562c-9f71-429f-392d-08d63a3efdfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 05:59:16.0496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4626
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
The SoC has PMU support in L3 cache controller (L3C) and in the
DDR4 Memory Controller (DMC).

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
 drivers/perf/thunderx2_pmu.c         | 867 +++++++++++++++++++++++++++
 include/linux/cpuhotplug.h           |   1 +
 5 files changed, 984 insertions(+)
 create mode 100644 Documentation/perf/thunderx2-pmu.txt
 create mode 100644 drivers/perf/thunderx2_pmu.c

--=20
2.18.0

