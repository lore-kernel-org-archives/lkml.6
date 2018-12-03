Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAB8C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A5B20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVIGNN+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A5B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbeLCHrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:47:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40412 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeLCHrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:47:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id q26so4523376wmf.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 23:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6lV8j+G7Xpem+oMI5fU07V0dy1BJ8+B6EqyreIDFMtY=;
        b=QVIGNN+3BvEMcJrtmsjKQNPG3Fcpvc+B7b8tCEQCXRrZwQucXwitlgb04ogdoK8CRa
         w/dUIe/oE12GNjwqMducrAuIz32TifA3RUPKFnpWdSXwftBkh41pmKkwE/iDGfLhjoFZ
         AbAyevk6qLm3fNLI27ppwNmXGXEMcAKXf5MwL9zrkr8p88i5hNchcOXjPpw9QDWFsQ7R
         lgtF7UvbekbGXymXG0BUqtGOwj3JwVbSjiUgXrwTTZn9v6H5gisZj3GoA3EcJXrFdnlP
         6X0AdgVKfB2OEz9bZvNfOpyiqaYO4sAXI5MYoFu3/ukjFZzSJcIJQ7o9Q6EqiNe/f3fY
         vYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6lV8j+G7Xpem+oMI5fU07V0dy1BJ8+B6EqyreIDFMtY=;
        b=j2Q/pllDmfjp+B5uidyQqHw05sAf8yZZCD8Swk/qW0DXbKxlyug6EtC7eGsF0MeeyY
         Dg5Am7ZGihk4hGktJJ1TZBowhJVnrhTWKzd2APc0FANsAxQ6Ox+tPV7D+hLXZxFA8mMa
         0LD0//hSTCIKJlhuFAKuL3ROf1CngrPidS4BgalfINye5iIHYjNsq5pERFtRfKvu7ym3
         Q0/ARkp7MeCBzfgBttnLroSAdshyW8ZsocH0Imtq6DoWQ3gspaO7kEEebylhLWUr9x0t
         ba5JX6ies6Slbf/9Uc3E9mujpL23tkbbAHqsZBm+6ET3PStTjpNFMxpGIbblBqkj9lDx
         YBBg==
X-Gm-Message-State: AA+aEWa6u8lxOr8ucZKDxzN5rA3mCyRz7V7+o54z/psYm+5PnojXaLvj
        J2FlrPnKBXXwr/KRi/mRaNQ=
X-Google-Smtp-Source: AFSGD/Udl/35lOXq1/H9bztfv7yJ7/4vBfeV6MUNoD3ykzgYozCFflYBGFK5Htp4/ePznzc77G2C9g==
X-Received: by 2002:a1c:1903:: with SMTP id 3-v6mr6873079wmz.141.1543823223376;
        Sun, 02 Dec 2018 23:47:03 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j76sm19059873wmf.26.2018.12.02.23.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 23:47:02 -0800 (PST)
Date:   Mon, 3 Dec 2018 08:47:00 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chanho Min <chanho.min@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181203074700.GA21240@gmail.com>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The patch stats this week look a little bit more normal than last tim,
> probably simply because it's also a normal-sized rc4 rather than the
> unusually small rc3.

So there's a new regression in v4.20-rc4, my desktop produces this 
lockdep splat:

