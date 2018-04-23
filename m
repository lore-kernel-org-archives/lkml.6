Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753967AbeDWDMk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:12:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753909AbeDWDMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:12:38 -0400
Date: Sun, 22 Apr 2018 20:13:46 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com
Subject: [PATCH tip/core/rcu 0/6] Torture-test updates for v4.18
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042303-0024-0000-0000-0000034CD0B8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021901; UDB=6.00521544; IPR=6.00801137;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:12:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0025-0000-0000-000047C2ED1F
Message-Id: <20180423031346.GA28371@linux.vnet.ibm.com>
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

Hello!

This series contains torture-test updates:

1.	Add a script to edit output from failed runs.  Running this
	script takes your editor through the build errors and the various
	problems in the console output, for each such file, first showing
	a summary of the errors and then the full output.

2.	Code cleanup: Fold parse-torture.sh into parse-console.sh.

3.	Output end-of-test state onto the console for rcutorture, which
	can help locate cases where RCU is unnecessarily starting new
	grace periods.	Of course, if you are testing the default RCU
	flavor, the kernel probably asked for another grace period,
	but it can be useful for the other RCU flavors.

4.	Print the above end-of-test state in the rcutorture test
	summary provided by the rcutorture scripting.

5.	Abbreviate kvm.sh summary lines to avoid line wrap.

6.	Make kvm-find-errors.sh find build warnings.

							Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcutorture.c                                   |    8 
 b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh |   60 ++++++
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh |   12 -
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh     |    4 
 b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh  |    1 
 b/tools/testing/selftests/rcutorture/bin/parse-console.sh   |  115 ++++++++++--
 tools/testing/selftests/rcutorture/bin/parse-torture.sh     |  105 ----------
 7 files changed, 176 insertions(+), 129 deletions(-)
