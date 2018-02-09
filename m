Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbeBILaD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 06:30:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750924AbeBILaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 06:30:02 -0500
Date: Fri, 9 Feb 2018 03:29:37 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        stern@rowland.harvard.edu, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        boqun.feng@gmail.com, will.deacon@arm.com, npiggin@gmail.com,
        dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com,
        akiyks@gmail.com
Subject: Re: [GIT PULL tools] Linux kernel memory model
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180208184106.GA17043@e110439-lin>
 <20180208200219.GE25181@hirez.programming.kicks-ass.net>
 <20180209091110.GA14128@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209091110.GA14128@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020911-0008-0000-0000-000002CF2D22
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008503; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000250; SDB=6.00987170; UDB=6.00501048; IPR=6.00766528;
 BA=6.00005821; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019456; XFM=3.00000015;
 UTC=2018-02-09 11:29:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020911-0009-0000-0000-00003833AB8F
Message-Id: <20180209112937.GU3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802090147
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 10:11:10AM +0100, Andrea Parri wrote:
> On Thu, Feb 08, 2018 at 09:02:19PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 08, 2018 at 06:41:06PM +0000, Patrick Bellasi wrote:
> > > Hi Paul,
> > > thanks to you and all the involved guys for this useful tool.
> > > 
> > > I give it a try today and found that by installing herd7 by just
> > > following the instruction in herdtools7/INSTALL.md, and precisely
> > > installing it via:
> > > 
> > >    opam install herdtools7
> > > 
> > > it seems to give you a tool which fails to run the basic example in
> > > your README with this error:
> > > 
> > >    File "./linux-kernel.def", line 44, characters 29-30: unexpected '-' (in macros)
> > > 
> > > As suggested by Will, by building instead herd7 HEAD (commit 44d69c2)
> > > everything works fine.
> > > 
> > > Maybe it's a know issue, in case just ignore me. :)
> > > 
> > > Otherwise, maybe it can be worth to add to the README a note on which
> > > minimum version of the herd7 tool is required.
> > > 
> > >  opma   version (not working)    : 7.47, Rev: exported
> > >  master version (working for me) : 7.47+7(dev), Rev: 44d69c2b1b5ca0f97bd138899d31532ee5e4e084
> > 
> > Urgh. So that's why it wouldn't work.
> > 
> > I remember Paul saying you needed the latest version, which is why I
> > rebuild from opam, but building top of git is a bit much.
> 
> +1
> 
> _Sadly_ enough, co-developers and I were aware of this issue,
> but it was only mildly reported here (c.f.,
> 
>   https://marc.info/?l=linux-kernel&m=151638196427685&w=2 ).
> 
> This bisects to that (crazy):
> 
>   2d5fba7782d669c6a1cc577dbc3bf507780273bb
>   ("linux-kernel*: Make RCU identifiers match ASPLOS paper")
> 
>   From repo.: https://github.com/aparri/memory-model
> 
> which not only did break 7.47, but also made the bell uglier
> by mixing dashes and underscores in a very same block.
> 
> As a solution to this issue, I can envisage a partial revert
> of that commit (just replace those dashes); Paul, Jade, Luc:
> any better solution?
> 
> (Sorry for being late on IRC, glad this came out here,)

Or maybe a 7.48 release?

							Thanx, Paul
