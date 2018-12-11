Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6518C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822902086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jy7oRFlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822902086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeLKU7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:59:40 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37824 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKU7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:59:39 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so13750207edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 12:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H/uzZxNOJ/zQ7NPBnilu6RMhiHAcIHCvhkJLWedK6NA=;
        b=jy7oRFljun1PKNnHrDsEaqX1ilZJFpEZV8+Fni1dh/vBPwCXHX6DF9326JfFXVDSNH
         Q8GQXKZ8A7940Nz0l9Jn/DyLYr1jB36lQLL7B5Qf2damiDOzDhI7k7TQQf2PUi5hbH1c
         PwBZD0UjB44F/so/xORD/2Kbt9nV4yxpV1oCCb06aj8ruc5M/aDnNjogQHdWQADTjOb8
         2cdvkDTCAlUD1zMbgK39dYK0cmNZiHZxprp6eoVsm/sqPiBSvySwTfbvS5WeTBMsxu87
         VkHUZWjuQXBqpFdMMZgSc5Vf6pbHp7orLnN/sLJ4C224o8eA5ilaboqs2Naa4YPFQpbD
         VY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H/uzZxNOJ/zQ7NPBnilu6RMhiHAcIHCvhkJLWedK6NA=;
        b=abbKAeIVyUcjeExEUjC0JQoTOrwBnXgsai+yETNGG3xZ5XOcS4TjWLbKSiw5dooiCy
         YP7JueLxJ/XFtbZmE4e4am+JYQ6jAHh+gffI0NrQ4Rht7sd6EmuaQYYyRMWGEkZEX7rn
         en/+mvuQrSBjzgd2lW0sT4TecU+SwZSp7Jtlk4qKyDQq85KSczcsiDUulhW9nVZqqWsx
         Esyypa3JX+vKk4ztcJx17GYLMgHaKqNU6dBLRriG3Wtutn/6yA55jKcOb4R3ss+0eazt
         2zBv8vAww9PTaGNLpmaFGCRoxafX+JueGa9aCoxVMnh7YJvLnQsvjeSUALgkFVijFgR1
         p5ww==
X-Gm-Message-State: AA+aEWa+E9vszZqwsUtRL5BRYVMzTSd60zGl8oGnAU62h5pu5WulUy2g
        JGXJUksI0jdB7NdQXmYNjrjs9Q==
X-Google-Smtp-Source: AFSGD/W27SfVTy8upnKoOQ8IzSjAUrQazR18Mv3WtZXYslxQPFbHVJnb76MvNxX1FmaUK4r0j1oQ2w==
X-Received: by 2002:a17:906:7751:: with SMTP id o17-v6mr13461517ejn.15.1544561977142;
        Tue, 11 Dec 2018 12:59:37 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w10sm4350453eda.77.2018.12.11.12.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 12:59:36 -0800 (PST)
Subject: Re: [LKP] [tty] c96cf923a9:
 WARNING:possible_circular_locking_dependency_detected
To:     Jiri Slaby <jslaby@suse.cz>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     lkp@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20181211091154.GL23332@shao2-debian>
 <b8a5b151-9eaa-b098-f24f-b17c1886f456@suse.cz>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <2780774e-b397-dcc2-6950-cccb527d5014@arista.com>
Date:   Tue, 11 Dec 2018 20:59:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <b8a5b151-9eaa-b098-f24f-b17c1886f456@suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone,

I'm looking into that.

Greg, please, keep tty patches set in linux-next, I'll address this
report before it goes into master.

This theoretical issue is not strictly related to the patches set, but
can be hit without patches.

