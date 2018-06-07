Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Qee2JriEGVudHQAAmS7hNA
	; Thu, 07 Jun 2018 19:17:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 74BFB606DD; Thu,  7 Jun 2018 19:17:12 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5hp1pVF"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Flag: YES
X-Spam-Level: ***
X-Spam-Status: Yes, score=3.4 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	SORTED_RECIPS autolearn=no autolearn_force=no version=3.4.0
X-Spam-Report: 
	*  3.9 FSL_HELO_FAKE No description available.
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      (ebiggers3[at]gmail.com)
	*  2.5 SORTED_RECIPS Recipient list is sorted by address
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -1.0 MAILING_LIST_MULTI Multiple indicators imply a widely-seen list
	*      manager
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 99A046063F;
	Thu,  7 Jun 2018 19:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99A046063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbeFGTRJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:17:09 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32840 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeFGTRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:17:07 -0400
Received: by mail-pf0-f195.google.com with SMTP id b17-v6so5381898pfi.0;
        Thu, 07 Jun 2018 12:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6CWf0nzLTlSY6aZqpN7Q1kkauFeGWagbahtOP6+rysc=;
        b=o5hp1pVF2vz9Wu9Fnd/oL9yphZdoemh/Om2049QWIdzeTHeGYVdmsJiKkqh3dnTT5s
         PTEfwR9bMSuV+ZbqVT/E5BB3jqu3/JuPgHKiEGzNHQbg+YRDg08XtJF5HPlXzMBdvJJc
         h72/tt03kBhjDCvReGOY0w8kSoAzNPQn/lnYmB+8JJCkNsgSKECOymB5vIJqCrm5mHvG
         ylLf7vW/wjm/ZFjOHLY+n22aWc4ZdrIi2dS7c1g+IhvRVrtXQPjS9UciYhcQ49EuI+4L
         WslNfmGzRY5KyxfbGogamZzpeyn0d33kRhOdYfRscM2Ng6LchGIRjC3l5gaQwkGZgK5/
         HlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6CWf0nzLTlSY6aZqpN7Q1kkauFeGWagbahtOP6+rysc=;
        b=PXC4x+Qbv2ccQZz717SpuuslMlO+ugrNROs56UkmntxrgtzG95lbOrPHDQEyQrU5A1
         x/FemQLRHbeT9b2Ha+ACaANNLDI2JIoHBz3sd3TmYYBr2KGiEtK0/e66jV0Y+mZAiELJ
         F9K34nsnH2eS3mKeczRm/qUc7G3MbA/0h1wSl6n3iAuQhydIJ3oespZM1OfObEsT64C+
         MyC14+GADerJa4eFtNxDA6QWEoJWYEW/C73vqsQGLGwnat2T7Hk5R9U1w0HaEhX42ugb
         09hDrpjRENRba6qGZtTvodgxt9eU/mVjpZxVp3HyBhhfu8OF5H4IcvLbZvoFz41SvQjh
         Mvfg==
X-Gm-Message-State: APt69E0nvvgQXXyYN6peHGDOLlv5/fzwFo6mnEUP/ZAsXIQQv2ubVuyp
        0X3hyqV2lWJUA+5DPE7BULY=
X-Google-Smtp-Source: ADUXVKIj3NoqNVnzW3+n8dpImnZhJ33zSasyU866oG/aHZRtOk++93iO0sGQTXKSm+Au8uFz8U462w==
X-Received: by 2002:a63:9702:: with SMTP id n2-v6mr2582952pge.88.1528399026645;
        Thu, 07 Jun 2018 12:17:06 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id y7-v6sm94100811pfy.52.2018.06.07.12.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 12:17:06 -0700 (PDT)
