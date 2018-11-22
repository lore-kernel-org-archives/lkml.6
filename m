Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3677C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C78220684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="hhuc0wM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C78220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404145AbeKVNl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:41:58 -0500
Received: from mail-eopbgr710046.outbound.protection.outlook.com ([40.107.71.46]:56096
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404119AbeKVNl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HObdfdOXFLPferrl6eq4DfVq2EiIew/+KVD2ycs+lk=;
 b=hhuc0wM48CTWp6wYZi9ktVzv/Aw1kad3DGZFyGKR7hScRXvYrKJHVFvJp4ywF4AnQSJT/3AwIQ+z/QQZY0bRiWBYw7i5Xlbxwq5U3f+VWZEDkd4MW2quT1loYr/fnWMk1LSt2XEGRyAZFV/1sC8xqEqBCsITFyaKCcFKGmIQr6M=
Received: from BN7PR07MB5298.namprd07.prod.outlook.com (20.176.177.92) by
 BN7PR07MB4260.namprd07.prod.outlook.com (52.135.243.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 03:04:35 +0000
Received: from BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::2c4f:febb:78f0:8747]) by BN7PR07MB5298.namprd07.prod.outlook.com
 ([fe80::2c4f:febb:78f0:8747%3]) with mapi id 15.20.1339.026; Thu, 22 Nov 2018
 03:04:35 +0000
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
Subject: [PATCH v8 2/2] ThunderX2, perf : Add Cavium ThunderX2 SoC UNCORE PMU
 driver
Thread-Topic: [PATCH v8 2/2] ThunderX2, perf : Add Cavium ThunderX2 SoC UNCORE
 PMU driver
Thread-Index: AQHUghAYcXpmruqSWEmL2TShxWMYsg==
Date:   Thu, 22 Nov 2018 03:04:35 +0000
Message-ID: <20181122030354.13570-3-ganapatrao.kulkarni@cavium.com>
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
x-microsoft-exchange-diagnostics: 1;BN7PR07MB4260;6:n+GF2NtOFq9SzUPz+DoIBexSUC5fiUJpHnTtixs0KRwxo397vlyHMyZwQi8O/BFrTo0HVzh/wtVFaHRRxo0zb0J7GikhH2L/oRfggR1LISoXzgnXPkqq4gAxS9eZp3Nqqx/KdPjDd+ufEnQybRfIvLplh4RZfBVQ68QoagCxaTxneVXEbZAEluS6KkOYr7GwavK4HRSh5HHcoM12eZpz/DExwhgGHiDp77bMFt/kwgpX7CTgvdLlFHG1qaOM+88glHHIS8+/VeZhQ4CkEb9ixzuoqeDSinEd6WGwtrJuKk/TzU8J+JMSQwqW2pqch7POyywt/HfXpNphf4gm76VRR/khjrL2d20Er1PJ8zyRHeiy7KA94aoUhpzNbtC9rVW4IKZl3p7DCa4BnTxXonAhQbohrn/SGvCNniXWdAEJPPNjQlt6AJiQFGU8QHYbLE7j/UTE7wWD1Pr0MEaeom1Hqw==;5:x4IyXMl8UsrldQk7PLgBxcIzVqEXwAT0Xs8NnYyONw77YUizVHEeSFEpqcvLx2xNVZtmFiVpQh++W1Mt2xYZjl5xiQXRNYGJrvzknb9cvsWm8oLs7q81BHGDleGEMfmvaszReiaTSltHFQZF5jKuCF4q1oYXE7yU7NJNgnM1npI=;7:Cm38iVOa08Ap3MCqPVrErsMC9G5PJfLZ4KcBIR6c0BeNLTFGhJoA/stymkh3CDUtgd2LSgCmO1ymnedHatFnAhg2OPNN1zHGvX3V9xmRddPHVDTCetvrinNxh5TknNl5rlaPk8HnwxiC9mZuSP6uGg==
x-ms-office365-filtering-correlation-id: fb5cb8d6-41bf-4415-d0d7-08d650273b28
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4260;
x-ms-traffictypediagnostic: BN7PR07MB4260:
x-microsoft-antispam-prvs: <BN7PR07MB4260750C41688EC07673D0C183DB0@BN7PR07MB4260.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231442)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN7PR07MB4260;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4260;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(106356001)(6512007)(386003)(2906002)(102836004)(6506007)(53946003)(105586002)(316002)(76176011)(7736002)(36756003)(186003)(486006)(4326008)(2201001)(39060400002)(305945005)(575784001)(86362001)(26005)(78486014)(25786009)(81156014)(81166006)(52116002)(99286004)(1076002)(8936002)(53936002)(446003)(217873002)(11346002)(478600001)(66066001)(256004)(14444005)(6486002)(97736004)(5024004)(68736007)(72206003)(476003)(2900100001)(2616005)(5660300001)(2501003)(14454004)(4744004)(6436002)(3846002)(6116002)(110136005)(54906003)(71200400001)(8676002)(71190400001)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4260;H:BN7PR07MB5298.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uShkcF3Lp3/EOl2Ip9SAzHeHhyXcLL8TtrZZhjnQQcbuEKuUKNX5B4LumoOUyAoseexg/ebltZYNO2UW5DqWsfWp/Vltpo0DKJdEcWtA2UrmuF93HM+dBLCrzyD0b6N9fMi6qvH2fmerLH7dqUnCqNU89B0oGdC5Z8wShlLCJfCKsCdNr/VMQo99Y8jnV3aNyQLPQUvo0G5NfDDAGTQxzWZ9wwVWjA/FrFJt+xmquHMNIwMsnVXxE3djN2J2FkwmN/7eVRlyAbntXCe0oLBUnCYZ+OCTJRhYs8iV/qCAkJEueHIob1f2bOEKZ0ZnlUbThaBdI0sFpVAhcbmf30EqZVu1nrqdkv7pBLpAhwtRGZ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5cb8d6-41bf-4415-d0d7-08d650273b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 03:04:35.0356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a perf driver for the PMU UNCORE devices DDR4 Memory
Controller(DMC) and Level 3 Cache(L3C). Each PMU supports up to 4
counters. All counters lack overflow interrupt and are
sampled periodically.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 drivers/perf/Kconfig         |   9 +
 drivers/perf/Makefile        |   1 +
 drivers/perf/thunderx2_pmu.c | 869 +++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h   |   1 +
 4 files changed, 880 insertions(+)
 create mode 100644 drivers/perf/thunderx2_pmu.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 08ebaf7cca8b..af9bc178495d 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -87,6 +87,15 @@ config QCOM_L3_PMU
 	   Adds the L3 cache PMU into the perf events subsystem for
 	   monitoring L3 cache events.
