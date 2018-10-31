Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B75C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD9720664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rvy1gCGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD9720664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbeJaXkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:40:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40476 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbeJaXkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:40:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id n3-v6so11837177lfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 07:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lhDbs1vluhJmhUAN/WwPRrQW3gOtpvuTdFHdux8en98=;
        b=rvy1gCGlpw9z+7ETxB8VdpBgn0tvkkmIEUnh+XZuwZepP3NWHW3OVs+qc/cV4+0L4x
         1vPA8pWgBaI3pWBxBVsjznNdWGBoajOH/pgDqcnfAiHjZFpqGMXxwCoSZfDRvzo05xdb
         wr8hRQPUH9SmpYOjeYT9rNXe6e250QpM3Ymic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lhDbs1vluhJmhUAN/WwPRrQW3gOtpvuTdFHdux8en98=;
        b=KO54id2xGj8zURC5wiVPQ7S1ppw4EpdXFk55nbGpqJ3Kx/G1fhPIG30MYbOzfiQKni
         GjgqdmXpGITM0u7xowIqmT0Nv4+Duc4CPgIe4c8pxaFfEWQ/BaHNhaa8XlYZrN07yRPi
         4ymqLZ/PhicopmP/AZWE3FfuKh4l7PDSUIBGqV5ER6fucSo+8+fQu4tpbPtj86UMvJyo
         oIiqZ1Fk3lL2Va7RsYEGNLLklZWFv7Ylr6B2qKRBMk+0U/88xL7nvux8yn7AsIyvAIzt
         g570LG3J9qrLmJRyXsjTneXcvKfHoD4Nmfx2jFGyHTNwpnshkZ+DNhCyEbRs1cAtJaT5
         aUsw==
X-Gm-Message-State: AGRZ1gJBWSexlYMNyZgDGTeUPQhf2EkynsOcyPT65TPH3zvj1bMdsJL0
        m3obTb6VrKHLtJ23OO3dZL+GaqYBZQDfxqQlmCTbEQ==
X-Google-Smtp-Source: AJdET5d+OrYKkkucYkzHeAAFD5Z+p8kYKHzWtW/l088cxY9A3OMDbw28C+VaaeDPsYcfpj0c6q8lq/PV8RWeFmGPzJc=
X-Received: by 2002:a19:1365:: with SMTP id j98mr1980820lfi.55.1540996905486;
 Wed, 31 Oct 2018 07:41:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:650a:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 07:41:44
 -0700 (PDT)
In-Reply-To: <4ed9af67cf4a46708905d3f392344bcb@AcuMS.aculab.com>
References: <20181029175322.189042-1-dancol@google.com> <4beaaae77bea4cc5b4cc15504331c9a9@AcuMS.aculab.com>
 <CAKOZuetR6_ztfJOe4TMVCX2J5sfuP8XBtG66hmsDkx-KH=CpJw@mail.gmail.com> <4ed9af67cf4a46708905d3f392344bcb@AcuMS.aculab.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 31 Oct 2018 07:41:44 -0700
Message-ID: <CAEXW_YS-nTccFtuE9DMkFYA7wXAfeRHt7v4KSZcXMWVYKm+Uyg@mail.gmail.com>
Subject: Re: [RFC PATCH] Minimal non-child process exit notification support
To:     David Laight <David.Laight@aculab.com>
Cc:     Daniel Colascione <dancol@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "timmurray@google.com" <timmurray@google.com>,
        "joelaf@google.com" <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 7:25 AM, David Laight <David.Laight@aculab.com> wrote:
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
>
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
>
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

This is incorrect if you mean numeric pids. See the end of these
comments in include/linux/pid.h . A pid value can be reused, it just
works Ok because it causes a new struct pid allocation. That doesn't
mean there isn't a numeric reuse. There's also no where in pid_alloc()
where we prevent the numeric reuse AFAICT.

/*
 * What is struct pid?
 *
 * A struct pid is the kernel's internal notion of a process identifier.
 * It refers to individual tasks, process groups, and sessions.  While
 * there are processes attached to it the struct pid lives in a hash
 * table, so it and then the processes that it refers to can be found
 * quickly from the numeric pid value.  The attached processes may be
 * quickly accessed by following pointers from struct pid.
 *
 * Storing pid_t values in the kernel and referring to them later has a
 * problem.  The process originally with that pid may have exited and the
 * pid allocator wrapped, and another process could have come along
 * and been assigned that pid.
 *
 * Referring to user space processes by holding a reference to struct
 * task_struct has a problem.  When the user space process exits
 * the now useless task_struct is still kept.  A task_struct plus a
 * stack consumes around 10K of low kernel memory.  More precisely
 * this is THREAD_SIZE + sizeof(struct task_struct).  By comparison
 * a struct pid is about 64 bytes.
 *
 * Holding a reference to struct pid solves both of these problems.
 * It is small so holding a reference does not consume a lot of
 * resources, and since a new struct pid is allocated when the numeric pid
 * value is reused (when pids wrap around) we don't mistakenly refer to new
 * processes.
 */
