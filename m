Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27F2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A7A20685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcZjX9Mq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A7A20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbeJaVyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:54:09 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44859 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbeJaVyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:54:09 -0400
Received: by mail-vk1-f195.google.com with SMTP id h128so2390293vkg.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 05:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2748mQjQZ5HZ8OHwmIKNL4oZpWL6si+Toa6T7ktkpG8=;
        b=ZcZjX9MqSMkHPNQEGkf/1r4cQ0yR4GD1WnR6odKOLR7Sezbz4u89T2YlojZmG6dU+4
         XjxyOh5ZFv/Jc0BKLfPuCPfRy9AoTdDscd1k7zhqKDEFYx0nkt6yYwymjdpTTN9pRMsd
         w7fbJGUaHBBEwjbNfYWleIe/rSb0a/6kcORrrGVAeamcZXXLtf2y5xqlp4vcN4hVmUA/
         OkcNUmo9iqHplwv+XkzriX3CMPp5doRDqjxZDDc53UF9PRU6Hsy1S1Gn0n0iw6xccF+8
         Tpq0betEVhLaWbJ+BFFPIaQ8iQ8t4OM/BsPPqbLwq5xt0vFLuda0NVvHYl57MwnJFKM0
         D86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2748mQjQZ5HZ8OHwmIKNL4oZpWL6si+Toa6T7ktkpG8=;
        b=Tdtzp1Xguat1dKqMTA4c5i2DzzPNhKkRIkLENs5eYzytw96fi6dtmxWS/DJuoIS1x+
         PyVVBJwVOfZINhOMq5zm4LSvPrLqdzMyHXAt3VlI9hi146o8cSlYE8RNNt5djUe2ArPR
         C1OZywLjEZRUSyb3mOsQ5XLM3yHoG49sfvRcoYlQcro3cdi8ZQuAlCIi182/hwsBfTzT
         zSxsF23MswCdlXDFSSpTzMrXWO5kjfTN4nHVGu9EzW7uIqLPZRZV1YwylE2+KLdyMOMI
         YifFj/sTP6vG7McjkOTEo75jV2FnDt71hhitoDj45U+8IkqL9t6L5jHE9rmJd57z4ykQ
         l/wA==
X-Gm-Message-State: AGRZ1gIGWWDnCXqLzDhCP4jyLHqvWBNc0zdtf6++tUNm//Lko/t5Qyrc
        PkqKf0K/5x1Up+TsOt0DBBVpDiJHWnkaT8zXaJLG1w==
X-Google-Smtp-Source: AJdET5ecbg32zGJNiSUzy6+vCP4WFL2bnv9DiNUqQNjavEWOPYZNJDpKE3XU+N87mg44uRQGvBs8Gl05Aqyn2HwN61s=
X-Received: by 2002:a1f:984e:: with SMTP id a75mr1230107vke.89.1540990573640;
 Wed, 31 Oct 2018 05:56:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 05:56:12
 -0700 (PDT)
In-Reply-To: <4beaaae77bea4cc5b4cc15504331c9a9@AcuMS.aculab.com>
References: <20181029175322.189042-1-dancol@google.com> <4beaaae77bea4cc5b4cc15504331c9a9@AcuMS.aculab.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 31 Oct 2018 12:56:12 +0000
Message-ID: <CAKOZuetR6_ztfJOe4TMVCX2J5sfuP8XBtG66hmsDkx-KH=CpJw@mail.gmail.com>
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

On Wed, Oct 31, 2018 at 12:27 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Daniel Colascione
>> Sent: 29 October 2018 17:53
>>
>> This patch adds a new file under /proc/pid, /proc/pid/exithand.
>> Attempting to read from an exithand file will block until the
>> corresponding process exits, at which point the read will successfully
>> complete with EOF.  The file descriptor supports both blocking
>> operations and poll(2). It's intended to be a minimal interface for
>> allowing a program to wait for the exit of a process that is not one
>> of its children.
>
> Why do you need an extra file?

Because no current file suffices.

> It ought to be possible to use poll() to wait for POLLERR having set
> 'events' to zero on any of the nodes in /proc/pid - or even on
> the directory itself.

That doesn't actually work today. And waiting on a directory with
POLLERR would be very weird, since directories in general don't do
things like blocking reads or poll support. A separate file with
self-contained, well-defined semantics is cleaner.

> Indeed, to avoid killing the wrong process you need to have opened
> some node of /proc/pid/* (maybe cmdline) before sending the kill
> signal.

The kernel really needs better documentation of the semantics of
procfs file descriptors. You're not the only person to think,
mistakenly, that keeping a reference to a /proc/$PID/something FD
reserves $PID and prevents it being used for another process. Procfs
FDs do no such thing. kill(2) is unsafe whether or not
/proc/pid/cmdline or any other /proc file is open.
