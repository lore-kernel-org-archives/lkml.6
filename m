Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA3AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9DC2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="H4Lns+xf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9DC2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404118AbeKVNlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:41:52 -0500
Received: from mail-eopbgr710071.outbound.protection.outlook.com ([40.107.71.71]:25600
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729872AbeKVNlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/CjG67SgJSPyyptxjFCtmApA74zCoo9EQ6aL6g6QDc=;
 b=H4Lns+xfdlb7KTqc/mlVrdG6DyCXCj7KjtG6jQEPloSWsFjIT4nf33wtmPsH8DqT82VU3Pk+t3TVyAcDalaGp6IhUIBj84pipzJsvIk9S/5dU1sRSVnGXH0wBjlqP3IxtNLXOoCbCODKf/Ki4oYDUxdMUJlDnYCT0UIPA2bDF5A=
Received: from BN7PR07MB5298.namprd07.prod.outlook.com (20.176.177.92) by
 BN7PR07MB4260.namprd07.prod.outlook.com (52.135.243.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 03:04:31 +0000
Received: from BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::2c4f:febb:78f0:8747]) by BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::2c4f:febb:78f0:8747%3]) with mapi id 15.20.1339.026; Thu, 22 Nov 2018
 03:04:31 +0000
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
Subject: [PATCH v8 1/2] perf, uncore: Adding documentation for ThunderX2 pmu
 uncore driver
Thread-Topic: [PATCH v8 1/2] perf, uncore: Adding documentation for ThunderX2
 pmu uncore driver
