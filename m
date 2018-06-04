Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1599531-1528108493-2-2089111849509204149
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528108492; b=NTY+HTessAETXXIGp+dqFniz5XjRnoJzO1LJIsF6n/86Xq+HIn
    Y+bBatCs4w0Im7eJyP4zivUANpnlVAchnr0OvAh03STVRkV62Mk+77nMpOlzHPao
    1LJBTA4Dcot67zwD/MMzOtzDx2CRZPYT3ECBt+e3+NcIMbhPN/l/AbKzllDDkJ2/
    MnzvfudLSeGvNY9nRbpknFk2h/g/74s+qFcZU8IPITKs1NFiuQDbOc0D7G9Z9Dsq
    //Ceouj4JsJv5AH5NGqRkbHSiBFwXSIyLe6pqs6+X59DENQz2CzbYKrfgkhgLleS
    m9Dbsfk3Ms/bgsn4q/couWCrxuxNlqgtLfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528108492; bh=5uFYQnUGcuYPVLTkNwEAO67Og9uZBQdlCGzUEh2L/m
    o=; b=Mkm2V4aU+djDtpNqGp7IVYCi6sU2xYwnH2tMs84pOersBD7I0N+8elBpWq
    LFWlpXJNMZRCW39Ezt3lp26E4Z3JmXJQDryFFZvjG7CHrn4wSGnTryqrZQQTaKg1
    yNgSI9QI7IYjkmGxmjPrhGgesNJWcxgdl31jO1gJDkPpl4OSbLSVeK3ZBu4Ww88Z
    Lqn+LlqDLaZ+JrB+PJ4hvQ+gV28C0vpgZ895IHMbDLdZuNLsl4VUwstacM1kDoX7
    hU2MUnHSz5gwuVHo/spwlZsE2UO9DMjK0s9xCaAufsorsaPw9RM7opECjyza2ZnQ
    ZCBFLRl32t86UDZ1gugfsw67tU5Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
    header.d=szeredi.hu header.i=@szeredi.hu header.b=Uvvx5lh7
    header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=dZaMzHwP;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256)
      header.d=szeredi.hu header.i=@szeredi.hu header.b=Uvvx5lh7
      header.a=-sha256 header.s=google x-bits=0;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=szeredi.hu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=dZaMzHwP;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=szeredi.hu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOz6L1xoztaCSgioiy6eWyPKMeYF5YWChMLS6MCGTUtyE73Rn1B7mB6kgb+XG8e/Y2+pNaa7r/jEalVT4siI6QxHLhb0p3ezoeL7D9Q1bCJy7DtCpp9i
    7t7Jain5CxKVYHhNfOaYj39BS2T/qAPRn44RDWZuAr1fEuPjUwJuMtsLc0+EU0PB/L9Yo/B2ZnbcnBTjr8rO2ZhSeV2FncSjpFIpUoRL8732gxmCIaFaRvOR
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=drOt6m5kAAAA:8 a=fTf08CykMkpD7dSz_G4A:9 a=QEXdDO2ut3YA:10
    a=RMMjzBEyIzXRtoq5n5K6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeFDKeu (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 06:34:50 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33501 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752345AbeFDKes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:34:48 -0400
X-Google-Smtp-Source: ADUXVKKxFMlwj0YgD+iteLPHnKu46ZHOc8moBYd8vOQmZJsR9nxvZRl/g+TNpZpoZoGNkymZqyOFWQ==
MIME-Version: 1.0
In-Reply-To: <20180603005532.GZ30522@ZenIV.linux.org.uk>
References: <20180602040434.GW30522@ZenIV.linux.org.uk> <20180601063928.GS30522@ZenIV.linux.org.uk>
 <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720691829.9073.10564431140980997005.stgit@warthog.procyon.org.uk>
 <20180601062654.GA32397@infradead.org> <7067.1527841663@warthog.procyon.org.uk>
 <20180602030913.GU30522@ZenIV.linux.org.uk> <20180602034255.GV30522@ZenIV.linux.org.uk>
 <21804.1527954321@warthog.procyon.org.uk> <20180602174957.GX30522@ZenIV.linux.org.uk>
 <20180603005532.GZ30522@ZenIV.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 4 Jun 2018 12:34:44 +0200
X-Gmail-Original-Message-ID: <CAELBmZCXMkCY+Lkz2xmhUiK_5oDctZzozHP-cXv9vp7qWsOtVQ@mail.gmail.com>
Message-ID: <CAELBmZCXMkCY+Lkz2xmhUiK_5oDctZzozHP-cXv9vp7qWsOtVQ@mail.gmail.com>
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

On Sun, Jun 3, 2018 at 2:55 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sat, Jun 02, 2018 at 06:49:58PM +0100, Al Viro wrote:
>
>> > > Hell, might even add AT_UMOUNT for "open root and detach, to be dissolved on
>> > > close", incompatible with AT_CLONE.
>> >
>> > Cute.  Guess you could do:
>> >
>> >     fd = open_mount(..., OPEN_TREE_DETACH);
>> >     mount_setattr(fd, "",
>> >                   MOUNT_SETATTR_EMPTY_PATH,
>> >                   MOUNT_SETATTR_NOSUID, NULL);
>> >     move_mount(fd, "", ...);
>
> Hadn't added that yet, but as for the rest of open_tree() - see
> vfs.git#mount-open_tree.  open() and its flags are not touched at all.
> Other changes compared to the previous:
>         * may_mount() is required for OPEN_TREE_CLONE
>         * sys_ni.c cruft is dropped - those make no sense until and unless
> those syscalls become conditional.
>
> Appears to work, combined with move_mount() it yields eqiuvalents of
> mount --{move,bind,rbind}.  Combined with mount_setattr(2) (when that
> gets added) we'll get mount -o remount,bind,nodev et.al.

fsopen = create fsfd
fsmount = fsfd -> mountfd & set attr on mountfd & attach mountfd
fspick = path -> fsfd
move_mount = attach mountfd or move existing
fsinfo = info from path
open_tree = new mountfd from path or clone
mount_setattr = set attr on mountfd

Notice that fsmount() encompasses mount_setattr() + move_mount()
functionality.   Split those out and leave fsmount() to actually do
the "fsfd ->mountfd" translation?

fsinfo() name suggests it's in the same class as
fsopen/fsmount/fspick, operating on fsfd object, but's it's not and I
think that's slightly confusing.

Rename move_mount() -> mount_move()?

Also does it make sense to make the cloning behavior of open_tree()
optional?  Without cloning it's just a plain open(O_PATH).  That  way
it could be renamed mount_clone().

Thanks,
Miklos
