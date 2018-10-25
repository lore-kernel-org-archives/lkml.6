Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BC6C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEE52083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Oeu2J9zC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEE52083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeJYOah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:30:37 -0400
Received: from mail-bl2nam02on0052.outbound.protection.outlook.com ([104.47.38.52]:45568
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726973AbeJYOag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/CjG67SgJSPyyptxjFCtmApA74zCoo9EQ6aL6g6QDc=;
 b=Oeu2J9zCB8Ih1lckV5PWVpjjS/nSSmLjeRCd4LzV2KDR3IjJYUDXoaNthfVgnrkJ76ueA2tF6UuDBynJahIM90IaD747U3t7m83oXJeEXCMI0Iu+Y2WV5jxFISAQ4nhMmllRIM7meBw6nQFVwz5cCT/DJ0IkB/KRJ8ZSERhKkFE=
Received: from BN7PR07MB5298.namprd07.prod.outlook.com (20.176.177.92) by
 BN7PR07MB4626.namprd07.prod.outlook.com (52.135.249.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 05:59:20 +0000
Received: from BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::c8bd:3664:252e:316e]) by BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::c8bd:3664:252e:316e%3]) with mapi id 15.20.1273.019; Thu, 25 Oct 2018
 05:59:20 +0000
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
Subject: [PATCH v7 1/2] perf, uncore: Adding documentation for ThunderX2 pmu
 uncore driver
Thread-Topic: [PATCH v7 1/2] perf, uncore: Adding documentation for ThunderX2
 pmu uncore driver
Thread-Index: AQHUbCffy5t4TQ8Iz0uSu+j9ZDwgxQ==
Date:   Thu, 25 Oct 2018 05:59:20 +0000
Message-ID: <20181025055833.28471-2-ganapatrao.kulkarni@cavium.com>
References: <20181025055833.28471-1-ganapatrao.kulkarni@cavium.com>
In-Reply-To: <20181025055833.28471-1-ganapatrao.kulkarni@cavium.com>
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
x-microsoft-exchange-diagnostics: 1;BN7PR07MB4626;6:QxSx7wHeEyDu97md+spYzmK8bgnxarU6s0z320LxjZfgqG2CIS4jfKFVMC+Xvg9fV/1t9obieEqQb7UPo1VgNB9SdQjdlibILA67jxBMUqRgXuiNyHVDtbepZ//CDXfY9DzGOflUFLU82sKhwEwHNFzYEnKPScxi+khCNN/ZEkzQ/duK8fyfFCjlVw4AekavoVF+xBRZuNlSDz5kqNA0ptadzrw4H+DnAJmxnxhxG3I+CHGvhCGKFSzzjH3tYZItbSEv+2WjzACb+6LNzZDvIgHQObLZ60GHgsWOdXN3O1QUMARUfEe5bNgGwj4+p2C8wHMpC67UgOj/KLAN0Fe3CQnqUq6/UW8H57QMU6co5KAf0h72OJvQBAjoZZ0rxkgK8npvFNKF4Up6S9j99vMxOGE8eQi/HA66yK+NszDrtIEywT3uwGCcceqwIQri/tG0dh7hcLHcwFYB1+pY8LjCsA==;5:vbsXFKWO1Gva+t8SFOdUypwURF2a33LfbFPLVRm/zOCr+bpIXfswtIdJN4Q3jk2B5BTbcy+/R424vkAoqMebTrtFrAu+E/SYXpuxXi0mJbYcuZHl3AomYurEtuH3KMCV3yyNEDQacvDAizRNp9Pim/VQDYXmOUapNrEcjwDI894=;7:zsr+rO8HaTLQhg7dDgCG6ZwLn+HSkky9V6V2SqqjIvleZiE2kl35N3fHlLySAIiv8tAGqCkfwOGSe3OHTpma4XirdVAA2rh9pE6n/UDpRJxB0yDvPJ2C478b4ieaUQ/2iJ3krMIKLNj5zdghIhdNsjzWf6zhhZnaFRRYaEmjkeNAAc+jYfgj9lXfkxS+HXMKTXTUMJ/SWEVpREi/1Y+4y64q4yEbuvN6g3bkrehFuqkWb/skvpDNR6ZOB5X9SjD4
x-ms-office365-filtering-correlation-id: 9ead966c-d779-4931-e9b4-08d63a3f00f3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4626;
x-ms-traffictypediagnostic: BN7PR07MB4626:
x-microsoft-antispam-prvs: <BN7PR07MB4626098C4B2A9AA545368A6983F70@BN7PR07MB4626.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(163750095850)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN7PR07MB4626;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4626;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(186003)(71200400001)(3846002)(256004)(305945005)(106356001)(2900100001)(26005)(1076002)(97736004)(8676002)(4326008)(76176011)(14444005)(6506007)(386003)(53936002)(36756003)(6486002)(25786009)(6116002)(81166006)(81156014)(6436002)(316002)(52116002)(2501003)(105586002)(5250100002)(11346002)(478600001)(39060400002)(7736002)(71190400001)(66066001)(476003)(99286004)(2616005)(86362001)(72206003)(486006)(5660300001)(2906002)(446003)(6512007)(8936002)(102836004)(110136005)(68736007)(14454004)(2201001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4626;H:BN7PR07MB5298.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4IrmrK8gnO1WQnVG276AlfTh4T63hj/pF/42lyj2gApdUbg66HOFtTeMVW9mwIHw+L1d7mheHQOncHos/D/4D8KXZrxMp3+X5lyMf6+++nFSKP7P3y5RDwgnsJdNgurNFyuGpp4Ickuor3K6u3MfQfvaZwcQ5I6w9Ihkp46cfx/zr+Sy8y2sqeaqm/FKHoUu/DOIP7lL9NFdJxaX8CBw5boe6G0C5MzEvkkIL4oTqp2QMaHc/IABmgI2PKxzYLj9tHR9VkqUoYtexSJi82JHEbFEX4PHIK9myqzd9wDfI1HeUs+JF8/yhWvRYDFjGCT18th0w+JuxJH8zFu7idHR9W9wxB4lWmVcRyLzfzW3tEo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ead966c-d779-4931-e9b4-08d63a3f00f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 05:59:20.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4626
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

