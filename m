Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67D8C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DA920851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfAQJaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:30:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728823AbfAQJaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:30:23 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0H9TAWq027645
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 04:30:22 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q2pj6sn9j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 04:30:22 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Thu, 17 Jan 2019 09:30:20 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 09:30:16 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0H9UFac54067390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 09:30:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5332CA4065;
        Thu, 17 Jan 2019 09:30:15 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20487A405D;
        Thu, 17 Jan 2019 09:30:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Jan 2019 09:30:15 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCHv2 2/3] perf report: Display names in s390 diagnostic counter sets
Date:   Thu, 17 Jan 2019 10:30:02 +0100
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190117093003.96287-1-tmricht@linux.ibm.com>
References: <20190117093003.96287-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011709-0016-0000-0000-00000246A1D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011709-0017-0000-0000-000032A0C34E
Message-Id: <20190117093003.96287-3-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s390 the CPU Measurement Facility diagnostic counter sets are
displayed by counter number and value. Add the logical counter name
in the output (if it is available). Otherwise "unknown" is shown.

Output before:
 [root@s35lp76 perf]# ./perf report -D --stdio
 [00000000] Counterset:0 Counters:6
   Counter:000 Value:0x000000000085ec36 Counter:001 Value:0x0000000000796c94
   Counter:002 Value:0x0000000000005ada Counter:003 Value:0x0000000000092460
   Counter:004 Value:0x0000000000006073 Counter:005 Value:0x00000000001a9a73
 [0x000038] Counterset:1 Counters:2
   Counter:000 Value:0x000000000007c59f Counter:001 Value:0x000000000002fad6
 [0x000050] Counterset:2 Counters:16
   Counter:000 Value:000000000000000000 Counter:001 Value:000000000000000000

Output after:
    [root@s35lp76 perf]# ./perf report -D --stdio

 [00000000] Counterset:0 Counters:6
     Counter:000 cpu_cycles Value:0x000000000085ec36
     Counter:001 instructions Value:0x0000000000796c94
     Counter:002 l1i_dir_writes Value:0x0000000000005ada
     Counter:003 l1i_penalty_cycles Value:0x0000000000092460
     Counter:004 l1d_dir_writes Value:0x0000000000006073
     Counter:005 l1d_penalty_cycles Value:0x00000000001a9a73
 [0x000038] Counterset:1 Counters:2
     Counter:000 problem_state_cpu_cycles Value:0x000000000007c59f
     Counter:001 problem_state_instructions Value:0x000000000002fad6
 [0x000050] Counterset:2 Counters:16
     Counter:000 prng_functions Value:000000000000000000

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/util/s390-sample-raw.c | 59 +++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index ae16c38ce296..73797bda919d 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -28,6 +28,7 @@
 #include "config.h"
 #include "color.h"
 #include "s390-cpumcf-kernel.h"
+#include "pmu-events/pmu-events.h"
 
 static size_t ctrset_size(struct cf_ctrset_entry *set)
 {
@@ -111,14 +112,61 @@ static void s390_cpumcfdg_dumptrail(const char *color, size_t offset,
 		      te.tod_base, te.mach_type);
 }
 
+/* Return starting number of a counter set */
+static int get_counterset_start(int setnr)
+{
+	switch (setnr) {
+	case CPUMF_CTR_SET_BASIC:		/* Basic counter set */
+		return 0;
+	case CPUMF_CTR_SET_USER:		/* Problem state counter set */
+		return 32;
+	case CPUMF_CTR_SET_CRYPTO:		/* Crypto counter set */
+		return 64;
+	case CPUMF_CTR_SET_EXT:			/* Extended counter set */
+		return 128;
+	case CPUMF_CTR_SET_MT_DIAG:		/* Diagnostic counter set */
+		return 448;
+	default:
+		return -1;
+	}
+}
+
+/* Scan the PMU table and extract the logical name of a counter from the
+ * PMU events table. Input is the counter set and counter number with in the
+ * set. Construct the event number and use this as key. If they match return
+ * the name of this counter.
+ * If no match is found a NULL pointer is returned.
+ */
+static const char *get_counter_name(int set, int nr, struct pmu_events_map *map)
+{
+	int rc, event_nr, wanted = get_counterset_start(set) + nr;
+
+	if (map) {
+		struct pmu_event *evp = map->table;
+
+		for (; evp->name || evp->event || evp->desc; ++evp) {
+			if (evp->name == NULL || evp->event == NULL)
+				continue;
+			rc = sscanf(evp->event, "event=%x", &event_nr);
+			if (rc == 1 && event_nr == wanted)
+				return evp->name;
+		}
+	}
+	return NULL;
+}
+
 static void s390_cpumcfdg_dump(struct perf_sample *sample)
 {
 	size_t i, len = sample->raw_size, offset = 0;
 	unsigned char *buf = sample->raw_data;
 	const char *color = PERF_COLOR_BLUE;
 	struct cf_ctrset_entry *cep, ce;
+	struct pmu_events_map *map;
+	struct perf_pmu pmu;
 	u64 *p;
 
+	memset(&pmu, 0, sizeof(pmu));
+	map = perf_pmu__find_map(&pmu);
 	while (offset < len) {
 		cep = (struct cf_ctrset_entry *)(buf + offset);
 
@@ -135,12 +183,13 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
 
 		color_fprintf(stdout, color, "    [%#08zx] Counterset:%d"
 			      " Counters:%d\n", offset, ce.set, ce.ctr);
-		for (i = 0, p = (u64 *)(cep + 1); i < ce.ctr; i += 2, p += 2)
+		for (i = 0, p = (u64 *)(cep + 1); i < ce.ctr; ++i, ++p) {
+			const char *ev_name = get_counter_name(ce.set, i, map);
+
 			color_fprintf(stdout, color,
-				      "\tCounter:%03d Value:%#018lx"
-				      " Counter:%03d Value:%#018lx\n",
-				      i, be64_to_cpu(*p),
-				      i + 1, be64_to_cpu(*(p + 1)));
+				      "\tCounter:%03d %s Value:%#018lx\n", i,
+				      ev_name ?: "<unknown>", be64_to_cpu(*p));
+		}
 		offset += ctrset_size(&ce);
 	}
 }
-- 
2.14.3

