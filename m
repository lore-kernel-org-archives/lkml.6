Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93B8F601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932489AbeFFJcI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:32:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932395AbeFFJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:32:07 -0400
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] selftests/ftrace: Add ppc support for kprobe args tests
Date: Wed,  6 Jun 2018 15:01:54 +0530
X-Mailer: git-send-email 2.17.0
X-TM-AS-GCONF: 00
x-cbid: 18060609-0016-0000-0000-000001D8AB73
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060609-0017-0000-0000-0000322BB6F9
Message-Id: <20180606093154.10408-1-naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806060109
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add powerpc support for the recently added kprobe args tests.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc  | 8 ++++++++
 .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc  | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index 5ba73035e1d9..a0002563e9ee 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -24,6 +24,14 @@ arm*)
   ARG2=%r1
   OFFS=4
 ;;
+ppc64*)
+  ARG2=%r4
+  OFFS=8
+;;
+ppc*)
+  ARG2=%r4
+  OFFS=4
+;;
 *)
   echo "Please implement other architecture here"
   exit_untested
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
index 231bcd2c4eb5..d026ff4e562f 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
@@ -34,6 +34,13 @@ arm*)
   GOODREG=%r0
   BADREG=%ax
 ;;
+ppc*)
+  GOODREG=%r3
+  BADREG=%msr
+;;
+*)
+  echo "Please implement other architecture here"
+  exit_untested
 esac
 
 test_goodarg() # Good-args
-- 
2.17.0
