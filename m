Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FDCC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 12:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD412184D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 12:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="KwKafbik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeLWMcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 07:32:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41068 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeLWMcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 07:32:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so9417682wrs.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 04:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=olMkFSjX+shZLOXDzDQn7xGkE6u3XFRL4mYR0/rKfA4=;
        b=KwKafbikhWJ1tFx3nd8h5QzpSscSqNOPbstu5/pwkvpY6pOhdv2OKHY0hmIzQ3gTaF
         oeqTmCXNLWtP+fcf/6J1ODg37fxuqFRRJoAC3zhTHCKrWG5JCXZ8l5J61UABXAkRL/2O
         A6eH35ruskmsKHvG8M5xBAD4SZvCYVSr5w3qc08lthklYjQDEqibeXz02wfPCgdf6wdi
         UnfabWNmKTx7gUJMbKAIeIIJEY0y5O6MqSvaQroXqC2UK4TTVrmDumjLFncJV3tf3Nci
         Inl/63l/KGtpVVNt1TwoQGXerEFVrX2v2VUpdIJStC240P1maTVRjMMva0FOW5EqXEMc
         aZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=olMkFSjX+shZLOXDzDQn7xGkE6u3XFRL4mYR0/rKfA4=;
        b=LXZDX/H2Ld7ZCDIstSCxW4onszII69C7bnmE0yh9weR1MdJB7Xru4fmy48Xw+QcqFb
         Ia7yKD1bIeoHm1oYNQO9aRGgtjr1nH5JVVIpQrNqKgaestdUnKgfrLnSZVbl3jfCEoVF
         m+CiiGAfQn0mBPtXTfSQtf/XlJ5rxc/kOtJJ9yQ68bYiLNVeaa+q5INrVfgtO4Twgl/k
         TJtw4rNd70MbPBb3xnBjcnGGjJAFmIPnUhNoQ8XQRXmWAu9Va2/RgFdNZV7JHs0eZ2oz
         dxFoR+Bl8fhL0dBAxMjAlGIdM33ZURbNQ1t2F2+10lHlzoTcHA8PWSwTNjQrf+rTcqIe
         LJ9Q==
X-Gm-Message-State: AJcUukdlgElGYGxzaivs7rMvKW2hOZfM8JiDdiW+qsUbjSeBvEq98tgT
        u1ZP1ddj1WLLuucG8S3kz8r5/g==
X-Google-Smtp-Source: ALg8bN6W1v/PqEMsT8lDM2G3rhhwrqqN+wPn4TVStvhtF274Ud3A5adxbC4d1E5G91VlNw0l/hhf6Q==
X-Received: by 2002:adf:f211:: with SMTP id p17mr8640687wro.293.1545568371369;
        Sun, 23 Dec 2018 04:32:51 -0800 (PST)
Received: from linux.fritz.box (p200300D993E1B70073C019066AB385FE.dip0.t-ipconnect.de. [2003:d9:93e1:b700:73c0:1906:6ab3:85fe])
        by smtp.googlemail.com with ESMTPSA id l20sm39355747wrb.93.2018.12.23.04.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 04:32:50 -0800 (PST)
Subject: Re: general protection fault in put_pid
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        ktsanaktsidis@zendesk.com, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <00000000000051ee78057cc4d98f@google.com>
 <CACT4Y+YX3=OLqfmWwhHVCQz+HwE=53VH9c1E2M+rgbF=UVTV5A@mail.gmail.com>
 <ab2fb696-8d3b-9720-a8a0-99c66a080605@colorfullife.com>
 <CACT4Y+Y-c7FgSTKyHqpRZu3eKLo5QfXy10axTSwWkU4MUgjFgw@mail.gmail.com>
 <87614226-e895-c3a3-3626-b0fbe7e191be@colorfullife.com>
 <CACT4Y+bU4mLF1tEhw6mKf1m1W63OGvaFhAsTrpTW0M5MFXekRQ@mail.gmail.com>
 <CACT4Y+Zynq-URqgJNyCZyTPM80GU8DndtKv=BFDU9_U=f0KceA@mail.gmail.com>
 <CACT4Y+ZitcDg=OA8NbJJTWQyHHzmiZ7rFekFkgxmdOOnSKTfXg@mail.gmail.com>
 <CACT4Y+bUYDEEdB-WrWc2gdzuQ-xOSoCZxzT7faNd3_ENnxFNnQ@mail.gmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <f4eaca71-09f6-3c21-258c-336d1b56d38c@colorfullife.com>
Date:   Sun, 23 Dec 2018 13:32:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bUYDEEdB-WrWc2gdzuQ-xOSoCZxzT7faNd3_ENnxFNnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

let's simplify the mail, otherwise noone can follow:

