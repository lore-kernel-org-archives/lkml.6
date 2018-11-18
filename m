Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C5CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8A620869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IAtl111Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8A620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeKSEwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 23:52:43 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34148 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeKSEwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 23:52:43 -0500
Received: by mail-vs1-f66.google.com with SMTP id y27so16560276vsi.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 10:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6A57/0HNF8dypxE5v4UBm06R8JG5ffBMLi/jKupeW0A=;
        b=IAtl111QodlaRCdu9ccduYNzdMibF/y/UBWVx9VXyS9O8Wjjvj24ffrG/FOOx9XFqF
         JyZfHvBLWJ+LUqUgXt/10qPSORNmzk+UUP4PyfTYJHqmrgkMfmf1X8vTfRpBcZvQAerc
         ncCSfA2cmOYKijm5FRiDIZv48DojJMS6FvrMKpcvYC/f1VgH/AaROfvUjUOHv27zrmZJ
         x39PDrIrt2NtigdN/ZAmcnCYnLtFK3k8uNyvwLUjdy79T2N+8cn/M3vV5LiEs1WTbbOU
         46TNnF1h4fIhdJR1CroVcJPBKdC0HhjKiuTG22yVxFBT6PHifQq71B1yDBmuK/pMcHFS
         thVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6A57/0HNF8dypxE5v4UBm06R8JG5ffBMLi/jKupeW0A=;
        b=Zv2kBoBWMVq9vfNB5oZEnPK8xOIgkxlK6x0rcuHjGkKTEfgK2TrMb66xJ8g/lP+V8W
         c2auBoNFEiG0S16Yc5+1D1wIE1u4GT/OiQgigyCXbq0gw+f0aaxTc4vDHkutdpR0kaQs
         318qiquRIMxEyDKqm4Wb0gD8u4y1Q9pjPllvV4iOaItvO5bBPI2zOsJR/nny15THrBdz
         vx55sWYAfw0Dmo8mmcXdwrMWFCeLJ5SlpUEG2wzYpUPENJhG+tT6cKh58CUZd9oAQacG
         1SYvMTQ03+x3Njr3SxrIeXfP2oiiwcyYATMAlBA0hk4u750NY8NqoU+hmYT1NSENukY8
         BOrw==
X-Gm-Message-State: AGRZ1gLhqRa3I0rkDO4vlLyehVozvKEnsCGct8aeFRHsqdH4LDpsFKaU
        t5KCLEQNiHkWq9E7iJaqBd+Vz9y49iMDf4lrrJvn4w==
X-Google-Smtp-Source: AJdET5ct+7Y4qtJvgD3uiAkTIcnNb2OK/l80j8wi4eU9ca5j9SwPCXZRjMblMP82g+RHgr/MmjDNS0rY8cC9rV1JWFY=
X-Received: by 2002:a67:6cc1:: with SMTP id h184mr7964796vsc.149.1542565903239;
 Sun, 18 Nov 2018 10:31:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 10:31:42
 -0800 (PST)
In-Reply-To: <CALCETrUb8MSPPBLLz5Md9Fzaq3Kd9HtG8R5JFwWuy21jOuzbUA@mail.gmail.com>
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <20181118174148.nvkc4ox2uorfatbm@brauner.io> <CAKOZueto1CmUSWFKjOkazcDcZH6CiXXCr4U=ghewLh8GjE2-=A@mail.gmail.com>
 <CALCETrUb8MSPPBLLz5Md9Fzaq3Kd9HtG8R5JFwWuy21jOuzbUA@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 10:31:42 -0800
Message-ID: <CAKOZueuj_MZD0e+Vf8qgyPxvo+KcQ+3QGD3u7KBFFcpZ0ZmMgQ@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 10:15 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Sun, Nov 18, 2018 at 10:07 AM Daniel Colascione <dancol@google.com> wrote:
>> Next, I want to merge my exithand proposal, or something like it. It's
>> likewise a simple change that, in a minimal way, addresses a
>> longstanding API deficiency. I'm very strongly against the
>> POLLERR-on-directory variant of the idea.
>
> Can you explain why you don't like POLLERR-on-a-directory?  I'm not
> saying that POLLERR-on-a-directory is fantastic, but I'd like to
> understand what your objection is.

I've written my objections in more detail at [1]. Basically,

1) Nothing else today works by polling on directory file descriptors.

2) POLLERR is wrong because POLLERR indicates, well, an error, but
since we want notifications upon either a transition to a zombie *or*
actual death, and /proc/pid operations work perfectly well on zombie
processes, there's no error to report, and reporting POLLERR would be
a weird kind of lie. POLLHUP might be less awkward here.

3) POLLERR is a single bit of information. I want exit status as well,
or at least a logical path from whatever we add to some kind of exit
status reporting. You can get exit status from a zombie with openat on
/proc/pid/stat, but what if the process fully dies by the time you get
around to reading its exit status? Should we synthesize a
/proc/pid/stat? It seems simpler to be able to just read(2) the exit
information from some FD.

4) Event monitoring frameworks generally treat POLLERR as some kind of
black sheep. Most people think in terms of bits indicating reading and
writing. I want something that can cleanly integrate into existing
wait mechanisms.

5) Poll events are *hints* that some other operation probably won't
block if attempted. Using poll as the primary way of communicating a
bit of information instead of an attempt-IO-now hint feels awkward.

6) A POLLERR interface can't be used by the shell without some kind of helper.

What *advantage* does a POLLERR interface have? That you don't have to
openat a separate file? That's a trivial operation in profs,
especially compared to the machinery of process shutdown.

I'm not particularly tied to a proc file; if we're adding a system
call interface for killing a process by its procfs dfd, we can add one
for returning an eventfd-like FD representing that process's status.
It's unfortunate that the process handle FD also happens to be a
directory FD; if it were a standalone object type, we could just use
POLLIN more naturally.

[1] https://lore.kernel.org/lkml/CAKOZueszfoSM0pxhmuFLOuPmJqSfYXxgutstyCgqxAyoUi4h3w@mail.gmail.com/
