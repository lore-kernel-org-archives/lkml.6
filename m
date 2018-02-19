Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeBSKZQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:25:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752275AbeBSKZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:25:15 -0500
From: Thomas Richter <tmricht@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf s390: Fix reading cpuid model information
Date: Mon, 19 Feb 2018 11:24:44 +0100
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18021910-0020-0000-0000-000003F92A13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021910-0021-0000-0000-0000428D3270
Message-Id: <20180219102444.96900-1-tmricht@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802190130
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit feb3d2d955c8 (perf record: Provide detailed information
on s390 CPU") fixed a  build error on Ubuntu. However the
fix uses the wrong size to print the model information.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/arch/s390/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index 231294b80dc4..a4c30f1c70be 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -81,7 +81,7 @@ int get_cpuid(char *buffer, size_t sz)
 			line2 = line + strlen(SYSINFO_MODEL);
 
 			while ((cp = strtok_r(line2, "\n ", &line2))) {
-				mdsize += scnprintf(model + mdsize, sizeof(type) - mdsize,
+				mdsize += scnprintf(model + mdsize, sizeof(model) - mdsize,
 						    "%s%s", model[0] ? "," : "", cp);
 			}
 			break;
-- 
2.14.3
