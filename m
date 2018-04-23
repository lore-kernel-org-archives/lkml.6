Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754756AbeDWLB2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:01:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754651AbeDWLBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:01:24 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com,
        pasic@linux.ibm.com, pmorel@linux.ibm.com,
        Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH v2 0/5] vfio: ccw: error handling fixes and improvements
Date: Mon, 23 Apr 2018 13:01:08 +0200
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18042311-0028-0000-0000-0000097C2816
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008905; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01022058; UDB=6.00521638; IPR=6.00801293;
 MB=3.00020722; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 11:01:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042311-0029-0000-0000-00003A7DD04B
Message-Id: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
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

Dear Reviewers,

Here is a new version for this patch series.

We didn't get agreement on patch #5 (#4 in v1) in the former cycle though,
I made it based on my understanding. We can continue discussing on it.

Changelog:
v1->v2:
 - #1. Reworded commit message and comment, plus some typo fixes.
 - #2. New patch.
 - #3. Added the missing suggested-by Pierre.
       Fixed typos.
       Added sanity check on pa->pa_iova_pfn and updated comments accordingly.
 - #4. Removed unused idaw_nr.
 - #5. Replaced leading white spaces with TABs.
       Traced the function in anycase.

Dong Jia Shi (3):
  vfio: ccw: shorten kernel doc description for pfn_array_pin()
  vfio: ccw: refactor and improve pfn_array_alloc_pin()
  vfio: ccw: set ccw->cda to NULL defensively

Halil Pasic (2):
  vfio: ccw: fix cleanup if cp_prefetch fails
  vfio: ccw: add traceponits for interesting error paths

 drivers/s390/cio/Makefile         |   1 +
 drivers/s390/cio/vfio_ccw_cp.c    | 134 ++++++++++++++++++++------------------
 drivers/s390/cio/vfio_ccw_fsm.c   |  16 ++++-
 drivers/s390/cio/vfio_ccw_trace.h |  77 ++++++++++++++++++++++
 4 files changed, 164 insertions(+), 64 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_trace.h

-- 
2.13.5
