Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753920AbeE1Hok (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:44:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753884AbeE1Hoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:44:39 -0400
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf docu: Update section on cpu topology
Date: Mon, 28 May 2018 09:44:33 +0200
X-Mailer: git-send-email 2.16.3
X-TM-AS-GCONF: 00
x-cbid: 18052807-0040-0000-0000-0000045E15CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052807-0041-0000-0000-00002102803B
Message-Id: <20180528074433.16652-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805280095
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an explanation of each cpu's core and socket
identifier to the documentation.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index d00f0d51cab8..c57904a526ce 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -153,10 +153,18 @@ struct {
 	HEADER_CPU_TOPOLOGY = 13,
 
 String lists defining the core and CPU threads topology.
+The string lists are followed by a variable length array
+which contains core_id and socket_id of each cpu.
+The number of entries can be determined by the size of the
+section minus the sizes of both string lists.
 
 struct {
        struct perf_header_string_list cores; /* Variable length */
        struct perf_header_string_list threads; /* Variable length */
+       struct {
+	      uint32_t core_id;
+	      uint32_t socket_id;
+       } cpus[nr]; /* Variable length records */
 };
 
 Example:
-- 
2.14.3
