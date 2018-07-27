Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54955C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E6020842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="w4wq7feJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E6020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389914AbeG0XWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:22:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55336 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389686AbeG0XWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:22:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so6680742wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+ooQhSX5g8ruVJTKoDjFfVynH32b74nE+TFfpBbUksk=;
        b=w4wq7feJLt8dp5zTd+0uL/d5U8NF7Xqq6h6GQgzmWf4SsE2hRJ5pMBrQrnpB8tFBkb
         yz3TqFum/3aad/OoWbZxXYPk0yY1AZ6axfd2HkFH79NZWL36W6ReTjg+sLHDvB7lk2cO
         F4ndFjLI8xCgxASjYkUZF5XtVstCalZV2liviJ4UeOepJnsjVLnVADUiuvFsEEU8Kgu9
         43s7e+LPCmuDO0N6s9O2fcTb+GVDcxuMxxaPUJJDnvmW+cqssmdG7sVSjoRnk2NWPl8c
         JhitjTiOGzKtVzNz15FfDrDNaI4CTeuZjZ2ZCs2mSnN4bfQJ4roOfowuOxY8tD6zmF/z
         2D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+ooQhSX5g8ruVJTKoDjFfVynH32b74nE+TFfpBbUksk=;
        b=rwT/ji+y7gCpXxGrW7855ImE9XLdA6qR5GqbvhQs+WPbF8lV4DHoNh8FyX0L4RUBbu
         RYLESCYAY3jCx+mrp9qhDAKlu24NpQBhv+4RnTNPfzDCQ0K+YDPNjDZTtVlJH2Y4huiM
         aTZYFlGLxc2OZxMre6TEbwH3CXsXvrmxY9g+sMeXuC0opnWSQdmqANqLOlULf/C/64TS
         bTj4O1R6Q8CWTCr0JK3NKebsx0V0GK5eYMOCtQvnKSMWFMvBC01yk+D9pGalC1xqfRNA
         G8N3a2GtYLBl61/pujVCXNeR1F4PqbFvamD91hKGH+UcuXEeBx5T1tZlABI8MXl+wOxs
         xc+A==
X-Gm-Message-State: AOUpUlFRuJxeIbFMgL0Ny2EWlU6mNfOILPXv+t5VBDuHKWPICCXfwbtl
        sLUu2xgA9Z1eZ/FFokKfIVjL7U/VQyabFqIuahHZ0g==
X-Google-Smtp-Source: AAOMgpcTg+mOTB6q6d2Qr10lgnELEdUoHtDqAL/eV13iVEXfTZ/Xt6VC17qviUB/NhwXHvdIn51Yd86+iKr3YRZG5Wk=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr5527656wmd.144.1532728692150;
 Fri, 27 Jul 2018 14:58:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 14:57:51 -0700 (PDT)
In-Reply-To: <7034.1532728300@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271287586.9458.6001928723332685410.stgit@warthog.procyon.org.uk>
 <CALCETrUXsOexKcj+K_v_bsW6DkGFgyNOaEs_qVOAcdNGBbEb2w@mail.gmail.com> <7034.1532728300@warthog.procyon.org.uk>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 27 Jul 2018 14:57:51 -0700
Message-ID: <CALCETrWDGa+ut=xsoki+XFKzdD7KruJJicfH1tKdBtywLuk7iQ@mail.gmail.com>
Subject: Re: [PATCH 29/38] vfs: syscall: Add fsconfig() for configuring and
 managing a context [ver #10]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 2:51 PM, David Howells <dhowells@redhat.com> wrote:
> Andy Lutomirski <luto@amacapital.net> wrote:
>
>> Unless I'm rather confused, you have two or possibly three ways to
>> pass in an open fd.  Can you clarify what the difference is and/or
>> remove all but one of them?
>
> No, they're not equivalent.
>
>> >  (*) fsconfig_set_path: A non-empty path is specified.  The parameter must
>> >      be expecting a path object.  value points to a NUL-terminated string
>> >      that is the path and aux is a file descriptor at which to start a
>> >      relative lookup or AT_FDCWD.
>
> So, an example:
>
>         fsconfig(fd, fsconfig_set_path, "source", "/dev/sda1", AT_FDCWD);
>
> I don't want to require that the caller open /dev/sda1 and pass in an fd as
> that might prevent the filesystem from "holding" it exclusively.
>
>> >  (*) fsconfig_set_path_empty: As fsconfig_set_path, but with AT_EMPTY_PATH
>> >      implied.
>
> You can't do:
>
>         fsconfig(fd, fsconfig_set_path, "source", "", dir_fd);
>
> because AT_EMPTY_PATH cannot be specified directly[*].  What you do instead is:
>
>         fsconfig(fd, fsconfig_set_path_empty, "source", "", dir_fd);
>
> [*] Not without a 6-arg syscall or some other way of passing it.

Are there still architectures that have problems with 6-arg syscalls?

>
> I *could* require that the caller must call open(O_PATH) or openat(O_PATH)
> before calling fsconfig() - so you don't pass a string, but only a path-fd.
>
>> >  (*) fsconfig_set_fd: An open file descriptor is specified.  value must
>> >      be NULL and aux indicates the file descriptor.
>
> See fd=%u on fuse.  I think it's cleaner to do:
>
>         fsconfig(fd, fsconfig_set_fd, "source", NULL, control_fd);
>
> saying explicitly that there's an open file to be passed rather than:
>
>         fsconfig(fd, fsconfig_set_path, "source", NULL, control_fd);

Hmm.  That should probably be clearly documented.  I suppose that, as
long as there is never a case where fsconfig_set_path and
fsconfig_set_fd both succeed, then it's not a big deal.
