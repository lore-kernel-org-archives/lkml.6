Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA800ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6EB20684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nebtPf14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6EB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbeGQRqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:46:10 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38947 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731404AbeGQRp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:45:59 -0400
Received: by mail-io0-f194.google.com with SMTP id o22-v6so562276ioh.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 10:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTVSC4VD//TDv6GXbp8o90J4gP81R50Ip6HwYMMfiAY=;
        b=nebtPf14tiFIXJQCcFgZYPRcMIYmiFfThMFTENmGRV0fQCM52wjKC+PQ5tULzxO2/q
         1TCQBTAcmO4DwPXb3qTL8nPlaON3q/dSXbG+sg1uh3sPMbg//NIGE/c5bZgGXai/oVuH
         Ao69WJ/4GXM/8gYUku40nbskPwacdhoLamP+mZu5d5L5fyUcV5dKUnE3Yz9qP3ltwuLC
         9YndbsHANuMVlb48k1yYQ+Lv0SuvUjDUTAyOXuiZoEiMKJvNlWb7W4KmYjSO9DyojDzH
         nVn7ODkm1001dfuLD+tPXrWkIQZzdiw3CDIVkZ9upNF3sl/nJDben/csOEbgBh+ag2dJ
         8rNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTVSC4VD//TDv6GXbp8o90J4gP81R50Ip6HwYMMfiAY=;
        b=Nr3mWXv6h0n+UcXFHM+WLzQlYE4W7rUrrPdhVuzEXB/1sRVApV10P7CJXTqFGogV84
         fir+OfzN4ixTW/XQds4KSgfy6jaAgUkzuwogqLQTcz9/RTu4mt0SZhIJT2XOAPa+9FPJ
         poiz/XxAeW+zOOfd37mTBnMZfeXUNpKPUF4UY1Yk2lyVnOW/et7QghnqbkbnnWGhv2Cp
         IKJwmQ9EyF2LO5WVQ+I2TIjA2DDjSFujVXQnzn09DNxY4kUKDGDE43vxklTzxQSZXu5L
         nBmkxP+M2X3jiKE1EXValz3+MVhqLSG/tskNbzV/TonkmqVJrJQT8oAn13xKtmnDKiJ8
         kRLA==
X-Gm-Message-State: AOUpUlHsbl+M3OGGnrkCSpMCmi4+4qsX98nLTE130pSK+WCa4Zu22nYS
        wDKcgEGCI2Acsl0M82zWEInbi9VTZ3tVqAzwA89WQg==
X-Google-Smtp-Source: AAOMgpd+w3hyq5QgS2hGTrxn/dx9yqqUcYkUsoZhzBx5Z+mAf89WW7BEeZ92hQaEdEXUXNgU6tl42wNy+Bz/zNk85kA=
X-Received: by 2002:a6b:ac03:: with SMTP id v3-v6mr2202565ioe.71.1531847542149;
 Tue, 17 Jul 2018 10:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006a10de0570cf4d66@google.com> <CAJfpeguHRhT4xwDNu-xEfA+YOrB7Wo7eM8sU19RGLaBpEN0g_A@mail.gmail.com>
 <CACT4Y+Y=NZZDXPGvgTZzoG0G=a0TG+=vUXHUJPZMBvcufz872A@mail.gmail.com> <CAJfpegu20a7CCJQYTgrmuKPuAJkRgdv_5rmt6T-3kWKH5BpWnQ@mail.gmail.com>
In-Reply-To: <CAJfpegu20a7CCJQYTgrmuKPuAJkRgdv_5rmt6T-3kWKH5BpWnQ@mail.gmail.com>
From:   Alistair Strachan <astrachan@google.com>
Date:   Tue, 17 Jul 2018 10:12:10 -0700
Message-ID: <CANDihLG6kRJQXSCsv1M-bC3xgBpyS=B4bVoHCQ2h1_tKJeqppg@mail.gmail.com>
Subject: Re: WARNING: lock held when returning to user space in fuse_lock_inode
To:     miklos@szeredi.hu
Cc:     dvyukov@google.com,
        syzbot+3f7b29af1baa9d0a55be@syzkaller.appspotmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 5:46 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Tue, Jul 17, 2018 at 1:36 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Tue, Jul 17, 2018 at 1:14 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >> On Thu, Jul 12, 2018 at 5:49 PM, syzbot
> >> <syzbot+3f7b29af1baa9d0a55be@syzkaller.appspotmail.com> wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following crash on:
> >>>
> >>> HEAD commit:    c25c74b7476e Merge tag 'trace-v4.18-rc3-2' of git://git.ke..
> >>> git tree:       upstream
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=177bcec2400000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=3f7b29af1baa9d0a55be
> >>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13aa7678400000
> >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17492678400000
> >>>
> >>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >>> Reported-by: syzbot+3f7b29af1baa9d0a55be@syzkaller.appspotmail.com
> >>>
> >>> random: sshd: uninitialized urandom read (32 bytes read)
> >>> random: sshd: uninitialized urandom read (32 bytes read)
> >>> random: sshd: uninitialized urandom read (32 bytes read)
> >>>
> >>> ================================================
> >>> WARNING: lock held when returning to user space!
> >>> 4.18.0-rc4+ #143 Not tainted
> >>> ------------------------------------------------
> >>> syz-executor012/4539 is leaving the kernel with locks still held!
> >>> 1 lock held by syz-executor012/4539:
> >>>  #0: (____ptrval____) (&fi->mutex){+.+.}, at: fuse_lock_inode+0xaf/0xe0
> >>> fs/fuse/inode.c:363
> >>
> >> False positive.
> >>
> >> fi->mutex is definitely not held by the acquiring task when returning
> >> to userspace.  Maybe syzkaller is confused by the fact that there are
> >> several interdependent tasks involved with fuse:  the one calling into
> >> fuse by doing something (looking up ./file0/file0) and the one that
> >> reads the fuse device (returning with the LOOKUP request for "file0").
> >> The second one will return with that lock held, but it's not the one
> >> that acquired it, so there's no bug at all here.
> >
> > Hi Miklos,
> >
> > syzkaller is unrelated here. That's what kernel self-detects and
> > prints. So either way there is something to fix in kernel here: either
> > fuse or lockdep.
> >
> > +Alistair did some analysis offline, hope you don't mind if I repost
> > your description:
> > ===
> > Just from reading the code, I think I can see how this happens. Fuse
> > is wrapping its inode mutex with a check for "parallel_dirops", which
> > is set up in process_init_reply(). The FUSE_PARALLEL_DIROPS appears to
> > always be set, in fuse_send_init(), but its initial state is to be
> > disabled. So if the mutex gets taken, and it'll never be unlocked if
> > the initial command is flushed by fuse_readdir()'s use of
> > fuse_lock_inode().
> > ===
>
> Ah, indeed.  Fix attached.

Looks good to me.

Tested-by: Alistair Strachan <astrachan@google.com>

> Thanks,
> Miklos
