Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeBTO5F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 09:57:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751000AbeBTO5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 09:57:03 -0500
Date: Tue, 20 Feb 2018 06:57:20 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2] tools/memory-model: Make compat with herd7 7.47 ("-"
 -> "_")
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180209141832.GA17505@linux.vnet.ibm.com>
 <df87e89b-7fbe-37a7-42cb-62df74591df4@gmail.com>
 <a788e08d-eccb-0aec-6aa5-944e5321e5c6@gmail.com>
 <20180210010703.GE3617@linux.vnet.ibm.com>
 <0ad5ff99-32e9-df65-70d3-ba4e9ec0f6c9@gmail.com>
 <20180214225238.GV3617@linux.vnet.ibm.com>
 <c09bd57e-38f5-df3b-bce5-67a00f7fb3d7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c09bd57e-38f5-df3b-bce5-67a00f7fb3d7@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022014-0040-0000-0000-000003FA01EF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008563; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992515; UDB=6.00504241; IPR=6.00771861;
 MB=3.00019656; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-20 14:57:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022014-0041-0000-0000-000007FB06FC
Message-Id: <20180220145720.GI3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802200189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 12:46:51AM +0900, Akira Yokosawa wrote:
> On 2018/02/14 14:52:38 -0800, Paul E. McKenney wrote:
> > On Thu, Feb 15, 2018 at 07:20:35AM +0900, Akira Yokosawa wrote:
> >> On 2018/02/09 17:07:03 -0800, Paul E. McKenney wrote:
> >>> On Sat, Feb 10, 2018 at 08:46:25AM +0900, Akira Yokosawa wrote:
> >>>> >From 7c1f497a9a51e8db1a94c8a7ef0b74b235aaab88 Mon Sep 17 00:00:00 2001
> >>>> From: Akira Yokosawa <akiyks@gmail.com>
> >>>> Date: Fri, 9 Feb 2018 04:51:05 -0800
> >>>> Subject: [PATCH v2] tools/memory-model: Make compat with herd7 7.47 ("-" -> "_")
> >>>>
> >>>> As of herd7 7.47, these '-'s are not permitted and end up in
> >>>> errors such as:
> >>>>
> >>>>     File "./linux-kernel.def", line 44, characters 29-30:
> >>>>     unexpected '-' (in macros)
> >>>>
> >>>> Partial revert of commit 2d5fba7782d6 ("linux-kernel*: Make RCU
> >>>> identifiers match ASPLOS paper") in the repository at
> >>>> https://github.com/aparri/memory-model can restore the compatibility
> >>>> with herd7 7.47.
> >>>>
> >>>> Reported-by: Patrick Bellasi <patrick.bellasi@arm.com>
> >>>> Suggested-by: Andrea Parri <parri.andrea@gmail.com>
> >>>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> >>>> ---
> >>>> Paul,
> >>>>
> >>>> FWIW, this is a squashed version relative to patch 07/10 in the RFC series.
> >>>
> >>> Thank you, Akira!
> >>>
> >>> I am going to hold off on this for a bit to see if we can instead get
> >>> a new release of herd7, but if we can't. this might well be a very good
> >>> way to go.
> >>
> >> So, herdtools7.7.48 is now available by "opam update; opam upgrade".
> >> Maybe mentioning the required version of herdtools7 in README would help.
> > 
> > Or have some way for the memory model's .cat files to state what version
> > they need, but in the meantime please see the patch below.  But even with
> > such version specification, we probably want to have the version in the
> > README...
> > 
> >> One glitch I'm aware of is one of the output of klitmus7 fails to
> >> compile on kernels prior to 4.14, because of smp_mb__after_spinlock()
> >> used in Z6.0+pooncelock+poonceLock+pombonce.litmus.
> > 
> > This is one advantage of having the memory model in the kernel source
> > itself -- the versions match.  And people can always fire up a different
> > kernel version (for example, within a VM) to run the output of klitmus7.
> > 
> 
> There is another unfortunate mismatch in kernel and herdtools7 updates.
> 
> klitmus7 in herdtools7 7.48 requires definition of ACCESS_ONCE() in kernel
> headers, but it has been removed in Linux 4.15. This means klitmus7 of
> herdtools7 7.48 works only on Linux 4.14.
> 
> In the repository of herdtools7, with the suggestion of Andrea, commit
> e87d7f9287d1 ("klitmus: Use WRITE_ONCE and READ_ONCE in place of deprecated
> ACCESS_ONCE in "user" synchronization barrier") has addressed the issue. 
> 
> This series is intended to be merged in Linux 4.17 merge window,
> and hopefully we can have another update of herdtools7 by the time the merge
> window opens...
> 
> Dependency to out-of-tree tools looks quite tricky. We need some neat way to
> manage things.
> 
> Umm...

Yes, dependencies on out-of-tree tools is quite tricky, witness the
"fun and excitement" provided even by GCC from time to time.

I agree that another herdtools7 release is required, and I do very much
thank you for testing this and finding this issue!

							Thanx, Paul
