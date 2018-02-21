Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeBUTF2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:05:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752040AbeBUTFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:05:25 -0500
Date: Wed, 21 Feb 2018 11:05:43 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, nborisov@suse.com
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180221175320.GI3617@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802211334560.2032-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802211334560.2032-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022119-0044-0000-0000-000003E7BAF3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008571; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00993078; UDB=6.00504577; IPR=6.00772422;
 MB=3.00019676; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-21 19:05:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022119-0045-0000-0000-00000817C0D0
Message-Id: <20180221190543.GM3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802210227
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 01:38:35PM -0500, Alan Stern wrote:
> On Wed, 21 Feb 2018, Paul E. McKenney wrote:
> 
> > On Wed, Feb 21, 2018 at 11:50:31AM -0500, Alan Stern wrote:
> > > On Wed, 21 Feb 2018, Paul E. McKenney wrote:
> > > 
> > > > On Wed, Feb 21, 2018 at 10:09:00AM -0500, Alan Stern wrote:
> > > > > On Tue, 20 Feb 2018, Paul E. McKenney wrote:
> > > > > 
> > > > > > From: Alan Stern <stern@rowland.harvard.edu>
> > > > > > 
> > > > > > This commit adds a litmus test in which P0() and P1() form a lock-based S
> > > > > > litmus test, with the addition of P2(), which observes P0()'s and P1()'s
> > > > > 
> > > > > Why do you call this an "S" litmus test?  Isn't ISA2 a better 
> > > > > description?
> > > > 
> > > > Indeed, the name of the test is in fact ISA2.
> > > 
> > > Sure; and the Changelog entry should reflect this.
> > 
> > No argument.
> 
> > ------------------------------------------------------------------------
> > 
> > commit e6658d1d7fcc6391f3d00beaadc484243123a893
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Wed Feb 21 09:49:01 2018 -0800
> > 
> >     tools/memory-order: Add documentation of new litmus test
> >     
> >     The litmus-tests/README file lacked any mention of then litmus test
> 
> s/lacked/lacks/
> s/then/the new/
> 
> >     named ISA2+pooncelock+pooncelock+pombonce.litmus.  This commit therefore
> 
> s/named //
> 
> >     adds this test.
> 
> It adds a description of the test, not the test itself.

Good catches, fixed.

> >     Reported-by: Alan Stern <stern@rowland.harvard.edu>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> > index dca7d823ad57..aff3eb90e067 100644
> > --- a/tools/memory-model/litmus-tests/README
> > +++ b/tools/memory-model/litmus-tests/README
> > @@ -32,6 +32,11 @@ IRIW+poonceonces+OnceOnce.litmus
> >  	order of a pair of writes, where each write is to a different
> >  	variable by a different process?
> >  
> > +ISA2+pooncelock+pooncelock+pombonce.litmus
> > +	Tests whether the ordering provided by a lock-protected S litmus
> 
> Call it an ISA2 litmus test, not an S litmus test!

Given the structure of the test, the relationship to S is important
because it helps motivate why anyone might care.  But yes, having ISA2
only in the filename is a bit obtuse.  How about the following?

ISA2+pooncelock+pooncelock+pombonce.litmus
	Tests whether the ordering provided by a lock-protected S
	litmus test is visible to an external process whose accesses are
	separated by smp_mb().	This addition of an external process to
	S is otherwise known as ISA2.

							Thanx, Paul

> > +	test is visible to an external process whose accesses are
> > +	separated by smp_mb().
> > +
> >  ISA2+poonceonces.litmus
> >  	As below, but with store-release replaced with WRITE_ONCE()
> >  	and load-acquire replaced with READ_ONCE().
> 
> Alan
> 