On 12/23/18 11:42 AM, Dmitry Vyukov wrote:
>
>> My naive attempts to re-reproduce this failed so far.
>> But I noticed that _all_ logs for these 3 crashes:
>> https://syzkaller.appspot.com/bug?extid=c92d3646e35bc5d1a909
>> https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac
>> https://syzkaller.appspot.com/bug?extid=9d8b6fa6ee7636f350c1
>> involve low memory conditions. My gut feeling says this is not a
>> coincidence. This is also probably the reason why all reproducers
>> create large sem sets. There must be some bad interaction between low
>> memory condition and semaphores/ipc namespaces.
>
> Actually was able to reproduce this with a syzkaller program:
>
> ./syz-execprog -repeat=0 -procs=10 prog
> ...
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 8788 Comm: syz-executor8 Not tainted 4.20.0-rc7+ #6
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> RIP: 0010:__list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51
> Code: ad de 4c 8b 26 49 39 c4 74 66 48 b8 00 02 00 00 00 00 ad de 48
> 89 da 48 39 c3 74 65 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
> 02 00 75 7b 48 8b 13 48 39 f2 75 57 49 8d 7c 24 08 48 b8 00
> RSP: 0018:ffff88804faef210 EFLAGS: 00010a02
> RAX: dffffc0000000000 RBX: f817edba555e1f00 RCX: ffffffff831bad5f
> RDX: 1f02fdb74aabc3e0 RSI: ffff88801b8a0720 RDI: ffff88801b8a0728
> RBP: ffff88804faef228 R08: fffff52001055401 R09: fffff52001055401
> R10: 0000000000000001 R11: fffff52001055400 R12: ffff88802d52cc98
> R13: ffff88801b8a0728 R14: ffff88801b8a0720 R15: dffffc0000000000
> FS:  0000000000d24940(0000) GS:ffff88802d500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004bb580 CR3: 0000000011177005 CR4: 00000000003606e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   __list_del_entry include/linux/list.h:117 [inline]
>   list_del include/linux/list.h:125 [inline]
>   unlink_queue ipc/sem.c:786 [inline]
>   freeary+0xddb/0x1c90 ipc/sem.c:1164
>   free_ipcs+0xf0/0x160 ipc/namespace.c:112
>   sem_exit_ns+0x20/0x40 ipc/sem.c:237
>   free_ipc_ns ipc/namespace.c:120 [inline]
>   put_ipc_ns+0x55/0x160 ipc/namespace.c:152
>   free_nsproxy+0xc0/0x1f0 kernel/nsproxy.c:180
>   switch_task_namespaces+0xa5/0xc0 kernel/nsproxy.c:229
>   exit_task_namespaces+0x17/0x20 kernel/nsproxy.c:234
>   do_exit+0x19e5/0x27d0 kernel/exit.c:866
>   do_group_exit+0x151/0x410 kernel/exit.c:970
>   __do_sys_exit_group kernel/exit.c:981 [inline]
>   __se_sys_exit_group kernel/exit.c:979 [inline]
>   __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
>   do_syscall_64+0x192/0x770 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4570e9
> Code: 5d af fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 0f 83 2b af fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffe35f12018 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00000000004570e9
> RDX: 0000000000410540 RSI: 0000000000a34c00 RDI: 0000000000000045
> RBP: 00000000004a43a4 R08: 000000000000000c R09: 0000000000000000
> R10: 0000000000d24940 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000008
> Modules linked in:
> Dumping ftrace buffer:
>     (ftrace buffer empty)
> ---[ end trace 17829b0f00569a59 ]---
> RIP: 0010:__list_del_entry_valid+0x7e/0x150 lib/list_debug.c:51
> Code: ad de 4c 8b 26 49 39 c4 74 66 48 b8 00 02 00 00 00 00 ad de 48
> 89 da 48 39 c3 74 65 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
> 02 00 75 7b 48 8b 13 48 39 f2 75 57 49 8d 7c 24 08 48 b8 00
> RSP: 0018:ffff88804faef210 EFLAGS: 00010a02
> RAX: dffffc0000000000 RBX: f817edba555e1f00 RCX: ffffffff831bad5f
> RDX: 1f02fdb74aabc3e0 RSI: ffff88801b8a0720 RDI: ffff88801b8a0728
> RBP: ffff88804faef228 R08: fffff52001055401 R09: fffff52001055401
> R10: 0000000000000001 R11: fffff52001055400 R12: ffff88802d52cc98
> R13: ffff88801b8a0728 R14: ffff88801b8a0720 R15: dffffc0000000000
> FS:  0000000000d24940(0000) GS:ffff88802d500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004bb580 CR3: 0000000011177005 CR4: 00000000003606e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> The prog is:
> unshare(0x8020000)
> semget$private(0x0, 0x4007, 0x0)
>
> kernel is on 9105b8aa50c182371533fc97db64fc8f26f051b3
>
> and again it involved lots of oom kills, the repro eats all memory, a
> process getting killed, frees some memory and the process repeats.

Ok, thus the above program triggers two bugs:

- a huge memory leak with semaphore arrays

- under OOM pressure, an oops.


1) I can reproduce the memory leak, it happens all the time :-(

I must look what is wrong.

2) regarding the crash:

What differs under oom pressure?

- kvmalloc can fall back to vmalloc()

- the 2nd or 3rd of multiple allocations can fail, and that triggers a 
rare codepath/race condition.

- rcu callback can happen earlier that expected


So far, I didn't notice anything unexpected :-(


--

     Manfred

