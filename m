Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEA6ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F57A2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/LOoT7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F57A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbeJaXq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:46:56 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38591 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbeJaXq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:46:56 -0400
Received: by mail-vk1-f194.google.com with SMTP id j20so3967524vke.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VXHMFRoEjcbyqAsTw0a9V7FO4ZhzNuA0KlmatjR5ocM=;
        b=O/LOoT7biqzr8xHAs6liAaCXA8WmGtkS6cRzQ723AbcmpH+/QF2Uei/mxqf2L1wnnq
         WM+9k9qqt/H+8xx1S6vxrbJdrBU04Lu6NqfGcQySpewS7AMScGVs1F+ZjC7OG0hoqu5s
         Jj/mU232Y1dRpxlCwMgDFNO4pXrbfyX1TGpagE5BXRf+HYReaMLAZw/gaamhkpNninGi
         LFh5m7/STop97N5tDdZcyjfp8kYz8onzBOMWoz/HjZE6DWL7QBz4lkIy2Lmf4EQyPGpa
         Uf4Lh0iG5ABWFIYks1CtOMAGY0PLseVjlIEfREsvqeKM+c23yk09yycP1IUSwAb8pTwU
         +iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VXHMFRoEjcbyqAsTw0a9V7FO4ZhzNuA0KlmatjR5ocM=;
        b=BdJztitvWdE26/i38Ro9j7VCUNPVBe8O4d1qxAiO/Ffp5MBGMOp3aMOCfdvAAubjro
         EEo6hKC6mU+6P/akRII11VhMOrKKt7NCDa2VggMs9xRzUNHy6Kzd8qQ/PpF40d8ePohj
         D+FnNEwZ3x4e0YpB0TSCear+eLdB9uG8lY5UzB7ShpJ/xokrdn+baj1YhMbUBOsBm45T
         zd3Q+lyNweziK3r4dzzDWDEjw8lEZKxbnK1RzU3NowXuqd2UG4fWrB/s8tSQABXoIoVo
         6JG3+uREGaPjRwQXtwrKvOGaIPYZPCRGfn9hMVe+QFfIua2+aixtesKdgdam9tSIiOng
         Utwg==
X-Gm-Message-State: AGRZ1gLv1lA1gBkCO7gZ3qTY0T9eRcbbUvLbk62hSLHrKeYO6BUOyiNU
        Tsd8UljeEga+slNauUIC9r+xK3i9I8Nq7vnvHOf+Ovp4a+g=
X-Google-Smtp-Source: AJdET5eWpsxOaleU9PuJHu2rWj+WMnZDBu1sxiChYQTT9uIaX2lvDZmln5Jn1Tn5HFxTdEWeuXbd/SMQtjRQlAtrRv4=
X-Received: by 2002:a1f:1144:: with SMTP id 65mr1406211vkr.54.1540997314794;
 Wed, 31 Oct 2018 07:48:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 07:48:34
 -0700 (PDT)
In-Reply-To: <4ed9af67cf4a46708905d3f392344bcb@AcuMS.aculab.com>
References: <20181029175322.189042-1-dancol@google.com> <4beaaae77bea4cc5b4cc15504331c9a9@AcuMS.aculab.com>
 <CAKOZuetR6_ztfJOe4TMVCX2J5sfuP8XBtG66hmsDkx-KH=CpJw@mail.gmail.com> <4ed9af67cf4a46708905d3f392344bcb@AcuMS.aculab.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 31 Oct 2018 14:48:34 +0000
Message-ID: <CAKOZueuuAGSDwXc2jdZM_=EJdsG0HeGZFLaFWDFNHLLKXJpwbg@mail.gmail.com>
Subject: Re: [RFC PATCH] Minimal non-child process exit notification support
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "timmurray@google.com" <timmurray@google.com>,
        "joelaf@google.com" <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 2:25 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Daniel Colascione
