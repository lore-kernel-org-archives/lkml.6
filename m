Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394DAECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E436320C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RD7qpR9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E436320C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbeGQMIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:08:45 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39884 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730795AbeGQMIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:08:44 -0400
Received: by mail-pl0-f67.google.com with SMTP id p23-v6so342905plo.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yEoPJV27CqV2ml9k5H0qqqsPd5GLijklc8L2NSSVhOM=;
        b=RD7qpR9Ijqi+s171MmN1YHrtDgD+zEwt2cTIiLnMFk/W7wItXE5IosUrNlmsH55WmK
         mLQtkuIvbVs/sA26Ae59rx+OLKsDwOsDWOl0AboSYe/d/2hNViQz0qKHYWTPVaHuPDHZ
         z5h7QHX/OZO9LW+UNfkzsWTtDUPr52V6UfKwbkSHBAyoORS1foS7n4SWxMDIhEyLUy+d
         3p3Js3+S2ywVPavTSM2RVHk6BHSBybPRINH51m7myO9cSEchj4gEX2bVHQXS+fA9NTW+
         fGFjicNSmmJfMKxYx6UzqBxw8BEv098ScO+/3BMsmNB698YOVVbw3EI2zvq6tVHd4yeO
         CRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yEoPJV27CqV2ml9k5H0qqqsPd5GLijklc8L2NSSVhOM=;
        b=DD8xIah94Ig9QAmE9BNDB6vuOs79p0/MtuQ0QzkjdGF/0tqwm8x4bqtlRg5lQgJ9rK
         bQW5mHQOtbXxqhm4FD7R2n+Kngt+Sxsfy9zBsCdUckMPoyEGdyE07EyIJ3PAGvixseif
         A+kqt/t9r5O40F1Q9zMr1BgEKolEIqcXhCEX3miaMjzlNpWNwwgrB0BQx/iWiNDx6TFC
         2qZn1nlsM1OFGNJjonn22eyUTnos2Hdb2/flTep3iA9nw1AUz3g1Ld5VWWPCcMHCcvBe
         aNlWH3+shsfonasKM+GrG0qWCB905E0C9lvaFefVxTu8E8qI33UJKaOPVbzrkgQaen0p
         pbag==
X-Gm-Message-State: AOUpUlGXIPib1+0ZfUNDNN4WVE8BK0PpvXQVzZth/N/Hs2j2LvtmVy76
        H/cmwGXqgKRXbhX8+a0Z+AViHSzFCsj48qlcibz4pQ==
X-Google-Smtp-Source: AAOMgpcSt8ZPdj+F2gQJYh9K338AP+1Le3TVXd3spAMDtMeOjAIK4sVh30pxVy+dA+lAN35BDXTykFn0TkHVjDuBN8Y=
X-Received: by 2002:a17:902:b48c:: with SMTP id y12-v6mr1260693plr.97.1531827391084;
 Tue, 17 Jul 2018 04:36:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Tue, 17 Jul 2018 04:36:10
 -0700 (PDT)
In-Reply-To: <CAJfpeguHRhT4xwDNu-xEfA+YOrB7Wo7eM8sU19RGLaBpEN0g_A@mail.gmail.com>
References: <0000000000006a10de0570cf4d66@google.com> <CAJfpeguHRhT4xwDNu-xEfA+YOrB7Wo7eM8sU19RGLaBpEN0g_A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Jul 2018 13:36:10 +0200
Message-ID: <CACT4Y+Y=NZZDXPGvgTZzoG0G=a0TG+=vUXHUJPZMBvcufz872A@mail.gmail.com>
Subject: Re: WARNING: lock held when returning to user space in fuse_lock_inode
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     syzbot <syzbot+3f7b29af1baa9d0a55be@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        astrachan@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 1:14 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Thu, Jul 12, 2018 at 5:49 PM, syzbot
> <syzbot+3f7b29af1baa9d0a55be@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    c25c74b7476e Merge tag 'trace-v4.18-rc3-2' of git://git.ke..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=177bcec2400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3f7b29af1baa9d0a55be
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13aa7678400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17492678400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+3f7b29af1baa9d0a55be@syzkaller.appspotmail.com
>>
>> random: sshd: uninitialized urandom read (32 bytes read)
>> random: sshd: uninitialized urandom read (32 bytes read)
>> random: sshd: uninitialized urandom read (32 bytes read)
>>
>> ================================================
>> WARNING: lock held when returning to user space!
>> 4.18.0-rc4+ #143 Not tainted
>> ------------------------------------------------
>> syz-executor012/4539 is leaving the kernel with locks still held!
>> 1 lock held by syz-executor012/4539:
>>  #0: (____ptrval____) (&fi->mutex){+.+.}, at: fuse_lock_inode+0xaf/0xe0
>> fs/fuse/inode.c:363
>
> False positive.
>
> fi->mutex is definitely not held by the acquiring task when returning
> to userspace.  Maybe syzkaller is confused by the fact that there are
> several interdependent tasks involved with fuse:  the one calling into
> fuse by doing something (looking up ./file0/file0) and the one that
> reads the fuse device (returning with the LOOKUP request for "file0").
> The second one will return with that lock held, but it's not the one
> that acquired it, so there's no bug at all here.

Hi Miklos,

syzkaller is unrelated here. That's what kernel self-detects and
prints. So either way there is something to fix in kernel here: either
fuse or lockdep.

+Alistair did some analysis offline, hope you don't mind if I repost
your description:
===
Just from reading the code, I think I can see how this happens. Fuse
is wrapping its inode mutex with a check for "parallel_dirops", which
is set up in process_init_reply(). The FUSE_PARALLEL_DIROPS appears to
always be set, in fuse_send_init(), but its initial state is to be
disabled. So if the mutex gets taken, and it'll never be unlocked if
the initial command is flushed by fuse_readdir()'s use of
fuse_lock_inode().
===