On 12/11/18 1:49 PM, Jiri Slaby wrote:
> On 11. 12. 18, 10:11, kernel test robot wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: c96cf923a98d1b094df9f0cf97a83e118817e31b ("tty: Don't block on IO when ldisc change is pending")
>> https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git tty-testing
> ...
>> [   87.209665] WARNING: possible circular locking dependency detected
>> [   87.210547] 4.20.0-rc4-00057-gc96cf92 #1 Tainted: G        W        
>> [   87.211449] ------------------------------------------------------
>> [   87.212405] getty/519 is trying to acquire lock:
>> [   87.213074] (____ptrval____) (&obj_hash[i].lock){-.-.}, at: debug_check_no_obj_freed+0xb4/0x302
>> [   87.214343] 
>> [   87.214343] but task is already holding lock:
>> [   87.215174] (____ptrval____) (&port_lock_key){-.-.}, at: uart_shutdown+0x3a3/0x4e2
> 
> This looks sensible -- normal use case.
> 
>> [   87.216260] which lock already depends on the new lock.
>> [   87.216260] 
>> [   87.217421] 
>> [   87.217421] the existing dependency chain (in reverse order) is:
> 
> This is during console init, so even if the report is not false
> positive, the deadlock is unlikely to happen. And only triggered with
> CONFIG_DEBUG_OBJECTS_FREE.
> 
> In any way, I don't see any connection between #2 and #0 below. The
> stack traces are completely different -- one from start_kernel, one from
> exit syscall.
> 
> I also wonder how could the commit above start causing this? Well, it
> might make it happen more likely due to more of EAGAINs.

Yes, as far as I can see right now, this is not related to tty changes,
but to non-clear locking policy between
DEBUG_OBJECTS_FREE hash bucket lock <-> uart's port->mutex.

As far as I remember WARN() prints can't be deferred and it makes sense
to have WARN() in debug objects.
I see probably fast and quite simple solution: to copy debug object's
state on stack and call debug_print_object() without bucket lock...
But not sure how straight-forward is this. I mean if speaking from
lib/debugobjects perspective.

I'll prepare a patch for that as it seems the easiest way (I haven't
looked long yet, though).

+Cc: Sergey, Petr, Steven - with their console_unlock()/printk() and
deferring expertise they probably have more brighter ideas.

