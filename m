Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4006321-1523906396-2-15586704048280815101
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
    1523906396; b=J+s2ZSgaIZg4EJuLrDojzVMnA8L/lMby66RAsqXzKLQlVS9hEL
    MLsBCV9+7T6Ar3W+TaCHO+yXx+RNAaUrvZC7XxkNjjTyOBFkLaKiGbQ6tVeZ71q4
    a+RiZbJwmyrmijjqQjIDdiHEGz2gOhIxG9mx7Qr3y+hOQajuTDzgbMx9XrQ9/noB
    hlKit4vEm4rwjngtamZKPmKmt4+nJRS1B2TwORaKX6gm/iy2PkmDPANz1Y8Pj2Rr
    FYlrEPigtI0Plu3sdQLeDQZtjGtIEUCfpUv/Cs4vWdyFrly8ONdTh+HgFytaOC2K
    2/DnI7J4Z2n9CETQDjhshw8WkLNV3F6QsN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523906396; bh=/Lv1KrDKzRfdnvSulCfHz2QQQIlbHHUuD4BOnXzQ3Z
    c=; b=XFqIO/R7YoPmptUKqm69gqaL6bx+q/Khj2NIT+qXYj3MzlDvFMrUxMttVJ
    09iQ0FNpkIpGfEFgR5KJdLXgTmoIP/Ql3ijoMKy2xbNOdJdndMKhLPaDYE10NnAX
    vZ+e3WqUF+k0Wwo0pyyHeRylWPja+jqrMFOUo0n1Ap1sGzK/JSDN9iG4bZTTe1xw
    d5FWysG+T+hYbpW3u9/LpxeZNsMpcC1XNNqT5LDfHQm/8d3OWxv5d64gwQB99uOw
    gFhYdPO7B0ywqyqfSphsepeKhx4VlpLoa1/xpIJYEcd2nhMSRezOVinGpTcF1psa
    RdgQaBCpM+veQtv9a/bF6kzA5zdw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BY8TnkIQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=E/NxAk8q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iJUhFVsW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BY8TnkIQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=E/NxAk8q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iJUhFVsW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB10Un/ClzPBBVmYgzQqqxzywbJKHzcSN7dtpjVkIRaVRI/hltm2lPMWKddktDKsZyYwUELeA2BnSIKQbyQ2kIGHQw0TvmXqSgaf8vJAtONIKZwzXlKG
    D8KcrZZ9/wtVGb7kiheG/wHgYFCoLvv7XqdIBt9E9eHS4LR4miJg32saujZpyvCuVOKyMxlBCO1JC7wI5msIPVGO1DGnut5vMtbLgFpgJiugyT+9kD3xbN7Z
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=Z8MruqhNdWPjUZnt8ykA:9 a=QEXdDO2ut3YA:10
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeDPTTy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 15:19:54 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:39071 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeDPTTx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 15:19:53 -0400
X-Google-Smtp-Source: AIpwx4/Q5Oud0gUmGileaQqtC4QGSE/OaMy4FZ0VGUzJCXE+MAY01GYILDBJznNF+VZGYC3oheMbJS/AkgaZvEolQ+4=
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
Date: Mon, 16 Apr 2018 12:19:51 -0700
X-Google-Sender-Auth: EkWwkiTk3vq9SzI2exhNB6ioCiE
Message-ID: <CA+55aFxt1FFJ0DPpHcANvHiOO1JLcupDok+mHKG7D+zzC-TeYw@mail.gmail.com>
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
> And yes, sometimes that means jumping through hoops. But that's what
> it takes to keep users happy.

The example of "jumping through hoops" I tend to give is the pipe "packet mode".

The kernel actually has a magic pipe mode for "packet buffers", so
that if you do two small writes, the other side of the pipe can
actually say "I want to read not the pipe buffers, but the individual
packets".

Why would we do that? That's not how pipes work! If you want to send
and receive messages, use a socket, for chrissake! A pipe is just a
stream of bytes - as the elder Gods of Unix decreed!

But it turns out that we added the notion of a packetized pipe writer,
and you can actually access it in user space by setting the O_DIRECT
flag (so after you do the "pipe()" system call, do a fcntl(SETFL,
O_DIRECT) on it).

Absolutely nobody uses it, afaik, because you'd be crazy to do it.
What would be the point? sockets work, and are portable.

So why do we have it?

We have it for one single user: autofs. The way you talk to the kernel
side of things is with a magic pipe that you get at mount time, and
the user-space autofs daemon might be 32-bit even if the kernel is
64-bit, and we had a horrible ABI mistake which meant that sending the
binary data over that pipe had different format for a 32-bit autofsd.

And systemd and automount had different workarounds (or lack
there-of), for the ABI issue.

So the whole "ok, allow people to send packets, and read them as
packets" came about purely because the ABI was broken, and there was
no other way to fix things.

See 64f371bc3107 ("autofs: make the autofsv5 packet file descriptor
use a packetized pipe") for (some) of the sad details.

That commit kind of makes it sound like it's a nice solution that just
takes advantage of the packetized pipes. Nice and clean fix, right?

No. The packetized pipes exist in the first place _purely_ to make
that nice solution possible. It's literally just a "this allows us to
be ABI compatible with two different users that were confused about
the compatibility issue we had due to a broken binary structure format
acrss x86-32 and x86-64".

See commit 9883035ae7ed ("pipes: add a "packetized pipe" mode for
writing") for the other side of that.

All this just because _we_ made a mistake in our ABI, and then real
life users started using that mistake, including one user that
literally *knew* about the mistake and worked around it and started
depending on the fact t hat our compatibility mode was buggy because
of it.

So it was a bug in our ABI. But since people depended on the bug, the
bug was a feature, and needed to be kept around. In this case by
adding a totally new and unrelated feature, and using that new feature
to make those old users happy. The whole "set packetized mode on the
autofs pipe" is all done transparently inside the kernel, and
automount never knew or needed to care that we started to use a
packetized pipe to get the data it sent us in the chunks it intended.

             Linus
