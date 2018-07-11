Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6FCC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392D520C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IuZxTx1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392D520C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbeGKQIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:08:23 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45944 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeGKQIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:08:22 -0400
Received: by mail-io0-f195.google.com with SMTP id l25-v6so24146938ioh.12;
        Wed, 11 Jul 2018 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWLBywxe48pLQ70B3+vZi590UDg9apxQDpHljnI9auI=;
        b=IuZxTx1us2OhUFKKofPI8Vd3kbh7UT7vaupoH3MshKCBVVYxaqNxPnoBD6POB7zdgV
         dG/Ft5ZXrg7O0GySRKY5biXcsuS1m5RCARMGnswXs66Egab7M6tJZhKdq8IWxc8/xjBW
         tECBzEv9V2GP8zlH+R8KjQcPQQepcHXcD23qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWLBywxe48pLQ70B3+vZi590UDg9apxQDpHljnI9auI=;
        b=Y/QSp7hTqIU6Yv7I31bvdzELJezMB7/5eXpXKVt9ISNHhRruJlYMr+QDqmtMwCZuuy
         n1TbFt+revKBS4T1S4jdfIQ+nhVOfpyCpxt0RkcdttUhOwEu5TW4wfkc6Sp4wrlx2FGT
         B6NTzFHivHQKCAWfD2KNHWQuMKUU7dgIPXl3vIZ8YD9ZojgNLVVrkB7wImZRvGDLxE26
         86S+Q9qs4/DjHzcsVXevNv5sW9OV9epu77QvWwW2uNXIjdaTNVnyGQORxw9qJwj9QUj5
         XIKqK3lL2LZIv62fiIzsRjXMEBDUn5TptH9XeAcgZcAU4Jau0fBWGTnt2EXkgOLFarDA
         9Wmg==
X-Gm-Message-State: APt69E2qHj8R6ENjzChwaoSE8EVA7e7t6eRym7lZhwjpqA05QlqskEPN
        yCoNz5/0mPqAkD3oveOi0gsvrH9bURU8qpSZIP0=
X-Google-Smtp-Source: AAOMgpeopObrgmdTxqFXk7GqWExgvn17hkcnZoVnMB4GBMF+5XtDmIQACuc1ux4qXVq+zJ7aQYW5P/tpF9ArhPc9c4g=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr26636116iov.203.1531325001214;
 Wed, 11 Jul 2018 09:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <CA+55aFzknfBLjg4-pRSCUeBFY3DWq04zX3PPyc949M0OygHktw@mail.gmail.com>
 <24347.1531298554@warthog.procyon.org.uk>
In-Reply-To: <24347.1531298554@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Jul 2018 09:03:10 -0700
Message-ID: <CA+55aFzxMzz2+LRmE7_9y3SE7sz1dTz+ERYGdEcs-PYaWvf0XQ@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     David Howells <dhowells@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 1:42 AM David Howells <dhowells@redhat.com> wrote:
>
>      Buffering till the end means you have to buffer *everything* - and,
>      unless you limit your buffer, you risk running out of RAM

Do we really care?

Can't we limit the buffer size to something small?

Right now, the mount options can't be bigger than a page anyway. Why
would we want to extend on that?

Btw, the magic word here is "why". I really really want to see a
fairly exhaustive explanation of why this all is such a big deal, and
exactly what limitations (including perhaps the mount option buffer
size) are such a pain right now and need changing.

> Now, I can replace the 'x' command with an ioctl() so that just writing random
> rubbish to the fd won't cause anything to actually happen.
>
>         fd = fsopen("ext4");
>         write(fd, "s /dev/sda1");
>         write(fd, "o user_xattr");
>         ioctl(fd, FSOPEN_IOC_CREATE_SB, 0);
>
> or I could make a special syscall for it:
>
>         fscommit(fd, FSCOMMIT_CREATE);
>
> or:
>
>         fscommit(fd, FSCOMMIT_RECONFIGURE);
>
> and require that you have CAP_SYS_ADMIN to enact it.

I think any of them sound fairly ok, with that whole "we need reasons" caveat.

               Linus
