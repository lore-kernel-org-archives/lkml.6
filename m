Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B717C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4472D20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bPQxSk9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4472D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeIGU4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:56:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39642 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeIGU4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:56:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id i190-v6so7234057pgc.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K+M1SAgGXC2Onc3KcZx0ik/r635nRcp4bKRLG2bVD7o=;
        b=bPQxSk9Rgg1cqwVlihZG1dIU12tg5FGr2lVrWB331Denl2IBhY/Y3prO5svNYP3o+E
         enrmWYyufPm5Y7ftyuiuSiRBQHf4FPm11Ss/zUXrsMKZzxuGilW66rG7dW0l3bqheyji
         Xrh1tyZ62nrWd5rOIhVkH85KZNcJnf3gp/1oemi98bgSv81ZgaQJHf4+x/8HI0sP4QXQ
         6oYtcWpPMGMo7dpQ3NdmerBo+N1Kb6RvKJrS/7Dv23r9JOeb/2+cX8B1vns2qWQ6gzSm
         1v4LiKms0DbCcXhVwyYWJo4vJyd8Q1aF7FG0sI7pZlr0ODXfEBXR2Zaw5iEudQc7mrdv
         ZKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K+M1SAgGXC2Onc3KcZx0ik/r635nRcp4bKRLG2bVD7o=;
        b=l5vuLFdiFZ57EMMO2mVqihweobqv7voFLZW/P6N6S88FbovKNSgfb8glcSO4RFHI45
         5AYACHldsFVdkrgHKU0H9gf/lFT51aMXyNHOb9s5l652QKPUg6ZbIGTVB1MfVe04ulhG
         GNwDgsHtCP1z4RjWrD8AnXO2E7IN3+5pcNLUTmHZgcD71cCSR9syNhP5ZvfjL8deALmd
         a49CfqKeb96kQEhidIZxCc8m2JDDciXx4R8wrnpxwMV7dPUSTFI65Am0CoWvZb15KfL/
         FRJpl8uPgodRdW67jAh/rxNoEy4Hqj3st2JxFc6NkpBIgmZrxJXWwMfvAoMQfp95M2JA
         U8xg==
X-Gm-Message-State: APzg51De7AFZS9hQ0TWCEIpvYcW4bzdSfwaWWix1oHudoAMa+TzatVa+
        7awgTfBwXzdwvwbdC+23dMVbc5jvi3cNfRytAasbwA==
X-Google-Smtp-Source: ANB0VdYGyM6xeEC/irj/fpHNsW+Wsrl7NiniTBtYI8UunH9TLzeeQ0B4azqlJzL3F6HCK2mMEme6xY36mSNAoKW82QA=
X-Received: by 2002:a63:6183:: with SMTP id v125-v6mr9165680pgb.242.1536336900677;
 Fri, 07 Sep 2018 09:15:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Fri, 7 Sep 2018 09:14:40
 -0700 (PDT)
In-Reply-To: <8e8f8ac1-8b72-a21c-f504-74a5ce12b625@kernel.org>
References: <CACT4Y+Ywimrr3_oD2r=u0-Sz-PFXL2tpXA4q0odKDMM_Tvw0AA@mail.gmail.com>
 <8e8f8ac1-8b72-a21c-f504-74a5ce12b625@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 7 Sep 2018 18:14:40 +0200
Message-ID: <CACT4Y+bJ+o7yLcPwQRbsD4_Ye_SsXe3GfmiozVJ-8w-4asyxbQ@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in vudc_probe
To:     Shuah Khan <shuah@kernel.org>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, khlebnikov@yandex-team.ru,
        paolo.valente@linaro.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 6:03 PM, Shuah Khan <shuah@kernel.org> wrote:
> Hi Dmitry,
>
> On 09/07/2018 04:54 AM, Dmitry Vyukov wrote:
>> Hi,
>>
>> I am getting the following error while booting kernel on upstream
>> commit a49a9dcce802b3651013f659813df1361d306172, config is attached.
>> Seems there is some kind of resource leak.
>>
>> Thanks
>
> Odd. This commit has nothing to do with vudc.

This is not the guilty commit, I just described state of my tree.

