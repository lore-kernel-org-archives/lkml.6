Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3D9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128CD2064C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbfAKLxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:53:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731266AbfAKLxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:53:14 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0BBnJjo041680
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:53:14 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pxt3jhn3n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:53:13 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 11 Jan 2019 11:53:11 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Jan 2019 11:53:08 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0BBr7nD57737416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 11:53:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 202E052050;
        Fri, 11 Jan 2019 11:53:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D733B52051;
        Fri, 11 Jan 2019 11:53:06 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [Patch 2/4] perf report: Display s390 diagnostic counter sets
Date:   Fri, 11 Jan 2019 12:52:57 +0100
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190111115259.99438-1-tmricht@linux.ibm.com>
References: <20190111115259.99438-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011111-0016-0000-0000-00000243E4FA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011111-0017-0000-0000-0000329DEE16
Message-Id: <20190111115259.99438-2-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s390 the event bc000 (also named CF_DIAG)
extracts the CPU Measurement Facility diagnostic counter sets
and displays them as counter number and counter value
pairs sorted by counter set number.

Output:
 [root@s35lp76 perf]# ./perf report -D --stdio

 [00000000] Counterset:0 Counters:6
   Counter:000 Value:0x000000000085ec36 Counter:001 Value:0x0000000000796c94
   Counter:002 Value:0x0000000000005ada Counter:003 Value:0x0000000000092460
   Counter:004 Value:0x0000000000006073 Counter:005 Value:0x00000000001a9a73
 [0x000038] Counterset:1 Counters:2
   Counter:000 Value:0x000000000007c59f Counter:001 Value:0x000000000002fad6
 [0x000050] Counterset:2 Counters:16
   Counter:000 Value:000000000000000000 Counter:001 Value:000000000000000000
   Counter:002 Value:000000000000000000 Counter:003 Value:000000000000000000
   Counter:004 Value:000000000000000000 Counter:005 Value:000000000000000000
   Counter:006 Value:000000000000000000 Counter:007 Value:000000000000000000
   Counter:008 Value:000000000000000000 Counter:009 Value:000000000000000000
   Counter:010 Value:000000000000000000 Counter:011 Value:000000000000000000
   Counter:012 Value:000000000000000000 Counter:013 Value:000000000000000000
   Counter:014 Value:000000000000000000 Counter:015 Value:000000000000000000
 [0x0000d8] Counterset:3 Counters:128
   Counter:000 Value:0x000000000000020f Counter:001 Value:0x00000000000001d8
   Counter:002 Value:0x000000000000d7fa Counter:003 Value:0x000000000000008b
   ...

The number in brackets is the offset into the raw data field
of the sample.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/arch/s390/util/Build         |   2 +-
 tools/perf/arch/s390/util/trace_event.c | 146 ++++++++++++++++++++++++++++++++
 tools/perf/util/s390-cpumcf-kernel.h    |  61 +++++++++++++
 3 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/s390/util/trace_event.c
 create mode 100644 tools/perf/util/s390-cpumcf-kernel.h

diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
index 4a233683c684..c21f540d0e56 100644
--- a/tools/perf/arch/s390/util/Build
+++ b/tools/perf/arch/s390/util/Build
@@ -4,6 +4,6 @@ libperf-y += kvm-stat.o
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
-libperf-y += machine.o
+libperf-y += machine.o trace_event.o
 
 libperf-$(CONFIG_AUXTRACE) += auxtrace.o
