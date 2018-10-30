Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91361C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C69C2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+GRQWTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C69C2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeJ3RwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:52:01 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46172 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3RwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:52:00 -0400
Received: by mail-vs1-f65.google.com with SMTP id l6so7131924vsj.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 01:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I56xSu4RY4TGKO99XbtGs2nK5ZhjNUH4Tr9D+ZItFAM=;
        b=l+GRQWTfX3biGvqREt9Ceo9/28nN9YRxtd6uBuxhQQjZ7L9JTazd9ZOY8iGdJhJ3QS
         vlj3BjfUE46zgCgZq1WD4H8krQTMqgfq5vaP2EobOW1gpq2885XZKY1mmfEryIML/PNp
         c+BNlPXIH8PXctOiSKh/Uw8h/JPNShfXOXrTYhOIMvbJO5hP1LlMKxw1gk3nJVXfALXk
         kZQHAN8+GuNLv/AmIAExI6HYhey8nT52c1dc6uhAS4ggnwoLYfQZemSDJdTdU+NAKmge
         utwsRoRIeH8IoeOw9ROnhZ4F9t8zkWBSpK5oGnhjQOEX+plW7IfzGq3yZC1k/rNi97o1
         V47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I56xSu4RY4TGKO99XbtGs2nK5ZhjNUH4Tr9D+ZItFAM=;
        b=cGHDyvJFqloa7RO5QpgZP2LGqxHsx6zQo5pwfcaAT7KJ5wpAWVjrL5r3eMnlTKV13c
         PIXmpJpR1qeHDrUCMKLocCljdwWvnBpd536mHxLPCrbXlbWkXPFpcAJriTWcLYpl9SgS
         XgY+vYcLcKvS1jsS7OpGOyaCgFq4ZzTvdo9CSuGPilarcM8SEzAJgdHlTXda50iVA7hP
         aERlh42cLms7fJKXnVPUbor6z+bBq83DIwokDl/nBprMVGW5nJGNiaqVTv43UPDAMjD3
         6+J7TkCRAi1RylsfQmOzEQ7VofSIR6tG2WLFaSQXMe4e5IlnqjixUPqOfidgfLHJwlxt
         sJZQ==
X-Gm-Message-State: AGRZ1gLKds7EfMgmJnlrdWXzIz6QSmdNwWcJhU0p7rao4kcSiwOkZ/lC
        zN+vof3RwHuZgTs0pdj9peR995Vx3Jyt92D7q0iCFt8TEgU=
X-Google-Smtp-Source: AJdET5dXeTby7YpO2oGQe3pi9KjHwkV2NPavrVFHOl152RQwaPe1HMUkY6yv+7dgsi6sfbBNM7NSznZaFcCX/i6Qgv8=
X-Received: by 2002:a67:6cc1:: with SMTP id h184mr2746911vsc.149.1540889966495;
 Tue, 30 Oct 2018 01:59:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f492:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 01:59:25
 -0700 (PDT)
In-Reply-To: <CAJWu+orRE9HL2KWRzEhr2B2Owi=66x-mgjYiJV=cje-rgOeSxQ@mail.gmail.com>
References: <20181029175322.189042-1-dancol@google.com> <CAJWu+opR5bU7b0ux5GZjO-Wu+=2F8sARke-E_y4PpH0XSubx9g@mail.gmail.com>
 <CAKOZuetEeP2QgowUL60LYoOgavN7e-WX52adzTdMQhZX0bZn-Q@mail.gmail.com> <CAJWu+orRE9HL2KWRzEhr2B2Owi=66x-mgjYiJV=cje-rgOeSxQ@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 30 Oct 2018 08:59:25 +0000
Message-ID: <CAKOZuetNC8Z4a5HAZkm2D4RMrTOCWj71rLJXOOtuoFaF3gGEpA@mail.gmail.com>
Subject: Re: [RFC PATCH] Minimal non-child process exit notification support
To:     Joel Fernandes <joelaf@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 3:06 AM, Joel Fernandes <joelaf@google.com> wrote:
> On Mon, Oct 29, 2018 at 1:01 PM Daniel Colascione <dancol@google.com> wrote:
>>
>> Thanks for taking a look.
>>
>> On Mon, Oct 29, 2018 at 7:45 PM, Joel Fernandes <joelaf@google.com> wrote:
>> >
>> > On Mon, Oct 29, 2018 at 10:53 AM Daniel Colascione <dancol@google.com> wrote:
>> > >
>> > > This patch adds a new file under /proc/pid, /proc/pid/exithand.
>> > > Attempting to read from an exithand file will block until the
>> > > corresponding process exits, at which point the read will successfully
>> > > complete with EOF.  The file descriptor supports both blocking
>> > > operations and poll(2). It's intended to be a minimal interface for
>> > > allowing a program to wait for the exit of a process that is not one
>> > > of its children.
>> > >
>> > > Why might we want this interface? Android's lmkd kills processes in
>> > > order to free memory in response to various memory pressure
>> > > signals. It's desirable to wait until a killed process actually exits
>> > > before moving on (if needed) to killing the next process. Since the
>> > > processes that lmkd kills are not lmkd's children, lmkd currently
>> > > lacks a way to wait for a proces to actually die after being sent
>> > > SIGKILL; today, lmkd resorts to polling the proc filesystem pid
>> >
>> > Any idea why it needs to wait and then send SIGKILL? Why not do
>> > SIGKILL and look for errno == ESRCH in a loop with a delay.
>>
>> I want to get polling loops out of the system. Polling loops are bad
>> for wakeup attribution, bad for power, bad for priority inheritance,
>> and bad for latency. There's no right answer to the question "How long
>> should I wait before checking $CONDITION again?". If we can have an
>> explicit waitqueue interface to something, we should. Besides, PID
>> polling is vulnerable to PID reuse, whereas this mechanism (just like
>> anything based on struct pid) is immune to it.
>
> The argument sounds Ok to me. I would also more details in the commit
> message about the alternate methods to do this (such as kill polling
> or ptrace) and why they don't work well etc so no one asks any
> questions. Like maybe under a "other ways to do this" section. A bit
> of googling also showed a netlink way of doing it without polling
> (though I don't look into that much and wouldn't be surprised if its
> more complicated)

Thanks for taking a look. I'll add to the commit message.

Re: netlink isn't enabled everywhere and is subject to lossy buffy
overruns, AIUI. You could also monitor process exit by setting up
ftrace and watching events, or by installing BPF that watched for
process exit and sent a perf event. :-) All of these interfaces feel
like abusing a "monitoring" API for controlling system operations, and
this kind of abuse tends to have ugly failure modes. I'm looking for
something a bit more explicit and robust.

>
> Also I guess when you send a patch, it'd be good to pass
> "--cc-cmd='./scripts/get_maintainer.pl" to git-send-email so it
> automatically CCs the maintainers who maintain this.

Thanks for the tip!