=20
+config THUNDERX2_PMU
+	tristate "Cavium ThunderX2 SoC PMU UNCORE"
+	depends on ARCH_THUNDER2 && ARM64 && ACPI && NUMA
+	default m
+	help
+	   Provides support for ThunderX2 UNCORE events.
+	   The SoC has PMU support in its L3 cache controller (L3C) and
+	   in the DDR4 Memory Controller (DMC).
+
 config XGENE_PMU
         depends on ARCH_XGENE
         bool "APM X-Gene SoC PMU"
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index b3902bd37d53..909f27fd9db3 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_ARM_PMU_ACPI) +=3D arm_pmu_acpi.o
 obj-$(CONFIG_HISI_PMU) +=3D hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+=3D qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) +=3D qcom_l3_pmu.o
+obj-$(CONFIG_THUNDERX2_PMU) +=3D thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) +=3D arm_spe_pmu.o
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
new file mode 100644
index 000000000000..e6509ba868ab
--- /dev/null
+++ b/drivers/perf/thunderx2_pmu.c
@@ -0,0 +1,869 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CAVIUM THUNDERX2 SoC PMU UNCORE
+ * Copyright (C) 2018 Cavium Inc.
+ * Author: Ganapatrao Kulkarni <gkulkarni@cavium.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/cpuhotplug.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+
+/* Each ThunderX2(TX2) Socket has a L3C and DMC UNCORE PMU device.
+ * Each UNCORE PMU device consists of 4 independent programmable counters.
+ * Counters are 32 bit and do not support overflow interrupt,
+ * they need to be sampled before overflow(i.e, at every 2 seconds).
+ */
+
+#define TX2_PMU_MAX_COUNTERS		4
+#define TX2_PMU_DMC_CHANNELS		8
+#define TX2_PMU_L3_TILES		16
+
+#define TX2_PMU_HRTIMER_INTERVAL	(2 * NSEC_PER_SEC)
+#define GET_EVENTID(ev)			((ev->hw.config) & 0x1ff)
+#define GET_COUNTERID(ev)		((ev->hw.idx) & 0x3)
+ /* 1 byte per counter(4 counters).
+  * Event id is encoded in bits [5:1] of a byte,
+  */
+#define DMC_EVENT_CFG(idx, val)		((val) << (((idx) * 8) + 1))
+
+#define L3C_COUNTER_CTL			0xA8
+#define L3C_COUNTER_DATA		0xAC
+#define DMC_COUNTER_CTL			0x234
+#define DMC_COUNTER_DATA		0x240
+
+/* L3C event IDs */
+#define L3_EVENT_READ_REQ		0xD
+#define L3_EVENT_WRITEBACK_REQ		0xE
+#define L3_EVENT_INV_N_WRITE_REQ	0xF
+#define L3_EVENT_INV_REQ		0x10
+#define L3_EVENT_EVICT_REQ		0x13
+#define L3_EVENT_INV_N_WRITE_HIT	0x14
+#define L3_EVENT_INV_HIT		0x15
+#define L3_EVENT_READ_HIT		0x17
+#define L3_EVENT_MAX			0x18
+
+/* DMC event IDs */
+#define DMC_EVENT_COUNT_CYCLES		0x1
+#define DMC_EVENT_WRITE_TXNS		0xB
+#define DMC_EVENT_DATA_TRANSFERS	0xD
+#define DMC_EVENT_READ_TXNS		0xF
+#define DMC_EVENT_MAX			0x10
+
+enum tx2_uncore_type {
+	PMU_TYPE_L3C,
+	PMU_TYPE_DMC,
+	PMU_TYPE_INVALID,
+};
+
+/*
+ * pmu on each socket has 2 uncore devices(dmc and l3c),
+ * each device has 4 counters.
+ */
+struct tx2_uncore_pmu {
+	struct hlist_node hpnode;
+	struct list_head  entry;
+	struct pmu pmu;
+	char *name;
+	int node;
+	int cpu;
+	u32    max_counters;
+	u32    prorate_factor;
+	u32    max_events;
+	u64 hrtimer_interval;
+	void __iomem *base;
+	DECLARE_BITMAP(active_counters, TX2_PMU_MAX_COUNTERS);
+	struct perf_event *events[TX2_PMU_MAX_COUNTERS];
+	struct device *dev;
+	struct hrtimer hrtimer;
+	const struct attribute_group **attr_groups;
+	enum tx2_uncore_type type;
+	void	(*init_cntr_base)(struct perf_event *event,
+			struct tx2_uncore_pmu *tx2_pmu);
+	void	(*stop_event)(struct perf_event *event);
+	void	(*start_event)(struct perf_event *event, int flags);
+};
+
+static LIST_HEAD(tx2_pmus);
+
+static inline struct tx2_uncore_pmu *pmu_to_tx2_pmu(struct pmu *pmu)
+{
+	return container_of(pmu, struct tx2_uncore_pmu, pmu);
+}
+
+/*
+ * sysfs format attributes
+ */
+static ssize_t tx2_pmu_format_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr =3D container_of(attr, struct dev_ext_attribute, attr);
+	return sprintf(buf, "%s\n", (char *) eattr->var);
+}
+
+#define FORMAT_ATTR(_name, _config) \
+	(&((struct dev_ext_attribute[]) { \
+	   { \
+	   .attr =3D __ATTR(_name, 0444, tx2_pmu_format_show, NULL), \
+	   .var =3D (void *) _config, \
+	   } \
+	})[0].attr.attr)
+
+static struct attribute *l3c_pmu_format_attrs[] =3D {
+	FORMAT_ATTR(event,	"config:0-4"),
+	NULL,
+};
+
+static struct attribute *dmc_pmu_format_attrs[] =3D {
+	FORMAT_ATTR(event,	"config:0-4"),
+	NULL,
+};
+
+static const struct attribute_group l3c_pmu_format_attr_group =3D {
+	.name =3D "format",
+	.attrs =3D l3c_pmu_format_attrs,
+};
+
+static const struct attribute_group dmc_pmu_format_attr_group =3D {
+	.name =3D "format",
+	.attrs =3D dmc_pmu_format_attrs,
+};
+
+/*
+ * sysfs event attributes
+ */
+static ssize_t tx2_pmu_event_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr =3D container_of(attr, struct dev_ext_attribute, attr);
+	return sprintf(buf, "config=3D0x%lx\n", (unsigned long) eattr->var);
+}
+
+#define EVENT_ATTR(_name, _config) \
+	(&((struct dev_ext_attribute[]) { \
+	   { \
+	   .attr =3D __ATTR(_name, 0444, tx2_pmu_event_show, NULL), \
+	   .var =3D (void *) _config, \
+	   } \
+	 })[0].attr.attr)
+
+static struct attribute *l3c_pmu_events_attrs[] =3D {
+	EVENT_ATTR(read_request,		L3_EVENT_READ_REQ),
+	EVENT_ATTR(writeback_request,		L3_EVENT_WRITEBACK_REQ),
+	EVENT_ATTR(inv_nwrite_request,		L3_EVENT_INV_N_WRITE_REQ),
+	EVENT_ATTR(inv_request,			L3_EVENT_INV_REQ),
+	EVENT_ATTR(evict_request,		L3_EVENT_EVICT_REQ),
+	EVENT_ATTR(inv_nwrite_hit,		L3_EVENT_INV_N_WRITE_HIT),
+	EVENT_ATTR(inv_hit,			L3_EVENT_INV_HIT),
+	EVENT_ATTR(read_hit,			L3_EVENT_READ_HIT),
+	NULL,
+};
+
+static struct attribute *dmc_pmu_events_attrs[] =3D {
+	EVENT_ATTR(cnt_cycles,			DMC_EVENT_COUNT_CYCLES),
+	EVENT_ATTR(write_txns,			DMC_EVENT_WRITE_TXNS),
+	EVENT_ATTR(data_transfers,		DMC_EVENT_DATA_TRANSFERS),
+	EVENT_ATTR(read_txns,			DMC_EVENT_READ_TXNS),
+	NULL,
+};
+
+static const struct attribute_group l3c_pmu_events_attr_group =3D {
+	.name =3D "events",
+	.attrs =3D l3c_pmu_events_attrs,
+};
+
+static const struct attribute_group dmc_pmu_events_attr_group =3D {
+	.name =3D "events",
+	.attrs =3D dmc_pmu_events_attrs,
+};
+
+/*
+ * sysfs cpumask attributes
+ */
+static ssize_t cpumask_show(struct device *dev, struct device_attribute *a=
ttr,
+		char *buf)
+{
+	struct tx2_uncore_pmu *tx2_pmu;
+
+	tx2_pmu =3D pmu_to_tx2_pmu(dev_get_drvdata(dev));
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(tx2_pmu->cpu));
+}
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *tx2_pmu_cpumask_attrs[] =3D {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static const struct attribute_group pmu_cpumask_attr_group =3D {
+	.attrs =3D tx2_pmu_cpumask_attrs,
+};
+
+/*
+ * Per PMU device attribute groups
+ */
+static const struct attribute_group *l3c_pmu_attr_groups[] =3D {
+	&l3c_pmu_format_attr_group,
+	&pmu_cpumask_attr_group,
+	&l3c_pmu_events_attr_group,
+	NULL
+};
+
+static const struct attribute_group *dmc_pmu_attr_groups[] =3D {
+	&dmc_pmu_format_attr_group,
+	&pmu_cpumask_attr_group,
+	&dmc_pmu_events_attr_group,
+	NULL
+};
+
+static inline u32 reg_readl(unsigned long addr)
+{
+	return readl((void __iomem *)addr);
+}
+
+static inline void reg_writel(u32 val, unsigned long addr)
+{
+	writel(val, (void __iomem *)addr);
+}
+
+static int alloc_counter(struct tx2_uncore_pmu *tx2_pmu)
+{
+	int counter;
+
+	counter =3D find_first_zero_bit(tx2_pmu->active_counters,
+				tx2_pmu->max_counters);
+	if (counter =3D=3D tx2_pmu->max_counters)
+		return -ENOSPC;
+
+	set_bit(counter, tx2_pmu->active_counters);
+	return counter;
+}
+
+static inline void free_counter(struct tx2_uncore_pmu *tx2_pmu, int counte=
r)
+{
+	clear_bit(counter, tx2_pmu->active_counters);
+}
+
+static void init_cntr_base_l3c(struct perf_event *event,
+		struct tx2_uncore_pmu *tx2_pmu)
+{
+	struct hw_perf_event *hwc =3D &event->hw;
+
+	/* counter ctrl/data reg offset at 8 */
+	hwc->config_base =3D (unsigned long)tx2_pmu->base
+		+ L3C_COUNTER_CTL + (8 * GET_COUNTERID(event));
+	hwc->event_base =3D  (unsigned long)tx2_pmu->base
+		+ L3C_COUNTER_DATA + (8 * GET_COUNTERID(event));
+}
+
+static void init_cntr_base_dmc(struct perf_event *event,
+		struct tx2_uncore_pmu *tx2_pmu)
+{
+	struct hw_perf_event *hwc =3D &event->hw;
+
+	hwc->config_base =3D (unsigned long)tx2_pmu->base
+		+ DMC_COUNTER_CTL;
+	/* counter data reg offset at 0xc */
+	hwc->event_base =3D (unsigned long)tx2_pmu->base
+		+ DMC_COUNTER_DATA + (0xc * GET_COUNTERID(event));
+}
+
+static void uncore_start_event_l3c(struct perf_event *event, int flags)
+{
+	u32 val;
+	struct hw_perf_event *hwc =3D &event->hw;
+
+	/* event id encoded in bits [07:03] */
+	val =3D GET_EVENTID(event) << 3;
+	reg_writel(val, hwc->config_base);
+	local64_set(&hwc->prev_count, 0);
+	reg_writel(0, hwc->event_base);
+}
+
+static inline void uncore_stop_event_l3c(struct perf_event *event)
+{
+	reg_writel(0, event->hw.config_base);
+}
+
+static void uncore_start_event_dmc(struct perf_event *event, int flags)
+{
+	u32 val;
+	struct hw_perf_event *hwc =3D &event->hw;
+	int idx =3D GET_COUNTERID(event);
+	int event_id =3D GET_EVENTID(event);
+
+	/* enable and start counters.
+	 * 8 bits for each counter, bits[05:01] of a counter to set event type.
+	 */
+	val =3D reg_readl(hwc->config_base);
+	val &=3D ~DMC_EVENT_CFG(idx, 0x1f);
+	val |=3D DMC_EVENT_CFG(idx, event_id);
+	reg_writel(val, hwc->config_base);
+	local64_set(&hwc->prev_count, 0);
+	reg_writel(0, hwc->event_base);
+}
+
+static void uncore_stop_event_dmc(struct perf_event *event)
+{
+	u32 val;
+	struct hw_perf_event *hwc =3D &event->hw;
+	int idx =3D GET_COUNTERID(event);
+
+	/* clear event type(bits[05:01]) to stop counter */
+	val =3D reg_readl(hwc->config_base);
+	val &=3D ~DMC_EVENT_CFG(idx, 0x1f);
+	reg_writel(val, hwc->config_base);
+}
+
+static void tx2_uncore_event_update(struct perf_event *event)
+{
+	s64 prev, delta, new =3D 0;
+	struct hw_perf_event *hwc =3D &event->hw;
+	struct tx2_uncore_pmu *tx2_pmu;
+	enum tx2_uncore_type type;
+	u32    prorate_factor;
+
+	tx2_pmu =3D pmu_to_tx2_pmu(event->pmu);
+	type =3D tx2_pmu->type;
+	prorate_factor =3D tx2_pmu->prorate_factor;
+
+	new =3D reg_readl(hwc->event_base);
+	prev =3D local64_xchg(&hwc->prev_count, new);
+
+	/* handles rollover of 32 bit counter */
+	delta =3D (u32)(((1UL << 32) - prev) + new);
+
+	/* DMC event data_transfers granularity is 16 Bytes, convert it to 64 */
+	if (type =3D=3D PMU_TYPE_DMC &&
+			GET_EVENTID(event) =3D=3D DMC_EVENT_DATA_TRANSFERS)
+		delta =3D delta/4;
+
+	/* L3C and DMC has 16 and 8 interleave channels respectively.
+	 * The sampled value is for channel 0 and multiplied with
+	 * prorate_factor to get the count for a device.
+	 */
+	local64_add(delta * prorate_factor, &event->count);
+}
+
+enum tx2_uncore_type get_tx2_pmu_type(struct acpi_device *adev)
+{
+	int i =3D 0;
+	struct acpi_tx2_pmu_device {
+		__u8 id[ACPI_ID_LEN];
+		enum tx2_uncore_type type;
+	} devices[] =3D {
+		{"CAV901D", PMU_TYPE_L3C},
+		{"CAV901F", PMU_TYPE_DMC},
+		{"", PMU_TYPE_INVALID}
+	};
+
+	while (devices[i].type !=3D PMU_TYPE_INVALID) {
+		if (!strcmp(acpi_device_hid(adev), devices[i].id))
+			break;
+		i++;
+	}
+
+	return devices[i].type;
+}
+
+static bool tx2_uncore_validate_event(struct pmu *pmu,
+				  struct perf_event *event, int *counters)
+{
+	if (is_software_event(event))
+		return true;
+	/* Reject groups spanning multiple HW PMUs. */
+	if (event->pmu !=3D pmu)
+		return false;
+
+	*counters =3D *counters + 1;
+		return true;
+}
+
+/*
+ * Make sure the group of events can be scheduled at once
+ * on the PMU.
+ */
+static bool tx2_uncore_validate_event_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader =3D event->group_leader;
+	int counters =3D 0;
+
+	if (event->group_leader =3D=3D event)
+		return true;
+
+	if (!tx2_uncore_validate_event(event->pmu, leader, &counters))
+		return false;
+
+	for_each_sibling_event(sibling, leader) {
+		if (!tx2_uncore_validate_event(event->pmu, sibling, &counters))
+			return false;
+	}
+
+	if (!tx2_uncore_validate_event(event->pmu, event, &counters))
+		return false;
+
+	/*
+	 * If the group requires more counters than the HW has,
+	 * it cannot ever be scheduled.
+	 */
+	return counters <=3D TX2_PMU_MAX_COUNTERS;
+}
+
+
+static int tx2_uncore_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc =3D &event->hw;
+	struct tx2_uncore_pmu *tx2_pmu;
+
+	/* Test the event attr type check for PMU enumeration */
+	if (event->attr.type !=3D event->pmu->type)
+		return -ENOENT;
+
+	/*
+	 * SOC PMU counters are shared across all cores.
+	 * Therefore, it does not support per-process mode.
+	 * Also, it does not support event sampling mode.
+	 */
+	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+		return -EINVAL;
+
+	/* We have no filtering of any kind */
+	if (event->attr.exclude_user	||
+	    event->attr.exclude_kernel	||
+	    event->attr.exclude_hv	||
+	    event->attr.exclude_idle	||
+	    event->attr.exclude_host	||
+	    event->attr.exclude_guest)
+		return -EINVAL;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	tx2_pmu =3D pmu_to_tx2_pmu(event->pmu);
+	if (tx2_pmu->cpu >=3D nr_cpu_ids)
+		return -EINVAL;
+	event->cpu =3D tx2_pmu->cpu;
+
+	if (event->attr.config >=3D tx2_pmu->max_events)
+		return -EINVAL;
+
+	/* store event id */
+	hwc->config =3D event->attr.config;
+
+	/* Validate the group */
+	if (!tx2_uncore_validate_event_group(event))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void tx2_uncore_event_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc =3D &event->hw;
+	struct tx2_uncore_pmu *tx2_pmu;
+
+	hwc->state =3D 0;
+	tx2_pmu =3D pmu_to_tx2_pmu(event->pmu);
+
+	tx2_pmu->start_event(event, flags);
+	perf_event_update_userpage(event);
+
+	/* Start timer for first event */
+	if (bitmap_weight(tx2_pmu->active_counters,
+				tx2_pmu->max_counters) =3D=3D 1) {
+		hrtimer_start(&tx2_pmu->hrtimer,
+			ns_to_ktime(tx2_pmu->hrtimer_interval),
+			HRTIMER_MODE_REL_PINNED);
+	}
+}
+
+static void tx2_uncore_event_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc =3D &event->hw;
+	struct tx2_uncore_pmu *tx2_pmu;
+
+	if (hwc->state & PERF_HES_UPTODATE)
+		return;
+
+	tx2_pmu =3D pmu_to_tx2_pmu(event->pmu);
+	tx2_pmu->stop_event(event);
+	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
+	hwc->state |=3D PERF_HES_STOPPED;
+	if (flags & PERF_EF_UPDATE) {
+		tx2_uncore_event_update(event);
+		hwc->state |=3D PERF_HES_UPTODATE;
+	}
+}
+
+static int tx2_uncore_event_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc =3D &event->hw;
+	struct tx2_uncore_pmu *tx2_pmu;
+
+	tx2_pmu =3D pmu_to_tx2_pmu(event->pmu);
+
+	/* Allocate a free counter */
+	hwc->idx  =3D alloc_counter(tx2_pmu);
+	if (hwc->idx < 0)
+		return -EAGAIN;
+
+	tx2_pmu->events[hwc->idx] =3D event;
+	/* set counter control and data registers base address */
+	tx2_pmu->init_cntr_base(event, tx2_pmu);
+
+	hwc->state =3D PERF_HES_UPTODATE | PERF_HES_STOPPED;
+	if (flags & PERF_EF_START)
+		tx2_uncore_event_start(event, flags);
+
+	return 0;
+}
+
+static void tx2_uncore_event_del(struct perf_event *event, int flags)
+{
+	struct tx2_uncore_pmu *tx2_pmu =3D pmu_to_tx2_pmu(event->pmu);
+	struct hw_perf_event *hwc =3D &event->hw;
+
+	tx2_uncore_event_stop(event, PERF_EF_UPDATE);
+
+	/* clear the assigned counter */
+	free_counter(tx2_pmu, GET_COUNTERID(event));
+
+	perf_event_update_userpage(event);
+	tx2_pmu->events[hwc->idx] =3D NULL;
+	hwc->idx =3D -1;
+}
+
+static void tx2_uncore_event_read(struct perf_event *event)
+{
+	tx2_uncore_event_update(event);
+}
+
+static enum hrtimer_restart tx2_hrtimer_callback(struct hrtimer *timer)
+{
+	struct tx2_uncore_pmu *tx2_pmu;
+	int max_counters, idx;
+
+	tx2_pmu =3D container_of(timer, struct tx2_uncore_pmu, hrtimer);
+	max_counters =3D tx2_pmu->max_counters;
+
+	if (bitmap_empty(tx2_pmu->active_counters, max_counters))
+		return HRTIMER_NORESTART;
+
+	for_each_set_bit(idx, tx2_pmu->active_counters, max_counters) {
+		struct perf_event *event =3D tx2_pmu->events[idx];
+
+		tx2_uncore_event_update(event);
+	}
+	hrtimer_forward_now(timer, ns_to_ktime(tx2_pmu->hrtimer_interval));
+	return HRTIMER_RESTART;
+}
+
+static int tx2_uncore_pmu_register(
+		struct tx2_uncore_pmu *tx2_pmu)
+{
+	struct device *dev =3D tx2_pmu->dev;
+	char *name =3D tx2_pmu->name;
+
+	/* Perf event registration */
+	tx2_pmu->pmu =3D (struct pmu) {
+		.module         =3D THIS_MODULE,
+		.attr_groups	=3D tx2_pmu->attr_groups,
+		.task_ctx_nr	=3D perf_invalid_context,
+		.event_init	=3D tx2_uncore_event_init,
+		.add		=3D tx2_uncore_event_add,
+		.del		=3D tx2_uncore_event_del,
+		.start		=3D tx2_uncore_event_start,
+		.stop		=3D tx2_uncore_event_stop,
+		.read		=3D tx2_uncore_event_read,
+	};
+
+	tx2_pmu->pmu.name =3D devm_kasprintf(dev, GFP_KERNEL,
+			"%s", name);
+
+	return perf_pmu_register(&tx2_pmu->pmu, tx2_pmu->pmu.name, -1);
+}
+
+static int tx2_uncore_pmu_add_dev(struct tx2_uncore_pmu *tx2_pmu)
+{
+	int ret, cpu;
+
+	cpu =3D cpumask_any_and(cpumask_of_node(tx2_pmu->node),
+			cpu_online_mask);
+
+	tx2_pmu->cpu =3D cpu;
+	hrtimer_init(&tx2_pmu->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	tx2_pmu->hrtimer.function =3D tx2_hrtimer_callback;
+
+	ret =3D tx2_uncore_pmu_register(tx2_pmu);
+	if (ret) {
+		dev_err(tx2_pmu->dev, "%s PMU: Failed to init driver\n",
+				tx2_pmu->name);
+		return -ENODEV;
+	}
+
+	/* register hotplug callback for the pmu */
+	ret =3D cpuhp_state_add_instance(
+			CPUHP_AP_PERF_ARM_TX2_UNCORE_ONLINE,
+			&tx2_pmu->hpnode);
+	if (ret) {
+		dev_err(tx2_pmu->dev, "Error %d registering hotplug", ret);
+		return ret;
+	}
+
+	/* Add to list */
+	list_add(&tx2_pmu->entry, &tx2_pmus);
+
+	dev_dbg(tx2_pmu->dev, "%s PMU UNCORE registered\n",
+			tx2_pmu->pmu.name);
+	return ret;
+}
+
+static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
+		acpi_handle handle, struct acpi_device *adev, u32 type)
+{
+	struct tx2_uncore_pmu *tx2_pmu;
+	void __iomem *base;
+	struct resource res;
+	struct resource_entry *rentry;
+	struct list_head list;
+	int ret;
+
+	INIT_LIST_HEAD(&list);
+	ret =3D acpi_dev_get_resources(adev, &list, NULL, NULL);
+	if (ret <=3D 0) {
+		dev_err(dev, "failed to parse _CRS method, error %d\n", ret);
+		return NULL;
+	}
+
+	list_for_each_entry(rentry, &list, node) {
+		if (resource_type(rentry->res) =3D=3D IORESOURCE_MEM) {
+			res =3D *rentry->res;
+			break;
+		}
+	}
+
+	if (!rentry->res)
+		return NULL;
+
+	acpi_dev_free_resource_list(&list);
+	base =3D devm_ioremap_resource(dev, &res);
+	if (IS_ERR(base)) {
+		dev_err(dev, "PMU type %d: Fail to map resource\n", type);
+		return NULL;
+	}
+
+	tx2_pmu =3D devm_kzalloc(dev, sizeof(*tx2_pmu), GFP_KERNEL);
+	if (!tx2_pmu)
+		return NULL;
+
+	tx2_pmu->dev =3D dev;
+	tx2_pmu->type =3D type;
+	tx2_pmu->base =3D base;
+	tx2_pmu->node =3D dev_to_node(dev);
+	INIT_LIST_HEAD(&tx2_pmu->entry);
+
+	switch (tx2_pmu->type) {
+	case PMU_TYPE_L3C:
+		tx2_pmu->max_counters =3D TX2_PMU_MAX_COUNTERS;
+		tx2_pmu->prorate_factor =3D TX2_PMU_L3_TILES;
+		tx2_pmu->max_events =3D L3_EVENT_MAX;
+		tx2_pmu->hrtimer_interval =3D TX2_PMU_HRTIMER_INTERVAL;
+		tx2_pmu->attr_groups =3D l3c_pmu_attr_groups;
+		tx2_pmu->name =3D devm_kasprintf(dev, GFP_KERNEL,
+				"uncore_l3c_%d", tx2_pmu->node);
+		tx2_pmu->init_cntr_base =3D init_cntr_base_l3c;
+		tx2_pmu->start_event =3D uncore_start_event_l3c;
+		tx2_pmu->stop_event =3D uncore_stop_event_l3c;
+		break;
+	case PMU_TYPE_DMC:
+		tx2_pmu->max_counters =3D TX2_PMU_MAX_COUNTERS;
+		tx2_pmu->prorate_factor =3D TX2_PMU_DMC_CHANNELS;
+		tx2_pmu->max_events =3D DMC_EVENT_MAX;
+		tx2_pmu->hrtimer_interval =3D TX2_PMU_HRTIMER_INTERVAL;
+		tx2_pmu->attr_groups =3D dmc_pmu_attr_groups;
+		tx2_pmu->name =3D devm_kasprintf(dev, GFP_KERNEL,
+				"uncore_dmc_%d", tx2_pmu->node);
+		tx2_pmu->init_cntr_base =3D init_cntr_base_dmc;
+		tx2_pmu->start_event =3D uncore_start_event_dmc;
+		tx2_pmu->stop_event =3D uncore_stop_event_dmc;
+		break;
+	case PMU_TYPE_INVALID:
+		devm_kfree(dev, tx2_pmu);
+		return NULL;
+	}
+
+	return tx2_pmu;
+}
+
+static acpi_status tx2_uncore_pmu_add(acpi_handle handle, u32 level,
+				    void *data, void **return_value)
+{
+	struct tx2_uncore_pmu *tx2_pmu;
+	struct acpi_device *adev;
+	enum tx2_uncore_type type;
+
+	if (acpi_bus_get_device(handle, &adev))
+		return AE_OK;
+	if (acpi_bus_get_status(adev) || !adev->status.present)
+		return AE_OK;
+
+	type =3D get_tx2_pmu_type(adev);
+	if (type =3D=3D PMU_TYPE_INVALID)
+		return AE_OK;
+
+	tx2_pmu =3D tx2_uncore_pmu_init_dev((struct device *)data,
+			handle, adev, type);
+
+	if (!tx2_pmu)
+		return AE_ERROR;
+
+	if (tx2_uncore_pmu_add_dev(tx2_pmu)) {
+		/* Can't add the PMU device, abort */
+		return AE_ERROR;
+	}
+	return AE_OK;
+}
+
+static int tx2_uncore_pmu_online_cpu(unsigned int cpu,
+		struct hlist_node *hpnode)
+{
+	struct tx2_uncore_pmu *tx2_pmu;
+
+	tx2_pmu =3D hlist_entry_safe(hpnode,
+			struct tx2_uncore_pmu, hpnode);
+
+	/* Pick this CPU, If there is no CPU/PMU association and both are
+	 * from same node.
+	 */
+	if ((tx2_pmu->cpu >=3D nr_cpu_ids) &&
+		(tx2_pmu->node =3D=3D cpu_to_node(cpu)))
+		tx2_pmu->cpu =3D cpu;
+
+	return 0;
+}
+
+static int tx2_uncore_pmu_offline_cpu(unsigned int cpu,
+		struct hlist_node *hpnode)
+{
+	int new_cpu;
+	struct tx2_uncore_pmu *tx2_pmu;
+	struct cpumask cpu_online_mask_temp;
+
+	tx2_pmu =3D hlist_entry_safe(hpnode,
+			struct tx2_uncore_pmu, hpnode);
+
+	if (cpu !=3D tx2_pmu->cpu)
+		return 0;
+
+	hrtimer_cancel(&tx2_pmu->hrtimer);
+	cpumask_copy(&cpu_online_mask_temp, cpu_online_mask);
+	cpumask_clear_cpu(cpu, &cpu_online_mask_temp);
+	new_cpu =3D cpumask_any_and(
+			cpumask_of_node(tx2_pmu->node),
+			&cpu_online_mask_temp);
+
+	tx2_pmu->cpu =3D new_cpu;
+	if (new_cpu >=3D nr_cpu_ids)
+		return 0;
+	perf_pmu_migrate_context(&tx2_pmu->pmu, cpu, new_cpu);
+
+	return 0;
+}
+
+static const struct acpi_device_id tx2_uncore_acpi_match[] =3D {
+	{"CAV901C", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, tx2_uncore_acpi_match);
+
+static int tx2_uncore_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	acpi_handle handle;
+	acpi_status status;
+
+	set_dev_node(dev, acpi_get_node(ACPI_HANDLE(dev)));
+
+	if (!has_acpi_companion(dev))
+		return -ENODEV;
+
+	handle =3D ACPI_HANDLE(dev);
+	if (!handle)
+		return -EINVAL;
+
+	/* Walk through the tree for all PMU UNCORE devices */
+	status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
+				     tx2_uncore_pmu_add,
+				     NULL, dev, NULL);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "failed to probe PMU devices\n");
+		return_ACPI_STATUS(status);
+	}
+
+	dev_info(dev, "node%d: pmu uncore registered\n", dev_to_node(dev));
+	return 0;
+}
+
+static int tx2_uncore_remove(struct platform_device *pdev)
+{
+	struct tx2_uncore_pmu *tx2_pmu, *temp;
+	struct device *dev =3D &pdev->dev;
+
+	if (!list_empty(&tx2_pmus)) {
+		list_for_each_entry_safe(tx2_pmu, temp, &tx2_pmus, entry) {
+			if (tx2_pmu->node =3D=3D dev_to_node(dev)) {
+				cpuhp_state_remove_instance_nocalls(
+					CPUHP_AP_PERF_ARM_TX2_UNCORE_ONLINE,
+					&tx2_pmu->hpnode);
+				perf_pmu_unregister(&tx2_pmu->pmu);
+				list_del(&tx2_pmu->entry);
+			}
+		}
+	}
+	return 0;
+}
+
+static struct platform_driver tx2_uncore_driver =3D {
+	.driver =3D {
+		.name		=3D "tx2-uncore-pmu",
+		.acpi_match_table =3D ACPI_PTR(tx2_uncore_acpi_match),
+	},
+	.probe =3D tx2_uncore_probe,
+	.remove =3D tx2_uncore_remove,
+};
+
+static int __init tx2_uncore_driver_init(void)
+{
+	int ret;
+
+	ret =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_TX2_UNCORE_ONLINE,
+				      "perf/tx2/uncore:online",
+				      tx2_uncore_pmu_online_cpu,
+				      tx2_uncore_pmu_offline_cpu);
+	if (ret) {
+		pr_err("TX2 PMU: setup hotplug failed(%d)\n", ret);
+		return ret;
+	}
+	ret =3D platform_driver_register(&tx2_uncore_driver);
+	if (ret)
+		cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_TX2_UNCORE_ONLINE);
+
+	return ret;
+}
+module_init(tx2_uncore_driver_init);
+
+static void __exit tx2_uncore_driver_exit(void)
+{
+	platform_driver_unregister(&tx2_uncore_driver);
+	cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_TX2_UNCORE_ONLINE);
+}
+module_exit(tx2_uncore_driver_exit);
+
+MODULE_DESCRIPTION("ThunderX2 UNCORE PMU driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Ganapatrao Kulkarni <gkulkarni@cavium.com>");
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index e0cd2baa8380..d50b711614f2 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -164,6 +164,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
 	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
 	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
+	CPUHP_AP_PERF_ARM_TX2_UNCORE_ONLINE,
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
--=20
2.18.0