>> [   87.218483] -> #2 (&port_lock_key){-.-.}:
>> [   87.219282]        lock_acquire+0x28c/0x2e7
>> [   87.219901]        _raw_spin_lock_irqsave+0x35/0x49
>> [   87.220601]        serial8250_console_write+0x110/0x5b5
>> [   87.221354]        univ8250_console_write+0x5f/0x64
>> [   87.222056]        console_unlock+0x61c/0x7cf
>> [   87.222680]        register_console+0x63a/0x7b0
>> [   87.223345]        univ8250_console_init+0x1e/0x28
>> [   87.224041]        console_init+0x3be/0x57e
>> [   87.224641]        start_kernel+0x441/0x6c6
>> [   87.225246]        x86_64_start_reservations+0x29/0x2b
>> [   87.225979]        x86_64_start_kernel+0x6f/0x72
>> [   87.226637]        secondary_startup_64+0xa4/0xb0
>> [   87.227314] 
>> [   87.227314] -> #1 (console_owner){-...}:
>> [   87.228127]        lock_acquire+0x28c/0x2e7
>> [   87.228728]        console_unlock+0x424/0x7cf
>> [   87.229363]        vprintk_emit+0x22d/0x252
>> [   87.229969]        vprintk_default+0x18/0x1a
>> [   87.230576]        vprintk_func+0xa9/0xab
>> [   87.231156]        printk+0x97/0xbe
>> [   87.231659]        __debug_object_init+0x8db/0x92d
>> [   87.232349]        debug_object_init+0x14/0x17
>> [   87.232987]        __init_work+0x1b/0x1d
>> [   87.233551]        rhashtable_init+0x53b/0x602
>> [   87.234192]        rhltable_init+0xe/0x41
>> [   87.234772]        test_insert_dup+0xac/0xa94
>> [   87.235467]        test_rht_init+0x387/0x79c
>> [   87.236222]        do_one_initcall+0x23c/0x4af
>> [   87.236869]        kernel_init_freeable+0x5ec/0x69f
>> [   87.237855]        kernel_init+0xc/0x100
>> [   87.238470]        ret_from_fork+0x3a/0x50
>> [   87.239071] 
>> [   87.239071] -> #0 (&obj_hash[i].lock){-.-.}:
>> [   87.239904]        __lock_acquire+0x1f78/0x22d1
>> [   87.240556]        lock_acquire+0x28c/0x2e7
>> [   87.241173]        _raw_spin_lock_irqsave+0x35/0x49
>> [   87.241882]        debug_check_no_obj_freed+0xb4/0x302
>> [   87.242620]        free_unref_page_prepare+0x33a/0x483
>> [   87.243368]        free_unref_page+0x48/0x80
>> [   87.243991]        __free_pages+0x2e/0x40
>> [   87.244611]        free_pages+0x54/0x5a
>> [   87.245188]        uart_shutdown+0x3df/0x4e2
>> [   87.245817]        uart_hangup+0x123/0x280
>> [   87.246406]        __tty_hangup+0x4da/0x50f
>> [   87.247025]        tty_vhangup_session+0xe/0x10
>> [   87.247680]        disassociate_ctty+0xeb/0x5c5
>> [   87.248349]        do_exit+0xc97/0x1daf
>> [   87.248920]        __x64_sys_exit_group+0x0/0x3e
>> [   87.249587]        __wake_up_parent+0x0/0x52
>> [   87.250211]        do_syscall_64+0x5e8/0x881
>> [   87.250839]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> [   87.251637] 
>> [   87.251637] other info that might help us debug this:
>> [   87.251637] 
>> [   87.252790] Chain exists of:
>> [   87.252790]   &obj_hash[i].lock --> console_owner --> &port_lock_key
>> [   87.252790] 
>> [   87.254307]  Possible unsafe locking scenario:
>> [   87.254307] 
>> [   87.255156]        CPU0                    CPU1
>> [   87.255813]        ----                    ----
>> [   87.256460]   lock(&port_lock_key);
>> [   87.256973]                                lock(console_owner);
>> [   87.257829]                                lock(&port_lock_key);
>> [   87.258680]   lock(&obj_hash[i].lock);
>> [   87.259223] 
>> [   87.259223]  *** DEADLOCK ***
>> [   87.259223] 
>> [   87.260067] 3 locks held by getty/519:
>> [   87.260605]  #0: (____ptrval____) (&tty->legacy_mutex){+.+.}, at: tty_lock+0x5c/0x68
>> [   87.261717]  #1: (____ptrval____) (&port->mutex){+.+.}, at: uart_hangup+0x4b/0x280
>> [   87.262795]  #2: (____ptrval____) (&port_lock_key){-.-.}, at: uart_shutdown+0x3a3/0x4e2
>> [   87.263974] 
>> [   87.263974] stack backtrace:
>> [   87.264631] CPU: 0 PID: 519 Comm: getty Tainted: G        W         4.20.0-rc4-00057-gc96cf92 #1
>> [   87.265893] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> [   87.267082] Call Trace:
>> [   87.267451]  dump_stack+0x86/0xc3
>> [   87.267942]  print_circular_bug+0x4a8/0x4b9
>> [   87.268635]  check_prevs_add+0x466/0x109c
>> [   87.269230]  ? quarantine_put+0x114/0x135
>> [   87.269821]  ? quarantine_put+0x114/0x135
>> [   87.270399]  ? serial_do_unlink+0x266/0x272
>> [   87.271009]  ? print_circular_bug_header+0x122/0x122
>> [   87.271722]  ? __kasan_slab_free+0x1e8/0x1fd
>> [   87.272341]  ? __kasan_slab_free+0x153/0x1fd

Thanks,
          Dmitry
