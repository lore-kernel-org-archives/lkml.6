Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1906107-1528140451-2-13206289126644747912
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528140451; b=egF2m5eOTNWHdzssuhHQiubA91UNwj9DIge0rVjwuA9BhAayVS
    9lVTLXmrYCjWY+w8lgcXzky0yz6RZhtYT5r4H6uoL//s9dq3ZJkZNF+4Atcr4WiB
    QPrOAntM7CCvwMkR9m/nzr3CKHkcBP87MWcoo9RI8snxOGeUkpqd1Jlx7FHii7zd
    DSIY//LISFmtFp9uppowXR1h9lmNcmKIAEh6wJ/Im7FdY94c+aKjkRfC7yXeODUT
    Aa7KeYpxb1+GSuAukJDIhtpDHvM20sv6SEAKaP4uxpxGzA5a3SrAp2sK7vmsfhIi
    KWEVytxkGm6L5pIpNIZFeoxaPq4jzm0NG80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528140451; bh=lmDeDQ45RvnqPTlABLetScI5MO0sYSDb2y2DEVAVTk
    Q=; b=BqIuO8kaGTHBG1Vd7Z2ge1mPw+wdJRFKBVJgX8Cbf2Jr8dTCpyPf7S0IJ/
    MaoOvCIhsmdhSLXIAuHWlZShvYN7SN+EHa5gm/JI+zGjYk16+X7fWpg6nxoWmHjy
    PEiBzOYymQGlBFupmXKGHaEYf8MRePtGcZp0XgviXXMXxyU/Z2cwQP2fB6fWdQkB
    UvdulmNsKCkYrHuD7xvEdYMANxQqcWf5NtDxvV9zwlq/B+YpNlynPZE+zXINBdPa
    fMc+JvO2FwU3W2efmjdqzyJ450vP/OdJlBHaiSkDAhQdljg5U6myC5Bq1jSMr+04
    OF5LwjMXCwTbJNYp3Wt8exGNKzIw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
    header.d=szeredi.hu header.i=@szeredi.hu header.b=XRxXCI9Q
    header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=NTfFw9T3;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
      header.d=szeredi.hu header.i=@szeredi.hu header.b=XRxXCI9Q
      header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=NTfFw9T3;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH+7R2ILLUy0EYLMQs/DdxzEh3+uWbaN4Hma2/DM356PejYKP8G/ubg/3hey2zdmprEjHkL41g9m7hkyTbqVRUPACjm6LTPnmk66e6FObCYsiCMHBcwV
    Rp+uCf1EQG92iusyRTsA+CB0Fyp61E7fyhlpUs5U7YmqDIx1rb2p3EUcQi+QFVpK4IxPPozexBsok9TqooDBR8nf3cphOntusQifqCmxJmcV+89WwQu5SLVl
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x3-3yhV3NOoA:10 a=IkcTkHD0fZMA:10
    a=7mUfYlMuFuIA:10 a=drOt6m5kAAAA:8 a=8szBa0liiU-dC40AzS0A:9
    a=0XuyrfqUkcBDx6MK:21 a=0FGnM3opUdOTWq3m:21 a=QEXdDO2ut3YA:10
    a=RMMjzBEyIzXRtoq5n5K6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeFDT11 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 15:27:27 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39188 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeFDT10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:27:26 -0400
X-Google-Smtp-Source: ADUXVKJdEOaPev++2fkGIuQUIvhB5B6pRB9GW3v2lRWm/xI+24rCbhUtDG3gEvhJkeIvsVNIZ26ywW/NQpsJn0e7hGE=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180604155205.GH30522@ZenIV.linux.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720691829.9073.10564431140980997005.stgit@warthog.procyon.org.uk>
 <20180601062654.GA32397@infradead.org> <7067.1527841663@warthog.procyon.org.uk>
 <20180602030913.GU30522@ZenIV.linux.org.uk> <20180602034255.GV30522@ZenIV.linux.org.uk>
 <21804.1527954321@warthog.procyon.org.uk> <20180602174957.GX30522@ZenIV.linux.org.uk>
 <20180603005532.GZ30522@ZenIV.linux.org.uk> <CAELBmZCXMkCY+Lkz2xmhUiK_5oDctZzozHP-cXv9vp7qWsOtVQ@mail.gmail.com>
 <20180604155205.GH30522@ZenIV.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 4 Jun 2018 21:27:24 +0200
Message-ID: <CAJfpegutvApf8GQdHSKx_tvZyz=BNntO2ZVsQcKHSJQ4pMHYeQ@mail.gmail.com>
Subject: Re: [PATCH][RFC] open_tree(2) (was Re: [PATCH 30/32] vfs: Allow
 cloning of a mount tree with open(O_PATH|O_CLONE_MOUNT) [ver #8])
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-afs@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jun 4, 2018 at 5:52 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Mon, Jun 04, 2018 at 12:34:44PM +0200, Miklos Szeredi wrote:
>
>> fsopen = create fsfd
>> fsmount = fsfd -> mountfd & set attr on mountfd & attach mountfd
>> fspick = path -> fsfd
>> move_mount = attach mountfd or move existing
>> fsinfo = info from path
>> open_tree = new mountfd from path or clone
>> mount_setattr = set attr on mountfd
>>
>> Notice that fsmount() encompasses mount_setattr() + move_mount()
>> functionality.   Split those out and leave fsmount() to actually do
>> the "fsfd ->mountfd" translation?
>
> Might make sense.

> FWIW, to make it clear: fsmount(2) in this series actually does *NOT*
> attach it to the tree.

Ah, that leaves the mount_setattr() functionality to split out.   I'd
be more happy to rid this new API of all the old MS_* crap and have
have a new set of attributes, that just apply to mounts.   It will
also need  two args: a bitmap of new attributes and a mask to tell us
which attributes to change.

>  Commit message definitely needs updating - as it
> is, it's
>
> +SYSCALL_DEFINE5(fsmount, int, fs_fd, unsigned int, flags, unsigned int, ms_flags,
> +               void *, reserved4, void *, reserved5)
>
> PS: IMO these reserved... arguments are in bad taste; if anyone has good reasons
> for that practice in ABI design, I'd like to hear those.

Agreed.  A flags argument is often wise to add even if currently
unused (and should be checked for undefined flags), but adding a
random number of pointers doesn't seem to make a lot of sense.

>
>> fsinfo() name suggests it's in the same class as
>> fsopen/fsmount/fspick, operating on fsfd object, but's it's not and I
>> think that's slightly confusing.
>>
>> Rename move_mount() -> mount_move()?
>
> mount_move_bikeshed_bikeshed_bikeshed(), surely?

Consistent naming for related functions... not unheard of in API
design.  The above set definitely does not qualify.

>> Also does it make sense to make the cloning behavior of open_tree()
>> optional?  Without cloning it's just a plain open(O_PATH).  That  way
>> it could be renamed mount_clone().
>
> Umm...  I'm not sure about that one.  If nothing else, OPEN_TREE_DETACH
> might be a good idea, in which case cloning is not the primary effect;
> hell knows.

So conceptually we have the following distinct mount tree operations:

treefd = clone(path);
treefd = detach(path);
attach(treefd, path);
move(path1, path2);

The detach/move/attach trio are more related in functionality, while
clone and detach have the same signature. I'm not sure either.

Thanks,
Miklos
