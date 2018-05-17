Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752544AbeEQOjR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:39:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752505AbeEQOjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:39:15 -0400
Date: Thu, 17 May 2018 07:40:44 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org
Subject: RCU branching for the v4.19 merge window
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051714-0040-0000-0000-0000042CE3D9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009041; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01033645; UDB=6.00528540; IPR=6.00812774;
 MB=3.00021162; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-17 14:39:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051714-0041-0000-0000-00000832FA15
Message-Id: <20180517144044.GA6089@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Steve!

Another year, another difficult-to-branch set of RCU commits.

In happy contrast to last year, I can make some branches (SRCU, some
of the torture commits, and a few miscellaneous commits), but I will
likely end up with several short branches and one huge one.  My thought
is to keep the long branch, but email the patches out in a few separate
serieses, with each depending on its predecessor.  For example, one series
from the big branch would be folding the ->gpnum and ->completed fields
into a single ->gp_seq, which helps the RCU-flavor consolidation task.
Another series suppresses some rare false-positive splats that have been
plaguing me for more than a year.  Yet another series within this huge
branch applies and optimizes funnel locking for grace-period startup.

The problem is that the conversion to ->gp_seq has a very large footprint,
which of course generates lots of conflicts.  I could of course collapse
these commits into a single commit, but if I did that I would also defer
to the merge window following v4.19 due to the resulting loss of bisection
within that change.

Any advice?

The commits are for-mingo..rcu/dev in my -rcu tree.

							Thanx, Paul
