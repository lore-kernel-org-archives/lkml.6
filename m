Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-974401-1526712140-2-12437952975997311949
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526712140; b=VrjspmDiJgYfjkBu4NieZxeTMglkn8/mq3o5DAzuf+iDmt9h7w
    TDdCoXuxTzicnLNHznxHlhafMDnjGSnXT8Mir6FAx6Jplv7f5XlmdHaHjE971ieM
    vqiQqKfj0wXtDXsTYWLAdVsWU5QzHoJrJsxKbM8TCdY3aOwkgNPH/TQvflVb5YSp
    pmm8sG7NcQl6989cG9XgWx7LKdnFUdJKCWtqiShcCTBhNs4aE4P0UpqtWzY6uUmS
    iAo08rfT7HRUtbDBtXLklRvMSCrhtVOP8bQnhjmA5+TVqvHk5mEt+eJaFJjLF7sg
    J1LekuyuRshIqbW/UA5rd/xcg1+OMFVQqxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526712140; bh=cXTA/qvQYH3rOUxwNTn1beS0wxt6nN9wuuhj3pTiOZ
    c=; b=M4fCC+yYsW1yJmESJYkZR8hp4VTs4tjTUA4INgPOuGY9y585cRED68+Npp
    lp1Rfzu2xowlZhxfAAI/NsslvfyX1Dur/i9kDAMDktbqGXLOiUq1IqjUdDvGZUno
    lNmojtWEl09BDUYmdALRv/Ljj+MSeVnmiMZ7uvgM7yshNTk6vwPawKZBIw5JYz6f
    tI+1APPxdFhf/ZSGw/W/gR18Xv1Z2/RQNt4PUjjgWYYrkPXAJaq8JKXUv6VciUlW
    428W3LGAv8gKS8ZI6AigdoZF6SzEGEmQLSsSh5wWD/I2doPo/trgYNAg1RLxgtcT
    u+8r+tl8NtSUBSVt9kuhL9yDFXsw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
    header.i=@google.com header.b=Q6k41BT4 x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=V9sB6U4v;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
      header.i=@google.com header.b=Q6k41BT4 x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=V9sB6U4v;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE1184Zk2u+kYQMIprvTg6VAPmBOPThCctqbi1woQ1VvpxN5boEOfdyjxl+J0HOX5q2lCJL4EyLMNjg5UcVRm6iPAwDbcDedZzlPGn6qA8sJbwZEELsA
    JHtmKaOpdvg7CQPllJpPKCRlb9cnadsjhkjh21tjivetehanXflYQtzDVePkEvnN2b15sc0sndLaB+rwI0olZb0NO6SvdaN8Vd69Al/GXNDJkzy6uSg1K7Tk
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=IA0wh2spAAAA:8 a=6Kb15VLVdy0xU05PFXoA:9 a=QEXdDO2ut3YA:10 a=XUn-8CSLFBoA:10
    a=WYX0T_o7Jp3h_ymY5bZZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750797AbeESGmQ (ORCPT <rfc822;linux@kroah.com>);
        Sat, 19 May 2018 02:42:16 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39829 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeESGmP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 May 2018 02:42:15 -0400
X-Google-Smtp-Source: AB8JxZrxJZZ19BFSBmCrQ+qpfjo77cQtEMd7DKj/32oQxgvqw31FkrYtC3i0yOT8I6pKCo3IVp9P3XXSRFEQotVfQF4=
MIME-Version: 1.0
In-Reply-To: <46b9489e-6986-d512-1276-9da14c96999e@I-love.SAKURA.ne.jp>
References: <000000000000237cc60569ad11c7@google.com> <46b9489e-6986-d512-1276-9da14c96999e@I-love.SAKURA.ne.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 19 May 2018 08:41:54 +0200
Message-ID: <CACT4Y+YFQfrnvV7XfeCsiQBQ7UicrHE=fadiYdJdPA8=jumW3g@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in d_walk
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+ae80b790eb412884ca77@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 1:05 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> OK. Patch is in vfs.git#for-next as 4fb48871409e2fcd.
>
> #syz fix: restore cond_resched() in shrink_dcache_parent()

I see there is another patch titled "fs/dcache.c: re-add
cond_resched() in shrink_dcache_parent()" points to this bug:
http://lkml.iu.edu/hypermail/linux/kernel/1804.1/06252.html
