Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0849C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB76820645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB76820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbeLFTvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:51:05 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:43360 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLFTvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:51:05 -0500
Received: by mail-io1-f71.google.com with SMTP id k4so1378745ioc.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 11:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BzFSLrIcxOa6i12TwNlZ8UARS2soRCx+KTaC1atrprQ=;
        b=Nw+yyHGtuv/yiD+u53SFBKHw1TNsa0OKEYb+dq76Qu2cO5oChBnvVjVFPs2yUmZKl9
         jUgv3e6pXwFQCGznY+YXTxnRfvJS6lEwKS67Q+dlBzo9+2WyT0MBhwlkC1+DKaXEXNke
         U9fB74jR6/3D0yYCqX3zUEpjlk5Sp306qanX9wf8yEZPIGXY+Oi5ZOjw6C3dlhDN+mnF
         fOiQ4r6JGGRsm42u0FIaXl9OpVXBrbELa1XjrlkgXvjYY8v6ayLwnmtUaGz/HsFfVJxl
         B10UCDXntlT4DSL1z01BMMFEtdLNT+1rZ8pryt1aCKLdg4+05OJELLH/GQRxPFg4UrnO
         S44Q==
X-Gm-Message-State: AA+aEWbtRKYgJTQTwwiKdRACiXCf0IaXu2oF4vzis8crSx/U4cv2NA9T
        1YlOVypYc1AbPrKT1v79X575zax3wr0Q+rpKiP45pCUPZ5rU
X-Google-Smtp-Source: AFSGD/VgE/H1n1x1TqW5oIhPVjLQWuMshtI2qSBJej9b8OgYqtByGzqaUIvRyWXK1NPVbumluVYrgVvQcbEH4YrGWNqV6OotStOY
MIME-Version: 1.0
X-Received: by 2002:a02:97da:: with SMTP id v26mr23009404jaj.1.1544125864089;
 Thu, 06 Dec 2018 11:51:04 -0800 (PST)
Date:   Thu, 06 Dec 2018 11:51:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e1fa9057c5fd1ae@google.com>
Subject: KASAN: stack-out-of-bounds Read in __schedule (2)
From:   syzbot <syzbot+df28818b7ebe8e7d704e@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d08970904582 Merge tag 'for-4.20-rc5-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106a5dd5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9cc5a440391cbfd
dashboard link: https://syzkaller.appspot.com/bug?extid=df28818b7ebe8e7d704e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12940cfb400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fb5e25400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+df28818b7ebe8e7d704e@syzkaller.appspotmail.com

kmem_cache               161KB        165KB
Out of memory: Kill process 7764 (syz-executor613) score 0 or sacrifice  
child
Killed process 7770 (syz-executor613) total-vm:18964kB, anon-rss:2124kB,  
file-rss:4kB, shmem-rss:0kB
oom_reaper: reaped process 7770 (syz-executor613), now anon-rss:0kB,  
file-rss:0kB, shmem-rss:0kB
==================================================================
BUG: KASAN: stack-out-of-bounds in schedule_debug kernel/sched/core.c:3284  
[inline]
BUG: KASAN: stack-out-of-bounds in __schedule+0x1c1b/0x21d0  
kernel/sched/core.c:3394
Read of size 8 at addr ffff8881ce710000 by task kworker/u4:4/2620

CPU: 1 PID: 2620 Comm: kworker/u4:4 Not tainted 4.20.0-rc5+ #266
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:

The buggy address belongs to the page:
page:ffffea000739c400 count:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 dead000000000100 dead000000000200 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881ce70ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1
  ffff8881ce70ff80: f1 00 00 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2
> ffff8881ce710000: f2 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2
                    ^
  ffff8881ce710080: f2 00 f2 f2 f2 00 00 00 00 00 00 00 00 00 00 00
  ffff8881ce710100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 2620 Comm: kworker/u4:4 Tainted: G    B             4.20.0-rc5+  
#266
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
oom_reaper: reaped process 7789 (syz-executor613), now anon-rss:0kB,  
file-rss:0kB, shmem-rss:0kB
rsyslogd invoked oom-killer: gfp_mask=0x6200ca(GFP_HIGHUSER_MOVABLE),  
nodemask=(null), order=0, oom_score_adj=0
rsyslogd cpuset=/ mems_allowed=0
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
