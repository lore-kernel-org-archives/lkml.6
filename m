Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbeDRIIL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:08:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753117AbeDRIIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:08:07 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 2/7] docs/vm: hugetlbpage: move section about kernel development to hugetlbfs_reserv
Date: Wed, 18 Apr 2018 11:07:45 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524038870-413-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1524038870-413-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041808-0020-0000-0000-000004132F0F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041808-0021-0000-0000-000042A77388
Message-Id: <1524038870-413-3-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180076
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hugetlbpage describes hugetlbfs from the user perspective and newer
hugetlbfs_reserv document targets kernel developers. Hence the section
about hugetlbfs kernel development naturally belongs there.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/hugetlbfs_reserv.rst | 8 ++++++++
 Documentation/vm/hugetlbpage.rst      | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/vm/hugetlbfs_reserv.rst b/Documentation/vm/hugetlbfs_reserv.rst
index 36a87a2..9d20076 100644
--- a/Documentation/vm/hugetlbfs_reserv.rst
+++ b/Documentation/vm/hugetlbfs_reserv.rst
@@ -583,5 +583,13 @@ of cpusets or memory policy there is no guarantee that huge pages will be
 available on the required nodes.  This is true even if there are a sufficient
 number of global reservations.
 
+Hugetlbfs regression testing
+============================
 
+The most complete set of hugetlb tests are in the libhugetlbfs repository.
+If you modify any hugetlb related code, use the libhugetlbfs test suite
+to check for regressions.  In addition, if you add any new hugetlb
+functionality, please add appropriate tests to libhugetlbfs.
+
+--
 Mike Kravetz, 7 April 2017
diff --git a/Documentation/vm/hugetlbpage.rst b/Documentation/vm/hugetlbpage.rst
index 99ad5d9..2b374d1 100644
--- a/Documentation/vm/hugetlbpage.rst
+++ b/Documentation/vm/hugetlbpage.rst
@@ -379,11 +379,3 @@ The `libhugetlbfs`_  library provides a wide range of userspace tools
 to help with huge page usability, environment setup, and control.
 
 .. _libhugetlbfs: https://github.com/libhugetlbfs/libhugetlbfs
-
-Kernel development regression testing
-=====================================
-
-The most complete set of hugetlb tests are in the libhugetlbfs repository.
-If you modify any hugetlb related code, use the libhugetlbfs test suite
-to check for regressions.  In addition, if you add any new hugetlb
-functionality, please add appropriate tests to libhugetlbfs.
-- 
2.7.4