Thread-Index: AQHUghAWwn7XCdSt8EalQ62X8aq3SA==
Date:   Thu, 22 Nov 2018 03:04:31 +0000
Message-ID: <20181122030354.13570-2-ganapatrao.kulkarni@cavium.com>
References: <20181122030354.13570-1-ganapatrao.kulkarni@cavium.com>
In-Reply-To: <20181122030354.13570-1-ganapatrao.kulkarni@cavium.com>
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
x-microsoft-exchange-diagnostics: 1;BN7PR07MB4260;6:9vFlJnPItuGaJIkAV596kjcq4CQYpc/b6egB7pDhKgjw6opoNGb6dx478GpShCtZTvrnBmaTEY3XVEue7claF6WtFdQsCP/la6v/HmFAUT+CeDtgrlkVZgtJsgTQJUY5zn0e35EVs3wxse5a3wQ0J87vkqIwPMmZY8lJXpH2GOQ4XGc3EszfJK+jiOCbiQcrG5OE/8xzI+y33fE+O/MqY3vhO63wa8H8N0J/ygUQAnVZl0Y5BHT3gePHwOoPjy6tJg56YwZ7Gh2ZMSbew7TGLo8KASrh8X2TrcOjS/JBqzsjI7gdiGLkbtKBvLtRyAWtqvJiCzUfvcQcpBMYkLWvp2v53EV6x6etWUPPPkdZdtVTlv8Y/SEQYXEQDk2r3UlynQYUwR2i7Hy6aPiHtWI4mbKdQmD+gkfrEjTkJuCledVNgLyNWAZ+j3FMgRlhcKk1/Hhd34XKCT3QfkUZj5CaUw==;5:u9Jt3WsgtMX24jchnv5GV5/yUojC93J2PqTSMIERUvZki4ek24UBbVtrb2rc/zL8jlWVCc99k36Jy4O+sHe0yMMwpaZASHxdIKqpZ1D+GxvyOnJWud8IBzYT7GyJrdc8htKNCVIM25RFiFsdBm0kqnGEleQkbXR/38J4O7j5lhw=;7:RNZg16IZYM4Ag90ZKA/YXhoRV+Y5vCiJl+0325ebtNZVbiBE1RWw9b6xFwM/JfpDGN26FPfKh7ayjt83BA0/+RxiuhF4gZE0OHTYI3hF3YTUWU0qKBLm5BjIGQaMHk1AW2zrxb1rSEqmi+B4ggY9rw==
x-ms-office365-filtering-correlation-id: 8cdf40f0-08e8-4f8d-4d25-08d6502738de
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4260;
x-ms-traffictypediagnostic: BN7PR07MB4260:
x-microsoft-antispam-prvs: <BN7PR07MB42608C5E8F011CF3CDEDAFB683DB0@BN7PR07MB4260.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231442)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN7PR07MB4260;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4260;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(106356001)(6512007)(386003)(2906002)(102836004)(6506007)(105586002)(316002)(76176011)(7736002)(36756003)(186003)(486006)(4326008)(2201001)(39060400002)(305945005)(86362001)(26005)(78486014)(25786009)(81156014)(81166006)(52116002)(99286004)(1076002)(8936002)(53936002)(446003)(11346002)(478600001)(66066001)(256004)(14444005)(6486002)(97736004)(68736007)(72206003)(476003)(2900100001)(2616005)(5660300001)(2501003)(14454004)(6436002)(3846002)(6116002)(110136005)(54906003)(71200400001)(8676002)(71190400001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4260;H:BN7PR07MB5298.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UqgYCG6edxL0cYEpoKWEUuJaYLNhFGsm8URiFgxubvDSBzAwQYWP6+dvldECJSCAMFnKIkIXDXexzUFViNbGk3Ti592x4SHbIwQWcSOPhAHZ8lr6E2ai9OlY+OSh6J/4ZjQ1QLQko/a5KmjkhoJajSLDouzVT0qUSMQUHyKW/wrKWwOL3/Mo+9x7aGIOxQGdMnOxC7/MJXZnFsZXPC0DLsuEM5TIQBulRe9+uSFQUi72ZH9yKoUMVge2pbnaBxVWVF+S3iazF3XvsHRbHy0fEveSgAYRG8hQve2Jaif4FQoBIFdirnaSS4f98OxppAcF5/bGoqVcLHTW0jwsciPjs5jDjZ04UhUY4bY30yzl/1s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdf40f0-08e8-4f8d-4d25-08d6502738de
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 03:04:31.2387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC has PMU support in its L3 cache controller (L3C) and in the
DDR4 Memory Controller (DMC).

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 Documentation/perf/thunderx2-pmu.txt | 106 +++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/perf/thunderx2-pmu.txt

diff --git a/Documentation/perf/thunderx2-pmu.txt b/Documentation/perf/thun=
derx2-pmu.txt
new file mode 100644
index 000000000000..9f5dd7459e68
--- /dev/null
+++ b/Documentation/perf/thunderx2-pmu.txt
@@ -0,0 +1,106 @@
+
+Cavium ThunderX2 SoC Performance Monitoring Unit (PMU UNCORE)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+ThunderX2 SoC PMU consists of independent system wide per Socket PMUs such
+as Level 3 Cache(L3C) and DDR4 Memory Controller(DMC).
+
+DMC has 8 interleave channels and L3C has 16 interleave tiles. Events are
+sampled for default channel(i.e channel 0) and prorated to total number of
+channels/tiles.
+
+DMC and L3C, Each PMU supports up to 4 counters. Counters are independentl=
y
+programmable and can be started and stopped individually. Each counter can
+be set to sample specific perf events. Counters are 32 bit and do not supp=
ort
+overflow interrupt; they are sampled at every 2 seconds.
+
+PMU UNCORE (perf) driver:
+
+The thunderx2-pmu driver registers several perf PMUs for DMC and L3C devic=
es.
+Each of the PMUs provides description of its available events
+and configuration options in sysfs.
+	see /sys/devices/uncore_<l3c_S/dmc_S/>
+
+S is socket id.
+Each PMU can be used to sample up to 4 events simultaneously.
+
+The "format" directory describes format of the config (event ID).
+The "events" directory provides configuration templates for all
+supported event types that can be used with perf tool.
+
+For example, "uncore_dmc_0/cnt_cycles/" is an
+equivalent of "uncore_dmc_0/config=3D0x1/".
+
+Each perf driver also provides a "cpumask" sysfs attribute, which contains=
 a
+single CPU ID of the processor which is likely to be used to handle all th=
e
+PMU events. It will be the first online CPU from the NUMA node of the PMU =
device.
+
+Example for perf tool use:
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
+The driver does not support sampling, therefore "perf record" will
+not work. Per-task (without "-a") perf sessions are not supported.
+
+L3C events:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+read_request:
+	Number of Read requests received by the L3 Cache.
+	This include Read as well as Read Exclusives.
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
+	This is the Number of Invalidate and Write received by the L3 Cache.
+	Also Writes from IO that did not go through the PCIe Write Cache.
+
+inv_nwrite_hit
+	This is the Number of Invalidate and Write received by the L3 Cache
+	That were a hit in the L3 Cache.
+
+inv_request:
+	Number of Invalidate request received by the L3 Cache.
+
+inv_hit:
+	Number of Invalidate request received by the L3 Cache that were a
+	hit in L3.
+
+evict_request:
+	Number of Evicts that the L3 generated.
+
+NOTE:
+1. Granularity of all these events counter value is cache line length(64 B=
ytes).
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

