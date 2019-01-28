Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D34BC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409232147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W0dxgfhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfA1ReE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:34:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38065 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbfA1ReA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:34:00 -0500
Received: by mail-lf1-f68.google.com with SMTP id a8so12485082lfk.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 09:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFDYS/TE9ERsAbfvybfOq/tSngwJltMjuujQp8mS1GM=;
        b=W0dxgfhYnlLFtHe+Y7NSynOAnat+UXpgtKlPISfrrIffUrUFqTzuxG0HBRxw+PHueX
         CnfQjnvd9S5HvvJPJUjMCyQgqimgcidRJH70s+zKn+TnNIZg4PlBZEZxzrTwNE9wPwVA
         uxUnWH36CvR9co4qrcXQ9vgsAXDPC4N42SLOBbQrAlspXu1vj/51Kg+14pvrgOtBoOoI
         cUrxn1TOWifk5/ynsvAR+CKWyTV3MG9ngHHkFJfZugbU5Fe8F4KnzOxxKkDm8KSfB4c9
         X1d9NC4ujzmZa/3GRrA9UcIgw/Gdqu29eLSq7v5Yz/fIgv4M6cGOcyw7tjri2ruzxd/5
         Xqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFDYS/TE9ERsAbfvybfOq/tSngwJltMjuujQp8mS1GM=;
        b=YZAxkpdZ4VZWgJK765XlOtjijqc8IrvexK+Qkb/uqbcm7k6IyCHwOCAiV19ZK0b3Eh
         SDNcCEILUmjxWgKlYsvZaq8FvcvesVkz5KvMhHUXUgQc27WvDVJPDIXW72t8QQdvLZky
         UozCd4d0xhTbOMnAhXPyqvwdUx6ldEJ0GzUNSR+nRmEDtFymcdN+dMgMzv3hYH6C0m8P
         UkrYoWIyRZo7C5KjKVL0kTVxajcFotHorkel5jEQlmZ0qRwaAQ9ebXwyx9qa8HwTK/xD
         i+BigA1nuiawIkzH6bQTKdQJWMko2FWkFktV7k624cFc0VE41mABt3B0p/cuU+fShMad
         0TkQ==
X-Gm-Message-State: AJcUukeGlUICYNTiu13zGjqlLsJLFMV8pbso8qP4GeRuW+hQzgJn5xbh
        b8se5AM8Uzt1j7ZCf0iuhF336nlhl4aRF9WITuMdvcSt9hU=
X-Google-Smtp-Source: ALg8bN5RROg7qCOCY0G0QoPeg/pj9LPMDuyomeQhTko/oKZcTh4I9O7OjyDGktsX2hX3BGZhzTYSOIaGbNaSL18+kgA=
X-Received: by 2002:a19:54d7:: with SMTP id b84mr17459499lfl.131.1548696837311;
 Mon, 28 Jan 2019 09:33:57 -0800 (PST)
MIME-Version: 1.0
References: <20190126102320.14120-1-christian@brauner.io>
In-Reply-To: <20190126102320.14120-1-christian@brauner.io>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 28 Jan 2019 09:33:45 -0800
Message-ID: <CAHRSSEw_JJ6L1nsGj-AOeXzTJiMmKaqDjVQZfu6uCik9cJHMGg@mail.gmail.com>
Subject: Re: [PATCH] binder: fix CONFIG_ANDROID_BINDER_DEVICES
To:     Christian Brauner <christian@brauner.io>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>, joel@joelfernandes.org,
        Martijn Coenen <maco@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 2:23 AM Christian Brauner <christian@brauner.io> wrote:
