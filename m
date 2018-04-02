Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3244740-1522682817-2-11466766189790199212
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522682816; b=JeqM9YfBZKTPCK77b6iUxCplI+7wV8irgLVLvKWHop0iyletxH
    IhuaZqucUzEr89udhFX8h7vMPDHsNLa0mzLuLJT0igAyG0J76s2ouMq8gdVtIFMO
    3Emnezl3LimGig6Q9s28l2pA+YJqapFTGUG0tFLMcksQPgUBuPkxp5THCWSHccMG
    pEZlikOjig0pDcEONaeBd38RWHMmKLnBf4EnIEZqSDA57V0D71KGzHpaGVr6z6h3
    tJebUNQO6Z5+YVZGy1p48szSglcf7qCOLkdknzrWIo0VkadHgRDbO7uZQ6bXlQV0
    8tPo3pnLOCT8JTaqzoouS18Iipk5jzSCc70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id
    :sender:list-id; s=fm2; t=1522682816; bh=jEovi3MMOMKL/cb1xdvNtT6
    FOeNGZ81T7vgFZqm5q8k=; b=CMup44FH52k3IXbBc7XX9KOpGo6pyJXkS4tEENb
    gn4wTwDxJk2s955WWs99sfhq07D8H336M+9hm2fYUz+aO02KgwvjRIiYaH40WWd2
    LKf3VbRtvaCEq8LprNgiNtYDB2muJWpfWng81TKtl04WuKfRIfj8grxIP14dR+WD
    PvZBHXmyD0NH86ZlfWTkkifzC9pE6Hp+I4aAnE4Z+h5tQXhVCxKLJQWx04zDMXEk
    WegplkbKzqqmjaLlirejfyHp/VsaBE4rtpeNpLisQIN05UVwVGk+RzW4i8RQCiC2
    npBM2JB5byvJhDVlguUNUxRAViWNRP5OEbp2yILf8UeErqw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMNDx1ZSqsNopMP4J6vLbwkw2I5/f0Utz/xfLLn0LdTZWeJh2LYiS/0oYQDUVDKL55XqrZmsIdS6yGSyYp8bO1gUnYdDdkIimVc4O0cNd6MrasZgcDT5
    weMzKS/j9+IevlVWKO7x1KmwXZk+nHepo6ATWLcv+nd1ZFmWbVlF68zioeWRT9BnoahJ3fNoy4CRV/ktXn5PWomMjEkye9tarctcnimFTNbWc8kP33nDKLAD
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=NQ9YILduYW5TqayEw2gA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeDBP0x (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 11:26:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752561AbeDBP0t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Apr 2018 11:26:49 -0400
Date: Mon, 2 Apr 2018 08:27:36 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Christopher Lameter <cl@linux.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable sequences
 system call (v12)
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com>
 <20180327160542.28457-3-mathieu.desnoyers@efficios.com>
 <20180401171356.085a2a33@alans-desktop>
 <alpine.DEB.2.20.1804021000290.23911@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1804021000290.23911@nuc-kabylake>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040215-0036-0000-0000-000002DA9C42
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008789; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012077; UDB=6.00515778; IPR=6.00791347;
 MB=3.00020376; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-02 15:26:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040215-0037-0000-0000-000043D7AAC9
Message-Id: <20180402152736.GL3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804020172
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 02, 2018 at 10:03:58AM -0500, Christopher Lameter wrote:
> On Sun, 1 Apr 2018, Alan Cox wrote:
> 
> > >        Restartable sequences are atomic  with  respect  to  preemption
> > >        (making  it atomic with respect to other threads running on the
> > >        same CPU), as well as  signal  delivery  (user-space  execution
> > >        contexts nested over the same thread).
> >
> > CPU generally means 'big lump with legs on it'. You are not atomic to the
> > same CPU, because that CPU may have 30+ cores with 8 threads per core.
> >
> > It could do with some better terminology (hardware thread, CPU context ?)
> 
> Well we call it a "CPU" in the scheduler context I think.  We could use
> better terminology throughout the kernel tools and source.

Agreed, it has been "CPU" for "single hardware thread" for a very long
time.  People tend to use "core" for "group of hardware threads" and
"socket" for "big lump with legs on it".

> Hardware Execution Context?

Should be even more fun when non-CPU hardware execution contexts show
up in force within each core.  ;-)

But the terminology in place for non-CPU hardware execution contexts
should be able to survive that event.

> > >        In  a  typical  usage scenario, the thread registering the rseq
> > >        structure will be performing  loads  and  stores  from/to  that
> > >        structure.  It  is  however also allowed to read that structure
> > >        from other threads.  The rseq field updates  performed  by  the
> > >        kernel  provide  relaxed  atomicity  semantics, which guarantee
> > >        that other threads performing relaxed atomic reads of  the  cpu
> > >        number cache will always observe a consistent value.
> >
> > So what happens to your API if the kernel atomics get improved ? You are
> > effectively exporting rseq behaviour from private to public.
> 
> There is already a pretty complex coherency model guiding kernel atomics.
> Improvements/changes to that are difficult and the effect will ripple
> throughout the kernel. So I would suggest that these areas of the kernel
> are pretty "petrified" (or written in stone).

I suspect that there are much more pressing areas of confusion in any
case!

							Thanx, Paul

