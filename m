Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB69BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C29B2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVyasIen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C29B2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeKAEcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:32:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33160 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeKAEcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:32:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id c25-v6so14685745oiy.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=12fgHqsRul7XuPR27RDax+pCSlmtmcQ5tfkV5Lfa8Vk=;
        b=TVyasIenKThHe+x8fjfxQiwrYIJOARnkPqC65SCpLpGwHPdbxo7vGYp7YgpB1XTlMd
         ZEVoE9iY6pP98lSbxHVLf2m+ArLBkEwJ97I3Emobof4KPgUXx7cSIm4BDn3L6un7AY7B
         j1yjhYkvdJ03/6l6ikoqr2XLX0K1VduSk4EzrAVIGA9eMXv/BLJDUcZXz5wnUT3jIEBB
         J8HON4bXuwmfq836K5RtW7boooxX/ilvqkqjVaoC0U9pAbXM6KqISJ6ceLc0beji/uWF
         m07eXsgxCkDPo5QhxQLLBvJteOZ68JVk/fhB8oQxZhuwOpqh9BDReO9HfTNYkYRVA97h
         yaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=12fgHqsRul7XuPR27RDax+pCSlmtmcQ5tfkV5Lfa8Vk=;
        b=oRpYR6I8qJl+spMsdj3wO53rRNjeFwQtrT4kU89sSXgj6hPp56VBCNNTzCo5kuOf+d
         Mm/3XuuJ/yFMLBffuP5MMF6RlAmcjdxan9ngrHpY8dufZQmwML/rDKEimcZT25ONBOsn
         rZpCquxIT3BmfSzUZQMxmSZCVlkyraCx2MjnNprrlpvPcf0oJWGUZi70W4nawAp/ofxh
         nMjaStCz8jHDQevb1v1QFAplPGbTM3sdwDx/wpwsaOwiA6rgX8KD40tg2Nx/JUwkJWWL
         DYJ1a6FSgLoN549uMQCLgSpLuFxBreBKJyeP8n4OxAVjAE0IbpUYtacvAsVTo2Noz1yA
         94bw==
X-Gm-Message-State: AGRZ1gLbnB1RLnxs0l2aospwR9PKDdP5vd/VfGG1dV4zxDtPu1fln6Qi
        dMPXSqkgJFedGR55n/bhfUYbeM8Q5NrpVnxu0f2gIYnqvLGSnQ==
X-Google-Smtp-Source: AJdET5dot6kz8LYpFvxtoibYzi5CNMj4DrAKogK1WtrcKLnhnS2NsUqf4SVYKBKq3N8cExjgUtLBV0qoz0YopVMFCkw=
X-Received: by 2002:aca:3788:: with SMTP id e130-v6mr2706693oia.117.1541014387830;
 Wed, 31 Oct 2018 12:33:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:4105:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 12:33:06
 -0700 (PDT)
In-Reply-To: <20181031181717.GD2180@cisco>
References: <20181029221037.87724-1-dancol@google.com> <20181031155912.45088-1-dancol@google.com>
 <20181031175448.GC2180@cisco> <CAKOZuevrFxWLY1J1DVPNGaEy8UbkD1r_M9T9FQTOtSrqp-G0qw@mail.gmail.com>
 <20181031181717.GD2180@cisco>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 31 Oct 2018 19:33:06 +0000
Message-ID: <CAKOZuetdSK8jhD1snja8p4AQTNPrLOugQrVn642RCH8S4QBGFg@mail.gmail.com>
Subject: Re: [PATCH v3] Implement /proc/pid/kill
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 6:17 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> On Wed, Oct 31, 2018 at 06:00:49PM +0000, Daniel Colascione wrote:
>> On Wed, Oct 31, 2018 at 5:54 PM, Tycho Andersen <tycho@tycho.ws> wrote:
>> > Why not just use an ioctl() like Jann suggested instead of this big
>> > security check? Then we avoid the whole setuid writer thing entirely,
>>
>> Don't you think a system call would be better than a new ioctl?
>
> We already have a kill() system call :)

kill(2) is useless this purpose: it accepts a numeric PID, but we'd
need it to accept a process file descriptor instead. It's true that
the existing kill(1) binary might be the vehicle for using a
hypothetical new system call, but that's a separate matter.

>> With either an ioctl or a new system call, though, the shell would
>> need a helper program to use the facility, whereas with the existing
>> approach, the shell can use the new facility without any additional
>> binaries.
>
> ...and a binary to use it!
>
> The nice thing about an ioctl is that it avoids this class of attacks
> entirely.

Let's stop talking about adding an ioctl. Ioctls have problems with
namespacing of the request argument; it's not safe, in general, to
issue an ioctl against a file descriptor of an unknown type. You don't
know how that FD will interpret your request code. The two good
options before us are a write(2) interface and a new system call. I
think both are defensible. But I don't see a good reason to consider
adding an ioctl instead of a system call.

>> > and we can pass the fd around if we want to.
>>
>> You can pass the FD around today --- specifically, you just pass the
>> /proc/pid directory FD, not the /proc/pid/kill FD. The /proc/pid
>> directory FD acts as a process handle. (It's literally a reference to
>> a struct pid.) Anyone who receives one of these process handle FDs and
>> who wants to use the corresponding kill file can open the kill fd with
>> openat(2). What you can't do is pass the /proc/pid/kill FD to another
>> security context and use it, but when would you ever want to do that?
>
> Perhaps I don't have a good imagination, because it's not clear to me
> when I'd ever use this from a shell instead of the kill binary,

I'm not against a new system call per se; I'd just prefer a write(2)
interface if we can get away with it. The trouble with a system call
is that it would have to accept a /proc/pid file descriptor, and file
descriptor management in the shell is awkward. I imagine the interface
would look something like kill -f PATH, where PATH is a PATH to a
/proc/pid directory. You'd be able to cd into /proc/$SOMETHING,
inspect state, and then, if you wanted to kill the process, you'd run
kill -f . 9 (or whatever signal number you want). It seems to be about
as ergonomic as 'echo 9 > ./kill'. But a new system call means new
kernel headers, coordination with procps, and bash, and every other
shell that has a kill builtin. You could provide a different, non-kill
binary, but then who'd distribute it? A new proc file, OTOH, would
Just Work. I agree that a system call interface would avoid the need
for the security check thing in the patch, but is avoiding this check
worth the coordination flowing from adding a new system call? I don't
know.

All of this is moot if the new comprehensive process interface that
comes out of LPC ends up being better anyway.

> either. Using this from the shell is still racy, because if I do
> something like:
>
> echo 9 > /proc/$pid/kill
>
> There's exactly the same race that there is with kill, that $pid might
> be something else.

> Of course I could do some magic with bind mounts or
> my pwd or something to keep it alive, but I can already do that today
> with kill.

You can't do it today with kill. The idea that keeping a open file
descriptor to a /proc/pid or a file within it prevents PID reuse is
widespread, but incorrect.