>> Sent: 31 October 2018 12:56
>> On Wed, Oct 31, 2018 at 12:27 PM, David Laight <David.Laight@aculab.com> wrote:
>> > From: Daniel Colascione
>> >> Sent: 29 October 2018 17:53
>> >>
>> >> This patch adds a new file under /proc/pid, /proc/pid/exithand.
>> >> Attempting to read from an exithand file will block until the
>> >> corresponding process exits, at which point the read will successfully
>> >> complete with EOF.  The file descriptor supports both blocking
>> >> operations and poll(2). It's intended to be a minimal interface for
>> >> allowing a program to wait for the exit of a process that is not one
>> >> of its children.
>> >
>> > Why do you need an extra file?
>>
>> Because no current file suffices.
>
> That doesn't stop you making something work on any/all of the existing files.

Why overload?

>> > It ought to be possible to use poll() to wait for POLLERR having set
>> > 'events' to zero on any of the nodes in /proc/pid - or even on
>> > the directory itself.
>>
>> That doesn't actually work today. And waiting on a directory with
>> POLLERR would be very weird, since directories in general don't do
>> things like blocking reads or poll support. A separate file with
>> self-contained, well-defined semantics is cleaner.
>
> Device drivers will (well ought to) return POLLERR when a device
> is removed.
> Making procfs behave the same way wouldn't be too stupid.

That's overkill. You'd need to add poll support to files throughout
/proc/pid, and I don't think doing so would add any new capabilities
over keeping the changes localized to one new place.

>> > Indeed, to avoid killing the wrong process you need to have opened
>> > some node of /proc/pid/* (maybe cmdline) before sending the kill
>> > signal.
>>
>> The kernel really needs better documentation of the semantics of
>> procfs file descriptors. You're not the only person to think,
>> mistakenly, that keeping a reference to a /proc/$PID/something FD
>> reserves $PID and prevents it being used for another process. Procfs
>> FDs do no such thing. kill(2) is unsafe whether or not
>> /proc/pid/cmdline or any other /proc file is open.
>
> Interesting.
> Linux 'fixed' the problem of pid reuse in the kernel by adding (IIRC)
> 'struct pid' that reference counts the pid stopping reuse.

Struct pid doesn't stop PID reuse. It just allows the kernel to
distinguish between a stale and current reference to a given PID. In a
sense, the "struct pid*" is the "real" name of a process and the
numeric PID is just a convenient way to find a struct pid.

> But since the pids are still allocated sequentially userspace can
> still reference a pid that is freed and immediately reused.
> I'd have thought that procfs nodes held a reference count on the 'struct pid'.
> There's probably no reason why it shouldn't.
>
> Annoyingly non-GPL drivers can't release references to 'struct pid' so
> are very constrained about which processes they can signal.

If I had my way, I'd s/EXPORT_SYMBOL_GPL/EXPORT_SYMBOL/ in pid.c.
These routines seem generally useful. As an alternative, I suppose
drivers could just use the new /proc/pid/kill interface, with
sufficient contortions, just as userspace can.

> I also managed to use a stale 'struct pid' and kill the wrong process
> - much more likely that the pid number being reused.

That shouldn't be possible, unless by "stale 'struct pid'" you mean a
struct pid* referring to a struct pid that's been released and reused
for some other object (possibly a different struct pid instances), and
that's UB.

> If you look at the NetBSD pid allocator you'll see that it uses the
> low pid bits to index an array and the high bits as a sequence number.
> The array slots are also reused LIFO, so you always need a significant
> number of pid allocate/free before a number is reused.
> The non-sequential allocation also makes it significantly more difficult
> to predict when a pid will be reused.
> The table size is doubled when it gets nearly full.

NetBSD is still just papering over the problem. The real issue is that
the whole PID-based process API model is unsafe, and a clever PID
allocator doesn't address the fundamental race condition. As long as
PID reuse is possible at all, there's a potential race condition, and
correctness depends on hope. The only way you could address the PID
race problem while not changing the Unix process API is by making
pid_t ridiculously wide so that it never wraps around.
