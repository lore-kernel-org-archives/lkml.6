Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeBTSgy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:36:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751814AbeBTSgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:36:43 -0500
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Matthew Wilcox <willy@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] doc-guide: kernel-doc: add comment about formatting verification
Date: Tue, 20 Feb 2018 20:36:25 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18022018-0020-0000-0000-000003F9BBAD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022018-0021-0000-0000-0000428DCA10
Message-Id: <1519151785-25997-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802200223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no automated checking for kernel-doc comments except
running 'kernel-doc -v -none <filename>'. Mention the possibility to run
kernel-doc to verify formatting of the comments in the kernel-doc guide.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
v2:
* fix typo
* add a sentence about using 'make W=n'

 Documentation/doc-guide/kernel-doc.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index c6c3297..80383b1 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -44,6 +44,17 @@ that somebody changing the code will also change the documentation. The
 overview kernel-doc comments may be placed anywhere at the top indentation
 level.
 
+Running the ``kernel-doc`` tool with increased verbosity and without actual
+output generation may be used to verify proper formatting of the
+documentation comments. For example::
+
+	scripts/kernel-doc -v -none drivers/foo/bar.c
+
+The documentation format is verified by the kernel build when it is
+requested to perform extra gcc checks::
+
+	make W=n
+
 Function documentation
 ----------------------
 
-- 
2.7.4
