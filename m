Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbeBBXUl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:20:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751963AbeBBXUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:20:35 -0500
Date: Fri, 2 Feb 2018 15:20:35 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Subject: Re: [PATCH 1/2] tools/memory-model: clarify the origin/scope of the
 tool name
Reply-To: paulmck@linux.vnet.ibm.com
References: <1517486609-10951-1-git-send-email-parri.andrea@gmail.com>
 <Pine.LNX.4.44L0.1802011026250.1677-100000@iolanthe.rowland.org>
 <20180201230941.GT3741@linux.vnet.ibm.com>
 <20180202085427.GA5456@andrea>
 <20180202231753.GA3617@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202231753.GA3617@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020223-0048-0000-0000-000002319B12
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008463; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00984168; UDB=6.00499197; IPR=6.00763446;
 BA=6.00005809; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019342; XFM=3.00000015;
 UTC=2018-02-02 23:20:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020223-0049-0000-0000-000043FFD595
Message-Id: <20180202232035.GA16644@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802020281
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 03:17:53PM -0800, Paul E. McKenney wrote:
> On Fri, Feb 02, 2018 at 09:54:27AM +0100, Andrea Parri wrote:
> > On Thu, Feb 01, 2018 at 03:09:41PM -0800, Paul E. McKenney wrote:
> > > On Thu, Feb 01, 2018 at 10:26:50AM -0500, Alan Stern wrote:
> > > > On Thu, 1 Feb 2018, Andrea Parri wrote:
> > > > 
> > > > > Ingo pointed out that:
> > > > > 
> > > > >   "The "memory model" name is overly generic, ambiguous and somewhat
> > > > >    misleading, as we usually mean the virtual memory layout/model
> > > > >    when we say "memory model". GCC too uses it in that sense [...]"
> > > > > 
> > > > > Make it clearer that, in the context of tools/memory-model/, the term
> > > > > "memory-model" is used as shorthand for "memory consistency model" by
> > > > > calling out this convention in tools/memory-model/README.
> > > > > 
> > > > > Stick to the full name in sources' headers and for the subsystem name.
> > > > > 
> > > > > Suggested-by: Ingo Molnar <mingo@kernel.org>
> > > > > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> > > > 
> > > > For both patches:
> > > > 
> > > > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > > 
> > > Thank you all -- I have queued this and pushed it to my RCU tree on
> > > branch lkmm.  I did reword the commit log a bit, please see below and
> > > please let me know if any of my rewordings need halp.
> > > 
> > > Andrea, when you resend your second patch, could you please add Alan's
> > > Acked-by?
> > 
> > You mean in order to integrate Will's suggestion? I was planning to send
> > that as a separate patch, as suggested by Will: the patch is on its way,
> > IAC, please let me know if you'd prefer a V2 merging the two changes.
> 
> Ah, apologies, I misread your reply.  I have queued your second patch
> with Will's and Alan's Acked-by's.

And I did reword the commit log a bit, so please check it.

							Thanx, Paul

------------------------------------------------------------------------

commit 12a62a1d07031c0afa396b03334abbe30d9b9cf7
Author: Andrea Parri <parri.andrea@gmail.com>
Date:   Thu Feb 1 13:04:26 2018 +0100

    MAINTAINERS: Add the Memory Consistency Model subsystem
    
    Move the contents of tools/memory-model/MAINTAINERS into the main
    MAINTAINERS file, removing tools/memory-model/MAINTAINERS. This
    allows get_maintainer.pl to correctly identify the maintainers of
    tools/memory-model/.
    
    Suggested-by: Ingo Molnar <mingo@kernel.org>
    Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
    Acked-by: Will Deacon <will.deacon@arm.com>
    Acked-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index e3581413420c..ba4dc08fbe95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8086,6 +8086,22 @@ M:	Kees Cook <keescook@chromium.org>
 S:	Maintained
 F:	drivers/misc/lkdtm*
 
+LINUX KERNEL MEMORY CONSISTENCY MODEL
+M:	Alan Stern <stern@rowland.harvard.edu>
+M:	Andrea Parri <parri.andrea@gmail.com>
+M:	Will Deacon <will.deacon@arm.com>
+M:	Peter Zijlstra <peterz@infradead.org>
+M:	Boqun Feng <boqun.feng@gmail.com>
+M:	Nicholas Piggin <npiggin@gmail.com>
+M:	David Howells <dhowells@redhat.com>
+M:	Jade Alglave <j.alglave@ucl.ac.uk>
+M:	Luc Maranget <luc.maranget@inria.fr>
+M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
+F:	tools/memory-model/
+
 LINUX SECURITY MODULE (LSM) FRAMEWORK
 M:	Chris Wright <chrisw@sous-sol.org>
 L:	linux-security-module@vger.kernel.org
diff --git a/tools/memory-model/MAINTAINERS b/tools/memory-model/MAINTAINERS
deleted file mode 100644
index db3bd3fc0435..000000000000
--- a/tools/memory-model/MAINTAINERS
+++ /dev/null
@@ -1,15 +0,0 @@
-LINUX KERNEL MEMORY CONSISTENCY MODEL
-M:	Alan Stern <stern@rowland.harvard.edu>
-M:	Andrea Parri <parri.andrea@gmail.com>
-M:	Will Deacon <will.deacon@arm.com>
-M:	Peter Zijlstra <peterz@infradead.org>
-M:	Boqun Feng <boqun.feng@gmail.com>
-M:	Nicholas Piggin <npiggin@gmail.com>
-M:	David Howells <dhowells@redhat.com>
-M:	Jade Alglave <j.alglave@ucl.ac.uk>
-M:	Luc Maranget <luc.maranget@inria.fr>
-M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
-L:	linux-kernel@vger.kernel.org
-S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
-F:	tools/memory-model/
