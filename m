Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754142AbeDWDNs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:13:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753993AbeDWDNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:13:01 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 5/6] rcutorture: Abbreviate kvm.sh summary lines
Date: Sun, 22 Apr 2018 20:14:04 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180423031346.GA28371@linux.vnet.ibm.com>
References: <20180423031346.GA28371@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042303-0024-0000-0000-0000034CD0BB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021901; UDB=6.00521544; IPR=6.00801137;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:12:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0025-0000-0000-000047C2ED44
Message-Id: <1524453245-29299-5-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230033
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of the end-of-test state, it is not uncommon for the
kvm.sh summary lines to overflow 80 characters.  This commit therefore
applies abbreviations in order to make the line fit into 80 characters
with high probability.

And yes, I did make heavy use of punched cards back in the day, so 80
columns it is for my xterms!  ;-)

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
index 166aed550bc9..477ecb1293ab 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
@@ -42,7 +42,7 @@ if test -z "$ngps"
 then
 	echo "$configfile ------- " $stopstate
 else
-	title="$configfile ------- $ngps grace periods"
+	title="$configfile ------- $ngps GPs"
 	dur=`sed -e 's/^.* rcutorture.shutdown_secs=//' -e 's/ .*$//' < $i/qemu-cmd 2> /dev/null`
 	if test -z "$dur"
 	then
@@ -50,7 +50,7 @@ else
 	else
 		ngpsps=`awk -v ngps=$ngps -v dur=$dur '
 			BEGIN { print ngps / dur }' < /dev/null`
-		title="$title ($ngpsps per second)"
+		title="$title ($ngpsps/s)"
 	fi
 	echo $title $stopstate
 	nclosecalls=`grep --binary-files=text 'torture: Reader Batch' $i/console.log | tail -1 | awk '{for (i=NF-8;i<=NF;i++) sum+=$i; } END {print sum}'`
-- 
2.5.2
