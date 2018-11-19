Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009A1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC94220870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="btvBDjJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC94220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbeKTGFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:05:01 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33430 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbeKTGFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:05:01 -0500
Received: by mail-ua1-f67.google.com with SMTP id t8so3425027uap.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9xsZE38xTUYiZ4BKZgkLAGyvdXvx5lZL/HRMO8epTiU=;
        b=btvBDjJICEVVHuTSGDLx9vnFm+1QxyVLRKFe9qu5rh+AYmkRrjfKO0OzE1g770M5K0
         tENUnZmpfV4lwrHU7ElPcqPKqlYVPARvAnJleqvvDiBD7gEJ/g2LY7HUcI1BPz1ixp+w
         l1spdoWo2C5eXljl97ogYVtDp27ttOUDuwvAE6Ma6p9HZ4hVAyD68Qpyy3bZQUTfhW65
         2pqb+XMehSaKqm0f0DGX1rQYuyltIlqraD92j0yAuxllfw2ikqrp88eCkSbfWMHCm/Rh
         9q4YKA+jXHZVI6dL8bwvS46yhAOwGA//dJJ0S3ToR4SNHYnkoOUAsg6jJ/XOwWHy/ern
         aMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9xsZE38xTUYiZ4BKZgkLAGyvdXvx5lZL/HRMO8epTiU=;
        b=ga+XrbPnCwBP3N4cCCbwWNDVMKJay8pmPACsT85HggK81sPf0h/cT9ab6DaQtg/rS6
         DPHdVlmJMGOsBRcPYnita7MK6GwV/fuhVM8PezlNcgspEMxMTAI10SOA3RhbqIUTeyJR
         nsKlP/KVAmViL3wmU3CGlZKi4sdVh4xoJAXK53GvUbsjSG/ncTntahWo7qBdaUtmasp8
         pkCDkxMJ5yt/T9SxHOVxP6avZt/lAh2xH9msOlYr+IO0TBbE2gvyqOro+Y2EjAwVFjQ+
         +HUVQ7S6xhoJaWJ4xVnhUoDdVSc0qnBPFFbr8vzSAq5L5Q6lZTcXLrIvqmx2KnMJ3o32
         ks+g==
X-Gm-Message-State: AGRZ1gLz8EN4Sc5pKFYY9/80O6sNvQKDj1IfKdldg7ssWvCKBRfN0GYW
        oOVqwNiPxlDbT+537bKO50Y5LQCT5LKRIl3I8+aezg==
X-Google-Smtp-Source: AJdET5fxMsnKg3INeyhRgZ0FNraROixfXpm/Mm7mVOH+lKavdzHPlE3awQ4r6n2yNsUOv5aaqGnIp8fogSW5ALlG/10=
X-Received: by 2002:ab0:225a:: with SMTP id z26mr10672112uan.100.1542656394542;
 Mon, 19 Nov 2018 11:39:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Mon, 19 Nov 2018 11:39:53
 -0800 (PST)
In-Reply-To: <20181119193128.hv7z4j52ajrue2jr@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io> <20181119103241.5229-3-christian@brauner.io>
 <CAKOZueshQ2DAwUYp+dLpmfYG6FtvCqeRQxH41SjNS+WqY3e0Fw@mail.gmail.com>
 <20181119182902.fadw6qiu3eepndm3@brauner.io> <87o9ak28nl.fsf@xmission.com> <20181119193128.hv7z4j52ajrue2jr@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 19 Nov 2018 11:39:53 -0800
Message-ID: <CAKOZuethLLUEf-ZFVpm7u1msyYUJ1ArP2vemMUzrct7K0sv_WA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yep. That's also what I was talking about, FWIW.

On Mon, Nov 19, 2018 at 11:31 AM, Christian Brauner
<christian@brauner.io> wrote:
> On Mon, Nov 19, 2018 at 01:02:06PM -0600, Eric W. Biederman wrote:
>> Christian Brauner <christian@brauner.io> writes:
>>
>> > On Mon, Nov 19, 2018 at 07:59:24AM -0800, Daniel Colascione wrote:
>> >> You never addressed my comment on the previous patch about your use of
>> >
>> > Sorry, that thread exploded so quickly that I might have missed it.
>> >
>> >> private_data here. Why can't you use the struct pid reference that's
>> >> already in the inode?
>> >
>> > If that's what people prefer we can probably use that. There was
>> > precedent for stashing away such data in fs/proc/base.c already for
>> > various other things including user namespaces and struct mm so I
>> > followed this model. A prior version of my patch (I didn't send out) did
>> > retrive the inode via proc_pid() in .open() took an additional reference
>> > via get_pid() and dropped it in .release(). Do we prefer that?
>>
>> If you are using proc/<pid>/ directories as your file descriptors, you
>> don't need to add an open or a release method at all.  The existing file
>> descriptors hold a reference to the inode which holds a reference the
>> the struct pid.
>>
>> The only time you need to get a reference is when you need a task
>> and kill_pid_info already performs that work for you.
>
> Oh, I see what you and Andy are saying now. Sweet, that means we can
> trim down the patch even more. Less code, less headache.
>
> Thanks!
>
>>
>> So using proc_pid is all you need to do to get the pid from the existing
>> file descriptors.
>>
>> Eric
>>