>
> Several users have tried to only rely on binderfs to provide binder devices
> and set CONFIG_ANDROID_BINDER_DEVICES="" empty. This is a great use-case of
> binderfs and one that was always intended to work. However, this is
> currently not possible since setting CONFIG_ANDROID_BINDER_DEVICES="" emtpy
> will simply panic the kernel:
>
> kobject: (00000000028c2f79): attempted to be registered with empty name!
> WARNING: CPU: 7 PID: 1703 at lib/kobject.c:228 kobject_add_internal+0x288/0x2b0
> Modules linked in: binder_linux(+) bridge stp llc ipmi_ssif gpio_ich dcdbas coretemp kvm_intel kvm irqbypass serio_raw input_leds lpc_ich i5100_edac mac_hid ipmi_si ipmi_devintf ipmi_msghandler sch_fq_codel ib_i
> CPU: 7 PID: 1703 Comm: modprobe Not tainted 5.0.0-rc2-brauner-binderfs #263
> Hardware name: Dell      DCS XS24-SC2          /XS24-SC2              , BIOS S59_3C20 04/07/2011
> RIP: 0010:kobject_add_internal+0x288/0x2b0
> Code: 12 95 48 c7 c7 78 63 3b 95 e8 77 35 71 ff e9 91 fe ff ff 0f 0b eb a7 0f 0b eb 9a 48 89 de 48 c7 c7 00 63 3b 95 e8 f8 95 6a ff <0f> 0b 41 bc ea ff ff ff e9 6d fe ff ff 41 bc fe ff ff ff e9 62 fe
> RSP: 0018:ffff973f84237a30 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff8b53e2472010 RCX: 0000000000000006
> RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff8b53edbd63a0
> RBP: ffff973f84237a60 R08: 0000000000000342 R09: 0000000000000004
> R10: ffff973f84237af0 R11: 0000000000000001 R12: 0000000000000000
> R13: ffff8b53e9f1a1e0 R14: 00000000e9f1a1e0 R15: 0000000000a00037
> FS:  00007fbac36f7540(0000) GS:ffff8b53edbc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fbac364cfa7 CR3: 00000004a6d48000 CR4: 00000000000406e0
> Call Trace:
>  kobject_add+0x71/0xd0
>  ? _cond_resched+0x19/0x40
>  ? mutex_lock+0x12/0x40
>  device_add+0x12e/0x6b0
>  device_create_groups_vargs+0xe4/0xf0
>  device_create_with_groups+0x3f/0x60
>  ? _cond_resched+0x19/0x40
>  misc_register+0x140/0x180
>  binder_init+0x1ed/0x2d4 [binder_linux]
>  ? trace_event_define_fields_binder_transaction_fd_send+0x8e/0x8e [binder_linux]
>  do_one_initcall+0x4a/0x1c9
>  ? _cond_resched+0x19/0x40
>  ? kmem_cache_alloc_trace+0x151/0x1c0
>  do_init_module+0x5f/0x216
>  load_module+0x223d/0x2b20
>  __do_sys_finit_module+0xfc/0x120
>  ? __do_sys_finit_module+0xfc/0x120
>  __x64_sys_finit_module+0x1a/0x20
>  do_syscall_64+0x5a/0x120
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fbac3202839
> Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffd1494a908 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 000055b629ebec60 RCX: 00007fbac3202839
> RDX: 0000000000000000 RSI: 000055b629c20d2e RDI: 0000000000000003
> RBP: 000055b629c20d2e R08: 0000000000000000 R09: 000055b629ec2310
> R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> R13: 000055b629ebed70 R14: 0000000000040000 R15: 000055b629ebec60
>
> So check for the empty string since strsep() will otherwise return the
> emtpy string which will cause kobject_add_internal() to panic when trying
> to add a kobject with an emtpy name.
>
> Fixes: ac4812c5ffbb ("binder: Support multiple /dev instances")
> Cc: Martijn Coenen <maco@google.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 751d76173f81..5f7d6fe06eec 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5898,21 +5898,23 @@ static int __init binder_init(void)
>                                     &transaction_log_fops);
>         }
>
> -       /*
> -        * Copy the module_parameter string, because we don't want to
> -        * tokenize it in-place.
> -        */
> -       device_names = kstrdup(binder_devices_param, GFP_KERNEL);
> -       if (!device_names) {
> -               ret = -ENOMEM;
> -               goto err_alloc_device_names_failed;
> -       }
> +       if (strcmp(binder_devices_param, "") != 0) {
> +               /*
> +               * Copy the module_parameter string, because we don't want to
> +               * tokenize it in-place.
> +                */
> +               device_names = kstrdup(binder_devices_param, GFP_KERNEL);
> +               if (!device_names) {
> +                       ret = -ENOMEM;
> +                       goto err_alloc_device_names_failed;
> +               }
>
> -       device_tmp = device_names;
> -       while ((device_name = strsep(&device_tmp, ","))) {
> -               ret = init_binder_device(device_name);
> -               if (ret)
> -                       goto err_init_binder_device_failed;
> +               device_tmp = device_names;
> +               while ((device_name = strsep(&device_tmp, ","))) {
> +                       ret = init_binder_device(device_name);
> +                       if (ret)
> +                               goto err_init_binder_device_failed;
> +               }
>         }
>
>         ret = init_binderfs();
> --
> 2.20.1
>
