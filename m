Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CFFC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB1620837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VyJqMfuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB1620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbeFUH6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:58:43 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:22284 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeFUH6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:58:40 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx193.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5L7wVij001218;
        Thu, 21 Jun 2018 02:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529567911;
        bh=pKNyWOb2StD0LQhVYqT8DjR1HddsLfWegQItjeBHXgc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VyJqMfufex6USE9KkdgM6mtqqrUNEqojZLDSNgUjgSjNeoGqbYJSKq6WoBwQKQJOl
         oSfcpLOw3OJmt6BcHRXzT7kVlYt/aOH3o85ozY7Sy0aKFuG2WPRx490vRMF3LrG8Cs
         NUZt+1s55Sz5mDJDb8LQ9IKzWtSAfGNPBSVcUWmc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5L7wVuj026222;
        Thu, 21 Jun 2018 02:58:31 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 21
 Jun 2018 02:58:31 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 21 Jun 2018 02:58:31 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5L7wR9G003939;
        Thu, 21 Jun 2018 02:58:28 -0500
Subject: Re: 4.18.0-rc1-next-20180619 boot failed on beagle board x15
To:     Samuel Morris <samorris@lexmark.com>
CC:     Tony Lindgren <tony@atomide.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Tejun Heo <tj@kernel.org>, <linux-omap@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <ssantosh@kernel.org>,
        Olof Johansson <olof@lixom.net>, Tero Kristo <t-kristo@ti.com>,
        <rafael@kernel.org>
References: <CA+G9fYuKW_jCFZPqG4tz=QY9ROfHO38KiCp9XTA+KaDOFVtcqQ@mail.gmail.com>
 <20180620102904.GC112168@atomide.com>
 <d5d57b10-facb-d5f7-ad7f-34afae726756@ti.com>
 <CAFY_6qqDcG7+sp7jawhTjuWHizPR75=HUsRJfGPhEPzVE4f5kg@mail.gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=rogerq@ti.com; prefer-encrypt=mutual; keydata=
 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
 IwrfNkJOLj3CvocMIw==
Message-ID: <6c15a753-c4a8-ff89-f5c0-0fd19c817c91@ti.com>
Date:   Thu, 21 Jun 2018 10:58:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFY_6qqDcG7+sp7jawhTjuWHizPR75=HUsRJfGPhEPzVE4f5kg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rafael

On 20/06/18 18:30, Samuel Morris wrote:
> On Wed, Jun 20, 2018 at 8:58 AM, Roger Quadros <rogerq@ti.com> wrote:
>> Tony,
>>
>> On 20/06/18 13:29, Tony Lindgren wrote:
>>> Hi,
>>>
>>> * Naresh Kamboju <naresh.kamboju@linaro.org> [180620 05:55]:
>>>> Linux next (4.18.0-rc1-next-20180619) boot failed on beagle board x15.
>>>
>>> Bisect points to commit aece27a2f01b ("ata: ahci_platform: allow disabling of
>>> hotplug to save power").
>>>
>>> Reverting the patch makes things work again. Any ideas what
>>> might be going wrong here? Things clearly idle but then there
>>> seems to be some register access with clocks disabled.
>>
>> The commit is doing this in probe.
>>
>> +       pm_runtime_set_active(dev);
>>         pm_runtime_enable(dev);
>> -       pm_runtime_get_sync(dev);
>> +       pm_runtime_forbid(dev);
>>
>> On OMAP, the device is not guaranteed to be active at probe and so we can't
>> say pm_runtime_set_active() and get rid of pm_runtime_get_sync().
> 
> Okay, by calling set_active(), I'm preventing the rpm_resume from
> completing that would normally happen in pm_runtime_forbid(). I assume
> you mean that there are parent devices that need to be resumed before

Actually, in the OMAP case, the AHCI controller device isn't active when probe is called.
For other platforms this might not be the case. So we need to be careful here.

> this device may be assumed active. I'm going to try removing the
> set_active(), then move that clause to the end of
> ahci_platform_init_host(). The pm_runtime_forbid() is effectively the
> same as get_sync(), it just also sets the runtime_auto flag to false.
> I don't think we should be saying the device is active until the host
> is initialized, so that seems like a better, common place for the
> pm_runtime init callbacks anyway. How does that sound?

Device active and initialized are different things. If the device is powered up
and can be accessed it is active, even if it is not yet initialized.
I don't think we should club the two.

Why do you need to call pm_runtime_set_active() at all in the probe sequence?

Documentation for pm_runtime_set_active() says,
"(it is only valid to use this function if 'power.runtime_error' is set
or 'power.disable_depth' is greater than zero);"

