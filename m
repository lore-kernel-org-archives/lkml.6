Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C962CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABD8214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="c9k32zX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABD8214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbeLFGq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:46:28 -0500
Received: from mail-eopbgr800084.outbound.protection.outlook.com ([40.107.80.84]:43392
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728294AbeLFGq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sRh8RLcpgOx2LQ5vZ0NZQ0HezQZUMuOUbnPpKPfk6Y=;
 b=c9k32zX1ZteJ/4WWCFBwFp0SXOlUn6zLW4jKC4gz7dpfFZpgUGRhjfDe3LJHlrpCd/6gvVkwi2/TnQqAkn3yzyMmvud0noGUuKA5svKtSD7lfSsYHRkZWqIgeHbnKZGNn/TV3RaAuJ80dllE54S/JNoSFm2twbd3LDUiM1L6GAE=
Received: from BN7PR07MB5298.namprd07.prod.outlook.com (20.176.177.92) by
 BN7PR07MB4610.namprd07.prod.outlook.com (52.135.249.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 06:46:21 +0000
Received: from BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::f892:12f:1622:393c]) by BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::f892:12f:1622:393c%2]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 06:46:21 +0000
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
Subject: [PATCH v10 1/2] perf, uncore: Adding documentation for ThunderX2 pmu
 uncore driver
Thread-Topic: [PATCH v10 1/2] perf, uncore: Adding documentation for ThunderX2
 pmu uncore driver
