Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AB8C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A1E206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="V5g+WyAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A1E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeLEK7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:59:33 -0500
Received: from mail-eopbgr700076.outbound.protection.outlook.com ([40.107.70.76]:18547
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbeLEK7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=desUS2eABvJWd35wnt98tn99k3ucSR8Md5DbqC6Y++c=;
 b=V5g+WyAVcBr9gm39nzyaDhZC7+D1uyj8GpzY9QS0qrfZjgDLIvmDcqrFLHsUJ4eZTY95Sogj6/AVlZzLvxFbe5J9LdxxtkiayHw2SbhJjfOwXPB0/FBsa3KwCZhInuLPlbBdOBVZ5TzAe5XuFiY3h7QRW04HdfpPhk29TPCqjhA=
Received: from BYAPR07MB5304.namprd07.prod.outlook.com (20.177.124.221) by
 BYAPR07MB4821.namprd07.prod.outlook.com (20.176.250.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 5 Dec 2018 10:59:28 +0000
Received: from BYAPR07MB5304.namprd07.prod.outlook.com
 ([fe80::91b2:46af:5f4c:5bf]) by BYAPR07MB5304.namprd07.prod.outlook.com
 ([fe80::91b2:46af:5f4c:5bf%3]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 10:59:28 +0000
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
Subject: [PATCH v9 1/2] perf, uncore: Adding documentation for ThunderX2 pmu
 uncore driver
Thread-Topic: [PATCH v9 1/2] perf, uncore: Adding documentation for ThunderX2
 pmu uncore driver
Thread-Index: AQHUjImX08IsmgbXSU+xQ8Zqw7ghCQ==
Date:   Wed, 5 Dec 2018 10:59:28 +0000
Message-ID: <20181205105853.15154-2-ganapatrao.kulkarni@cavium.com>
References: <20181205105853.15154-1-ganapatrao.kulkarni@cavium.com>
In-Reply-To: <20181205105853.15154-1-ganapatrao.kulkarni@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::19) To BYAPR07MB5304.namprd07.prod.outlook.com
 (2603:10b6:a03:65::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [111.93.218.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4821;6:MU6AZm+fu0hGU6MNV5XVzh7Xt9Q3ZehyHCQep45qY8huCL0lLfChp2//QJ2K6mWGJjdQZP/oxtDdcfVtFyBKb0WASJRRUfVZtmrQs+zfUlI2gGIm207qtjmXeSsYm9KfahOLLwp5YlUmPcvmNv0VOP2DWm1os0eEP/3ZqmIshGt+N5EUXrrbNkP5m1IQTG8c2dtrU3rByH/LNJmAUpM9tFI+JW3ezS/fDeVCSTmWiXV7eHR44drt8wbXnF2ejWBYL+8m4+PFF0Dl+2Ng6Y2hraQLpiL+0tEjYEWvTv/Y5vd5AN7lKqVxClMqMKhETS4KZDQiHgmJVgPtUwzoMx1tAI/pPUtPzh1vRCTNqCrPiKiVrbIroNlt953B7/RjTT2BiCmYYH2khU3Ltqm6ukuPjsczhD1a1LcWN1lhdrfExJY4z/RjbxhHMW5oi9SOVj6NCNQP1hRjq6KZ5CPY6mtoDQ==;5:1/Vry3n/JLyxLlb4qDwDibsLwwycWE0F5IJN1Ol0zPKdJYQ/xJfIJonk8v93tp9ZdLHLJZ1I0VVmXTU/evijWRZij5YdRKc8Cxm345AVonrfm0/N6QYDwY6/RH3QScDpC3UW4JCW70wrU1kJU6JgWyYWoaETBixfIFf5ysmJ0MQ=;7:0mHTHxPqTqz0KyjHx5U5ZrbPvd10mTWo+ha+yxDWOpqPYqB0lZZIVSVuXT/L3Yr7hR2SliORLc5tH1nLEnesQOn5nPGyM4yfak6CP5u2HaQ2foEZ5BmvbtD4CGBRzeaMvVu1/fid4ui1aQnz6OGpyQ==
x-ms-office365-filtering-correlation-id: 1efc9710-a569-452e-d6eb-08d65aa0ba25
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4821;
x-ms-traffictypediagnostic: BYAPR07MB4821:
x-microsoft-antispam-prvs: <BYAPR07MB4821C83B55082D420B6B2FB983A80@BYAPR07MB4821.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4821;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4821;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(396003)(346002)(189003)(199004)(14454004)(8676002)(99286004)(486006)(11346002)(3846002)(6116002)(446003)(2501003)(6436002)(72206003)(8936002)(81166006)(81156014)(476003)(78486014)(52116002)(2906002)(14444005)(256004)(71190400001)(6506007)(186003)(386003)(102836004)(26005)(71200400001)(54906003)(110136005)(316002)(1076002)(2616005)(66066001)(76176011)(4326008)(305945005)(7736002)(25786009)(68736007)(6512007)(478600001)(53936002)(36756003)(6486002)(105586002)(106356001)(97736004)(86362001)(39060400002)(2201001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4821;H:BYAPR07MB5304.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pHHYG4I9bIL0W4wBYDrt7mg1LnOYZRN0euiSl+rRsI6oVz4H+usvRRB3xPOKTND8o3NBXOBSxEc4tx0MFjcKtfKyLtNmQX5l8cfwZv1eRXmGa/r2c9E2Z6guT5fhF0vCpPhOVnwYy33acbZwBg386N6raKLKsszCE2ssUt8Sax6tPnn8jWmUX/oskk6ORj5GOvrvzx/vyZypFbduT8L15/oZmDDLJ7MmLopB93/JcnhsBhjDR4wqTPfI2u2mGbE6Fb9nLc/bgD2RMAE5HKn2sixrl1AmE62s20GpYmFr0fbamIH3BkNJT9ObMLnnZ64Lz4tVPbFskMdcLCof91UXt41m0brdd0EUiFCw94T7Ac0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efc9710-a569-452e-d6eb-08d65aa0ba25
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 10:59:28.7335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4821
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
index 000000000000..f8835bf1068c
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
+are counted for default channel(i.e channel 0) and prorated to total numbe=
r of
+channels/tiles.
+
+DMC and L3C supports up to 4 counters. Counters are independently programm=
able
+and can be started and stopped individually. Each counter can be set to
+different event. Counters are 32 bit and do not support overflow interrupt=
;
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

