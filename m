Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EBAC65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42992084D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aFWdJyRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42992084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJFUKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 16:10:07 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34891 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbeJFUKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 16:10:07 -0400
Received: by mail-it1-f196.google.com with SMTP id p64-v6so6454150itp.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 06:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sArb+o4nGlB/1R00j0WQLW0cVei1gVT2Mda1Wfvw11I=;
        b=aFWdJyRTcLc/m8TFxNxGpbFA0hTye83kQRqy7SgI4j4w5U15LfkErRF0YakkbovMq6
         0ck3QFh+C+vyesq2Va4i2qbdNb4Lh0imeBf3bRajjKzroBR5YNNqNiz+JeSxy5k1h6C5
         7Utu9dduJCY1oSCck8H1quxA2qHz3qJlYY2STTd1dydLWHOrVTjV3S927J2xKkb89/B9
         H8Gw0+CZxp/cM+Iw9FFx0g3EstPBXdjlEY1RaDj8yvSLoed8PQj/z4GqgLFhOsvrZ4Tx
         m2vBErSGlcph/Ymfl9fFjKyh5aVUZqzHQ+e9PSEtK3TWYsSSXuLJ9crOnAmPmAJmDPCA
         zhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sArb+o4nGlB/1R00j0WQLW0cVei1gVT2Mda1Wfvw11I=;
        b=q/to4Ax4yQIkZKJhEiDaUMkG2XNwALsE0zhUa6KtzOtX7rxgMbvoy/Fz8TL6hd9CLC
         PJ+N7CdyRuNwl5DgtAlK7JBvBfhylkqsJejpUXfrLCRNkhROQXYVt2JVrUC4paYPNkZq
         g9WZ+MR9U67+pJZnTLZ19jDYZHXa/PMfd6tR/0wFw0ubUFtzoSxMcMTuAZmM5abFiXwC
         s5IdMiOZDertYpR0QVe7Xl1yQ0haVzpL/4e8WVUXCOEC873KVS6Y3ngrIz8A+6uw42rj
         fnz4iiGQEiOwUlH5jb8faDyAJHpFNwDxV02e3IR0QUFE3M4FPHuHak1y7Tbr1NhtlskR
         46lA==
X-Gm-Message-State: ABuFfogOH55uCNNjFFfznBlxLUSDW/lRYdy800mXvTpUNyMyiAnZhTSC
        aoGnmnrtkgSdtKxyxcdge74vSJYsd0b2Ss67piemiQ==
X-Google-Smtp-Source: ACcGV63oeF5QSf0KkS6EahL8bPh7gccaugrBFMdViemcl3Jgeh84AMXCRhZE/RZsO2Is5D+dadkAxVzT4lRA4nxKbNk=
X-Received: by 2002:a02:97c5:: with SMTP id v5-v6mr11637134jaj.72.1538831211195;
 Sat, 06 Oct 2018 06:06:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Sat, 6 Oct 2018 06:06:30 -0700 (PDT)
