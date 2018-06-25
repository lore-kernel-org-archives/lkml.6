Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A21C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E52C256A1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n60vIbxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E52C256A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754988AbeFYJWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:22:11 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33053 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754948AbeFYJWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:22:08 -0400
Received: by mail-pg0-f66.google.com with SMTP id e11-v6so5811763pgq.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0rBVRrLTZF7ZsJZeFcrLp8op/Z/fwAcvcAhewP4yinI=;
        b=n60vIbxwjkhOWtMY1/6F3U7e4N/kKNvWO6OugNMShrwUgC56kiOcTtUjL2GJTM2KnM
         H5UKffNOSYEtXXC4Bvl9G1iP3ooMXz44ibXJcXz+I9g4FERMNm40IBrDEA/R48s5P7kU
         WQbMeu3WGjkFBsXL33LhxQXLKc16cfdb9gzRiz/xAZ6U4Yd7Npxc3jNW5T/kgLmVEMfC
         A/TRMf/jl5rvQ3gnEtowPkHToFee8PERA9GAy3OPKHMUgVe3E4Qw2zpjnz6yd/Hri+xp
         Eb7ymV+wk+gRgG7yqj4KVuOFxX0QlvASyHcyavaYV5/dUmgSi6Tng0wBtPxHZhq0X6Ht
         /lkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0rBVRrLTZF7ZsJZeFcrLp8op/Z/fwAcvcAhewP4yinI=;
        b=r7Z51obJ6lckNzFOha5BK3UOWhcui+MQQW7cFy8VUpUdiBplSpEkM5m9KhzgjlxKdc
         s6HHDi1oDAXl20s3CDJXAUwnx0HnVMKCK71uHSu7VReehUHPtsGTGxiSQVcfzDxbEHwn
         u8xjqHMGFQ8n5kyTvrWi9zxAABiWsvSWGVsJqmWzidxjttUm3JGkCiFo9jRWjEaQPqFY
         88ChDPFnsD50b7s/9sYkYoAzBXXzLn/KDez+wjeNhcqJJJw0xjwKxb6mBvz/3XlcT/z8
         y4aNoagpCb9elMLpG8gKRblZuxFSruv5N39hCHSnIheCtf+tyjXKzRhMAv1m8jlab6Jq
         n5aw==
X-Gm-Message-State: APt69E3CueZEYAlCT9aM7jscwoMkaT6LXztBCDSLjSmddOIiSW7r+4Ts
        +riSacAhzqjAgtWBLCyo7cG/HRd/2nvXqbiSY+OFSw==
X-Google-Smtp-Source: ADUXVKKpUQulm0gAan9I6gPsBsqPYxhCdXEIW49JBiXP5Nzxu69JtU9D0Phn+uhiCA1agSTwSB2BclVcreUNYqV0qxU=
X-Received: by 2002:a63:b407:: with SMTP id s7-v6mr10255612pgf.334.1529918527947;
 Mon, 25 Jun 2018 02:22:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 25 Jun 2018 02:21:47
 -0700 (PDT)
In-Reply-To: <20180624025651.bvjlcfulbmycz5bf@linux-r8p5>
References: <000000000000e403b3056e76c786@google.com> <20180624025651.bvjlcfulbmycz5bf@linux-r8p5>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 Jun 2018 11:21:47 +0200
Message-ID: <CACT4Y+anMTUCaRH5D4QoZR4bLdtH=_wtCxK2dM6isJozbVThDg@mail.gmail.com>
Subject: Re: ipc/msg: zalloc struct msg_queue when creating a new msq
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     syzbot <syzbot+2827ef6b3385deb07eaf@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        manfred <manfred@colorfullife.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 4:56 AM, Davidlohr Bueso <dave@stgolabs.net> wrote:
> The following splat was reported around the msg_queue structure
> which can have uninitialized fields left over after newque().
> Future syscalls which make use of the msq id (now valid) can thus
> make KMSAN complain because not all fields are explicitly initialized
> and we have the padding as well. This is internal to the kernel,
> hence no bogus leaks.

