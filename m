Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeBBIlZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 03:41:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750795AbeBBIlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 03:41:07 -0500
Date: Thu, 1 Feb 2018 21:40:13 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com,
        dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com,
        akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180129065724.ybrdsabvktq7fbqg@gmail.com>
 <20180129095449.GT3741@linux.vnet.ibm.com>
 <20180131090006.onaopgyqthppoysi@gmail.com>
 <20180201011728.GL3741@linux.vnet.ibm.com>
 <20180202044603.i2z3q25jeftbct5c@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202044603.i2z3q25jeftbct5c@tardis>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020208-0008-0000-0000-000002CB98A0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008461; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00983875; UDB=6.00499021; IPR=6.00763153;
 BA=6.00005808; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019331; XFM=3.00000015;
 UTC=2018-02-02 08:40:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020208-0009-0000-0000-0000381FE7F5
Message-Id: <20180202054013.GV3741@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802020103
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 12:46:03PM +0800, Boqun Feng wrote:
> On Wed, Jan 31, 2018 at 05:17:28PM -0800, Paul E. McKenney wrote:
> [...]
> > > - A long term question: have you considered and would it make sense to generate a
> > >   memory-barriers.txt like file directly into Documentation/locking/, using the
> > >   formal description? That way any changes/extensions/fixes to the model could be
> > >   tracked on a high level, without readers having to understand the formal
> > >   representation.
> > 
> > I hadn't considered this at all, actually.  ;-)
> > 
> > The sections of memory-barriers.txt dealing with MMIO ordering would need
> > to stay hand-generated, but they are a very small fraction of the total.
> > The herd7 tool is capable of generating cool diagrams sort of like
> > this one: https://static.lwn.net/images/2017/mm-model/rmo-acyclic.png,
> > which might replace at least some of the hand-generated ASCII-art
> > diagrams.
> 
> Which reminds me, one thing we could start with is to try to convert all
> the examples with litmus tests. Has this been done somewhere (e.g. in
> your litmus github repo)? If not, I can try if you think that's a good
> idea.

That would be very helpful, thank you!

There are probably some that are already in the litmus-tests directory,
but I suspect that most are not yet converted.  So please do!

							Thanx, Paul

> Regards,
> Boqun
> 
> > Although I do confess harboring some skepticism about being able to
> > generated high-quality text, there is no denying that it would be
> > valuable to be able to do so.
> > 
> > > In any case, the base commit is certainly nice and clean and I've pulled it into 
> > > tip:locking/core for a v4.17 merge.
> > 
> > Very good!
> > 
> > > I believe these additional improvements (to the extent you agree with doing them!) 
> > > could/should be done as add-on commits on top of this existing commit.
> > 
> > Sounds good!
> > 
> > Would you prefer a pull request or a patch series for these?
> > 
> > 							Thanx, Paul
> > 
