Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3647214-1523897249-2-6691173243393520266
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
    1523897249; b=inB4OI+AY8sBCfAQNyL3TUbo3f0q2pAa6t7Ru59PQ/Ueh9YqZt
    ooxezkykUZwmTrP3d6s+hJscGhlm7QinfJfRI+XQJRxd7V3JbIwRUH08T80L3sD7
    CHfITrQAWAj6Z7r9T8C+wuL9OadALtTwey/eFNPqKwjKrMposiRCa5bTcnzcMTTN
    rmkWFWCa6xA8rc2d90vy3l70e6WQKYEVlBMETv7tFMIA1TGwqVrykggp7y4oy4k1
    6D86Ap9y8uJeWxx/1WFScFctBac6YjLuV5Qr3TMOgQyt74PZBeB/PoYPmqBI9bPk
    iaXZEMhbtliCnQrDF1OIjzxehsV64yP9STfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523897249;
    bh=gYhlCjfB/F/Xwre67wkZKoRenexkfhSaTVPOnmH+zjg=; b=S/N11tVe103B
    laAVf/H5Ada/UrhWwCKFAn2lhypJF+HLTjXuXoEtpcedtLMHZgc2TKgsKBeNAYsA
    ZPrEtlyLSHw+2czLJs1+rq3w2FeNGeXr4MX6u4PEQcMRyAFowZwvqTNzH5bWOcna
    RIeClDLl9mCshB+m3JCZTYBFZlUVQXd4sNPcMOPbCPsBzu2bvXUXZSwk6eO/Q424
    TAA5/hkPjw89EBhtUR79vnk8vVSaJRE6Af6832cavl3uhwZYeHsN38epjnJdxvud
    QtFgIfR5OXUfY463G4DBIjVbbXXPxlv6K79EZL0z41ac1M/9JYREH/M8I5XJA0LR
    7k1eEpUF9A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfEKEpaOXUGhkhoVtUL5oUi4a8SqF0RuT2ZXKw+ReNVtrMhMwNuUqTbYKZalbNvzgkSQWn55D/ym6H4CbFZk3m+rLvPdNe0hA5I2HYNMjB+qtDhhId7Na
    pIVSN7vGKibnBfg4mbYleoIx5H4kPG8av3mq6cb+g/RsCK9W0GWJ6yNmqVzYISMZvvxcfbIk/dY7GzKtU1hmTWiax5ASyPzC4eWPPwclABBvItHf6q9jji/C
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=ZR2unDN7ODYN6Q_DsToA:9 a=Yw9P8Ugxk04-Fmpw:21
    a=t9g7SE9TY-Lp96zt:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752947AbeDPQrT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752913AbeDPQrQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 12:47:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAAF217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 12:47:11 -0400
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
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180416124711.048f1858@gandalf.local.home>
In-Reply-To: <20180416163107.GC2341@sasha-vm>
References: <20180409001936.162706-15-alexander.levin@microsoft.com>
        <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
        <20180415144248.GP2341@sasha-vm>
        <20180416093058.6edca0bb@gandalf.local.home>
        <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
        <20180416153031.GA5039@amd>
        <20180416155031.GX2341@sasha-vm>
        <20180416160608.GA7071@amd>
        <20180416161412.GZ2341@sasha-vm>
        <20180416122244.146aec48@gandalf.local.home>
        <20180416163107.GC2341@sasha-vm>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 16:31:09 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> On Mon, Apr 16, 2018 at 12:22:44PM -0400, Steven Rostedt wrote:
> >On Mon, 16 Apr 2018 16:14:15 +0000
> >Sasha Levin <Alexander.Levin@microsoft.com> wrote:
> >  
> >> Since the rate we're seeing now with AUTOSEL is similar to what we were
> >> seeing before AUTOSEL, what's the problem it's causing?  
> >
> >Does that mean we just doubled the rate of regressions? That's the
> >problem.  
> 
> No, the rate stayed the same :)
> 
> If before ~2% of stable commits were buggy, this is still the case with
> AUTOSEL.

Sorry, I didn't mean "rate" I meant "number". If the rate stayed the
same, that means the number increased.

> 
> >>
> >> How do you know if a bug bothers someone?
> >>
> >> If a user is annoyed by a LED issue, is he expected to triage the bug,
> >> report it on LKML and patiently wait for the appropriate patch to be
> >> backported?  
> >
> >Yes.  
> 
> I'm honestly not sure how to respond.
> 
> Let me ask my wife (who is happy using Linux as a regular desktop user)
> how comfortable she would be with triaging kernel bugs...

That's really up to the distribution, not the main kernel stable. Does
she download and compile the kernels herself? Does she use LEDs?

The point is, stable is to keep what was working continued working.
If we don't care about introducing a regression, and just want to keep
regressions the same as mainline, why not just go to mainline? That way
you can also get the new features? Mainline already has the mantra to
not break user space. When I work on new features, I sometimes stumble
on bugs with the current features. And some of those fixes require a
rewrite. It was "good enough" before, but every so often could cause a
bug that the new feature would trigger more often. Do we back port that
rewrite? Do we backport fixes to old code that are more likely to be
triggered by new features?

Ideally, we should be working on getting to no regressions to stable.

-- Steve
