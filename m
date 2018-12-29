Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC0FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16FF2184E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeL2JVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 04:21:06 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:51419 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbeL2JVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 04:21:06 -0500
Received: by mail-it1-f198.google.com with SMTP id b14so3981214itd.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 01:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=b9ByV/IXNvfxqrOvbhrBkzsQqt5lHOiNi2MHxAcv1nU=;
        b=pyI1EZ3/4V2fS754YjJdq9ugEjIh7PsKPxpDAZSxF5AjhdCkQ99s/B0zmzL2cgwi/U
         Y1Owxh/im3/Pirrxu4E0nhrVacKDxju66TxuFfM0RPKF7BbTHQGUG+4o+V9ToK5FqYfW
         J9zUzWSiul0Hl+hIc97JBcbHwgLI+5TYE0YnruEkDj89Y17pEtVb591lQIC37V+n5nfB
         0jbSttFNRl0dyOrIQkac+CZSXWqvTr/Yk2AHE0KdtDXIku5RTiAQCLBVeCJcwz/0j3Pt
         2aM1ad5IJQkn6M0gUc71DsCLOjKtxIGWW8gw2mweWy0fhAlNbMg4AYEK252u+7sdY8dA
         cjeA==
X-Gm-Message-State: AA+aEWb7nxEj1FS31WuzATGh/wYNLd9vFvT+1AX7hoA1LbP2VsmandUt
        Mh1VYmoP3tSkUaYeQUP7P7nC0vxYrNbrVAPcy6eTnESQCrfS
X-Google-Smtp-Source: AFSGD/Xo7pQepjdHsCSnkS/xFRV/tLwE8l+4At1ih6PvGrII3a3OwIM4NFwuiKS43uMClt5/CMifzI+tyT2WAHWydRBeDl10R88n
MIME-Version: 1.0
X-Received: by 2002:a02:77c2:: with SMTP id g185mr23771803jac.9.1546075264841;
 Sat, 29 Dec 2018 01:21:04 -0800 (PST)
Date:   Sat, 29 Dec 2018 01:21:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4fe3e057e25b276@google.com>
Subject: INFO: trying to register non-static key in __flush_work
From:   syzbot <syzbot+12f1b031b6da017e34f8@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
        mahesh1.kumar@intel.com, rodrigo.vivi@intel.com,
        rodrigosiqueiramelo@gmail.com, seanpaul@chromium.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5694cecdb092 Merge tag 'arm64-upstream' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124eebc7400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91a256823ef17263
dashboard link: https://syzkaller.appspot.com/bug?extid=12f1b031b6da017e34f8
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1174a1dd400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1336e38b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+12f1b031b6da017e34f8@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 8039 Comm: syz-executor964 Not tainted 4.20.0+ #389
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  assign_lock_key kernel/locking/lockdep.c:727 [inline]
  register_lock_class+0x21c5/0x29d0 kernel/locking/lockdep.c:753
  __lock_acquire+0x184/0x4c20 kernel/locking/lockdep.c:3227
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  __flush_work+0x752/0x9b0 kernel/workqueue.c:2912
  flush_work+0x17/0x20 kernel/workqueue.c:2938
  vkms_atomic_crtc_destroy_state+0x2b/0x40  
drivers/gpu/drm/vkms/vkms_crtc.c:139
  drm_atomic_state_default_clear+0x37c/0xda0 drivers/gpu/drm/drm_atomic.c:171
  drm_atomic_state_clear+0x9f/0xd0 drivers/gpu/drm/drm_atomic.c:240
  __drm_atomic_state_free+0x3a/0xf0 drivers/gpu/drm/drm_atomic.c:256
  kref_put include/linux/kref.h:70 [inline]
  drm_atomic_state_put include/drm/drm_atomic.h:385 [inline]
  drm_atomic_helper_set_config+0xe6/0x160  
drivers/gpu/drm/drm_atomic_helper.c:2947
  drm_mode_setcrtc+0x767/0x1890 drivers/gpu/drm/drm_crtc.c:748
  drm_ioctl_kernel+0x278/0x330 drivers/gpu/drm/drm_ioctl.c:758
  drm_ioctl+0x58f/0xb90 drivers/gpu/drm/drm_ioctl.c:858
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x443e59
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff2bc037c8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443e59
RDX: 0000000020000100 RSI: 00000000c06864a2 RDI: 0000000000000003
RBP: 00000000006ce018 R08: 0000000000000000 R09: 00000000004002e0
R10: 000000000000000f R11: 0000000000000213 R12: 0000000000401b60
R13: 0000000000401bf0 R14: 0000000000000000 R15: 000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
