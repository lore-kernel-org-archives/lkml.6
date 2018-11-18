Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53166C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 13:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101F82080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 13:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVXXmMDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101F82080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeKSATv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:19:51 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42485 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeKSATu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:19:50 -0500
Received: by mail-vs1-f68.google.com with SMTP id b74so16280412vsd.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 05:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YQ9La5BR4nomH41UKaWmwEQ3YGqZVjb7lZbfpKqW1CU=;
        b=JVXXmMDIKUXCptsScc8oZ2th6i5DbACs/w9DsI241977XVugJWE8YLLlNNLhtv8+Au
         +O4rOG18i98TqAZ6zlq9jzh2Mae2Ni+/sKcdUSR/0gLCoPk28g1jI0UDJOvYjcjZ61kC
         NwuUs6ddmYoY0/UOo57QaHyKdDjbbarkHYeqvhQYFjhJ3CxEKizfN28AgASvJcqZp/F2
         AKtPPKcUWqO4S7khSTZyE2Dy2e/9fyc/mQpIAIOEyvG4s6pAXNKL1PDJDWL07CFY6uQK
         dWBQQHXN/reXGIID85TxM49iSJWs9fdnxmw49hhAX6IAvwI2Rvhx9K4Mzq1QqlQEgVvW
         0qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YQ9La5BR4nomH41UKaWmwEQ3YGqZVjb7lZbfpKqW1CU=;
        b=PBiXXgwhLeod3YAkmDO40QCo0rH2UjmwEZvREiIpcdu8Bj3muWW//Ozoquv7Rul24H
         W8oyMi4r00CaRcj9X8YsGZMWSVb5nAn13RtLz5Ic6U5Q2blEV4l3JHWUSNqXvl4AWm26
         Li3K0hZzLixH5lKrbOjZfQDL+qvjHA6s1DIJNbMPkTqWrtq6gBDhyispfGvkYiNOYK2x
         kwcSAcQXYlN154kU4SebRieN1HcQISVjMw/MP04yEz3AaHwAwSjiUqkVFW1lQvtpsXuK
         GG+a0W2A/lcOjSgwQJiSpOF5f2BKb545Qs719a9BWIszUqnPQ1DL3KYyXxcTzrKNG6YZ
         Sh5g==
X-Gm-Message-State: AGRZ1gLyOMaF6rJ5YynQpumFGcF8WXV0LBlmozMsNNigHrgHjrdeAXha
        mDT6PpVuGpJ/JOflSD1J9SK9JoqG+1Ck/90l62veAg==
X-Google-Smtp-Source: AJdET5cqmstCI60UIGG6POxj99l6q/b7LMEQ96DKOS7vXWOT/riB254kKG//PvwZVpXDI934BnabmZ4Z+nxiu7HLFCo=
X-Received: by 2002:a67:b44:: with SMTP id 65mr7547012vsl.77.1542549565740;
 Sun, 18 Nov 2018 05:59:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 05:59:25
 -0800 (PST)
In-Reply-To: <20181118111751.6142-1-christian@brauner.io>
References: <20181118111751.6142-1-christian@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 05:59:25 -0800
Message-ID: <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Christian Brauner <christian@brauner.io>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, serge@hallyn.com,
        Jann Horn <jannh@google.com>, luto@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had been led to believe that the proposal would be a comprehensive
process API, not an ioctl basically equivalent to my previous patch.
If you had a more comprehensive proposal, please just share it on LKML
instead of limiting the discussion to those able to attend these
various conferences. If there's some determined opposition to a
general new process API, this opposition needs a fair and full airing,
as not everyone can attend these conferences.

On Sun, Nov 18, 2018 at 3:17 AM, Christian Brauner <christian@brauner.io> wrote:
> With this patch an open() call on /proc/<pid> will give userspace a handle
> to struct pid of the process associated with /proc/<pid>. This allows to
> maintain a stable handle on a process.
> I have been discussing various approaches extensively during technical
> conferences this year culminating in a long argument with Eric at Linux
> Plumbers. The general consensus was that having a handle on a process
> will be something that is very simple and easy to maintain

ioctls are the opposite of "easy to maintain". Their
file-descriptor-specific behavior makes it difficult to use the things
safely. If you want to take this approach, please make a new system
call. An ioctl is just a system call with a very strange spelling and
unfortunate collision semantics.

> with the
> option of being extensible via a more advanced api if the need arises.

The need *has* arisen; see my exithand patch.

> I
> believe that this patch is the most simple, dumb, and therefore
> maintainable solution.
>
> The need for this has arisen in order to reliably kill a process without
> running into issues of the pid being recycled as has been described in the
> rejected patch [1].

That patch was not "rejected". It was tabled pending the more
comprehensive process API proposal that was supposed to have emerged.
This patch is just another variant of the sort of approach we
discussed on that patch's thread here. As I mentioned on that thread,
the right approach option is a new system call, not an ioctl.

 To fulfill the need described in that patchset a new
> ioctl() PROC_FD_SIGNAL is added. It can be used to send signals to a
> process via a file descriptor:
>
> int fd = open("/proc/1234", O_DIRECTORY | O_CLOEXEC);
> ioctl(fd, PROC_FD_SIGNAL, SIGKILL);
> close(fd);
>
> Note, the stable handle will allow us to carefully extend this feature in
> the future.

We still need the ability to synchronously wait on a process's death,
as in my patch set. I will be refreshing that patch set.