Date: Thu, 7 Jun 2018 12:17:04 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <syzbot+29d17b7898b41ee120a5@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, herbert@gondor.apana.org.au, hpa@zytor.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: KASAN: slab-out-of-bounds Write in sha256_finup
Message-ID: <20180607191704.GA29665@gmail.com>
References: <0000000000009913f4056e0cf508@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009913f4056e0cf508@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 06:07:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    1c8c5a9d38f6 Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11289b9f800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2e1a31e8576e013a
> dashboard link: https://syzkaller.appspot.com/bug?extid=29d17b7898b41ee120a5
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=146fbb9f800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119de79f800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+29d17b7898b41ee120a5@syzkaller.appspotmail.com
> 
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in put_unaligned_be32
> include/linux/unaligned/access_ok.h:60 [inline]
> BUG: KASAN: slab-out-of-bounds in sha256_base_finish
> include/crypto/sha256_base.h:124 [inline]
> BUG: KASAN: slab-out-of-bounds in sha256_finup+0x4bf/0x540
> arch/x86/crypto/sha256_ssse3_glue.c:80
> Write of size 4 at addr ffff8801b39b2ca0 by task syz-executor364/4468
> 
> CPU: 0 PID: 4468 Comm: syz-executor364 Not tainted 4.17.0+ #88
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_store4_noabort+0x17/0x20 mm/kasan/report.c:437
>  put_unaligned_be32 include/linux/unaligned/access_ok.h:60 [inline]
>  sha256_base_finish include/crypto/sha256_base.h:124 [inline]
>  sha256_finup+0x4bf/0x540 arch/x86/crypto/sha256_ssse3_glue.c:80
>  sha256_avx_finup arch/x86/crypto/sha256_ssse3_glue.c:161 [inline]
>  sha256_avx_final+0x28/0x30 arch/x86/crypto/sha256_ssse3_glue.c:166
>  crypto_shash_final+0x104/0x260 crypto/shash.c:152
>  kdf_ctr security/keys/dh.c:186 [inline]
>  keyctl_dh_compute_kdf security/keys/dh.c:217 [inline]
>  __keyctl_dh_compute+0x1184/0x1bc0 security/keys/dh.c:389
>  keyctl_dh_compute+0xb9/0x100 security/keys/dh.c:425
>  __do_sys_keyctl security/keys/keyctl.c:1741 [inline]
>  __se_sys_keyctl security/keys/keyctl.c:1637 [inline]
>  __x64_sys_keyctl+0x12a/0x3b0 security/keys/keyctl.c:1637
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440019
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 6b 45 00 00 c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffcb5a0db48 EFLAGS: 00000217 ORIG_RAX: 00000000000000fa
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440019
> RDX: 0000000020a53ffb RSI: 0000000020000100 RDI: 0000000000000017
> RBP: 00000000006ca018 R08: 0000000020c61fc8 R09: 00000000004002c8
> R10: 0000000000000005 R11: 0000000000000217 R12: 0000000000401940
> R13: 00000000004019d0 R14: 0000000000000000 R15: 0000000000000000
> 
> Allocated by task 4468:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  __do_kmalloc mm/slab.c:3718 [inline]
>  __kmalloc+0x14e/0x760 mm/slab.c:3727
>  kmalloc include/linux/slab.h:518 [inline]
>  keyctl_dh_compute_kdf security/keys/dh.c:211 [inline]
>  __keyctl_dh_compute+0xfe9/0x1bc0 security/keys/dh.c:389
>  keyctl_dh_compute+0xb9/0x100 security/keys/dh.c:425
>  __do_sys_keyctl security/keys/keyctl.c:1741 [inline]
>  __se_sys_keyctl security/keys/keyctl.c:1637 [inline]
>  __x64_sys_keyctl+0x12a/0x3b0 security/keys/keyctl.c:1637
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 2842:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3813
>  single_release+0x8f/0xb0 fs/seq_file.c:609
>  __fput+0x353/0x890 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x1e4/0x290 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
>  exit_to_usermode_loop+0x2bd/0x310 arch/x86/entry/common.c:166
>  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>  do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> The buggy address belongs to the object at ffff8801b39b2c80
>  which belongs to the cache kmalloc-32 of size 32
> The buggy address is located 0 bytes to the right of
>  32-byte region [ffff8801b39b2c80, ffff8801b39b2ca0)
> The buggy address belongs to the page:
> page:ffffea0006ce6c80 count:1 mapcount:0 mapping:ffff8801b39b2000
> index:0xffff8801b39b2fc1
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801b39b2000 ffff8801b39b2fc1 0000000100000039
> raw: ffffea00075c03a0 ffffea000764c620 ffff8801da8001c0 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801b39b2b80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
>  ffff8801b39b2c00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> > ffff8801b39b2c80: 00 00 00 00 fc fc fc fc fb fb fb fb fc fc fc fc
>                                ^
>  ffff8801b39b2d00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
>  ffff8801b39b2d80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ==================================================================
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
> 
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000009913f4056e0cf508%40google.com.
> For more options, visit https://groups.google.com/d/optout.

Duplicate:

#syz dup: KASAN: slab-out-of-bounds Write in sha1_finup

Tentative fix is "[PATCH] dh key: fix rounding up KDF output length".
