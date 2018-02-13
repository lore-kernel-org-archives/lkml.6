Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934771AbeBMLb7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:31:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933926AbeBMLb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:31:57 -0500
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] scripts: kernel_doc: fixup reporting of function identifiers
Date: Tue, 13 Feb 2018 13:31:46 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18021311-0040-0000-0000-0000040F3961
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021311-0041-0000-0000-00002612FBB2
Message-Id: <1518521506-6770-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802130139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When function description includes brackets after the function name as
suggested by Documentation/doc-guide/kernel-doc, the kernel-doc script
omits the function name from "Scanning doc for" report.
Extending match for identifier name with optional brackets fixes this
issue.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index fee8952037b1..a6a9a8ef116c 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1873,7 +1873,7 @@ sub process_file($) {
 	    }
 	    elsif (/$doc_decl/o) {
 		$identifier = $1;
-		if (/\s*([\w\s]+?)\s*-/) {
+		if (/\s*([\w\s]+?)(\(\))?\s*-/) {
 		    $identifier = $1;
 		}
 
-- 
2.7.4
