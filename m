Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93757C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D42720663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZBLXh9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfBXUkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 15:40:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46047 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfBXUkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 15:40:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so3449805pgc.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 12:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=5PTWcjW/fg8l6LpSnx5M+b8BKI7drP9Kcq707eCxORA=;
        b=RZBLXh9BamNSPcmxphPCXsaH79xN3POXPTwVZ30j+cVCmFVH2LlJvKnNx3b7hrzexk
         +fUMtUNy1smn+u4SK0tqyBn47fzpjUROATRIWX/AfC51pAXdZim6QcGNEoeLiqx5Lqj5
         tWayeUKKDG4FJSjzIlmM05y60YS51XZy5ehxF+Zb6ea7A9DDN+sx7PT5QXDzLrWfxHSb
         O6CxNGEB3loMNrSJ7dD720LGbB969Nxq2oc4mqPg9uqFxmo0MkvwYIxUwhW7YxdU0mnN
         kKBVL0a6NZ1K8KVzkVwznrk4+8JW4RBjUZhV6cCkGXahq7Uhx4s8UjHKV3SRZb6d7n69
         SuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=5PTWcjW/fg8l6LpSnx5M+b8BKI7drP9Kcq707eCxORA=;
        b=ZFwp+aI6LLKyPdTFGODcHzfVYNbaO55cVL4bMSDyxNIqJ1zT+eA/SMuqTEtar0aRiC
         jNe+VwZcCHLhMk7kfH94kTQPhaAFmQnNRBLK9vOp8bFfZni4KcIoPF2Fwi5HOM8fvvWS
         oJWowmHxPTkhBckzA9LWcyHuhx7RpkPjrS1KEfPv8w/gAxOGbcoRNtcgR1i/hEdhEFP6
         ITnajrz3KAdof5uw3KDCUb6hbX+qXNfqwAxf2r3K0Scb1r5C5yja0FXa8FNGAc+fzR4b
         PhnRob8kVA/+cZHTTLhKPgjQ7tNVYg45fibtX7HUwVQoU63iuXoiRdAzC4LYNOy16Amj
         RLow==
X-Gm-Message-State: AHQUAuZroEc7vHGKv/E7/8J/eP4DmaAO0N4yoXfWbpxewVhCTGfmTSXY
        9E1P+8JSz8xh6Rx2qqw/Sdoezw==
X-Google-Smtp-Source: AHgI3IbFzMavXFogGbnyQlOW5W9tdJq2hNmCF0zFXQahoD9EeMkKWO09YXRcRtNPLj2+BeC5420kQQ==
X-Received: by 2002:a63:8b43:: with SMTP id j64mr15001940pge.332.1551040820482;
        Sun, 24 Feb 2019 12:40:20 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id o2sm17462629pgq.29.2019.02.24.12.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 12:40:19 -0800 (PST)
Date:   Sun, 24 Feb 2019 12:40:19 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     syzbot <syzbot+12f1b031b6da017e34f8@syzkaller.appspotmail.com>
cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
        mahesh1.kumar@intel.com, rodrigo.vivi@intel.com,
        rodrigosiqueiramelo@gmail.com, seanpaul@chromium.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: trying to register non-static key in __flush_work
In-Reply-To: <000000000000f4fe3e057e25b276@google.com>
Message-ID: <alpine.DEB.2.21.1902241238190.190029@chino.kir.corp.google.com>
References: <000000000000f4fe3e057e25b276@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2018, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    5694cecdb092 Merge tag 'arm64-upstream' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=124eebc7400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=91a256823ef17263
> dashboard link: https://syzkaller.appspot.com/bug?extid=12f1b031b6da017e34f8
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1174a1dd400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1336e38b400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+12f1b031b6da017e34f8@syzkaller.appspotmail.com
> 
> INFO: trying to register non-static key.
> the code is fine but needs lockdep annotation.
> turning off the locking correctness validator.
> CPU: 0 PID: 8039 Comm: syz-executor964 Not tainted 4.20.0+ #389
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
> 01/01/2011
> Call Trace:
> __dump_stack lib/dump_stack.c:77 [inline]
> dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
> assign_lock_key kernel/locking/lockdep.c:727 [inline]
> register_lock_class+0x21c5/0x29d0 kernel/locking/lockdep.c:753
> __lock_acquire+0x184/0x4c20 kernel/locking/lockdep.c:3227
> lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
> __flush_work+0x752/0x9b0 kernel/workqueue.c:2912
> flush_work+0x17/0x20 kernel/workqueue.c:2938
> vkms_atomic_crtc_destroy_state+0x2b/0x40 drivers/gpu/drm/vkms/vkms_crtc.c:139
> drm_atomic_state_default_clear+0x37c/0xda0 drivers/gpu/drm/drm_atomic.c:171
> drm_atomic_state_clear+0x9f/0xd0 drivers/gpu/drm/drm_atomic.c:240
> __drm_atomic_state_free+0x3a/0xf0 drivers/gpu/drm/drm_atomic.c:256
> kref_put include/linux/kref.h:70 [inline]
> drm_atomic_state_put include/drm/drm_atomic.h:385 [inline]
> drm_atomic_helper_set_config+0xe6/0x160
> drivers/gpu/drm/drm_atomic_helper.c:2947
> drm_mode_setcrtc+0x767/0x1890 drivers/gpu/drm/drm_crtc.c:748
> drm_ioctl_kernel+0x278/0x330 drivers/gpu/drm/drm_ioctl.c:758
> drm_ioctl+0x58f/0xb90 drivers/gpu/drm/drm_ioctl.c:858
> vfs_ioctl fs/ioctl.c:46 [inline]
> file_ioctl fs/ioctl.c:509 [inline]
> do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
> ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
> __do_sys_ioctl fs/ioctl.c:720 [inline]
> __se_sys_ioctl fs/ioctl.c:718 [inline]
> __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
> do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x443e59
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48
> 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f
> 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fff2bc037c8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443e59
> RDX: 0000000020000100 RSI: 00000000c06864a2 RDI: 0000000000000003
> RBP: 00000000006ce018 R08: 0000000000000000 R09: 00000000004002e0
> R10: 000000000000000f R11: 0000000000000213 R12: 0000000000401b60
> R13: 0000000000401bf0 R14: 0000000000000000 R15: 000000000
> 

This is reproducible up to at least

commit e60b5f79bd7529e76b13cf1e85823abbd0e33634
Merge: 6089a91fc02e 8f5b27347e88
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Feb 23 11:13:50 2019 -0800

    Merge tag 'powerpc-5.0-6' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux

and my theory is that it's due to this:

commit dfb9f5cabfe31b8e936b725b5de8f787f7c18b0f
Author: Haneen Mohammed <hamohammed.sa@gmail.com>
Date:   Tue Jul 24 19:31:05 2018 +0300

    drm/vkms: subclass CRTC state
    
in 4.20-rc1.  We aren't doing INIT_WORK() for the workqueue that is being 
flushed.

Don't we need to do INIT_WORK() in vkms_atomic_crtc_reset() too?