In-Reply-To: <20181005223206.GA184636@gmail.com>
References: <0000000000002e9bdb0576c70441@google.com> <20181005223206.GA184636@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 6 Oct 2018 15:06:30 +0200
Message-ID: <CACT4Y+aVZTpjzMzPQ2Rtgx_cRjXdwJG7BaAEO78UAitm-AnptA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in sha1_mb_mgr_get_comp_job_avx2
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+87dbe4b17debcec16d71@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, megha.dey@linux.intel.com,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        tim.c.chen@linux.intel.com,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 6, 2018 at 12:32 AM, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, Sep 26, 2018 at 07:27:04AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    a38523185b40 erge tag 'libnvdimm-fixes-4.19-rc6' of git://..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1767b7fa400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=87dbe4b17debcec16d71
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+87dbe4b17debcec16d71@syzkaller.appspotmail.com
>>
>> BUG: unable to handle kernel NULL pointer dereference at 0000000000000034
>> PGD 1b8b87067 P4D 1b8b87067 PUD 1b8b88067 PMD 0
>> Oops: 0002 [#1] PREEMPT SMP KASAN
>> CPU: 1 PID: 24 Comm: kworker/1:1 Not tainted 4.19.0-rc5+ #32
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Workqueue: crypto mcryptd_flusher
>> RIP: 0010:sha1_mb_mgr_get_comp_job_avx2+0x62/0xba
>> arch/x86/crypto/sha1-mb/sha1_mb_mgr_flush_avx2.S:256
>> Code: 04 c4 e2 69 3b d3 c4 c1 79 7e d0 49 f7 c0 f0 ff ff ff 75 6e 49 6b d8
>> 08 48 8d 9c 1f 08 01 00 00 48 8b 03 48 c7 03 00 00 00 00 <c7> 40 34 02 00 00
>> 00 48 8b 9f 00 01 00 00 48 c1 e3 04 4c 09 c3 48
>> kobject: 'loop1' (00000000307f8c2f): kobject_uevent_env
>> RSP: 0018:ffff8801d94473c0 EFLAGS: 00010206
>> RAX: 0000000000000000 RBX: ffff8801d4818688 RCX: 1ffff1003b2869e1
>> RDX: 1ffffd1ffffa2591 RSI: ffffffff81454f3a RDI: ffff8801d4818580
>> RBP: ffff8801d9447520 R08: 0000000000000000 R09: 0000000000000006
>> kobject: 'loop1' (00000000307f8c2f): fill_kobj_path: path =
>> '/devices/virtual/block/loop1'
>> R10: 0000000000000000 R11: ffff8801d9434640 R12: ffff8801d94474f8
>> R13: 0000000000000001 R14: ffff8801bb509720 R15: 0000000000000200
>> FS:  0000000000000000(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> kobject: 'loop4' (00000000fa342cfc): kobject_uevent_env
>> CR2: 0000000000000034 CR3: 00000001b8b85000 CR4: 00000000001406e0
>> kobject: 'loop4' (00000000fa342cfc): fill_kobj_path: path =
>> '/devices/virtual/block/loop4'
>> Call Trace:
>>  sha1_mb_flusher+0x2f4/0x60b arch/x86/crypto/sha1-mb/sha1_mb.c:918
>>  mcryptd_flusher+0x3af/0x520 crypto/mcryptd.c:208
>>  process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
>>  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
>>  kthread+0x35a/0x420 kernel/kthread.c:246
>>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
>> Modules linked in:
>> CR2: 0000000000000034
>> ---[ end trace 7d3a48e5625a9543 ]---
>> RIP: 0010:sha1_mb_mgr_get_comp_job_avx2+0x62/0xba
>> arch/x86/crypto/sha1-mb/sha1_mb_mgr_flush_avx2.S:256
>> Code: 04 c4 e2 69 3b d3 c4 c1 79 7e d0 49 f7 c0 f0 ff ff ff 75 6e 49 6b d8
>> 08 48 8d 9c 1f 08 01 00 00 48 8b 03 48 c7 03 00 00 00 00 <c7> 40 34 02 00 00
>> 00 48 8b 9f 00 01 00 00 48 c1 e3 04 4c 09 c3 48
>> RSP: 0018:ffff8801d94473c0 EFLAGS: 00010206
>> RAX: 0000000000000000 RBX: ffff8801d4818688 RCX: 1ffff1003b2869e1
>> RDX: 1ffffd1ffffa2591 RSI: ffffffff81454f3a RDI: ffff8801d4818580
>> RBP: ffff8801d9447520 R08: 0000000000000000 R09: 0000000000000006
>> R10: 0000000000000000 R11: ffff8801d9434640 R12: ffff8801d94474f8
>> R13: 0000000000000001 R14: ffff8801bb509720 R15: 0000000000000200
>> FS:  0000000000000000(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000000034 CR3: 00000001b8b85000 CR4: 00000000001406e0
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
>> syzbot.
>
> The "fix" for this is queued in cryptodev:
>
> #syz fix: crypto: x86 - remove SHA multibuffer routines and mcryptd

That's the best type of fix! :)