> 
>>
>>
>>>
>>>> Full log of trace please refer this link,
>>>> https://lkft.validation.linaro.org/scheduler/job/291535#L946
>>>>
>>>> Here is back trace,
>>>> [    3.561640] omap_rng 48090000.rng: Random Number Generator ver. 20
>>>> [    3.611949] brd: module loaded
>>>> [    3.641298] loop: module loaded
>>>> [    3.646435] at24 0-0050: 4096 byte 24c32 EEPROM, writable, 1 bytes/write
>>>> [    3.658481] ------------[ cut here ]------------
>>>> [    3.663196] WARNING: CPU: 0 PID: 1 at
>>>> /srv/oe/build/tmp-rpb-glibc/work-shared/am57xx-evm/kernel-source/drivers/bus/omap_l3_noc.c:147
>>>> l3_interrupt_handler+0x27c/0x39c
>>>> [    3.678052] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_CFG
>>>> (Read): Data Access in User mode during Functional access
>>>> [    3.689330] Modules linked in:
>>>> [    3.692426] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
>>>> 4.18.0-rc1-next-20180619 #1
>>>> [    3.699952] Hardware name: Generic DRA74X (Flattened Device Tree)
>>>> [    3.706099] [<c04156f0>] (unwind_backtrace) from [<c040eec4>]
>>>> (show_stack+0x20/0x24)
>>>> [    3.713897] [<c040eec4>] (show_stack) from [<c116a668>]
>>>> (dump_stack+0xb0/0xdc)
>>>> [    3.721171] [<c116a668>] (dump_stack) from [<c0450a14>] (__warn+0x118/0x130)
>>>> [    3.728270] [<c0450a14>] (__warn) from [<c0450a84>]
>>>> (warn_slowpath_fmt+0x58/0x74)
>>>> [    3.735808] [<c0450a84>] (warn_slowpath_fmt) from [<c08be648>]
>>>> (l3_interrupt_handler+0x27c/0x39c)
>>>> [    3.744742] [<c08be648>] (l3_interrupt_handler) from [<c04cd270>]
>>>> (__handle_irq_event_percpu+0x90/0x45c)
>>>> [    3.754286] [<c04cd270>] (__handle_irq_event_percpu) from
>>>> [<c04cd678>] (handle_irq_event_percpu+0x3c/0x8c)
>>>> [    3.764001] [<c04cd678>] (handle_irq_event_percpu) from
>>>> [<c04cd710>] (handle_irq_event+0x48/0x6c)
>>>> [    3.772933] [<c04cd710>] (handle_irq_event) from [<c04d170c>]
>>>> (handle_fasteoi_irq+0xb0/0x164)
>>>> [    3.781513] [<c04d170c>] (handle_fasteoi_irq) from [<c04cc344>]
>>>> (generic_handle_irq+0x34/0x44)
>>>> [    3.790183] [<c04cc344>] (generic_handle_irq) from [<c04cca48>]
>>>> (__handle_domain_irq+0x6c/0xc4)
>>>> [    3.798941] [<c04cca48>] (__handle_domain_irq) from [<c0402528>]
>>>> (gic_handle_irq+0x68/0xac)
>>>> [    3.807347] [<c0402528>] (gic_handle_irq) from [<c04019bc>]
>>>> (__irq_svc+0x5c/0x7c)
>>>> [    3.814874] Exception stack(0xee179c70 to 0xee179cb8)
>>>> [    3.819963] 9c60:                                     fc140000
>>>> ee3e2f10 ee3a9810 00000000
>>>> [    3.828189] 9c80: 00000000 ee3e2f10 fc140004 fc140000 ee3a9800
>>>> ee3a9810 00000000 ee179cdc
>>>> [    3.836414] 9ca0: ee179ce0 ee179cc0 c0c3b364 c0c3b2ec 60000013 ffffffff
>>>> [    3.843079] [<c04019bc>] (__irq_svc) from [<c0c3b2ec>]
>>>> (ahci_enable_ahci+0x24/0x70)
>>>> [    3.850789] [<c0c3b2ec>] (ahci_enable_ahci) from [<c0c3b364>]
>>>> (ahci_save_initial_config+0x2c/0x388)
>>>> [    3.859894] [<c0c3b364>] (ahci_save_initial_config) from
>>>> [<c0c3cbdc>] (ahci_platform_init_host+0x9c/0x4f4)
>>>> [    3.869609] [<c0c3cbdc>] (ahci_platform_init_host) from
>>>> [<c0c3c33c>] (ahci_probe+0xa0/0xc0)
>>>> [    3.878018] [<c0c3c33c>] (ahci_probe) from [<c0ba40f0>]
>>>> (platform_drv_probe+0x58/0xac)
>>>> [    3.885989] [<c0ba40f0>] (platform_drv_probe) from [<c0ba1aec>]
>>>> (driver_probe_device+0x25c/0x338)
>>>> [    3.894915] [<c0ba1aec>] (driver_probe_device) from [<c0ba1cbc>]
>>>> (__driver_attach+0xf4/0xf8)
>>>> [    3.903411] [<c0ba1cbc>] (__driver_attach) from [<c0b9f9ac>]
>>>> (bus_for_each_dev+0x78/0xc4)
>>>> [    3.911643] [<c0b9f9ac>] (bus_for_each_dev) from [<c0ba13b8>]
>>>> (driver_attach+0x2c/0x30)
>>>> [    3.919696] [<c0ba13b8>] (driver_attach) from [<c0ba0cfc>]
>>>> (bus_add_driver+0x114/0x220)
>>>> [    3.927752] [<c0ba0cfc>] (bus_add_driver) from [<c0ba2e2c>]
>>>> (driver_register+0x88/0x11c)
>>>> [    3.935896] [<c0ba2e2c>] (driver_register) from [<c0ba4044>]
>>>> (__platform_driver_register+0x50/0x58)
>>>> [    3.945003] [<c0ba4044>] (__platform_driver_register) from
>>>> [<c1aa9cf0>] (ahci_driver_init+0x24/0x28)
>>>> [    3.954195] [<c1aa9cf0>] (ahci_driver_init) from [<c0403a8c>]
>>>> (do_one_initcall+0x9c/0x434)
>>>> [    3.962517] [<c0403a8c>] (do_one_initcall) from [<c1a01410>]
>>>> (kernel_init_freeable+0x3b8/0x53c)
>>>> [    3.971276] [<c1a01410>] (kernel_init_freeable) from [<c118551c>]
>>>> (kernel_init+0x18/0x128)
>>>> [    3.979597] [<c118551c>] (kernel_init) from [<c04010ac>]
>>>> (ret_from_fork+0x14/0x28)
>>>> [    3.987210] Exception stack(0xee179fb0 to 0xee179ff8)
>>>> [    3.992298] 9fa0:                                     00000000
>>>> 00000000 00000000 00000000
>>>> [    4.000524] 9fc0: 00000000 00000000 00000000 00000000 00000000
>>>> 00000000 00000000 00000000
>>>> [    4.008750] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>>>> [    4.015405] irq event stamp: 663130
>>>> [    4.018926] hardirqs last  enabled at (663129): [<c118d9d4>]
>>>> _raw_spin_unlock_irqrestore+0x40/0x6c
>>>> [    4.027939] hardirqs last disabled at (663130): [<c04019ac>]
>>>> __irq_svc+0x4c/0x7c
>>>> [    4.035384] softirqs last  enabled at (661486): [<c0402c98>]
>>>> __do_softirq+0x2a8/0x5e8
>>>> [    4.043262] softirqs last disabled at (661449): [<c04594a4>]
>>>> irq_exit+0x178/0x1a4
>>>> [    4.050826] ---[ end trace 095abac70926448f ]---
>>>>
>>>> Best regards
>>>> Naresh Kamboju
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> cheers,
>> -roger
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
