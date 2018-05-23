Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753833AbeEWC4z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 22:56:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753705AbeEWC4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 22:56:54 -0400
From: Dong Jia Shi <bjsdjshi@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com,
        pasic@linux.ibm.com, pmorel@linux.ibm.com
Subject: [PATCH v4 0/4] vfio: ccw: error handling fixes and improvements
Date: Wed, 23 May 2018 04:56:41 +0200
X-Mailer: git-send-email 2.16.3
X-TM-AS-GCONF: 00
x-cbid: 18052302-0016-0000-0000-000008C8397A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009069; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036291; UDB=6.00530123; IPR=6.00815420;
 MB=3.00021250; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 02:56:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052302-0017-0000-0000-00003EDB9583
Message-Id: <20180523025645.8978-1-bjsdjshi@linux.ibm.com>
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

Dear Reviewers,

Here is a new version for this patch series.

We didn't get agreement on patch #4 (#5 in v2) in the former cycle though,
I made it based on my understanding. We can continue discussing on it.

Changelog:
v3->v4:
 - Change mail address from @linux.vnet.ibm.com to @linux.ibm.com

v2->v3:
 - #2. Reworded comment message.
 - #4. Trace failure only, trace all error path, and a common knob for all
       failure paths.

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

Halil Pasic (1):
  vfio: ccw: add traceponits for interesting error paths

 drivers/s390/cio/Makefile         |   1 +
 drivers/s390/cio/vfio_ccw_cp.c    | 121 +++++++++++++++++++-------------------
 drivers/s390/cio/vfio_ccw_fsm.c   |  17 +++++-
 drivers/s390/cio/vfio_ccw_trace.h |  54 +++++++++++++++++
 4 files changed, 130 insertions(+), 63 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_trace.h

-- 
2.16.3
