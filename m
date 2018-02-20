Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3031579-1519138285-2-14879083247109009496
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519138284; b=lVV5uMSija844DTzJSny7OkRll6ASFvbi2zAt4fi3zz1B8m
    B6l6GEYxPANqmyP7QmBWocrm8+bRlr24UhxOCcLuYH2cbNU1UIjQCtQchNi4HWo2
    +NewqBzOoyfuBz2E6a70z/cs8xEQXryVGVNzP7mGDwXc+HLzmx4NADG8D8T14NCN
    CQh7rQlLVpWlAc0QO7VotAuahVb5uZk14puS+Dfu1Z/+abT5TnFjaDokFVFQn8Cx
    4JVUbF+l1D+KPcWWeL4ZwKIMQy+oTF4hmqm5TpBBzz6YpfckLnr0RoyYJk05P6Eu
    3lum4nM6jMjRQ/+w4ViWzJb9MBn+DAeizvLawaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519138284; bh=krBFx3SxXefcdv+KlhYbTdqTSuP5LceELX2HUU
    NNakY=; b=YZ2sU9vnC6DYlPaiWyGz/kw9SH2rvjaobu3zcfkg4MfyPRBfcCSGJF
    yfA0ebv2lWzKjmL+3jwNbMZRPb/FD0ZmmsyVd48S7UMXvhwF3oJF7mctLouZ7bLj
    HcL4DKbX1i3h8JFhG1Wg2zX0XrHq4nnrHeGySTt32t07uLlPOW95/p9vXR/hqA1V
    V0xA2c9D6oQ5ltHWgMq/jP5xZfjCqT/qz9WF8iUDBsfr1Mdk2Xv2N1r9T5noNHQ+
    NAfW92Va9xmYC6CSErd12VhxutpOJrGGoJt6xqyoUiBvmuUsoPUfG7YEifx6fmZ3
    fnxW8Ubcdl3Gr/ICdY23m6sF+LYLOYBA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=Yyk7CYSv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p2dK5xmy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=Yyk7CYSv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p2dK5xmy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbeBTOvM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 09:51:12 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33016 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbeBTOvL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 09:51:11 -0500
X-Google-Smtp-Source: AH8x225wNPWs5BzfbcZBjTC8N06RD8a+17bFF48xiyMv3WglDF6oPCN2qG/I7jj6RiMiyPAtw4gEalnxEJnVKrZvZsc=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180220140640.GE25201@hirez.programming.kicks-ass.net>
References: <20170328122915.640228468@linuxfoundation.org> <20170328122918.597715642@linuxfoundation.org>
 <20180220123757.GE25314@hirez.programming.kicks-ass.net> <CAHC9VhTOxzcJpVSFDign56jkkruQjujTp7GQzk107FNWYTXRYg@mail.gmail.com>
 <20180220140640.GE25201@hirez.programming.kicks-ass.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Feb 2018 09:51:08 -0500
Message-ID: <CAHC9VhS40=qNxjNJSBqz2GwrqrvTqLKpdOWUrJ5iUDFp8ERO-A@mail.gmail.com>
Subject: Re: [PATCH 4.10 070/111] audit: fix auditd/kernel connection state tracking
To: Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 9:06 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Feb 20, 2018 at 08:25:21AM -0500, Paul Moore wrote:
>> On Tue, Feb 20, 2018 at 7:37 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Tue, Mar 28, 2017 at 02:30:56PM +0200, Greg Kroah-Hartman wrote:
>> >> 4.10-stable review patch.  If anyone has any objections, please let me know.
>> >
>> >> +     if (!(auditd_test_task(current) ||
>> >> +           (current == __mutex_owner(&audit_cmd_mutex)))) {
>> >> +             long stime = audit_backlog_wait_time;
>> >
>> > Since I cannot find the original email on lkml, NAK on this.
>> > __mutex_owner() is not a general purpose helper function.
>>
>> Since this code also exists in the current kernel, I need to ask what
>> recommended alternatives exist for determining the mutex owner?
>>
>> I imagine we could track the mutex owner separately in the audit
>> subsystem, but I'd much prefer to leverage an existing mechanism if
>> possible.
>
> It's not at all clear to me what that code does, I just stumbled upon
> __mutex_owner() outside of the mutex code itself and went WTF.

If you don't want people to use __mutex_owner() outside of the mutex
code I might suggest adding a rather serious comment at the top of the
function, because right now I don't see anything suggesting that
function shouldn't be used.  Yes, there is the double underscore
prefix, but that can mean a few different things these days.

> The comment (aside from having the most horribly style) ...

Yeah, your dog is ugly too.  Notice how neither comment is constructive?

> ... is wrong too, because it claims it will not block when we hold that lock, while,
> afaict, it will in fact do just that.

A mutex blocks when it is held, but the audit_log_start() function
should not block for the task that currently holds the
audit_cmd_mutex; that is what the comment is meant to convey.  I
believe the comment makes sense, but I did write it so I'll concede
that I'm probably the not best judge.  If anyone would like to offer a
different wording I'm happy to consider it.

> Maybe if you could explain how that code is supposed to work and why it
> doesn't know if it holds a lock I could make a suggestion...

I just spent a few minutes looking back over the bits available in
include/linux/mutex.h and I'm not seeing anything beyond
__mutex_owner() which would allow us to determine the mutex owning
task.  It's probably easiest for us to just track ownership ourselves.
I'll put together a patch later today.

-- 
paul moore
www.paul-moore.com
