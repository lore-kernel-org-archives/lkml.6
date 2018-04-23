Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754842AbeDWLBl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:01:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754653AbeDWLBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:01:30 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com,
        pasic@linux.ibm.com, pmorel@linux.ibm.com,
        Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH v2 2/5] vfio: ccw: shorten kernel doc description for pfn_array_pin()
Date: Mon, 23 Apr 2018 13:01:10 +0200
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
References: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042311-0028-0000-0000-0000097C2823
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008905; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01022058; UDB=6.00521638; IPR=6.00801293;
 MB=3.00020722; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 11:01:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042311-0029-0000-0000-00003A7DD06B
Message-Id: <20180423110113.59385-3-bjsdjshi@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230116
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel doc description for usage of the struct pfn_array in
pfn_array_pin() is unnecessary long. Let's shorten it by describing
the contents of the struct pfn_array fields at the struct's definition
instead.

Suggested-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 62d66e195304..e8fe7450702e 100644
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
2.13.5
