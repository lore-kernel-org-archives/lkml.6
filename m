Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1547530-1527776887-2-3044660185424125381
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527776886; b=mij2ASm9UtMZKZrNtK8D+qvVJQNuM2Vx2z3Ux1hZFGpqipHQvs
    5RTZElwVUkeUY7f3VOYNvd+qgRoIf/7PHUtidBh82QpiTPlitvxQ8A2yhyIxnYfc
    xvxBM8XKTW5urnDgM2EEpyFyuknDjGF2j8zAyhp9tU/a8WOk8igpIX/7SqGEWEUy
    QEOessk/84qpOvbzi4HyC7ksjn29ht8EPf7STuqbjYMgoGZ+BU3bGCstFOPd9fHu
    W4kJ+JRyT7z/R3PUKySWj2MYECwwur8IJlrciXD+V3OpO/++cTTTjbE/ADswqOKt
    bdqGuHUCRItfjFugM1tPMD1zMrzOadsy7kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527776886; bh=EB0bomDVxGV9K69MB3ZCaIJPWI3oi4dc2x1kvwXnZ3
    w=; b=C1U6ykR6T85hNRZyDEB0C6oDy0B3JEnt84GOcMkYW/rM8tJdklPLbl7R1j
    hgZv1OfgQajHavbu/4NEAkPS3asGXj1BPjrrdi0l90kO6Ul9CdVO6WRb13EsOp5x
    20kD/ZlTO6Seum9TW9tW5g8yhOE3hpw2o0iyZj8mY5kl/FQLIc7nbvIFFtTzsw4d
    5QGtXIwSXIjq3vX027ndY8+vy25EfT4/b1jZEOzxmFy3popFxBsCGMrXwAF2qPC3
    mLLhgP9AnlNkoCp/r/SZC1hAYjmngevsgUFa0c18SWEfj7lGnBnAPu4c1hGxW0hV
    oSt662rGQY2AwXtT3r4TnfmAIxOQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
    header.d=szeredi.hu header.i=@szeredi.hu header.b=DHXSFApn
    header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=iJMAV+QC;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=49 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
      header.d=szeredi.hu header.i=@szeredi.hu header.b=DHXSFApn
      header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=iJMAV+QC;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=49 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPgPoQaP4RfhqaK+NzQd0oJTnSNt4E4bnTN5BDWq0wHX5aMkUhoAhimIpCjZcxmH7SmyMH2seZw3nKnKT1dpmgQ4ULkClX0AU3TMabcqvGC9qdxs+rj1
    yjIYUaw6+lMz0WWB7b1MceMBISyirfs73f5Z/6/xozCuoUxYQpaWapMcf4fCOfSzaOtynbHN2sxVpWiFruZTmFK3drQKg7cHaNwK7QKaNo3rEWX/t5zv8UDy
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x3-3yhV3NOoA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=oeBtWo9Y3AFpdgF6yG0A:9
    a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755411AbeEaO2B (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 10:28:01 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39714 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755314AbeEaO17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 May 2018 10:27:59 -0400
X-Google-Smtp-Source: ADUXVKJnUV6aNmrcRaV/p9RVvSDdObAHrKHx8UCGVrH7nssGuRIrR1Vjg36T7bPe8BT4QAOezOUWIS+LTn+M5CVBdac=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <cedce932-4275-8d7e-fa4a-d7f44b8bfd85@I-love.SAKURA.ne.jp>
References: <000000000000c0a706056ad69897@google.com> <cedce932-4275-8d7e-fa4a-d7f44b8bfd85@I-love.SAKURA.ne.jp>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 31 May 2018 16:27:58 +0200
Message-ID: <CAJfpegvVs+jNMY5FfbRzUM7CFwrB5onfQQiECxGH6YjzvGYA8g@mail.gmail.com>
Subject: Re: general protection fault in fuse_ctl_remove_conn
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+32c236387d66c4516827@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 28, 2018 at 4:29 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> From 9f41081f8bd6762a6f629e5e23e6d07a62bba69c Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sat, 28 Apr 2018 11:24:09 +0900
> Subject: [PATCH] fuse: don't keep inode-less dentry at fuse_ctl_add_dentry().
>
> syzbot is reporting NULL pointer dereference at fuse_ctl_remove_conn() [1].
> Since fc->ctl_ndents is incremented by fuse_ctl_add_conn() when new_inode()
> failed, fuse_ctl_remove_conn() reaches an inode-less dentry and tries to
> clear d_inode(dentry)->i_private field. Fix this by calling dput() rather
> than incrementing fc->ctl_ndents when new_inode() failed.
>
> [1] https://syzkaller.appspot.com/bug?id=f396d863067238959c91c0b7cfc10b163638cac6

Slightly different fix pushed to:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next

Thanks,
Miklos