Thread-Index: AQHUjS9mQjnUVvox+EaI//Y3oZB0kA==
Date:   Thu, 6 Dec 2018 06:46:21 +0000
Message-ID: <20181206064545.536-2-ganapatrao.kulkarni@cavium.com>
References: <20181206064545.536-1-ganapatrao.kulkarni@cavium.com>
In-Reply-To: <20181206064545.536-1-ganapatrao.kulkarni@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR01CA0117.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::33)
 To BN7PR07MB5298.namprd07.prod.outlook.com (2603:10b6:408:2d::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [111.93.218.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR07MB4610;6:u42kxSAguGbyjWZsUtq1UQX5Wc0WcG5wTY4qko92ONtJWm0oeLGogSiPJE56FD8lFbUbpEkZwGTsH1n/lImbM9gNnBZLS3gf9tF7ir1tNhP/wIjvtQjv3TZ/iJuy9gNXSE+GYlkT8ATwItJXhB9+O2Bp6POqGCKxW+i0p/tin9RDSeR4w2wc8ZZvBzkvQa2VhNRyC7icTBn4e2HzwYWdu72hPJMHzXLPAQp58dBnOitaoJ8zmV5uFVdeGMkxmuuYG37mmomRPE8va29XO1Ilov5OOI3JLfdIJecsv1NGgIdWnD+qlLfG930pRRPpkJD5RJMb1/BOlfdxMfsc6ROJwbrJsMBqWTM9eF/IE4h0GM7eccX3nfernUPfRg48Bp2jtQ2YK4O7H0JEWHRkkviHD4VKWYvrwJAWN4BGg6hUf7xg5y0W8H/DZYudzur07nJ0SsXFl/ybrNJkBbv2D6BWBg==;5:7BKzwKMe0QW8CfrrMBZ/FWKBWsvhcjCJF+xppKvJoPGYrntlyjCNOTV/aAxmmxtVIxr+UQWmDI0+vx870Qc1L2sDy8Xhxa1Pe3zHGB5Us/luOdl6LIUsKgxWJ9Qtcwhp3aFAGgmxeIxj3CCRmXKky45FVLUPYCsX0F4Pbv5cZCA=;7:e7O9CSPl2JIM5AIL179ijatEyuNa5qYOqdxPU6DIA2mNxwJgSpZ1+cHuuPdUeVSVzmimL0M46hElZnqnPN1IPcgMN4TYneerylQjMJc7xHf1npHHstCUhpTpiR+UdAgqzd5vrdv+jOFwlWrJqbnBvw==
x-ms-office365-filtering-correlation-id: a7c335f7-3756-4826-d9ec-08d65b468872
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4610;
x-ms-traffictypediagnostic: BN7PR07MB4610:
x-microsoft-antispam-prvs: <BN7PR07MB4610056BAD9F01CAC347F3E583A90@BN7PR07MB4610.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN7PR07MB4610;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4610;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(39860400002)(396003)(189003)(199004)(97736004)(186003)(8936002)(76176011)(81166006)(81156014)(8676002)(575784001)(86362001)(386003)(2201001)(6506007)(78486014)(52116002)(66066001)(71190400001)(256004)(68736007)(14444005)(105586002)(106356001)(71200400001)(6436002)(2616005)(5660300001)(478600001)(3846002)(11346002)(39060400002)(6512007)(1076002)(6486002)(53936002)(26005)(476003)(102836004)(2906002)(446003)(305945005)(4326008)(6116002)(36756003)(7736002)(486006)(99286004)(110136005)(54906003)(316002)(25786009)(14454004)(2501003)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4610;H:BN7PR07MB5298.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: meCstWnGIP/jYWjUlgzWYgXC0cA4smWJw9CFUvfkxX2vGRjax3aT16TPkcxtZTPxAoLTz0wHfdhd/IaYGcizIoYeu2uVZN19jubjZvK31XgrOXZa9E9N06ePzo8BRIN1WVA1zQ78X4a6c1IRcvigtqRIaMk1Jxo5NENf6xJ/9NPeS42WrKXIozztou9j0BOaghYyIcuP3y6ArnnVGJXY66QfAiMwx+8TyxSzGgNP48jlOmn10K0cQyf9XOzeRt0LHXSijEfJqmOBnJFUARdZykIEvZfz1MRNuJUXXboVXKPBCWSI+eTUMKv94qP4kGbkqK2CjGZ3xFuTG67amDtZHOoJxLFJRpaDBXBl0JL+wEA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c335f7-3756-4826-d9ec-08d65b468872
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 06:46:21.7012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC has PMU support in its L3 cache controller (L3C) and in the
DDR4 Memory Controller (DMC).

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 Documentation/perf/thunderx2-pmu.txt | 93 ++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/perf/thunderx2-pmu.txt

diff --git a/Documentation/perf/thunderx2-pmu.txt b/Documentation/perf/thun=
derx2-pmu.txt
new file mode 100644
index 000000000000..6ec37f0e6d2c
--- /dev/null
+++ b/Documentation/perf/thunderx2-pmu.txt
@@ -0,0 +1,93 @@
+
+Cavium ThunderX2 SoC Performance Monitoring Unit (PMU UNCORE)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+ThunderX2 SoC PMU consists of independent system wide per Socket PMUs, suc=
h
+as Level 3 Cache(L3C) and DDR4 Memory Controller(DMC).
+
+The DMC has 8 interleaved channels and the L3C has 16 interleaved tiles. E=
vents
+are counted for the default channel(i.e channel 0) and prorated to total n=
umber of
+channels/tiles.
+
+DMC and L3C support up to 4 counters. Counters are independently programma=
ble
+and can be started and stopped individually. Each counter can be set to
+a different event. Counters are 32 bit and do not support overflow interru=
pt;
+they are read every 2 seconds.
+
+PMU UNCORE (perf) driver:
+
+The thunderx2_pmu driver registers per socket perf PMUs for DMC and L3C de=
vices.
+Each PMU can be used to count up to 4 events simultaneously. PMUs provide
+description of its available events and configuration options
+in sysfs, see /sys/devices/uncore_<l3c_S/dmc_S/>; S is the socket id.
+
+The driver does not support sampling, therefore "perf record" will
+not work. Per-task perf sessions are not supported.
+
+Examples:
+
+perf stat -a -e uncore_dmc_0/cnt_cycles/ sleep 1
+
+perf stat -a -e \
+uncore_dmc_0/cnt_cycles/,\
+uncore_dmc_0/data_transfers/,\
+uncore_dmc_0/read_txns/,\
+uncore_dmc_0/write_txns/ sleep 1
+
+perf stat -a -e \
+uncore_l3c_0/read_request/,\
+uncore_l3c_0/read_hit/,\
+uncore_l3c_0/inv_request/,\
+uncore_l3c_0/inv_hit/ sleep 1
+
+
+L3C events:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+read_request:
+	Number of Read requests received by the L3 Cache.
+	This includes Read as well as Read Exclusives.
+
+read_hit:
+	Number of Read requests received by the L3 cache that were hit
+	in the L3 (Data provided form the L3)
+
+writeback_request:
+	Number of Write Backs received by the L3 Cache. These are basically
+	the L2 Evicts and writes from the PCIe Write Cache.
+
+inv_nwrite_request:
+	Number of Invalidate and Write requests received by the L3 Cache.
+	Also Writes from IO that did not go through the PCIe Write Cache.
+
+inv_nwrite_hit
+	Number of Invalidate and Write requests received by the L3 Cache
+	that were a hit in the L3 Cache.
+
+inv_request:
+	Number of Invalidate requests received by the L3 Cache.
+
+inv_hit:
+	Number of Invalidate requests received by the L3 Cache that were a
+	hit in the L3 Cache.
+
+evict_request:
+	Number of Evicts that the L3 cache generated.
+
+NOTE:
+1. Granularity of all these event counter values are cache line length(64 =
bytes)
+2. L3C cache Hit Ratio =3D (read_hit + inv_nwrite_hit + inv_hit) / (read_r=
equest + inv_nwrite_request + inv_request)
+
+DMC events:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+cnt_cycles:
+	Count cycles (Clocks at the DMC clock rate)
+
+write_txns:
+	Number of 64 Bytes write transactions received by the DMC(s)
+
+read_txns:
+	Number of 64 Bytes Read transactions received by the DMC(s)
+
+data_transfers:
+	Number of 64 Bytes data transferred to or from DRAM.
--=20
2.18.0

