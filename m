Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeCLKiT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:38:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752087AbeCLKiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:38:17 -0400
From: Thomas Richter <tmricht@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf stat: Make function perf_stat_evsel_id_init static
Date: Mon, 12 Mar 2018 11:38:07 +0100
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031210-0008-0000-0000-000004DB6299
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031210-0009-0000-0000-00001E6E8F94
Message-Id: <20180312103807.45069-2-tmricht@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803120124
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function perf_stat_evsel_id_init() has global linkage
but is only used in util/stat.c. Make it static.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/util/stat.c | 2 +-
 tools/perf/util/stat.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 32235657c1ac..a0061e0b0fad 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -92,7 +92,7 @@ static const char *id_str[PERF_STAT_EVSEL_ID__MAX] = {
 };
 #undef ID
 
-void perf_stat_evsel_id_init(struct perf_evsel *evsel)
+static void perf_stat_evsel_id_init(struct perf_evsel *evsel)
 {
 	struct perf_stat_evsel *ps = evsel->stats;
 	int i;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index dbc6f7134f61..679994a5cd07 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -126,8 +126,6 @@ bool __perf_evsel_stat__is(struct perf_evsel *evsel,
 #define perf_stat_evsel__is(evsel, id) \
 	__perf_evsel_stat__is(evsel, PERF_STAT_EVSEL_ID__ ## id)
 
-void perf_stat_evsel_id_init(struct perf_evsel *evsel);
-
 extern struct runtime_stat rt_stat;
 extern struct stats walltime_nsecs_stats;
 
-- 
2.14.3
