Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58227C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3DD208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lexmark.com header.i=@lexmark.com header.b="FtGnRKaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3DD208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lexmark.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeFTPbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:31:04 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41636 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752901AbeFTPbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:31:02 -0400
Received: by mail-lf0-f67.google.com with SMTP id d24-v6so5611160lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lexmark.com; s=lxk-google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VimNcWb/FlyN1IY1B30J444pH8MBgKxc2CIe7dg8LSQ=;
        b=FtGnRKaInPjUGaM5d86i8tHkpjGf0hUniUTIUl+euW9iaUAQ3XQbpLBdX99e+NE/70
         i03ejoTuGKNw4EGrDCaGbxsNXkCILGl/BVNTIowkGv+kPQs4Vlmfch8tqkf9/KYgNIWt
         saR5DFyd3ZGVh+y8OyH1QElZnZrmvJRuIVGvmyiXrczJzr+qbvQCly9U8hommoIgS7vA
         mS+AX90gP2HiQS9TyIqjOoRdVcsAoj/hf4ZaV4YG5sKpj49iJJ75WqAwlZ0fDvwn37t8
         qvCEDBxh+RUhAVUtMuVwQpi5VPGJm2rpNqh/DuDZwPSCAQbLzsaK5e2d7ceLBMNw9Ghp
         Y0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VimNcWb/FlyN1IY1B30J444pH8MBgKxc2CIe7dg8LSQ=;
        b=KYlBvW/Vvchnyux43XQ4TOEZrLd8gcAKJF8kvM9VcZl4eSUh+ikBtH6BcHcCsXl/BH
         jUcFHy+A1G1TnwqiR34h8hEBytA0IUemrSGJ0yB1GZA37m8L9yBH+AyFgaqN7cAUpV0G
         HcJeHUMYiN7DTGF4C/vxIAqc2qLIqaJdudrkbSkjoFFFzoyqMcd2fXEXh8UqLS/tN+o4
         J7wSfRdO5iUqOH6tkh8q0t7qLx1DbAUG37SBhm7EfbOz8QLnhxki45vd2ozSqPpCwbIX
         F+kAGqgcByC5kfnI/0n/Tjs0vQja0NcXyqeSwwU0kHsGN3ebCDdSk3DiFtD5MlRWrajR
         iTPA==
X-Gm-Message-State: APt69E15JuFljGgugr/DeKFLLT5UB+4l3ddkRvtzyKJIJI24iUsVc/Ne
        MJ/7klya605+CX/9kc2rtXN90u/H6ugPfQVAVYGGhw==
X-Google-Smtp-Source: ADUXVKKxMQXLrL0JLI0nw+6H1J773y843srMjjIkf9GIWEFUjYYOsWZTJUZOfYUWimXxYv1FttyYb1j+D6dOZMHaxO0=
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr14016160ljh.132.1529508660489;
 Wed, 20 Jun 2018 08:31:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:481a:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 08:30:19
 -0700 (PDT)
In-Reply-To: <d5d57b10-facb-d5f7-ad7f-34afae726756@ti.com>
References: <CA+G9fYuKW_jCFZPqG4tz=QY9ROfHO38KiCp9XTA+KaDOFVtcqQ@mail.gmail.com>
 <20180620102904.GC112168@atomide.com> <d5d57b10-facb-d5f7-ad7f-34afae726756@ti.com>
From:   Samuel Morris <samorris@lexmark.com>
Date:   Wed, 20 Jun 2018 11:30:19 -0400
Message-ID: <CAFY_6qqDcG7+sp7jawhTjuWHizPR75=HUsRJfGPhEPzVE4f5kg@mail.gmail.com>
Subject: Re: 4.18.0-rc1-next-20180619 boot failed on beagle board x15
To:     Roger Quadros <rogerq@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Tejun Heo <tj@kernel.org>, linux-omap@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, ssantosh@kernel.org,
        Olof Johansson <olof@lixom.net>, Tero Kristo <t-kristo@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 8:58 AM, Roger Quadros <rogerq@ti.com> wrote:
