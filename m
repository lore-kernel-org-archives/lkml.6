Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA72ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB7120C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GWc2noAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB7120C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbeGQLqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:46:37 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40070 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbeGQLqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:46:37 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so1255440oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q3e1s3fqXQJGeRMiGghReKnux5dgmK9ZuWEZdWDIkfk=;
        b=GWc2noAbPRwz0jobmgdAz9LOr0xMSMflEiPCIvxQddv9B9PN2Rw3plqXZUopyrRqGd
         YXdsbPyzBt5APTR7aGoG3Ge9pDY2/7wTS3ByAPzrW7m8Im7SZuyd0ibpWhJauj3dVIeZ
         aOnWD6QiNjhTI3Lklkk6Haq6JEZ9z5zYPdsEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q3e1s3fqXQJGeRMiGghReKnux5dgmK9ZuWEZdWDIkfk=;
        b=P4nwMjUTYnF/Mats+d4QS+0lcgvIu2wscP1kglWI7tCGOMJtil/K30dcN+X7MzwJo/
         bi+h92gkgo3XAESoG8+VQB0gsMe/BNO7KYFZmOA+s4DZU7tGzxqloG1UPNxIPTNgM4q3
         uyehjA0xz9+fgnc/7OJeS4Wk20cemKfgqbYAthk/94caqJ9x7fXZ/NvtmzLnnZ6JC5m5
         DcllSsXOcjtXDUAXe2HYm6WVtgOxAy/dgC93plCcgWKju+CgR2QKTHztfXZg+Xy4UXHE
         AJTuj0e8Wo5CYqtUAaKD2/H17YmCGCIwkMmwhWzoKmGGWIvo2LcfwXPjJZ0dp5rNi/sN
         C4jg==
X-Gm-Message-State: AOUpUlF8dpKAquWxxmoaln5fXFUc4Teo5vStvctdblfgQ5crqcNNK9gY
        ZQZbOcalI6zhjRBa2PK+TeF6vfpB024bOaeUcIjhvw==
X-Google-Smtp-Source: AAOMgpfFOo9ugIqow1X8t3lgCnjlHV9Zs4z5bH/1ZP+AW9A8DOTUvD+Y2TEyVm8weoDndiekAwuYOj4uimiFpu8k6o4=
X-Received: by 2002:aca:4bc6:: with SMTP id y189-v6mr1086573oia.181.1531826069591;
 Tue, 17 Jul 2018 04:14:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 04:14:28
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <0000000000006a10de0570cf4d66@google.com>
References: <0000000000006a10de0570cf4d66@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Jul 2018 13:14:28 +0200
Message-ID: <CAJfpeguHRhT4xwDNu-xEfA+YOrB7Wo7eM8sU19RGLaBpEN0g_A@mail.gmail.com>
Subject: Re: WARNING: lock held when returning to user space in fuse_lock_inode
To:     syzbot <syzbot+3f7b29af1baa9d0a55be@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 5:49 PM, syzbot
<syzbot+3f7b29af1baa9d0a55be@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    c25c74b7476e Merge tag 'trace-v4.18-rc3-2' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=177bcec2400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3f7b29af1baa9d0a55be
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13aa7678400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17492678400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3f7b29af1baa9d0a55be@syzkaller.appspotmail.com
>
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
>
> ================================================
> WARNING: lock held when returning to user space!
> 4.18.0-rc4+ #143 Not tainted
> ------------------------------------------------
> syz-executor012/4539 is leaving the kernel with locks still held!
> 1 lock held by syz-executor012/4539:
>  #0: (____ptrval____) (&fi->mutex){+.+.}, at: fuse_lock_inode+0xaf/0xe0
> fs/fuse/inode.c:363

False positive.

fi->mutex is definitely not held by the acquiring task when returning
to userspace.  Maybe syzkaller is confused by the fact that there are
several interdependent tasks involved with fuse:  the one calling into
fuse by doing something (looking up ./file0/file0) and the one that
reads the fuse device (returning with the LOOKUP request for "file0").
The second one will return with that lock held, but it's not the one
that acquired it, so there's no bug at all here.

Thanks,
Miklos

>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