> I am adding developers
> that are associated with this commit to the thread.
>
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 58c6efa9f9a9..9fe5952d117d 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -275,9 +275,9 @@ static void bfqg_and_blkg_get(struct bfq_group *bfqg)
>
>  void bfqg_and_blkg_put(struct bfq_group *bfqg)
>  {
> -       bfqg_put(bfqg);
> -
>         blkg_put(bfqg_to_blkg(bfqg));
> +
> +       bfqg_put(bfqg);
>  }
>
>  /* @stats = 0 */
> --
>
>>
>> ------------[ cut here ]------------
>> ODEBUG: free active (active state 0) object type: timer_list hint:
>> delayed_work_timer_fn+0x0/0x6e kernel/workqueue.c:4923
>> WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:329
>> debug_print_object+0x164/0x17c lib/debugobjects.c:326
>> Kernel panic - not syncing: panic_on_warn set ...
>>
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc2-00205-ga49a9dcce802 #6
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1a5/0x28b lib/dump_stack.c:113
>>  panic+0x239/0x4e8 kernel/panic.c:184
>>  __warn+0x16f/0x1c5 kernel/panic.c:536
>>  report_bug+0x163/0x1c9 lib/bug.c:186
>>  fixup_bug+0x43/0x7c arch/x86/kernel/traps.c:178
>>  do_error_trap+0xee/0x2ac arch/x86/kernel/traps.c:296
>>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
>> RIP: 0010:debug_print_object+0x164/0x17c lib/debugobjects.c:326
>> Code: 3c 02 00 74 05 e8 06 12 cc fe 48 8b 14 dd 60 9c c8 86 4d 89 e9
>> 49 89 e8 44 89 f1 4c 89 e6 48 c7 c7 a0 90 c8 86 e8 5e a7 7a fe <0f> 0b
>> 5b ff 05 b1 92 45 06 5d 41 5c 41 5d 41 5e c3 ff 05 a3 92 45
>> RSP: 0000:ffff88006bbaf510 EFLAGS: 00010086
>> RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffff88006bba2900
>> RDX: 000000616bba2900 RSI: ffffffff8148ef03 RDI: ffffed000d775e76
>> RBP: ffffffff868e66a0 R08: fffffbfff0ff8ff1 R09: 0000000000000001
>> R10: ffff88006bba2900 R11: fffffbfff0ff8ff0 R12: ffffffff86c89580
>> R13: ffffffff813c4247 R14: 0000000000000000 R15: ffff88006a131208
>>  __debug_check_no_obj_freed lib/debugobjects.c:786 [inline]
>>  debug_check_no_obj_freed+0x176/0x2a1 lib/debugobjects.c:818
>>  slab_free_hook mm/slub.c:1368 [inline]
>>  slab_free_freelist_hook+0x8a/0xed mm/slub.c:1398
>>  slab_free mm/slub.c:2953 [inline]
>>  kfree+0x187/0x222 mm/slub.c:3906
>
> I am a bit stumped. The memory vudc is trying to free is valid. I am
> looking into this more. Please send me the full dmesg.
>
>>  vudc_probe+0x9d9/0xa24 drivers/usb/usbip/vudc_dev.c:633
>>  platform_drv_probe+0xdd/0x181 drivers/base/platform.c:579
>>  really_probe+0x590/0xb2a drivers/base/dd.c:500
>>  driver_probe_device+0x2a8/0x313 drivers/base/dd.c:662
>>  __device_attach_driver+0x220/0x27b drivers/base/dd.c:758
>>  bus_for_each_drv+0x177/0x1b8 drivers/base/bus.c:461
>>  __device_attach+0x203/0x36d drivers/base/dd.c:815
>>  bus_probe_device+0xc8/0x22d drivers/base/bus.c:521
>>  device_add+0x5b6/0x1273 drivers/base/core.c:1927
>>  platform_device_add+0x53a/0x68d drivers/base/platform.c:417
>>  init+0x13e/0x3c4 arch/x86/crypto/blowfish_glue.c:444
>>  do_one_initcall+0x2d8/0x63f init/main.c:885
>>  do_initcall_level init/main.c:953 [inline]
>>  do_initcalls init/main.c:961 [inline]
>>  do_basic_setup init/main.c:979 [inline]
>>  kernel_init_freeable+0x4bb/0x5ac init/main.c:1144
>>  kernel_init+0x11/0x1b6 init/main.c:1063
>>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
>>
>
> thanks,
> -- Shuah
