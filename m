Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93721C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C04120862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YC0wMXgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C04120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeKHDxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:53:36 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39351 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeKHDxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:53:36 -0500
Received: by mail-ua1-f68.google.com with SMTP id k10so6195335ual.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 10:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QYUaHOK8vceZkSPfI0EfEH6FkTI2Ic5ANXg6IXsWYmc=;
        b=YC0wMXgD/6JkC3eFtRpoY8AcYg/O2fQU6GGWOAJcEVASz0v8EhaDijJ6+tNso/ndaS
         UhG7ghlec0rccuB/9cE59afXjOFEdgzJds3q2a8S2IkQp1eZWqvinQXoP7XmJTVrfrPa
         tqANjZ9HyIJVBsi2+8v7bsxVXUbV28aIFgPJmyENX1ExU+YEhkW9N7FwbJgLawr4htz3
         mN0TSDaCAXmHvCWmg7EMkJGzXZNIOEMNcY2EwIDJ/e+LF7sUsuAlT9BLk9T6yAlIsmNm
         uIXVob+16SlkjLoysy1drf5UbF/11n2aZXRDeO13wfDI4dbIVPYuj6/lrQKWqm+3XbwH
         m5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QYUaHOK8vceZkSPfI0EfEH6FkTI2Ic5ANXg6IXsWYmc=;
        b=UI3GcoWamyxs30+R9IfLEwqGH5ezPQ6rYXZkwmafI1u8YWt5mx8tB2BT/Bk/Bdr8Gv
         iWglCZjggRz20vGzLoMMdCAT6FlRxZf3hLMZCxR1FP3zs9sr4/AyFG0leKZp3vRGC/Ut
         YX5p8TbH6ej35l0zHO17q3NqTvrmbtqyilyg+5Tx8mvjkQZmef6pzW3uVsTULhrkopFm
         u36NZxbWLK78JPkpr1HM2Ig3ZQhFErbcHZQIZEe+WX/BmaHKOr54AIZ6zXesMjKqAun0
         H2bb1xWO8OoK3aAdcwpS2xqDx46lptpypXQyaYJAsMJq2qZ7OKrzEg6ugNuRZzFfxsO6
         kcmA==
X-Gm-Message-State: AGRZ1gKeivH+pqY66HksH5xES/GSo7tcjjUyL6ZpLiYmyqI7ZYRb5lhs
        /XZ3Hf2AhLu7HRr+vdsy4jkadNbYeABEHuTyjkh56A==
X-Google-Smtp-Source: AJdET5cJ3YyoBa9PASXQjwTe9vA/PVGyjKkPxV2fXk1V9ONYIl+QZ2/FeF688dljQcEzH+tE+fEi0Cb6XOcowQeryks=
X-Received: by 2002:ab0:72a:: with SMTP id h39mr600663uah.11.1541614920550;
 Wed, 07 Nov 2018 10:22:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 10:21:59 -0800 (PST)
In-Reply-To: <20181107171644.GK3074@bombadil.infradead.org>
References: <20181031150625.147369-1-dancol@google.com> <20181105132205.138695-1-dancol@google.com>
 <20181106060113.GA4499@rapoport-lnx> <20181107171644.GK3074@bombadil.infradead.org>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 7 Nov 2018 10:21:59 -0800
Message-ID: <CAKOZuet9KGHc9dAyC=-cMZNt39s2m9=YEu3R1-7ExWzaNzLzjA@mail.gmail.com>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 9:16 AM, Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Nov 06, 2018 at 08:01:13AM +0200, Mike Rapoport wrote:
>> > diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
>> > index 12a5e6e693b6..0b14460f721d 100644
>> > --- a/Documentation/filesystems/proc.txt
>> > +++ b/Documentation/filesystems/proc.txt
>> > @@ -125,6 +125,13 @@ process running on the system, which is named after the process ID (PID).
>> >  The link  self  points  to  the  process reading the file system. Each process
>> >  subdirectory has the entries listed in Table 1-1.
>> >
>> > +Note that an open a file descriptor to /proc/<pid> or to any of its
>
> "open file descriptor" (the "a" is unnecessary)

Thanks for spotting that. I had to re-read that sentence three times
or so before even seeing that extra "a".

>> > +contained files or subdirectories does not prevent <pid> being reused
>> > +for some other process in the event that <pid> exits. Operations on
>> > +open /proc/<pid> file descriptors corresponding to dead processes
>> > +never act on any new process that the kernel may, through chance, have
>> > +also assigned the process ID <pid>. Instead, operations on these FDs
>> > +usually fail with ESRCH.
>
> The paragraph is a bit wordy.  More pithy:
>
> An open file descriptor for /proc/<pid> (or any of the files or
> subdirectories in it) does not prevent <pid> from being reused after
> the process exits.  Operations on a file descriptor referring to a dead
> process usually return ESRCH.  They do not act on any new process which
> has been assigned the same <pid>.

I'll send a new patch version --- unless we can just tweak the patch
when we merge it into the tree?
