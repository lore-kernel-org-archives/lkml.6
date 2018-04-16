Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4006321-1523908552-2-16744788789154644374
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523908551; b=KNcl0mJO4HqWPt8fePJ8c24cTt4pZZA85FUBDGGCL5hwPEtAKd
    xJCS6czxdJya2dxfb0jEq5Q0IigfAN+UKvensAl0OBC51nPLBxS1oowiMn92dCzU
    Z7QTufd84hEI2ouWVZWFmHpDZzh31OEYCkRmi6akxdp2fQpVjcLOgYUHZsDgALwj
    2nhLz+WKDTP5l1+9G6qeU0i2OK6Rkw7BF+7KDZRt7hKR0WhHjunfmP8WnSDfrJ/Z
    8ORWq0wIoGJ89S2+B7dCD8cLk3LslX7FrF5fgDdu0yaWk9V9g4K7/Ig7YWikODDG
    eJnMBpSIuy8a2oJfblYOcbq8L4t2kxNXGfoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523908551; bh=e/NPTJk6wm4LJiqMFKZnlxRr6+XVYC8oWYAYZtMpL3
    0=; b=qzmNqsnpVeoGuoJOYBz1QuZzLJTOrLS/nTBnUyxGepTm1WVEyopUHb9iOz
    Yv8mBSnDCuUc5Rqh9dYL3kTEqvzfyN7XlYlA7iHCzGUxRlZN9/ZNFRQOj+ZRlqZY
    M5edi//3ONWf9iTaXW8zSbUdJ5Px6CMlKm5oposQwBgauaA5h+I2Rg31gTQuYtWZ
    lt+6HsgUwjay/poTfQ1WiwBLucfPcjNj6i+SWUVq92hm0/hvpUX8XtOI3+eIIYf3
    i7wOCqjnvoB5SfYUSQ2nD4CPI4NW86Ak+KQ22THy9a49PD09UHH37wCEV4XCpOX3
    gxblaFSP+ezFBvKlW76FZSKdPQwQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HuxRsSw2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=q7gwcHAZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rqsgDMv7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HuxRsSw2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=q7gwcHAZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rqsgDMv7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEtw5+L4+gimkLxiY19o2FNuv0yBYBXbezTxLiUIuChGKiJqUKP0ZndqiGh32IyefLXd/TjbNfaBLToGH9q0oR98RWpntOJwLccyZa4dIzIwFHjffpG2
    R86v4oQ9Jhzx9i5+gFuwEjiXc6m+FGn0+RxLo7tOc3gdwNt+2G+mpC/zAO1HAo6QEm5rEV7IHoYU/rF9DQ+pJEcOb2O3hx8YO4uYxtgyV6oZyii0zW1d6+nQ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=meVymXHHAAAA:8 a=42E5YPRjqnxsnEUuBvoA:9 a=QEXdDO2ut3YA:10
    a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbeDPTzt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 15:55:49 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:54616 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752934AbeDPTzs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 15:55:48 -0400
X-Google-Smtp-Source: AIpwx49vQSnz3Xi4U2LzsYobwtig216LLWmmZYK4SeEQoaHQCbtth4Dsab9AdgDrMh54ITaA21NYQIej5//PPdKV0lc=
MIME-Version: 1.0
In-Reply-To: <20180416153816.292a5b5c@gandalf.local.home>
References: <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416122019.1c175925@gandalf.local.home>
 <20180416162757.GB2341@sasha-vm> <20180416163952.GA8740@amd>
 <20180416164310.GF2341@sasha-vm> <20180416125307.0c4f6f28@gandalf.local.home>
 <20180416170936.GI2341@sasha-vm> <20180416133321.40a166a4@gandalf.local.home>
 <20180416174236.GL2341@sasha-vm> <20180416142653.0f017647@gandalf.local.home>
 <CA+55aFzggPvS2MwFnKfXs6yHUQrbrJH7uyY4=znwetcdEXmZrw@mail.gmail.com>
 <20180416144117.5757ee70@gandalf.local.home> <CA+55aFyyZ7KmXbEa151JP287vypJAkxugW17YC7Q1B9=TnyHkw@mail.gmail.com>
 <20180416152429.529e3cba@gandalf.local.home> <CA+55aFwjSRZDT1f99QdY-Q5R4W_asb_1mZgM69YOqRR9-efmwA@mail.gmail.com>
 <20180416153816.292a5b5c@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 12:55:46 -0700
X-Google-Sender-Auth: e7ggBH782J2W0zU8VB6fwSjhUT8
Message-ID: <CA+55aFwXRjgfLfAWSaLBdajjzh4gt8-5M2N-bmjKt8nrJT+vWQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 12:38 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But I don't see in the git history that this was ever reverted. My reply
> saying that "I hope it wasn't reverted", was a response for it being
> reverted in stable, not mainline.

See my other email.

If your'e stable maintainer, and you get a report of a commit that
causes problems, your first reaction probably really should just be
"revert it".

You can always re-apply it later, but a patch that causes problems is
absolutely very much suspect, and automatically should make any stable
maintainer go "that needs much more analysis".

Sure, hopefully automation finds the fix too (ie commit 21b81716c6bf
"ipr: Fix regression when loading firmware") in mainline.

It did have the proper "fixes" tag, so it should hopefully have been
easy to find by the automation that stable people use.

But at the same time, I still  maintain that "just revert it" is
rather likely the right solution for stable. If it had a bug once,
maybe it shouldn't have been applied in the first place.

The author can then get notified by the other stable automation, and
at that point argue for "yeah, it was buggy, but together with this
other fix it's really important".

But even when that is the case, I really don't see that the author
should complain about it being reverted. Because it's *such* a
no-brainer in stable.

               Linus
