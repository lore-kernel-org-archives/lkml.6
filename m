Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1535273-1523962006-2-10892564793885910364
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523962006; b=XBp1k9sw4yQq7o9InHKBbSpjHs2rF6Q1HQXZQlNHttyuiRsnfV
    NsLXrbn2Mzbyt1uabbjE4KP8EcL766roEaERijkHjSEfOtAzs+etZmgPN/ylGb3G
    8fBa6dBKGYWPnYWO8YQOlenUbDxYEowbc5sr2Y7So9yNpJq+STuOEdhoSr4Z8+xz
    AYCjd4MByXgEPVKjxJ/QxlZv8C9yM3FR8aAbgrzaFMS9b+ElqQQpL+0C2gJKGUqg
    UYKQdiuTKpD26ipe/cMVyf/4mJQQHTuES1UpLnus9vg6czuaW+lKANsFG1P4eAlz
    VjnEL8JDhaV/aDwCDxdqS5lcg9DgRE5v0HrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523962006; bh=kItfi/iZ7JCBTvdV0HKvw3inLTwHtR
    a8WcXRci7HoGk=; b=K4OtqzFgZge82x1LCLXyymIw/p0GPSLCVBAaaJ6JwZy7uT
    +a49OLMqU6E2j3DB33HSWT9D9srl2l70uel9H+nkX3JwLXfxJtSShQQUmUwzYjEj
    Ufk0iwOxWNZW4msFEMhLfBr5pS0Aud0ciqrrDcUiohPlI3KkCBtyYX/uzetfYzxs
    AXCnn7uEOsDmfoj+b9CAPfyjlx/gbgHNO3wmBswoPSAy080qlfzW83hbTYrrygNy
    uLk7PDlYGv6N64iO11T22ftvH8JZagOdo0xZz9tNJRNSqjIuXgQ5t2lllACVJs3E
    M9vYKjO8YQFWHUqdGuOX2i6OgbSsTKJLqDJM2f9g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=eeOWfW5+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=eeOWfW5+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL2V029djvuTDtieoOlaGTJ5GgAB4u/15rawDKrw+8buzS4JhS0njWURHOQTuYMTFKdtmHnrNXDqg3QeBgOlmfTzvSGio3kDfKjATAKZJrrGmI8N17G7
    RJnAjBo/nEK5j6p+ounJ00ThfCvGMYM/wt0HxNaOXLR8gDByqBrkvYDh+F1q0yCsvDWXg6IUQ5zsuU2/kONlABBlb+O3xnTbyK/U7vQSwsskkNSHpx6+5pN/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=S7EZvegbvvhE8-UanOAA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeDQKqo (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 06:46:44 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36807 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751980AbeDQKqn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 06:46:43 -0400
X-ME-Sender: <xms:ktDVWs4BseUPYnW_4hFrKkUUcJyJl3p3J1LJrQpwfr6CoJbPYaaCeQ>
Date: Tue, 17 Apr 2018 12:46:37 +0200
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20180417104637.GD8445@kroah.com>
References: <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd>
 <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd>
 <20180416161412.GZ2341@sasha-vm>
 <20180416122244.146aec48@gandalf.local.home>
 <20180416163107.GC2341@sasha-vm>
 <20180416124711.048f1858@gandalf.local.home>
 <20180416165258.GH2341@sasha-vm>
 <20180416170010.GA11034@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416170010.GA11034@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 07:00:10PM +0200, Pavel Machek wrote:
> Hi!
> 
> > >> Let me ask my wife (who is happy using Linux as a regular desktop user)
> > >> how comfortable she would be with triaging kernel bugs...
> > >
> > >That's really up to the distribution, not the main kernel stable. Does
> > >she download and compile the kernels herself? Does she use LEDs?
> > >
> > >The point is, stable is to keep what was working continued working.
> > >If we don't care about introducing a regression, and just want to keep
> > >regressions the same as mainline, why not just go to mainline? That way
> > >you can also get the new features? Mainline already has the mantra to
> > >not break user space. When I work on new features, I sometimes stumble
> > >on bugs with the current features. And some of those fixes require a
> > >rewrite. It was "good enough" before, but every so often could cause a
> > >bug that the new feature would trigger more often. Do we back port that
> > >rewrite? Do we backport fixes to old code that are more likely to be
> > >triggered by new features?
> > >
> > >Ideally, we should be working on getting to no regressions to stable.
> > 
> > This is exactly what we're doing.
> > 
> > If a fix for a bug in -stable introduces a different regression,
> > should we take it or not?
> 
> If a fix for bug introduces regression, would you call it "obviously
> correct"?

I honestly can't believe you all are arguing about this.  We backport
bugfixes to the stable tree.  If those fixes also are buggy we either
apply the fix for that problem that ended up in Linus's tree, or we
revert the patch.  If the fix is not in Linus's tree, sometimes we leave
the "bug" in stable for a bit to apply some pressure on the
developer/maintainer to get it fixed in Linus's tree (that's what I mean
by being "bug compatible".)

This is exactly what we have been doing for over a decade now, why are
people suddenly getting upset?

Oh, I know why, suddenly subsystems that never were taking the time to
mark patches for stable are getting patches backported and are getting
nervous.  The simple way to stop that from happening is to PROPERLY MARK
PATCHES FOR STABLE IN THE FIRST PLACE!

If you do that, then, no "automated" patches will get selected as you
already handled them all.  Or if there are some automated patches
picked, you can easily NAK them (like xfs does as they know better than
everyone else, and honestly, I trust them, and don't run xfs myself), or
do like what I do when it happens to me and go "hey, nice, I missed that
one!"

There, problem solved, if you do that, no more worrying by you at all,
and this thread can properly die.

ugh,

greg k-h
