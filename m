Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1049172-1519202769-2-7892973935570559066
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 3.2, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519202769; b=TPOl1c6WWg6QyultqZkZ4ULTXP9Zrx03UXgyZDH2ykeRJMK
    6gutdy/rGqwNGRwXcDHowmryTrhMDGZHe4TP2e+GZejf07PUtvcZ3V0oyHyFWJRJ
    MVk1y5Jt74TibRIas6ubjQABKTVGy35wRwry6rE+rebUp/VdBE+4bC7daq1HMfgr
    eC45Zk8N954Okdz13Y8/WPTXGKtdpycnc0//FPxfHbCCS3BfnHrg6JSXBgghe0ru
    KYNTsOrefqvDdWu7N1EEACYfnWIQU9XiefABILH4ePr6YzhUhungKG61BYwNfauW
    0X9KWCRRFciqogGDediatBFY+wnPnERUBptBDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519202769; bh=EPp8EOEMlrfGpztZEoRbZbPd75
    EdUZ0V4JXiERKwRx8=; b=tyz5yddG/zCaEgJqG5hSteqvx/g0xmAjrkghFAbM64
    rF8bqQnWP7ttIl2LGmVHAqo43gGwAXyI/fbFiVYtuiTkOcHYAy+fGFdxN39W0jHR
    W7Q2S6kF3PkqZer+fP09ygltIn1QLwjjWBRcahmcXyrpjzjV4zCi+7Zw/+NtfLfM
    6OXDhv5MBBcSwwJTZ/KftRQQ1CTiSJ/w42dqmMVd+OAxNo8i2rlViQAlh8C9NGXR
    YtOXbG3jB2hT8H4V1rDPQBAwdDBhMnx28KJcsDERfgeFDTSlgm+WhDzlJjEYg+oN
    IhTxAVB5GZwuKN3jDkOajJLt0vtOKvT9XaDIoycDI8JQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ht84gC6g x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T5piIA9/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ht84gC6g x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T5piIA9/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeBUIqH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 03:46:07 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39455 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbeBUIqG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 03:46:06 -0500
X-Google-Smtp-Source: AH8x227sV7BNC96V0mpUJP02LGd4Bt5OHka1banBC+UVuioi58F2fqPRrXUVmTjSq7Z4onhqE97GYg==
Date: Wed, 21 Feb 2018 09:46:02 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, linux-audit@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4.10 070/111] audit: fix auditd/kernel connection state
 tracking
Message-ID: <20180221084601.scnvgiiv32s2pgye@gmail.com>
References: <20170328122915.640228468@linuxfoundation.org>
 <20170328122918.597715642@linuxfoundation.org>
 <20180220123757.GE25314@hirez.programming.kicks-ass.net>
 <CAHC9VhTOxzcJpVSFDign56jkkruQjujTp7GQzk107FNWYTXRYg@mail.gmail.com>
 <20180220140640.GE25201@hirez.programming.kicks-ass.net>
 <CAHC9VhS40=qNxjNJSBqz2GwrqrvTqLKpdOWUrJ5iUDFp8ERO-A@mail.gmail.com>
 <20180220151849.GG25201@hirez.programming.kicks-ass.net>
 <CAHC9VhQUGF+W0sZemeCstPDUHxwQrD7Pmbu5SnAHZVdkCPdMwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQUGF+W0sZemeCstPDUHxwQrD7Pmbu5SnAHZVdkCPdMwg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Paul Moore <paul@paul-moore.com> wrote:

> On Tue, Feb 20, 2018 at 10:18 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Feb 20, 2018 at 09:51:08AM -0500, Paul Moore wrote:
> >> On Tue, Feb 20, 2018 at 9:06 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >> > It's not at all clear to me what that code does, I just stumbled upon
> >> > __mutex_owner() outside of the mutex code itself and went WTF.
> >>
> >> If you don't want people to use __mutex_owner() outside of the mutex
> >> code I might suggest adding a rather serious comment at the top of the
> >> function, because right now I don't see anything suggesting that
> >> function shouldn't be used.  Yes, there is the double underscore
> >> prefix, but that can mean a few different things these days.
> >
> > Find below.
> >
> >> > The comment (aside from having the most horribly style) ...
> >>
> >> Yeah, your dog is ugly too.  Notice how neither comment is constructive?
> >
> > I'm sure you've seen this one:
> >
> >   https://lkml.org/lkml/2016/7/8/625
> 
> Yep.  I stand behind my earlier comment in this thread.
> 
> >> > Maybe if you could explain how that code is supposed to work and why it
> >> > doesn't know if it holds a lock I could make a suggestion...
> >>
> >> I just spent a few minutes looking back over the bits available in
> >> include/linux/mutex.h and I'm not seeing anything beyond
> >> __mutex_owner() which would allow us to determine the mutex owning
> >> task.  It's probably easiest for us to just track ownership ourselves.
> >> I'll put together a patch later today.
> >
> > Note that up until recently the mutex implementation didn't even have a
> > consistent owner field. And the thing is, it's very easy to use wrong,
> > only today I've seen a patch do: "__mutex_owner() == task", where task
> > was allowed to be !current, which is just wrong.
> 
> Arguably all the more reason why a strongly worded warning is
> important (which I see you've included below, feel free to include my
> Reviewed-by).
> 
> > Looking through kernel/audit.c I'm not even sure I see how you would end
> > up in audit_log_start() with audit_cmd_mutex held.
> >
> > Can you give me a few code paths that trigger this? Simple git-grep is
> > failing me.
> 
> Basically look at the code in audit_receive_msg(), but I wasn't asking
> your opinion on how we should rewrite the audit subsystem, I was just
> asking how one could determine if the current task was holding a given
> mutex in a way that was acceptable to you.  Based on your comments,
> and some further inspection of the mutex code, it appears that is/was
> not something that the core mutex code wants to support/make-visible.
> Which is perfectly fine, I just wanted to make sure I wasn't missing
> something before I went ahead and wrote a wrapper around the mutex
> code for use by audit.
> 
> FWIW, I just put together the following patch which removes the
> __mutex_owner() call from audit and doesn't appear to break anything
> on the audit side (you're CC'd on the patch).  It has only been
> lightly tested, but I'm going to bang on it for a day or so and if I
> hear no objections I'll merge it into audit/next.
>
> * https://www.redhat.com/archives/linux-audit/2018-February/msg00066.html

Could you please explain the audit_ctl_lock()/unlock() primitive you are 
introducing there? You seem to be implementing some sort of recursive locking 
primitive, but in a strange way.

AFAICS the primary problem appears to be this code path:

  audit_receive() -> audit_receive_msg() -> AUDIT_TTY_SET -> audit_log_common_recv_msg() -> audit_log_start()

where we can arrive already holding the lock.

I.e. recursive mutex, kinda.

What's the thinking there? Neither the changelog nor the code explains this.

Thanks,

	Ingo
