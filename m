Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeBZWCE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:02:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751022AbeBZWCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:02:02 -0500
Date: Mon, 26 Feb 2018 14:02:25 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: [PATCH tip/core/rcu 0/12] Torture-test updates
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022622-0048-0000-0000-0000023FB487
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995533; UDB=6.00506035; IPR=6.00774861;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 22:02:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022622-0049-0000-0000-000044433A84
Message-Id: <20180226220225.GA32136@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260276
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides torture-test updates:

1.	Replace multi-instance kzalloc() with kcalloc().

2.	Use __func__ instead of hard-coded function names.

3.	Avoid fake-writer use of undefined primitives, which are
	represented with NULL in the structure referenced by cur_ops.

4.	Re-enable testing of dynamic expediting.

5.	Record which grace-period primitives are tested.

6.	Update kvm.sh header comment.

7.	Add basic ARM64 support to run scripts, courtesy of Lihao Liang.

8.	Specify qemu memory size with --memory argument.

9.	Default jitter off when running rcuperf.

10.	Adjust rcuperf trace processing to allow for workqueues.

11.	Grace periods do not piggyback off of themselves, so make
	rcuperf understand this.

12.	Provide more sensible nreader/nwriter defaults for rcuperf.

							Thanx, Paul

------------------------------------------------------------------------

 kernel/rcu/rcuperf.c                                                 |   21 ++
 kernel/rcu/rcutorture.c                                              |   72 +++++-----
 tools/testing/selftests/rcutorture/bin/functions.sh                  |   17 ++
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh |   11 -
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh             |    4 
 tools/testing/selftests/rcutorture/bin/kvm.sh                        |   22 ++-
 tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh  |   24 ---
 7 files changed, 102 insertions(+), 69 deletions(-)