[ 1772.588771] WARNING: pkexec/4633 still has locks held!
[ 1772.588773] 4.20.0-rc4-custom-00213-g93a49841322b #1 Not tainted
[ 1772.588775] ------------------------------------
[ 1772.588776] 1 lock held by pkexec/4633:
[ 1772.588778]  #0: 00000000ed85fbf8 (&sig->cred_guard_mutex){+.+.}, at: prepare_bprm_creds+0x2a/0x70
[ 1772.588786] stack backtrace:
[ 1772.588789] CPU: 7 PID: 4633 Comm: pkexec Not tainted 4.20.0-rc4-custom-00213-g93a49841322b #1
[ 1772.588792] Call Trace:
[ 1772.588800]  dump_stack+0x85/0xcb
[ 1772.588803]  flush_old_exec+0x116/0x890
[ 1772.588807]  ? load_elf_phdrs+0x72/0xb0
[ 1772.588809]  load_elf_binary+0x291/0x1620
[ 1772.588815]  ? sched_clock+0x5/0x10
[ 1772.588817]  ? search_binary_handler+0x6d/0x240
[ 1772.588820]  search_binary_handler+0x80/0x240
[ 1772.588823]  load_script+0x201/0x220
[ 1772.588825]  search_binary_handler+0x80/0x240
[ 1772.588828]  __do_execve_file.isra.32+0x7d2/0xa60
[ 1772.588832]  ? strncpy_from_user+0x40/0x180
[ 1772.588835]  __x64_sys_execve+0x34/0x40
[ 1772.588838]  do_syscall_64+0x60/0x1c0

The warning gets triggered by an ancient lockdep check in the freezer:

(gdb) list *0xffffffff812ece06
0xffffffff812ece06 is in flush_old_exec (./include/linux/freezer.h:57).
52	 * DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION
53	 * If try_to_freeze causes a lockdep warning it means the caller may deadlock
54	 */
55	static inline bool try_to_freeze_unsafe(void)
56	{
57		might_sleep();
58		if (likely(!freezing(current)))
59			return false;
60		return __refrigerator(false);
61	}

I reviewed the ->cred_guard_mutex code, and the mutex is held across all 
of exec() - and we always did this.

But there's this recent -rc4 commit:

> Chanho Min (1):
>       exec: make de_thread() freezable

  c22397888f1e: exec: make de_thread() freezable

I believe this commit is bogus, you cannot call try_to_freeze() from 
de_thread(), because it's holding the ->cred_guard_mutex.

Also, I'm 3 times grumpy:

 #1: I think this commit was never tested with lockdep turned on, as I 
     think splat this should trigger 100% of the time with the ELF 
     binfmt loader.

 #2: Less than 4 days passed between the commit on Nov 19 and it being 
     upstream by Nov 23. *Please* give it more testing if you change 
     something as central as fs/exec.c ...

 #3  Also, please also proof-read changelogs before committing them:

     >>  The casue is that de_thread() sleeps in TASK_UNINTERRUPTIBLE waiting for
     >>  [...]
     >>
     >>  In our machine, it causes freeze timeout as bellows.

     That's *three* typos in a single commit:

        s/casue/cause
        s/In our/On our
        s/bellows/below

     ...

Grump! :-)

Note that I haven't tested the revert yet, but the code and the breakage 
looks pretty obvious. (I'll boot the revert, will follow up if that 
didn't solve the problem.)

Thanks,

	Ingo

Signed-off-by: Ingo Molnar <mingo@kernel.org>

This reverts commit c22397888f1eed98cd59f0a88f2a5f6925f80e15.
---
 fs/exec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index acc3a5536384..fc281b738a98 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -62,7 +62,6 @@
 #include <linux/oom.h>
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
-#include <linux/freezer.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1084,7 +1083,7 @@ static int de_thread(struct task_struct *tsk)
 	while (sig->notify_count) {
 		__set_current_state(TASK_KILLABLE);
 		spin_unlock_irq(lock);
-		freezable_schedule();
+		schedule();
 		if (unlikely(__fatal_signal_pending(tsk)))
 			goto killed;
 		spin_lock_irq(lock);
@@ -1112,7 +1111,7 @@ static int de_thread(struct task_struct *tsk)
 			__set_current_state(TASK_KILLABLE);
 			write_unlock_irq(&tasklist_lock);
 			cgroup_threadgroup_change_end(tsk);
-			freezable_schedule();
+			schedule();
 			if (unlikely(__fatal_signal_pending(tsk)))
 				goto killed;
 		}
