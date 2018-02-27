Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeB0G4O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 01:56:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751759AbeB0G4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 01:56:13 -0500
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>, crml <criu@openvz.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] init/Kconfig: make CHECKPOINT_RESTORE select PROC_PAGE_MONITOR
Date: Tue, 27 Feb 2018 08:55:04 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18022706-0020-0000-0000-000003FC440F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022706-0021-0000-0000-0000429067D2
Message-Id: <1519714504-28894-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802270082
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpointing a process requires knowledge about the process memory layout
which is obtained from /proc/<pid>/smaps, /proc/<pid>/pagemap etc.
Make sure these interfaces are available only when
CONFIG_CHECKPOINT_RESTORE=y

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index e37f4b2a6445..63c1fd5bc360 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1328,6 +1328,7 @@ config MEMBARRIER
 config CHECKPOINT_RESTORE
 	bool "Checkpoint/restore support" if EXPERT
 	select PROC_CHILDREN
+	select PROC_PAGE_MONITOR
 	default n
 	help
 	  Enables additional kernel features in a sake of checkpoint/restore.
-- 
2.7.4
