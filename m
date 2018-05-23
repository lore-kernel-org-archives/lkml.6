Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbeEWC5B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 22:57:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753849AbeEWC45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 22:56:57 -0400
From: Dong Jia Shi <bjsdjshi@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com,
        pasic@linux.ibm.com, pmorel@linux.ibm.com
Subject: [PATCH v4 1/4] vfio: ccw: shorten kernel doc description for pfn_array_pin()
Date: Wed, 23 May 2018 04:56:42 +0200
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180523025645.8978-1-bjsdjshi@linux.ibm.com>
References: <20180523025645.8978-1-bjsdjshi@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052302-0024-0000-0000-00001876DA31
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009069; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036291; UDB=6.00530123; IPR=6.00815419;
 MB=3.00021250; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 02:56:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052302-0025-0000-0000-0000501CD9CA
Message-Id: <20180523025645.8978-2-bjsdjshi@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230025
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel doc description for usage of the struct pfn_array in
pfn_array_pin() is unnecessary long. Let's shorten it by describing
the contents of the struct pfn_array fields at the struct's definition
instead.

Suggested-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index dce92b2a895d..b38ef387e4f0 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -23,9 +23,13 @@
 #define CCWCHAIN_LEN_MAX	256
 
 struct pfn_array {
+	/* Starting guest physical I/O address. */
 	unsigned long		pa_iova;
+	/* Array that stores PFNs of the pages need to pin. */
 	unsigned long		*pa_iova_pfn;
+	/* Array that receives PFNs of the pages pinned. */
 	unsigned long		*pa_pfn;
+	/* Number of pages to pin/pinned from @pa_iova. */
 	int			pa_nr;
 };
 
@@ -53,14 +57,8 @@ struct ccwchain {
  * Attempt to pin user pages in memory.
  *
  * Usage of pfn_array:
- * @pa->pa_iova     starting guest physical I/O address. Assigned by caller.
- * @pa->pa_iova_pfn array that stores PFNs of the pages need to pin. Allocated
- *                  by caller.
- * @pa->pa_pfn      array that receives PFNs of the pages pinned. Allocated by
- *                  caller.
- * @pa->pa_nr       number of pages from @pa->pa_iova to pin. Assigned by
- *                  caller.
- *                  number of pages pinned. Assigned by callee.
+ * Any field in this structure should be initialized by caller.
+ * We expect @pa->pa_nr > 0, and its value will be assigned by callee.
  *
  * Returns:
  *   Number of pages pinned on success.
-- 
2.16.3