diff --git a/tools/perf/arch/s390/util/trace_event.c b/tools/perf/arch/s390/util/trace_event.c
new file mode 100644
index 000000000000..c69d76945f61
--- /dev/null
+++ b/tools/perf/arch/s390/util/trace_event.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright IBM Corp. 2018
+ * Author(s): Thomas Richter <tmricht@linux.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ * Architecture specific trace_event function. Save event's bc000 raw data
+ * to file. File name is aux.ctr.## where ## stands for the CPU number the
+ * sample was taken from.
+ */
+
+#include <unistd.h>
+#include <stdio.h>
+#include <string.h>
+#include <inttypes.h>
+
+#include <sys/stat.h>
+
+#include "debug.h"
+#include "util.h"
+#include "auxtrace.h"
+#include "session.h"
+#include "evlist.h"
+#include "config.h"
+#include "color.h"
+#include "s390-cpumcf-kernel.h"
+
+static size_t ctrset_size(struct cf_ctrset_entry *set)
+{
+	return sizeof(*set) + set->ctr * sizeof(u64);
+}
+
+static bool ctrset_valid(struct cf_ctrset_entry *set)
+{
+	return set->def == S390_CPUMCF_DIAG_DEF;
+}
+
+/* CPU Measurement Counter Facility raw data is a byte stream. It is 8 byte
+ * aligned and might have trailing padding bytes.
+ * Display the raw data on screen.
+ */
+static bool s390_cpumcfdg_testctr(struct perf_sample *sample)
+{
+	size_t len = sample->raw_size, offset = 0;
+	unsigned char *buf = sample->raw_data;
+	struct cf_trailer_entry *te;
+	struct cf_ctrset_entry *ce;
+
+	if (!len)
+		return false;
+	while (offset < len) {
+		ce = (struct cf_ctrset_entry *)(buf + offset);
+		if (!ctrset_valid(ce) || offset + ctrset_size(ce) > len) {
+			/* Raw data for counter sets are always multiple of 8
+			 * bytes. Prepending a 4 bytes size field to the
+			 * raw data block in the sample causes the perf tool
+			 * to append 4 padding bytes to make the raw data part
+			 * of the sample a multiple of eight bytes again.
+			 *
+			 * If the last entry (trailer) is 4 bytes off the raw
+			 * area data end, all is good.
+			 */
+			if (len - offset - sizeof(*te) == 4)
+				break;
+			pr_err("Invalid counter set entry at %#"  PRIx64 "\n",
+			       offset);
+			return false;
+		}
+		offset += ctrset_size(ce);
+	}
+	return true;
+}
+
+/* Dump event bc000 on screen, already tested on correctness. */
+static void s390_cpumcfdg_dumptrail(const char *color, size_t offset,
+				    struct cf_trailer_entry *te)
+{
+	color_fprintf(stdout, color, "    [%#08zx] Trailer:%c%c%c%c%c"
+		      " Cfvn:%d Csvn:%d Speed:%d TOD:%#llx\n",
+		      offset, te->clock_base ? 'T' : ' ',
+		      te->speed ? 'S' : ' ', te->mtda ? 'M' : ' ',
+		      te->caca ? 'C' : ' ', te->lcda ? 'L' : ' ',
+		      te->cfvn, te->csvn, te->cpu_speed, te->timestamp);
+	color_fprintf(stdout, color, "\t\t1:%lx 2:%lx 3:%lx TOD-Base:%#llx"
+		      " Type:%x\n\n",
+		      te->progusage1, te->progusage2, te->progusage3,
+		      te->tod_base, te->mach_type);
+}
+
+static void s390_cpumcfdg_dump(struct perf_sample *sample)
+{
+	size_t i, len = sample->raw_size, offset = 0;
+	unsigned char *buf = sample->raw_data;
+	const char *color = PERF_COLOR_BLUE;
+	struct cf_ctrset_entry *ce;
+	u64 *p;
+
+	while (offset < len) {
+		ce = (struct cf_ctrset_entry *)(buf + offset);
+
+		if (!ctrset_valid(ce)) {	/* Print trailer */
+			s390_cpumcfdg_dumptrail(color, offset,
+						(struct cf_trailer_entry *)ce);
+			return;
+		}
+
+		color_fprintf(stdout, color, "    [%#08zx] Counterset:%d"
+			      " Counters:%d\n", offset, ce->set, ce->ctr);
+		for (i = 0, p = (u64 *)(ce + 1); i < ce->ctr; i += 2, p += 2)
+			color_fprintf(stdout, color,
+				      "\tCounter:%03d Value:%#018lx"
+				      " Counter:%03d Value:%#018lx\n",
+				      i, *p, i + 1, *(p + 1));
+		offset += ctrset_size(ce);
+	}
+}
+
+/* S390 specific trace event function. Check for PERF_RECORD_SAMPLE events
+ * and if the event was triggered by a counter set diagnostic event display
+ * its raw data.
+ * The function is only invoked when the dump flag -D is set.
+ * When flag --itrace=d has been specified on the command line save the
+ * counter set data to a file named 'aux.ctr.##'.
+ */
+void arch__trace_event(struct perf_evlist *evlist, union perf_event *event,
+		       struct perf_sample *sample)
+{
+	struct perf_evsel *ev_bc000;
+
+	if (event->header.type != PERF_RECORD_SAMPLE)
+		return;
+
+	ev_bc000 = perf_evlist__event2evsel(evlist, event);
+	if (ev_bc000 == NULL || ev_bc000->attr.config != 0xbc000)
+		return;
+
+	/* Display raw data on screen */
+	if (!s390_cpumcfdg_testctr(sample)) {
+		pr_err("Invalid counter set data encountered\n");
+		return;
+	}
+	s390_cpumcfdg_dump(sample);
+}
diff --git a/tools/perf/util/s390-cpumcf-kernel.h b/tools/perf/util/s390-cpumcf-kernel.h
new file mode 100644
index 000000000000..6ae89f8a6efd
--- /dev/null
+++ b/tools/perf/util/s390-cpumcf-kernel.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Auxtrace support for s390 CPU measurement counet set diagnostic facility
+ *
+ *  Copyright IBM Corp. 2018
+ *  Author(s): Hendrik Brueckner <brueckner@linux.ibm.com>
+ *	       Thomas Richter <tmricht@linux.ibm.com>
+ */
+#ifndef S390_CPUMCF_KERNEL_H
+#define S390_CPUMCF_KERNEL_H
+
+#define	S390_CPUMCF_DIAG_DEF	0xfeef	/* Counter diagnostic entry ID */
+
+struct cf_ctrset_entry {	/* CPU-M CF counter set entry (8 byte) */
+	unsigned int def:16;	/* 0-15  Data Entry Format */
+	unsigned int set:16;	/* 16-23 Counter set identifier */
+	unsigned int ctr:16;	/* 24-39 Number of stored counters */
+	unsigned int res1:16;	/* 40-63 Reserved */
+};
+
+struct cf_trailer_entry {	/* CPU-M CF trailer for raw traces (64 byte) */
+	/* 0 - 7 */
+	union {
+		struct {
+			unsigned int clock_base:1;	/* TOD clock base */
+			unsigned int speed:1;		/* CPU speed */
+			/* Measurement alerts */
+			unsigned int mtda:1;	/* Loss of MT ctr. data alert */
+			unsigned int caca:1;	/* Counter auth. change alert */
+			unsigned int lcda:1;	/* Loss of counter data alert */
+		};
+		unsigned long flags;		/* 0-63    All indicators */
+	};
+	/* 8 - 15 */
+	unsigned int cfvn:16;			/* 64-79   Ctr First Version */
+	unsigned int csvn:16;			/* 80-95   Ctr Second Version */
+	unsigned int cpu_speed:32;		/* 96-127  CPU speed */
+	/* 16 - 23 */
+	unsigned long timestamp;		/* 128-191 Timestamp (TOD) */
+	/* 24 - 55 */
+	union {
+		struct {
+			unsigned long progusage1;
+			unsigned long progusage2;
+			unsigned long progusage3;
+			unsigned long tod_base;
+		};
+		unsigned long progusage[4];
+	};
+	/* 56 - 63 */
+	unsigned int mach_type:16;		/* Machine type */
+	unsigned int res1:16;			/* Reserved */
+	unsigned int res2:32;			/* Reserved */
+};
+
+#define	CPUMF_CTR_SET_BASIC	0	/* Basic Counter Set */
+#define	CPUMF_CTR_SET_USER	1	/* Problem-State Counter Set */
+#define	CPUMF_CTR_SET_CRYPTO	2	/* Crypto-Activity Counter Set */
+#define	CPUMF_CTR_SET_EXT	3	/* Extended Counter Set */
+#define	CPUMF_CTR_SET_MT_DIAG	4	/* MT-diagnostic Counter Set */
+#endif
-- 
2.14.3

