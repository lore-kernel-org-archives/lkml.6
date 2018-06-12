Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 89C51C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373512086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dY7rbfbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373512086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933818AbeFLSGx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:06:53 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32848 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753979AbeFLSGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:06:52 -0400
Received: by mail-io0-f196.google.com with SMTP id d185-v6so468193ioe.0;
        Tue, 12 Jun 2018 11:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qOZV64h2gQWvgTr9A4Vu5UHb+aaXcWG2xSDjGxpz60=;
        b=dY7rbfbpF7A3SqYTmrOtu/gxbBQKsw1JnILZ57IZOv2zlIjrinj0GQ5AtxnE8ZtnNQ
         5WjWzJjllb4+kkymXJKZnrbULwgwD7ArNCBYiA1xTLHMVsyuDOUrIf62i+vtNliUEtRM
         7xLziAu3olDiT0lXKCpGx1myxwa8j68d67CCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qOZV64h2gQWvgTr9A4Vu5UHb+aaXcWG2xSDjGxpz60=;
        b=cGnqBCLUT2NcC18nAk+cbyP9RmNGAOoX80VYUoWhsYaQJ2CN3eFSLzFgdop02oCXgx
         js1yQNQxT/Xa5VJ23SwKDHS4c+DI7qwJk/bjH2TZWKAZ+RkBb3jlYieN9jhwjbBr6adO
         JLR1xskMz1HMA40qUcKzoWe9OkROQdIN6T3vyoB8T+AZSpCqy7xIXikIt5K5mogc5oOr
         DKUnYbx9IyR0mKIaehQViBqy2xlbj51wx6ArIMMGxyEMBVTr+FPF6qVsVFNIE2GrV9SU
         7H1zHgRhEeqSnwvcT2Tk9H4Gl2kZUV/WjPGDLatiaZewGXwDE/sAbteQKpzmih3jEfZn
         zlTQ==
X-Gm-Message-State: APt69E32WiFvGXs0Sx3IJHC0KKWZLU21iXWSe7kNglpHjL3Z76d+i939
        uZIfcPlXg531MtH3KfKDmcPzuvJ8m7zIli3gJ/I=
X-Google-Smtp-Source: ADUXVKLf5tN003ku0Txzgp54CekG3jdWrQqzh1J1Z/798kbRgcRjoNdL5sVkT2OtrmfQxdTHpFcMk/aL75UVVMJgTV8=
X-Received: by 2002:a6b:f90b:: with SMTP id j11-v6mr1610582iog.238.1528826811228;
 Tue, 12 Jun 2018 11:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <e5c90488937d14e9df81752a024be9d1e73ed398.camel@hammerspace.com> <CA+55aFxYMg+F9Jdi_25X-Qtt=7imqjQhLnjEyQXOQ6+eJvy83A@mail.gmail.com>
In-Reply-To: <CA+55aFxYMg+F9Jdi_25X-Qtt=7imqjQhLnjEyQXOQ6+eJvy83A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 11:06:40 -0700
Message-ID: <CA+55aFw+2+xCRAaMo8qgvZ7qNgRMo6D=WkwP7APQndG-y5b3dw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client changes for 4.18
To:     trondmy@hammerspace.com, NeilBrown <neilb@suse.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:42 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So could we please have a cursor entry for RCU walking, and actually
> have a agreed-upon way to do this? Maybe even using the low bit in the
> "next" field to mark a cursor entry generically - the same way we
> already do for the HEAD field in the bit-locked lists, just on the
> actual entries _on_ the list instead.

The real problem with a RCU cursor is that the lifetime of the cursor
is also RCU extended, so you can't do the traditional "just allocate
the cursor entry on the stack" that you can with synchronous locked
lists.

That makes it slightly more inconvenient to do simple cursors.

The dcache code has a fairly clean "dcache cursor", but it does use a
whole "struct dentry" for it (and it depends on "next_positive()" to
just skip them because dursors are never _positive_ dentries, so
there's some subtlety there).

But at least it's a very explicit cursor model, not that odd
delegation inode that seems to have a life as a real inode too.

So maybe a generic rcu-list cursor is too hard to do sanely, but can
we at least encourage that very explicit cursor model that is *only* a
cursor, and might not be touched/moved/reallocated by something else?

                Linus
