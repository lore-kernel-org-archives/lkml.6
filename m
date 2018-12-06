Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786DFC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF1A208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="LZpp3MTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF1A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbeLFLvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:51:33 -0500
Received: from mail-eopbgr690073.outbound.protection.outlook.com ([40.107.69.73]:31184
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727763AbeLFLvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sRh8RLcpgOx2LQ5vZ0NZQ0HezQZUMuOUbnPpKPfk6Y=;
 b=LZpp3MTRTZlNCkeMSi85Pf05fY9aX29ovn6yU2xs6VwZuGZM532g8xBtLHK9MXssT92UVVjH923HxLoEU6s6WWnJLUcOy+qgDprfSrHpnBebvKpfUXMec1hNZqoSnrFlADzNZMAvLGy2TM4J2yyZGrf5c/FiJ9RCZh3X6a8pfr0=
Received: from BN7PR07MB5298.namprd07.prod.outlook.com (20.176.177.92) by
 BN7PR07MB5315.namprd07.prod.outlook.com (20.176.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Thu, 6 Dec 2018 11:51:28 +0000
Received: from BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::f892:12f:1622:393c]) by BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::f892:12f:1622:393c%2]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 11:51:28 +0000
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
Subject: [PATCH v11 1/2] perf, uncore: Adding documentation for ThunderX2 pmu
 uncore driver
Thread-Topic: [PATCH v11 1/2] perf, uncore: Adding documentation for ThunderX2
 pmu uncore driver
Thread-Index: AQHUjVoFQHezpmIGXUeGE/TmLNybcg==
Date:   Thu, 6 Dec 2018 11:51:27 +0000
Message-ID: <20181206115053.7665-2-ganapatrao.kulkarni@cavium.com>
References: <20181206115053.7665-1-ganapatrao.kulkarni@cavium.com>
In-Reply-To: <20181206115053.7665-1-ganapatrao.kulkarni@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::30)
 To BN7PR07MB5298.namprd07.prod.outlook.com (2603:10b6:408:2d::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [111.93.218.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR07MB5315;6:R2NL84sxD/PIZrkJ9koPYBm3i1uVERMXuyP7pfxSRHruCiKMvFPSdl+M8wyw2THj4Z9VRRsDlyTT2w6uvN2VFYFLTIvu/W6ZwfSC2hB0t7Z2Q2fJLybe/DVAmMxktdNNsyZCU1ifOFcPI5snaNs2jhTYKFayf4etSWdKRmDknOlqIC62P3l10p1CmgBmhllOBpXYGKOUd8eDkiFTLWykkIvLO9v8ioVISEEtIapXSHwksWNyWbpZgoKLmEI4mSM1wNyYZSM7OHRuquHvMR0aMAj0zXzYRIIXylP9tbEUKfmoZUYrF9ayiS4QKPTtqRj+HpdkOyyxl0/YqbwsE/M7uPgWVLPvuzlp2uPDGHl04lhNC46qChB4CfPtxxYTWnGZr3Ip87n+OSaF3sVtqrBH5sZYeWHJpJHqIP9BxO6PXfASg73Dq6NxniyiGNvhDf+QhPr/7QuBJ4envG5jBsmulw==;5:k3PDridWRCc564cH2kSXdZKWk9J9zR5kOvb33Sxueua0td/+hkHYveKSOenlSmmbVVN3VLckEdU4zPgd5G80g0IPZoCeU70ypEBcfyAAAVzhZLLKynTUDR9VvMfLwebPTzLlNMLTOy02VRxnnmZkxWcMYAGYvpjzXBhkmrnW55c=;7:A/bUuls+T3uUtvN4072WjzTH2KHC3YLewxXdfiuJqJldA5ezVRhVLMMdUFOWIU/Wk1L+JOXO0ySzxxBGX7EHH4oshNJUcCaASuh6m9szCaM4vRQlyMJ9JDD+ggaK4GUqav6SkyzEE7RwkcxMjYkPPQ==
x-ms-office365-filtering-correlation-id: 36fa18a5-2b52-4014-6f9b-08d65b7127cd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB5315;
x-ms-traffictypediagnostic: BN7PR07MB5315:
x-microsoft-antispam-prvs: <BN7PR07MB5315538D1D5A5498F3C1C9A283A90@BN7PR07MB5315.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN7PR07MB5315;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB5315;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(199004)(189003)(1076002)(5660300001)(2906002)(53936002)(2501003)(6486002)(6436002)(316002)(26005)(54906003)(110136005)(186003)(102836004)(6512007)(6116002)(3846002)(36756003)(99286004)(66066001)(8936002)(11346002)(71190400001)(78486014)(446003)(2616005)(71200400001)(81166006)(81156014)(25786009)(97736004)(8676002)(14444005)(6506007)(52116002)(386003)(256004)(476003)(486006)(76176011)(105586002)(7736002)(86362001)(68736007)(4326008)(305945005)(2201001)(72206003)(575784001)(14454004)(508600001)(106356001)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB5315;H:BN7PR07MB5298.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X47sWB7PlstdCXIJq7lu3D1PanpCB0KCk8c80xRltjP4/uXEHJFQjXNew0hqiu2DVZ8srcigsTfhdF2n8Hl40JsZEDk5vaaAH1H2yei+CG7L+K6dPz3f+ZQZm+oXj311VvJMST0fe87f6zNFDxNpmLrk5yEAoBMlCS1Yp4Ezq8BJNfo9EM1i7KjhUF4zbBQMRLwLhgfhSHPLfNXDo/aTnHjQEo9mB4RoaJ9EM+bNdB4BNjydsmeexfCdz80ThyViox1dsnheV75AI7hJL4qAzan8Hrzu2mhpbI39uSc8FM06qIn9AXiaIZdc5f78/8ge3M9FCGPKtxKe3RgQz7S7TbigJU9WuNppDays7MEVn6Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fa18a5-2b52-4014-6f9b-08d65b7127cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 11:51:28.0123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB5315
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

