Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3243475-1522681444-2-12216467493526584764
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522681444; b=uIetnJEen52/rRBwEe4FQzmX+mSHuSIsiceGOPkAUztl/hCnLK
    P+nORUJR5hVHl4o7jwApEoDPOPHgBHQypoL2bP6Zxlew6Fk2oc3p20ZQXemfmWMS
    vZcJB7UEqQb5+2XSZWcQ64JAfosCmD27O1PFN0dzym1Nim7szGso3kH/6pb6ZAYD
    fJoodUks1pcgWYgLX7cb7Jhf0owJxrhpCC+sqmROzK+DIZZxAokKv5GhXrxeZPQN
    e/OG2UDjrGZKEWN+GUk/IKpHGG7CxIjmcNo137sMV6+1KP2rl6a5ReqqjHilVf/5
    tMx0FGQXSGu/RK5E9LUNITCpOR3PXvcLJSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1522681444; bh=ezz+3TfdE9I4HUXKBzOU1VRxoqK6qKDb1IbM5Oo
    y8jQ=; b=qZlsmr6oByw8tuU7RDmU6y64iglYpcguEWixKEIybci55ZKvii/wF2P
    cIvX3pU6P0IYUc/QQxxgIMCeZu4QTXIkj2GxNglx5MjjLiUXZSAm052I9jZEI1Fa
    DgXIfVTYUv2eG/p69dcFcIhL9A0tvgnkFqhyTZinHGOjYgbIFsaXSbrerg8+s7zg
    kjBR9buJfev4bcW1g1t+pqEWXFALWfDpSfYmSVg+4kTztyJrOpoiVbZ9MtmevCQf
    Omfv7mCSjYzUYEBH5dLdohka49MgrumnPh1QC8E1taWKblrnQtCKYGMbweFkehOX
    FR4UD5HMJE97Bjymccbm8mgvfdiCdqw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGNppGLuolwzU95/O5tc2MrLFGP4NxqcujjUS0z9gCc1XgD/tkcUsfpguwGy3kESI6l1YcXXKkJ5G1GccEF16xM9Acbk/VfDTxME0hFgYXBtyuf9N8AF
    HPseBffd2FEseTrA2iD2dnHM3Mlpx/WSXyg2uB4Kmne/knV13VJq+T+2GlDErYI7Tq2mdBltH6YyVmIcBjg/Rk/o/tQF5czqtBYbXQ6enk50kjU+wkSUo7ap
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=khwyK8DuSVkA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=-2vJVp6Nht3eZwDVjHkA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeDBPEC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 11:04:02 -0400
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:60392 "EHLO
        resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751433AbeDBPEC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Apr 2018 11:04:02 -0400
Date: Mon, 2 Apr 2018 10:03:58 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
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
In-Reply-To: <20180401171356.085a2a33@alans-desktop>
Message-ID: <alpine.DEB.2.20.1804021000290.23911@nuc-kabylake>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180327160542.28457-3-mathieu.desnoyers@efficios.com> <20180401171356.085a2a33@alans-desktop>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfL7vMM2q1MR4bAwHTPZ9sTwW7Ys5OR32VPXDmgMnJfcF1J2vm7uG6E4OTD8PQqal1S6MZ15r/NG5+PyG9P70h+ZFchHIrc+pLAabj22ASu7r2Bs2khri
 drZmTnhVZSUhxkhlSYqez34lHfKBuR+h+NLWqEotfJssXmA2WTGDhpbcMzOALVf4Ys88cuJONXDfa/UnkgRPzsHBMOW5UDleZ84MVSsemjQsfCYCZWht5u17
 0ECjBy3znVvG4yqhSzos/AbvecDP7yTvCmqc1Ti5bPhu9PmXoEK37zutw0F9tLJvWj76qKYzran0lRKCkcLbxYLTsWBhf7mN/SBomQeeS1AgT8+nIK5E50BX
 TejOQ/1TXx7tAXetZtFcWZOienl63FlWmTScsol2NgZkhDA7u+xQgdcN3D8/Ei6C9CXfbH2E0TcZChNQ47p5bfK6EBOEW/REU7eWNDUP0Iag7I1IcF1atcHg
 omYGUCErU/DDuVZzpglNFX1IUtYCKB53xZp2kbvzyDePvtDtxHZiiQWhkJdJeXBqV7hveYuta/+vY4uP1H3EEtpyyiJoMl6Y99c7lx/3nZXQQIJD9RGBs06t
 5DR0klefi8ZtYUF/bFXvszmWUbrPBtVwq/GFRHVUyD0NZDyuF+Wop1CfwGDRZ+blNaXYwWbhfxFbOonZavsQQfQr/MXx1LumLH7NGtQ3QcZzGCWUa1aF+1Th
 oJ4wwizuBvMtEyN8D+VOAFG3B33eSf5LP0F7pT+QHGZRZ4xuevJjuTJmj3k4Mgr8boS/9+qL4GTcz5nNscFtczo8rK4nPV8cBNl8w5GzuR9nBm5HWaYbvjA8
 P7z9tuEOHmdmC8EXga6byXyhCYyMMZAplyaIORzmk+KUifHH/tt5BFHAUA7TuU4o2tLG24JKt8IIDHvrd/NCsvnwIOufw4LqMWHpa0RAq3vB5bDjTp20n2A0
 ooAnGA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 1 Apr 2018, Alan Cox wrote:

> >        Restartable sequences are atomic  with  respect  to  preemption
> >        (making  it atomic with respect to other threads running on the
> >        same CPU), as well as  signal  delivery  (user-space  execution
> >        contexts nested over the same thread).
>
> CPU generally means 'big lump with legs on it'. You are not atomic to the
> same CPU, because that CPU may have 30+ cores with 8 threads per core.
>
> It could do with some better terminology (hardware thread, CPU context ?)

Well we call it a "CPU" in the scheduler context I think.  We could use
better terminology throughout the kernel tools and source.

Hardware Execution Context?

> >        In  a  typical  usage scenario, the thread registering the rseq
> >        structure will be performing  loads  and  stores  from/to  that
> >        structure.  It  is  however also allowed to read that structure
> >        from other threads.  The rseq field updates  performed  by  the
> >        kernel  provide  relaxed  atomicity  semantics, which guarantee
> >        that other threads performing relaxed atomic reads of  the  cpu
> >        number cache will always observe a consistent value.
>
> So what happens to your API if the kernel atomics get improved ? You are
> effectively exporting rseq behaviour from private to public.

There is already a pretty complex coherency model guiding kernel atomics.
Improvements/changes to that are difficult and the effect will ripple
throughout the kernel. So I would suggest that these areas of the kernel
are pretty "petrified" (or written in stone).
