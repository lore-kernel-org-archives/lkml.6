Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3848786-1523905213-2-6003948727822538059
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
    1523905212; b=Giu4dYBFoDL958Ow0P7B+elNHAob10I0kAgQ48hg1b69dSYH5H
    MYGla1akX+3xYKWEr/WNcZpTfFSDc0qc1rlngs07NTlu9mr8/o6kqIeA1neOoAnB
    29J0ixQXdHR/gD/1HMKvPudM2lb4T7dl3U3lV9RJcLb6g2Xot1V4ggnrsQmbF6ir
    ANbMIME3IeabCGjJakRJRdOWNilrZaKRG8i2LoDo5w2ssp0WTvW+Q6Xek3ZLAGfu
    B6772hBAc9eXv7XOkeWGEUMIcWfVg/r8YinPItzSexEFScd/s0UNESOwGswO+sIb
    2t+g5z/HFcnP/nDS5cU5p8OPxzJnH+GTNx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523905212; bh=6J8DlDdt6/sd6kxy6xET8x3QUXwXMLl7C7KMiZfueZ
    k=; b=oJw9u2bfAAQSV2IBud4t+Ru6OFd5sUPaJSK7gpVH9n6lNb0IfA6Vj/rt5l
    o6Nx5iN5X4eGvkxXtTHJydhv7CNBsUKxIm50G2IAIjd+U0lj8vs51MVAaAlpjIQQ
    3Qrs4NLnpwF34r5EkPdGKM7PXN3fnRKGYqajMvyaiQBfsP5qLEr4b0UXgs1DBA3k
    eX/v/d2YKQkL9EOneYJzLroS2OkCDBH9Gol2keCB2cltTUCOk5t4bN1yjlgdO23l
    Kr/I3G0RridJnguxgRXsJkly3vG2cg4dAK3lTQ6XVpwZf1q+rc6RePo0Nz+W9zRy
    Fn99Ia32gFC/J4zstfcQHsP2kXDA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bBwC3N50 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XnrfRiqf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=G6Jrt5Bb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bBwC3N50 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XnrfRiqf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=G6Jrt5Bb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOBZXlKuOhUhLRXseH6iQXk5O1xcO2m2TdmuzPdAEPQtVeH5C3wJLDMK6DXPLyJT0KVgmfiPHOzCv5Sff+vPhPZtiQC6WyIk1jNe+j22cUgzi5TytM7Q
    DL6nzG9g2KVVjwY///hFdc0vGy0ckQvDaLRJXPAcZ4L1MEEaITmdUJrjwk16aFZW3HIxUcAibo6IGwNAy/XutWTVFWS7/391y81aOCiPh8ezJoYfh1x0q2X4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=DuL5xXPf9OJQ0m_Br40A:9 a=QEXdDO2ut3YA:10
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753104AbeDPTAL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 15:00:11 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33650 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753077AbeDPTAK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 15:00:10 -0400
X-Google-Smtp-Source: AIpwx48KFrIyhPOuXYWkg462aVSegNtj0KE4DLxZfn0H9sYBi/HCCmmi64p45W+1a2uxM0hXfVZrZ/yTS23IdGhSlcI=
MIME-Version: 1.0
In-Reply-To: <CA+55aFyyZ7KmXbEa151JP287vypJAkxugW17YC7Q1B9=TnyHkw@mail.gmail.com>
References: <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416122019.1c175925@gandalf.local.home>
 <20180416162757.GB2341@sasha-vm> <20180416163952.GA8740@amd>
 <20180416164310.GF2341@sasha-vm> <20180416125307.0c4f6f28@gandalf.local.home>
 <20180416170936.GI2341@sasha-vm> <20180416133321.40a166a4@gandalf.local.home>
 <20180416174236.GL2341@sasha-vm> <20180416142653.0f017647@gandalf.local.home>
 <CA+55aFzggPvS2MwFnKfXs6yHUQrbrJH7uyY4=znwetcdEXmZrw@mail.gmail.com>
 <20180416144117.5757ee70@gandalf.local.home> <CA+55aFyyZ7KmXbEa151JP287vypJAkxugW17YC7Q1B9=TnyHkw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 12:00:08 -0700
X-Google-Sender-Auth: MLI953x1HLawjvIHOpRgcVN_l5Q
Message-ID: <CA+55aFz0obg3SmCpa7Ff2d91CATF8p-syYjkm4s5FrR+cp5XRA@mail.gmail.com>
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

On Mon, Apr 16, 2018 at 11:52 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> We're better off making *no* progress, than making "unsteady progress".
>
> Really. Seriously.

Side note: the original impetus for this was our suspend/resume mess.
It went on for *YEARS*, and it was absolutely chock-full of exactly
this "I fixed the worse problem, and introduced another one".

There's a reason I'm a hardliner on the regression issue.  We've been
there, we've done that.

The whole "two steps forwards, one step back" mentality may work
really well if you're doing line dancing.

BUT WE ARE NOT LINE DANCING. We do kernel development.

Absolutely NOTHING else is more important than the "no regressions"
rule. NOTHING.

And just since everybody always tries to weasel about this: the only
regressions that matter are the ones that people notice in real loads.

So if you write a test-case that tests that "system call number 345
returns -ENOSYS", and we add a new system call, and you say "hey, you
regressed my system call test", that's not a regression. That's just a
"change in behavior".

It becomes a regression only if there are people using tools or
workflows that actually depend on it. So if it turns out (for example)
that Firefox had some really odd bug, and the intent was to do system
call 123, but a typo had caused it to do system call 345 instead, and
another bug meant that the end result worked fine as long as system
call 345 returned ENOSYS, then the addition of that system call
actually does turn into a regression.

See? Even adding a system call can be a regression, because what
matters is not behavior per se, but users _depending_ on some specific
behavior.

               Linus
