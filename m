Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D7DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2B02083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C45RYrxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBYTUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:20:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45946 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfBYTUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:20:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so4921505pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 11:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=KAqxavEck460EBbGcDM8p2TI1xGRgrYHrpJPUu5KR9I=;
        b=C45RYrxxeLoP/1YaKM32YEGaeJYiIDdEAJJVU3uQZtTiZVN+xUsOhNEhY4Z317eSuU
         z6zH/9AH4LlOpd7l9yqx3XcjvVUdbDV14xCQ8ST7GKH8vKRXECS7yAeItHVsQlnWQrWw
         BwTsfNoDg/y/h2yqbpKZBr7tU2r2l6VKma9gh//BEx5N0/KMzEA67mrXRdkBNhqa7rf2
         jQTWhRdMPo0nqJpjDk/vAi60Is8ps4nU/e5YnbISeZFMZRYviuQOf4HW4ksoaH6gGKso
         foYBMGQiL2M4zK9RcgYzHM7fLUvHKHMSTpMV2fBuUvMv0DTdRUmeBOh4HQM2GkQ1Iaan
         GUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=KAqxavEck460EBbGcDM8p2TI1xGRgrYHrpJPUu5KR9I=;
        b=PvDcxGfOwmBrc0DvzUF2E4lG0O1aCaR86NLFxLUfwVT8h0WMQSRa7nFXrE793dOitl
         f5oMLp23MQfvNwOMUwDpEbLIy53LnBYGSFmPxl/J2MWV6xdChlbj6lMRBt0xDhTVwliy
         MT0Nq1OEEkoIx7qA+qzxI5EdXeJjLdqczqmiTwR1Rg7henKDfH1SJSloGjtV7NxQf3/Y
         B6qns1dlq+DvrvbHUkGUbbFjYJv8ypMzc8rY8ofekhK4qjzFekM3or6AnS8FDxo35muu
         cFZNpzGJxK+5DZGububSZO0Ycs1/CwywBUvLPfz440j8Ze5vDJSbGj4mnQtf90VUZTEE
         wTlQ==
X-Gm-Message-State: AHQUAub78Mko3mxHp1MDeKZn2UODmB2QIE6ogsh+8J/vY74v9ZBD7c0s
        ZMyZO+oCP2Kj7kibTjB/ZdVzdA==
X-Google-Smtp-Source: AHgI3Ibzfn6KTUQWMdQynX6KrAytL6VrjLhpHgY4mrKlz2A5zHtjHBlZx+0VcY6XydI5pAluwjiuFQ==
X-Received: by 2002:a17:902:e113:: with SMTP id cc19mr22315864plb.179.1551122402977;
        Mon, 25 Feb 2019 11:20:02 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h64sm18047360pfc.142.2019.02.25.11.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 11:20:02 -0800 (PST)
Date:   Mon, 25 Feb 2019 11:20:01 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     syzbot <syzbot+12f1b031b6da017e34f8@syzkaller.appspotmail.com>,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
        mahesh1.kumar@intel.com, rodrigo.vivi@intel.com,
        rodrigosiqueiramelo@gmail.com, seanpaul@chromium.org,
        syzkaller-bugs@googlegroups.com
cc:     daniel@ffwll.ch, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: INFO: trying to register non-static key in __flush_work
In-Reply-To: <20190225083311.GG2665@phenom.ffwll.local>
Message-ID: <alpine.DEB.2.21.1902251119330.167839@chino.kir.corp.google.com>
References: <000000000000f4fe3e057e25b276@google.com> <alpine.DEB.2.21.1902241238190.190029@chino.kir.corp.google.com> <20190225083311.GG2665@phenom.ffwll.local>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019, Daniel Vetter wrote:

> On Sun, Feb 24, 2019 at 12:40:19PM -0800, David Rientjes wrote:
> > On Sat, 29 Dec 2018, syzbot wrote:
> > 
> > > Hello,
> > > 
> > > syzbot found the following crash on:
> > > 
> > > HEAD commit:    5694cecdb092 Merge tag 'arm64-upstream' of git://git.kerne..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=124eebc7400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=91a256823ef17263
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=12f1b031b6da017e34f8
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1174a1dd400000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1336e38b400000
> > > 
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+12f1b031b6da017e34f8@syzkaller.appspotmail.com
> > > 
> > > INFO: trying to register non-static key.
> > > the code is fine but needs lockdep annotation.
> > > turning off the locking correctness validator.
> > > CPU: 0 PID: 8039 Comm: syz-executor964 Not tainted 4.20.0+ #389
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
> > > 01/01/2011
> > > Call Trace:
> > > __dump_stack lib/dump_stack.c:77 [inline]
> > > dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
> > > assign_lock_key kernel/locking/lockdep.c:727 [inline]
> > > register_lock_class+0x21c5/0x29d0 kernel/locking/lockdep.c:753
> > > __lock_acquire+0x184/0x4c20 kernel/locking/lockdep.c:3227
> > > lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
> > > __flush_work+0x752/0x9b0 kernel/workqueue.c:2912
> > > flush_work+0x17/0x20 kernel/workqueue.c:2938
> > > vkms_atomic_crtc_destroy_state+0x2b/0x40 drivers/gpu/drm/vkms/vkms_crtc.c:139
> > > drm_atomic_state_default_clear+0x37c/0xda0 drivers/gpu/drm/drm_atomic.c:171
> > > drm_atomic_state_clear+0x9f/0xd0 drivers/gpu/drm/drm_atomic.c:240
> > > __drm_atomic_state_free+0x3a/0xf0 drivers/gpu/drm/drm_atomic.c:256
> > > kref_put include/linux/kref.h:70 [inline]
> > > drm_atomic_state_put include/drm/drm_atomic.h:385 [inline]
> > > drm_atomic_helper_set_config+0xe6/0x160
> > > drivers/gpu/drm/drm_atomic_helper.c:2947
> > > drm_mode_setcrtc+0x767/0x1890 drivers/gpu/drm/drm_crtc.c:748
> > > drm_ioctl_kernel+0x278/0x330 drivers/gpu/drm/drm_ioctl.c:758
> > > drm_ioctl+0x58f/0xb90 drivers/gpu/drm/drm_ioctl.c:858
> > > vfs_ioctl fs/ioctl.c:46 [inline]
> > > file_ioctl fs/ioctl.c:509 [inline]
> > > do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
> > > ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
> > > __do_sys_ioctl fs/ioctl.c:720 [inline]
> > > __se_sys_ioctl fs/ioctl.c:718 [inline]
> > > __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
> > > do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> > > entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > RIP: 0033:0x443e59
> > > Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48
> > > 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f
> > > 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > > RSP: 002b:00007fff2bc037c8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
> > > RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443e59
> > > RDX: 0000000020000100 RSI: 00000000c06864a2 RDI: 0000000000000003
> > > RBP: 00000000006ce018 R08: 0000000000000000 R09: 00000000004002e0
> > > R10: 000000000000000f R11: 0000000000000213 R12: 0000000000401b60
> > > R13: 0000000000401bf0 R14: 0000000000000000 R15: 000000000
> > > 
> > 
> > This is reproducible up to at least
> > 
> > commit e60b5f79bd7529e76b13cf1e85823abbd0e33634
> > Merge: 6089a91fc02e 8f5b27347e88
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Sat Feb 23 11:13:50 2019 -0800
> > 
> >     Merge tag 'powerpc-5.0-6' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> > 
> > and my theory is that it's due to this:
> > 
> > commit dfb9f5cabfe31b8e936b725b5de8f787f7c18b0f
> > Author: Haneen Mohammed <hamohammed.sa@gmail.com>
> > Date:   Tue Jul 24 19:31:05 2018 +0300
> > 
> >     drm/vkms: subclass CRTC state
> >     
> > in 4.20-rc1.  We aren't doing INIT_WORK() for the workqueue that is being 
> > flushed.
> > 
> > Don't we need to do INIT_WORK() in vkms_atomic_crtc_reset() too?
> 
> Patch is in linux-next:
> 
> commit b30b61ff6b1dc37f276cf56a8328b80086a3ffca
> Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date:   Sat Jan 19 01:43:43 2019 +0900
> 
>     drm/vkms: Fix flush_work() without INIT_WORK()
> 

Great, thanks Tetsuo!