> Tony,
>
> On 20/06/18 13:29, Tony Lindgren wrote:
>> Hi,
>>
>> * Naresh Kamboju <naresh.kamboju@linaro.org> [180620 05:55]:
>>> Linux next (4.18.0-rc1-next-20180619) boot failed on beagle board x15.
>>
>> Bisect points to commit aece27a2f01b ("ata: ahci_platform: allow disabling of
>> hotplug to save power").
>>
>> Reverting the patch makes things work again. Any ideas what
>> might be going wrong here? Things clearly idle but then there
>> seems to be some register access with clocks disabled.
>
> The commit is doing this in probe.
>
> +       pm_runtime_set_active(dev);
>         pm_runtime_enable(dev);
> -       pm_runtime_get_sync(dev);
> +       pm_runtime_forbid(dev);
>
> On OMAP, the device is not guaranteed to be active at probe and so we can't
> say pm_runtime_set_active() and get rid of pm_runtime_get_sync().

Okay, by calling set_active(), I'm preventing the rpm_resume from
completing that would normally happen in pm_runtime_forbid(). I assume
you mean that there are parent devices that need to be resumed before
this device may be assumed active. I'm going to try removing the
set_active(), then move that clause to the end of
ahci_platform_init_host(). The pm_runtime_forbid() is effectively the
same as get_sync(), it just also sets the runtime_auto flag to false.
I don't think we should be saying the device is active until the host
is initialized, so that seems like a better, common place for the
pm_runtime init callbacks anyway. How does that sound?

>
>
>>
>>> Full log of trace please refer this link,
>>> https://lkft.validation.linaro.org/scheduler/job/291535#L946
>>>
>>> Here is back trace,
>>> [    3.561640] omap_rng 48090000.rng: Random Number Generator ver. 20
>>> [    3.611949] brd: module loaded
>>> [    3.641298] loop: module loaded
>>> [    3.646435] at24 0-0050: 4096 byte 24c32 EEPROM, writable, 1 bytes/write
>>> [    3.658481] ------------[ cut here ]------------
>>> [    3.663196] WARNING: CPU: 0 PID: 1 at
>>> /srv/oe/build/tmp-rpb-glibc/work-shared/am57xx-evm/kernel-source/drivers/bus/omap_l3_noc.c:147
>>> l3_interrupt_handler+0x27c/0x39c
>>> [    3.678052] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_CFG
>>> (Read): Data Access in User mode during Functional access
>>> [    3.689330] Modules linked in:
>>> [    3.692426] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
>>> 4.18.0-rc1-next-20180619 #1
>>> [    3.699952] Hardware name: Generic DRA74X (Flattened Device Tree)
>>> [    3.706099] [<c04156f0>] (unwind_backtrace) from [<c040eec4>]
>>> (show_stack+0x20/0x24)
>>> [    3.713897] [<c040eec4>] (show_stack) from [<c116a668>]
>>> (dump_stack+0xb0/0xdc)
>>> [    3.721171] [<c116a668>] (dump_stack) from [<c0450a14>] (__warn+0x118/0x130)
>>> [    3.728270] [<c0450a14>] (__warn) from [<c0450a84>]
>>> (warn_slowpath_fmt+0x58/0x74)
>>> [    3.735808] [<c0450a84>] (warn_slowpath_fmt) from [<c08be648>]
>>> (l3_interrupt_handler+0x27c/0x39c)
>>> [    3.744742] [<c08be648>] (l3_interrupt_handler) from [<c04cd270>]
>>> (__handle_irq_event_percpu+0x90/0x45c)
>>> [    3.754286] [<c04cd270>] (__handle_irq_event_percpu) from
>>> [<c04cd678>] (handle_irq_event_percpu+0x3c/0x8c)
>>> [    3.764001] [<c04cd678>] (handle_irq_event_percpu) from
>>> [<c04cd710>] (handle_irq_event+0x48/0x6c)
>>> [    3.772933] [<c04cd710>] (handle_irq_event) from [<c04d170c>]
>>> (handle_fasteoi_irq+0xb0/0x164)
>>> [    3.781513] [<c04d170c>] (handle_fasteoi_irq) from [<c04cc344>]
>>> (generic_handle_irq+0x34/0x44)
>>> [    3.790183] [<c04cc344>] (generic_handle_irq) from [<c04cca48>]
>>> (__handle_domain_irq+0x6c/0xc4)
>>> [    3.798941] [<c04cca48>] (__handle_domain_irq) from [<c0402528>]
>>> (gic_handle_irq+0x68/0xac)
>>> [    3.807347] [<c0402528>] (gic_handle_irq) from [<c04019bc>]
>>> (__irq_svc+0x5c/0x7c)
>>> [    3.814874] Exception stack(0xee179c70 to 0xee179cb8)
>>> [    3.819963] 9c60:                                     fc140000
>>> ee3e2f10 ee3a9810 00000000
>>> [    3.828189] 9c80: 00000000 ee3e2f10 fc140004 fc140000 ee3a9800
>>> ee3a9810 00000000 ee179cdc
>>> [    3.836414] 9ca0: ee179ce0 ee179cc0 c0c3b364 c0c3b2ec 60000013 ffffffff
>>> [    3.843079] [<c04019bc>] (__irq_svc) from [<c0c3b2ec>]
>>> (ahci_enable_ahci+0x24/0x70)
>>> [    3.850789] [<c0c3b2ec>] (ahci_enable_ahci) from [<c0c3b364>]
>>> (ahci_save_initial_config+0x2c/0x388)
>>> [    3.859894] [<c0c3b364>] (ahci_save_initial_config) from
>>> [<c0c3cbdc>] (ahci_platform_init_host+0x9c/0x4f4)
>>> [    3.869609] [<c0c3cbdc>] (ahci_platform_init_host) from
>>> [<c0c3c33c>] (ahci_probe+0xa0/0xc0)
>>> [    3.878018] [<c0c3c33c>] (ahci_probe) from [<c0ba40f0>]
>>> (platform_drv_probe+0x58/0xac)
>>> [    3.885989] [<c0ba40f0>] (platform_drv_probe) from [<c0ba1aec>]
>>> (driver_probe_device+0x25c/0x338)
>>> [    3.894915] [<c0ba1aec>] (driver_probe_device) from [<c0ba1cbc>]
>>> (__driver_attach+0xf4/0xf8)
>>> [    3.903411] [<c0ba1cbc>] (__driver_attach) from [<c0b9f9ac>]
>>> (bus_for_each_dev+0x78/0xc4)
>>> [    3.911643] [<c0b9f9ac>] (bus_for_each_dev) from [<c0ba13b8>]
>>> (driver_attach+0x2c/0x30)
>>> [    3.919696] [<c0ba13b8>] (driver_attach) from [<c0ba0cfc>]
>>> (bus_add_driver+0x114/0x220)
>>> [    3.927752] [<c0ba0cfc>] (bus_add_driver) from [<c0ba2e2c>]
>>> (driver_register+0x88/0x11c)
>>> [    3.935896] [<c0ba2e2c>] (driver_register) from [<c0ba4044>]
>>> (__platform_driver_register+0x50/0x58)
>>> [    3.945003] [<c0ba4044>] (__platform_driver_register) from
>>> [<c1aa9cf0>] (ahci_driver_init+0x24/0x28)
>>> [    3.954195] [<c1aa9cf0>] (ahci_driver_init) from [<c0403a8c>]
>>> (do_one_initcall+0x9c/0x434)
>>> [    3.962517] [<c0403a8c>] (do_one_initcall) from [<c1a01410>]
>>> (kernel_init_freeable+0x3b8/0x53c)
>>> [    3.971276] [<c1a01410>] (kernel_init_freeable) from [<c118551c>]
>>> (kernel_init+0x18/0x128)
>>> [    3.979597] [<c118551c>] (kernel_init) from [<c04010ac>]
>>> (ret_from_fork+0x14/0x28)
>>> [    3.987210] Exception stack(0xee179fb0 to 0xee179ff8)
>>> [    3.992298] 9fa0:                                     00000000
>>> 00000000 00000000 00000000
>>> [    4.000524] 9fc0: 00000000 00000000 00000000 00000000 00000000
>>> 00000000 00000000 00000000
>>> [    4.008750] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>>> [    4.015405] irq event stamp: 663130
>>> [    4.018926] hardirqs last  enabled at (663129): [<c118d9d4>]
>>> _raw_spin_unlock_irqrestore+0x40/0x6c
>>> [    4.027939] hardirqs last disabled at (663130): [<c04019ac>]
>>> __irq_svc+0x4c/0x7c
>>> [    4.035384] softirqs last  enabled at (661486): [<c0402c98>]
>>> __do_softirq+0x2a8/0x5e8
>>> [    4.043262] softirqs last disabled at (661449): [<c04594a4>]
>>> irq_exit+0x178/0x1a4
>>> [    4.050826] ---[ end trace 095abac70926448f ]---
>>>
>>> Best regards
>>> Naresh Kamboju
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> cheers,
> -roger
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
