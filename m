Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbeEOT1b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 15:27:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750810AbeEOT1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 15:27:30 -0400
Date: Tue, 15 May 2018 12:28:56 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joe Perches <joe@perches.com>
Cc: Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] rcu: Use pr_fmt to prefix "rcu: " to logging output
Reply-To: paulmck@linux.vnet.ibm.com
References: <cover.1525964381.git.joe@perches.com>
 <41d9686471d67f6f98d160e5891bf61061515b6d.1525964386.git.joe@perches.com>
 <20180514202910.GI26088@linux.vnet.ibm.com>
 <32216d8f154b29400d4c11bae91850591114f7f8.camel@perches.com>
 <20180514222456.GO26088@linux.vnet.ibm.com>
 <3c7770a062355650fb61e48a5fbeb9653d98d85a.camel@perches.com>
 <20180514235832.GR26088@linux.vnet.ibm.com>
 <0cb282d85c37d9b626933a03574848d17430f04c.camel@perches.com>
 <20180515003205.GT26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515003205.GT26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051519-0040-0000-0000-0000042BC4F5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009030; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032781; UDB=6.00528023; IPR=6.00811913;
 MB=3.00021130; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-15 19:27:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051519-0041-0000-0000-00000831D9A4
Message-Id: <20180515192856.GA24473@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 05:32:05PM -0700, Paul E. McKenney wrote:
> On Mon, May 14, 2018 at 05:23:59PM -0700, Joe Perches wrote:
> > On Mon, 2018-05-14 at 16:58 -0700, Paul E. McKenney wrote:
> > > OK, so if I define pr_fmt as follows, I get the old behavior?
> > > 
> > > 	#define pr_fmt(fmt) fmt
> > 
> > yes.
> 
> OK, then I will queue patches with this for the near term for
> the various torture files.

And here is the patch.  Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit de94f0b65dd4dcb7e651e2d85df9d9bc86b5bf23
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue May 15 12:25:05 2018 -0700

    torture: Keep old-school dmesg format
    
    This commit adds "#define pr_fmt(fmt) fmt" to the torture-test files
    in order to keep the current dmesg format.  Once Joe's commits have
    hit mainline, these definitions will be changed in order to automatically
    generate the dmesg line prefix that the scripts expect.  This will have
    the beneficial side-effect of allowing printk() formats to be used more
    widely and of shortening some pr_*() lines.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Joe Perches <joe@perches.com>

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 6d42670a1c70..5f00e5a2ef3b 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -21,6 +21,9 @@
  *          Davidlohr Bueso <dave@stgolabs.net>
  *	Based on kernel/rcu/torture.c.
  */
+
+#define pr_fmt(fmt) fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 9047e5439e46..791f8ae7ce20 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -19,6 +19,9 @@
  *
  * Authors: Paul E. McKenney <paulmck@us.ibm.com>
  */
+
+#define pr_fmt(fmt) fmt
+
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9d80245b2a1c..ca08e6733fa2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -22,6 +22,9 @@
  *
  * See also:  Documentation/RCU/torture.txt
  */
+
+#define pr_fmt(fmt) fmt
+
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/kernel/torture.c b/kernel/torture.c
index 840fd33c1cda..1ac24a826589 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -20,6 +20,9 @@
  * Author: Paul E. McKenney <paulmck@us.ibm.com>
  *	Based on kernel/rcu/torture.c.
  */
+
+#define pr_fmt(fmt) fmt
+
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
