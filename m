Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbeBJBE7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:04:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753375AbeBJBE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:04:58 -0500
Date: Fri, 9 Feb 2018 17:05:03 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC tip/lkmm 04/10] EXP litmus_tests:  Add comments
 explaining tests' purposes
Reply-To: paulmck@linux.vnet.ibm.com
References: <1518186031-17997-4-git-send-email-paulmck@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802091345180.1460-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802091345180.1460-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18021001-0056-0000-0000-000004187EE4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008506; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000251; SDB=6.00987442; UDB=6.00501212; IPR=6.00766800;
 BA=6.00005821; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019471; XFM=3.00000015;
 UTC=2018-02-10 01:04:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021001-0057-0000-0000-0000084FF141
Message-Id: <20180210010503.GD3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802100011
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 01:46:30PM -0500, Alan Stern wrote:
> On Fri, 9 Feb 2018, Paul E. McKenney wrote:
> 
> > This commit adds comments to the litmus tests summarizing what these
> > tests are intended to demonstrate.
> > 
> > Suggested-by: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > [ paulmck: Apply Andrea's and Alan's feedback. ]
> > ---
> 
> > --- a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
> > +++ b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
> > @@ -1,5 +1,15 @@
> >  C IRIW+poonceonces+OnceOnce
> >  
> > +(*
> > + * Result: Never
> > + *
> > + * Test of independent reads from independent writes with nothing
> > + * between each pairs of reads.  In other words, is anything at all
> > + * needed to cause two different reading processes to agree on the order
> > + * of a pair of writes, where each write is to a different variable by a
> > + * different process?
> > + *)
> 
> The result should be Sometimes.

Right you are, and better yet, the memory model agrees with you.

I have fixed this, thank you for the careful review!

							Thanx, Paul
