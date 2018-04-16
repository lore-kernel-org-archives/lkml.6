Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3972417-1523905078-3-14054758472367463682
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523905077; b=SOJt1X5Lsf2kF3goQG7rZkU18iw6jMLnzXcV5TkLEcsV0qxGsa
    d2T2nFbxJ2Yg1Iv/lc+AVZP4M3ZD7rIyTpMEK+bC3gImcIyUvejyPowszrMgP70/
    oRngO+rA+bJY4+X5ylIcEux5fZvCUgtXCdETnuqBzmTFSHfgKU4xubd8zEqE4ohX
    bb6u4EYlhABOkvUghmuQwyljSme5u0VAMVqVfWihoZOpOY7rk1rmDLmDl5cWN+a8
    Njf0RlfTm9ttAVf9hGZlVI4/aHZFfKJKp2ekc7sfLzFGFo3sxhybbzqn8hKn5TeJ
    EbljiD+PeQz5rdYENf+TfexRhxlGRJJ1XJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523905077;
    bh=OxoKDq9tVhHawBFtTyu3Gyx1kBu8LBPw77u5j9LwI3I=; b=syIklSc46+3G
    zbwebuIDrV5ojBPbZKu9Me93+cL1ja+Tj9xjgKBh3A6eDxh11ey0JjnZ89bIxV8n
    pb0eSwi9893FE04e68Ql8mVp6jqzUic4gqbWFZlpDMl2YrFvf//MMlbiuYXXeQXJ
    UEFtUHqiNHgnCd/M66y4QPkoLzIHRnGXfgWpglIUxUNJt7UsgP8DyqMCs45VXGnL
    gTJ9pN4ifBTxsWv1ER4Jrk/fkSGquB5oWQrtuBHVWj1funate41xCaemM2t+W1dk
    arOos2sY+LRxwQqR6SWTZhWZXT3x3zYxQ0MOf6dOGq+bAkSJipmMoN30S9pQ4cwi
    zbZ8eUt4SQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPezKL2fNyqpmTjAb2UUGXRTyEJELQAHfjV8unSVl8H4HMZiSuGxR8+JFCKECHvZuujDiTp6LHOJPpkdEGipWZdje76TWDXDi43bOfrYJ33taFe+s1yR
    c3D5GjBG5fnXU57gZZVQuHbqA3pWqc5cljh0bElFIi31+8CxxOYMUs7R6uKQI3ScF3hBH1S64YPpgeQQlPPa+TzQNWIjAC0VBio46bFOertDQCCyU5zdLJdy
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=ja6ORx9kDvQRnJeOgeIA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbeDPS5y (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 14:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753077AbeDPS5y (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 14:57:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E95F217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 14:57:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180416145749.07075366@gandalf.local.home>
In-Reply-To: <20180416183542.GN2341@sasha-vm>
References: <20180416160608.GA7071@amd>
        <20180416122019.1c175925@gandalf.local.home>
        <20180416162757.GB2341@sasha-vm>
        <20180416163952.GA8740@amd>
        <20180416164310.GF2341@sasha-vm>
        <20180416125307.0c4f6f28@gandalf.local.home>
        <20180416170936.GI2341@sasha-vm>
        <20180416133321.40a166a4@gandalf.local.home>
        <20180416174236.GL2341@sasha-vm>
        <20180416142653.0f017647@gandalf.local.home>
        <20180416183542.GN2341@sasha-vm>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 18:35:44 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> If I were to tell you that I have a crack team of 10 kernel hackers who
> dig through all mainline commits to find commits that should be
> backported to stable, and they do it with less mistakes than
> authors/maintainers make when they tag their own commits, would I get the
> same level of objection?

Probably ;-)

I've been struggling with my own stable tags, and been thinking that I
too suffer from tagging too much for stable, because there's code I
fix, and think "hmm, this could have some unwanted side effects". I'm
actually worried that my own fixes could cause an API breakage that I'm
unaware of.

What I'm staying is, I think we should start looking at fixes that fix
bugs we consider critical. Those being:

 * off-by-one
 * memory overflow
 * locking mismatch
 * API regressions

For my sub-system

 * wrong data coming out

Which can be a critical issue. Wrong data is worse than no data. But
then, there's the times a bug will produce no data, and considering
what it is, and how much of an effort it takes to fix it, I may or may
not label "no data" issues for stable. The cases where I enable
something with a bunch of parameters, and because of some mishandling
of the parameter it just screws up totally (where it's obvious that it
screwed up), I only mark those for stable if it doesn't require a
redesign of the code to fix it. There's been some cases where a
redesign was required, and I didn't mark it for stable.

The fixes for tracing that I don't usually tag for stable is when doing
complex tracing simply doesn't work and produces no data or errors
incorrectly. Depending on how complex the fix is, I mark it for stable,
otherwise, I think the fix is more likely to break something else that
is more common, then this hardly ever used feature.

The fact that nobody noticed, or hasn't complained about it usually
plays a lot in that decision. If someone complained to me about
breakage, I'm more likely to label it for stable. But if I discover it
myself, as I probably use the tracing system differently than others as
I wrote the code, then I don't usually mark it.

-- Steve
