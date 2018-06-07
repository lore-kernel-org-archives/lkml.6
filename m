Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7TgxN8eNGVtHdwAAmS7hNA
	; Thu, 07 Jun 2018 19:55:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BB1C36074D; Thu,  7 Jun 2018 19:55:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 42F8360115;
	Thu,  7 Jun 2018 19:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42F8360115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753698AbeFGTzs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:55:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932344AbeFGTzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:55:45 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57JsQbe099441
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 15:55:44 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jfay50sar-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 15:55:44 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 7 Jun 2018 15:55:44 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 15:55:39 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w57JtcQk5636462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 19:55:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FE02B2066;
        Thu,  7 Jun 2018 16:57:08 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DA41B205F;
        Thu,  7 Jun 2018 16:57:08 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.189.94])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jun 2018 16:57:08 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5D16A16C0D6B; Thu,  7 Jun 2018 12:57:28 -0700 (PDT)
Date: Thu, 7 Jun 2018 12:57:28 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roman Pen <roman.penyaev@profitbricks.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180530183826.GI7063@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1805301449350.1502-100000@iolanthe.rowland.org>
 <CAJrWOzBMB-6e1pKms4L216k=TN_Lr52_gWxj-ny8yitgf+K5gg@mail.gmail.com>
 <20180606190710.GY3593@linux.vnet.ibm.com>
 <CA+55aFwZTAp3wZYGSJR1kPkc=QhPNMdEEPttsM4REcWPPDH9Bw@mail.gmail.com>
 <20180607094314.GF3593@linux.vnet.ibm.com>
 <CA+55aFzs0ueN22WaKs_R6=T4HHY9j0MtpoFA8eh=t=PN7grCnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzs0ueN22WaKs_R6=T4HHY9j0MtpoFA8eh=t=PN7grCnA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18060719-2213-0000-0000-000002B4EC05
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009147; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01043636; UDB=6.00534377; IPR=6.00822721;
 MB=3.00021516; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-07 19:55:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060719-2214-0000-0000-00005A65C224
Message-Id: <20180607195728.GM3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 08:06:51AM -0700, Linus Torvalds wrote:
> On Thu, Jun 7, 2018 at 2:41 AM Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > We are considering adding unmarked accesses, for example, accesses
> > protected by locks.  One possible litmus test (not yet supported!)
> > might look like this:
> 
> Fair enough - you do want to have the distinction between "marked" and
> "unmarked".
> 
> And it does make sense, although at that point I think you do hit the
> "what can a compiler do" issue more. Right now, I think the things you
> check are all pretty much "compiler can't do a lot of movement".

Agreed, and the added freedom unmarked accesses give the compiler is
one reason why this is something being thought about as opposed to
something already done.  The approach that looks most feasible is to
make LKMM complain if there is a data race involving unmarked accesses.
This is a bit annoying given the Linux kernel's large number of unmarked
accesses to shared variable that do involve data races, however, my
belief is that developers and maintainers of such code are under the
obligation to make sure that the compiler cannot mess them up.  One
way that they could do this is to list the transformations that the
compiler could carry out, and make a separate litmus test for each,
substituting READ_ONCE() and WRITE_ONCE() for the unmarked accesses.

Then unmarked accesses would be for code protected by locks or that
used dependencies to avoid data races.

Thoughts?

> But I suspect that the markings you do have are going to be fairly
> limited. Things like "READ_ONCE()" vs "smp_read_acquire()" are still
> fairly simple from a compiler standpoint, at least when it comes to
> control flow - they have "side effects". So I guess that's the only
> real difference there - a regular read doesn't have side effects, so
> it could be moved up past a conditional, and/or duplicated for each
> use. That sounds much more complex to the checker than the existing
> things it supports, no?

Indeed!

And those sorts of compiler transformations are one of the things that
has pushed us to the "no data races" model.  If there are no data races,
then those compiler transformations don't affect the outcome, given that
C11 and later compilers are not allowed to introduce data races.

							Thanx, Paul
