Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3848786-1523903221-2-15643790159398192779
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
    1523903220; b=axaz8chgzTF8RWsKF8GSfdlBxAPy2HYGLW37wuw80WC6QHV7yd
    hhVx7HA2Eg5ZfUZVyUiztagNIyb2fJYwxP72M40o0psFeo9XI9Qar1REG+cIPcOw
    w4FsxUKixBQBaaUbWOOvBK7WoASnfyFlRA7wlUYvhwl0Yhz/K5QbqGzIX7RBzsR6
    Xeex8Tc6kyu/X9Yq4UdQl/kq841mrlSBS1pJTUvFtpslqITuj28b7fmQp6ICafSe
    o/DHQwpNgdVmxnTO6d32t5V41Ze0Gsy2RQxF9mhznLgvxHC7pweXUJV1p2kq+/ev
    KiRXLjfjs4377y/KEbJGiZk+Bty1y4wATQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523903220;
    bh=EhsMpQddbEVhzrmU2gRNnXiHBmoQ7BepiK0H23lYVwA=; b=SSlABwRF75Yt
    OMEujLvj6oFl/fNiWxDIzYFgIaNR2e1ZDX130pb/Qzts4II/vmvs7xyzdi4FsnR5
    DfmUNQ9hT7DnDbCyBUdUIPz3Kw1Tc4AtYnxpyPxL3D/Fqxq0bPnK4miC9zplDKpg
    ru5AkdM/nX3vS/HN3R65SrFUC2Hik+QQ97/0AqhWImntGYJ70igolUTC87t6nIZO
    u2a6vYKtv9JpK7kzXhKhNt8G/DzTO92ODNHnLexUNShnqec51S72Z8jXi+7NWZWW
    x/M7CM42+COUJswXju2VEWEeOWsofFSliseO/oef8bGK2yihOQLtruc8a+dSE0vR
    OSIZH4M2pQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfLYFSGLoc1UNrWD0Il1UGcDIUg8K7Ov146ARkbQ0W7u96lGv3FNBc2w0TOnJojWC4t5Ee6H9QRaggcvbHtVT4rEAbapfseBSqotAvx6CjEjRZQx/HzJ7
    mGvdQLhoTywRPs0yuH5ab2c3AbFhlbx6c6CBcpE0AAg7Fvb7TzlDTD6VWMWucuN6fawPO6huHOLGzzXnfu6p9fYZSjnSNGQBTOmmb+lg3CvwDbD/KtNFFJd8
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=jmX_MDLKbrFfV5iLbQ4A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbeDPS06 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 14:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752955AbeDPS05 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 14:26:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D867421837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 14:26:53 -0400
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
Message-ID: <20180416142653.0f017647@gandalf.local.home>
In-Reply-To: <20180416174236.GL2341@sasha-vm>
References: <20180416153031.GA5039@amd>
        <20180416155031.GX2341@sasha-vm>
        <20180416160608.GA7071@amd>
        <20180416122019.1c175925@gandalf.local.home>
        <20180416162757.GB2341@sasha-vm>
        <20180416163952.GA8740@amd>
        <20180416164310.GF2341@sasha-vm>
        <20180416125307.0c4f6f28@gandalf.local.home>
        <20180416170936.GI2341@sasha-vm>
        <20180416133321.40a166a4@gandalf.local.home>
        <20180416174236.GL2341@sasha-vm>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 17:42:38 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> >> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id=a918d2bcea6aab6e671bfb0901cbecc3cf68fca1  
> >
> >Sure. Even if it has a subtle regression, that's a critical bug being
> >fixed.  
> 
> This was later reverted, in -stable:
> 
> """
> Commit d63c7dd5bcb9 ("ipr: Fix out-of-bounds null overwrite") removed
> the end of line handling when storing the update_fw sysfs attribute.
> This changed the userpace API because it started refusing writes
> terminated by a line feed, which broke the update tools we already have.
> """

I hope it wasn't reverted. It did fix a critical bug.

The problem is that it only fixed a critical bug, but didn't go far
enough to keep the bug fix from breaking API. I see this as two bugs
being fixed. Even though the second bug was "caused" by the first fix.
the first fix was still necessary. The second bug was relying on broken
code. This hasn't changed my position on that patch from being
backported. I would not even mark this as a regression. I would say the
original code was broken too much, and fixing part of it just showed
revealed another broken part.


> 
> >> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id=b1999fa6e8145305a6c8bda30ea20783717708e6  
> >
> >I would consider unlocking a mutex that one didn't lock a critical bug,
> >so yes.
> >
> >Again, things that deal with locking or buffer overflows, I would take
> >the fix, as those are critical. But other behavior issues where it's
> >not critical, I would leave be unless told further by someone else.  
> 
> This too, was reverted:
> 
> """
> It causes run-time breakage in the 4.4-stable tree and more patches are
> needed to be applied first before this one in order to resolve the
> issue.
> """

It wasn't reverted in mainline. Looks like there was some subtle issues
with the different stable versions. Perhaps the "fixes" was wrong.

> 
> This is how fun it is reviewing AUTOSEL commits :)
> 
> Even the small "trivial", "obviously correct" patches have room for
> errors for various reasons.

And that's fine. Any code written can have bugs in it. That's just a
given. Which pushes for why we should be extremely picky about what we
backport.

> 
> Also note that all of these patches were tagged for stable and actually
> ended up in at least one tree.
> 
> This is why I'm basing a lot of my decision making on the rejection rate.
> If the AUTOSEL process does the job well enough as the "regular"
> process did before, why push it back?

Because I think we are adding too many patches to stable. And
automating it may just make things worse. Your examples above back my
argument more than they refute it. If people can't determine what is
"obviously correct" how is automation going to do any better?

-- Steve
