Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965490AbeE2Rdl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:33:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965010AbeE2Rdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:33:40 -0400
Date: Tue, 29 May 2018 10:35:18 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, efault@gmx.de, peterz@infradead.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: [GIT PULL rcu/next] Additional RCU commit for 4.18
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052917-0008-0000-0000-0000030E27A6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009097; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039460; UDB=6.00532006; IPR=6.00818588;
 MB=3.00021361; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-29 17:33:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052917-0009-0000-0000-00003965D2FC
Message-Id: <20180529173518.GA6850@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290190
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo,

This additional v4.18 pull request contains a single commit that fell
through the cracks:

1.	Provide early rcu_cpu_starting() callback for the benefit of the
	x86/mtrr code, which needs RCU to be available on incoming CPUs
	earlier than has been the case in the past.

	http://lkml.kernel.org/r/20180525191802.GA7141@linux.vnet.ibm.com

All of these changes have been subjected to 0day Test Robot and -next
testing, and are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to f64c6013a2029316ea552f99823d116ee5f5f955:

  rcu/x86: Provide early rcu_cpu_starting() callback (2018-05-22 16:12:26 -0700)

----------------------------------------------------------------
Peter Zijlstra (1):
      rcu/x86: Provide early rcu_cpu_starting() callback

 arch/x86/kernel/cpu/mtrr/main.c | 4 ++++
 include/linux/rcupdate.h        | 1 -
 include/linux/rcutiny.h         | 1 +
 include/linux/rcutree.h         | 1 +
 kernel/rcu/tree.c               | 9 +++++++++
 5 files changed, 15 insertions(+), 1 deletion(-)