Hi Davidlohr,

As far as I understand the root problem is that (1) we publish a
not-fully initialized objects and (2) finish it's initialization in a
racy manner when other threads already have access to it. As the
result other threads can act on a wrong object. I am not sure that
zeroing the object really solves these problems. It will sure get rid
of the report at hand (but probably not of KTSAN, data race detector,
report), other threads still can see wrong 0 id and the id is still
initialized in racy way. I would expect that a proper fix would be to
publish a fully initialized object with proper, final id. Am I missing
something?



> ==================================================================
> BUG: KMSAN: uninit-value in do_msgrcv+0x509/0x1e30 ipc/msg.c:1048
> CPU: 0 PID: 4528 Comm: syz-executor852 Not tainted 4.17.0-rc5+ #103
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
>  kmsan_report+0x149/0x260 mm/kmsan/kmsan.c:1084
>  __msan_warning_32+0x6e/0xc0 mm/kmsan/kmsan_instr.c:686
>  do_msgrcv+0x509/0x1e30 ipc/msg.c:1048
>  ksys_msgrcv ipc/msg.c:1184 [inline]
>  __do_sys_msgrcv ipc/msg.c:1190 [inline]
>  __se_sys_msgrcv ipc/msg.c:1187 [inline]
>  __x64_sys_msgrcv+0x160/0x1b0 ipc/msg.c:1187
>  do_syscall_64+0x152/0x230 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x4459b9
> RSP: 002b:00007f0d57662db8 EFLAGS: 00000297 ORIG_RAX: 0000000000000046
> RAX: ffffffffffffffda RBX: 00000000006dac54 RCX: 00000000004459b9
> RDX: 00000000000000d0 RSI: 0000000020000000 RDI: 0000000000260007
> RBP: 00000000006dac50 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000000
> R13: 00007ffd5ab7e25f R14: 00007f0d576639c0 R15: 0000000000000006
>
> Uninit was created at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:279 [inline]
>  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:189
>  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:315
>  __kmalloc_node+0xe25/0x11f0 mm/slub.c:3865
>  kmalloc_node include/linux/slab.h:554 [inline]
>  kvmalloc_node+0x197/0x2f0 mm/util.c:421
>  kvmalloc include/linux/mm.h:550 [inline]
>  newque+0xb4/0x7d0 ipc/msg.c:139
>  ipcget_new ipc/util.c:315 [inline]
>  ipcget+0x27b/0xd90 ipc/util.c:653
>  ksys_msgget ipc/msg.c:289 [inline]
>  __do_sys_msgget ipc/msg.c:294 [inline]
>  __se_sys_msgget ipc/msg.c:292 [inline]
>  __x64_sys_msgget+0x14c/0x1d0 ipc/msg.c:292
>  do_syscall_64+0x152/0x230 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> ==================================================================
>
> Fix this by simply zero init the whole structure, something that
> sysvsems also do; this is safe as it's a nop, having no secondary
> effect afaict.
>
> Reported-by: syzbot <syzbot+2827ef6b3385deb07eaf@syzkaller.appspotmail.com>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
> ipc/msg.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ipc/msg.c b/ipc/msg.c
> index 62545ce19173..da81b374f9fd 100644
> --- a/ipc/msg.c
> +++ b/ipc/msg.c
> @@ -136,7 +136,7 @@ static int newque(struct ipc_namespace *ns, struct
> ipc_params *params)
>         key_t key = params->key;
>         int msgflg = params->flg;
>
> -       msq = kvmalloc(sizeof(*msq), GFP_KERNEL);
> +       msq = kvzalloc(sizeof(*msq), GFP_KERNEL);
>         if (unlikely(!msq))
>                 return -ENOMEM;
>
> --
> 2.16.4
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/20180624025651.bvjlcfulbmycz5bf%40linux-r8p5.
> For more options, visit https://groups.google.com/d/optout.
