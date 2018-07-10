Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD33C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE525208F7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE525208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934432AbeGJQMP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:12:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934265AbeGJQMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:12:13 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6AG9x69002727
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 12:12:13 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k4wt0cgyu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 12:12:12 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 10 Jul 2018 12:12:12 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Jul 2018 12:12:05 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6AGC4v97733722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Jul 2018 16:12:04 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B10FB206A;
        Tue, 10 Jul 2018 12:11:38 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 473D1B2064;
        Tue, 10 Jul 2018 12:11:38 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jul 2018 12:11:38 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 83D0016C1AF9; Tue, 10 Jul 2018 09:14:23 -0700 (PDT)
Date:   Tue, 10 Jul 2018 09:14:23 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Reply-To: paulmck@linux.vnet.ibm.com
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
 <20180709164939.uhqsvcv4a7jlbhvp@pburton-laptop>
 <CAAhV-H7bqhz+dzgPk0_tTAN6y_k_8Ds9heF0p5uPHsHNg0v4Rg@mail.gmail.com>
 <20180710093637.GF2476@hirez.programming.kicks-ass.net>
 <20180710105437.GT2512@hirez.programming.kicks-ass.net>
 <tencent_26F8B9E004D4512B2225FCE1@qq.com>
 <20180710121727.GK2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180710121727.GK2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071016-0072-0000-0000-0000037DD041
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009345; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059369; UDB=6.00543689; IPR=6.00837290;
 MB=3.00022089; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-10 16:12:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071016-0073-0000-0000-000048AA2EF4
Message-Id: <20180710161423.GS3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807100172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 02:17:27PM +0200, Peter Zijlstra wrote:
> 
> Please!! Learn to use email.
> 
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> Also, wrap non-quoted lines to 78 characters.
> 
> On Tue, Jul 10, 2018 at 07:45:22PM +0800, 陈华才 wrote:
> > I'm afraid that you have missing something......
> > 
> > Firstly, our previous conclusion (READ_ONCE need a barrier to avoid
> > 'reads prioritised over writes') is totally wrong. So define
> > cpu_relax() to smp_mb() like ARM11MPCore is incorrect, even if it can
> > 'solve' Loongson's problem.  Secondly, I think the real problem is
> > like this:
> 
> >  1, CPU0 set the lock to 0, then do something;
> >  2, While CPU0 is doing something, CPU1 set the flag to 1 with
> >     WRITE_ONCE(), and then wait the lock become to 1 with a READ_ONCE()
> >     loop;
> >  3, After CPU0 complete its work, it wait the flag become to 1, and if
> >     so then set the lock to 1;
> >  4, If the lock becomes to 1, CPU1 will leave the READ_ONCE() loop.

Are there specific loops in the kernel whose conditions are controlled
by READ_ONCE() that don't contain cpu_relax(), smp_mb(), etc.?  One
way to find them given your description of your hardware is to make
cpu_relax() be smp_mb() as Peter suggests, and then run tests to find
the problems.

Or have you already done this?

							Thanx, Paul

> > If without SFB, everything is OK. But with SFB in step 2, a
> > READ_ONCE() loop is right after WRITE_ONCE(), which makes the flag
> > cached in SFB (so be invisible by other CPUs) for ever, then both CPU0
> > and CPU1 wait for ever.
> 
> Sure.. we all got that far. And no, this isn't the _real_ problem. This
> is a manifestation of the problem.
> 
> The problem is that your SFB is broken (per the Linux requirements). We
> require that stores will become visible. That is, they must not
> indefinitely (for whatever reason) stay in the store buffer.
> 
> > I don't think this is a hardware bug, in design, SFB will flushed to
> > L1 cache in three cases:
> 
> > 1, data in SFB is full (be a complete cache line);
> > 2, there is a subsequent read access in the same cache line;
> > 3, a 'sync' instruction is executed.
> 
> And I think this _is_ a hardware bug. You just designed the bug instead
> of it being by accident.
> 
> > In this case, there is no other memory access (read or write) between
> > WRITE_ONCE() and READ_ONCE() loop. So Case 1 and Case 2 will not
> > happen, and the only way to make the flag be visible is wbflush
> > (wbflush is sync in Loongson's case).
> >
> > I think this problem is not only happens on Loongson, but will happen
> > on other CPUs which have write buffer (unless the write buffer has a
> > 4th case to be flushed).
> 
> It doesn't happen an _any_ other architecture except that dodgy
> ARM11MPCore part. Linux hard relies on stores to become available
> _eventually_.
> 
> Still, even with the rules above, the best work-around is still the very
> same cpu_relax() hack.


