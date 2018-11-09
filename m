Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646FFC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D6020818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D6020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeKJBrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:47:43 -0500
Received: from foss.arm.com ([217.140.101.70]:33908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbeKJBrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:47:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB82480D;
        Fri,  9 Nov 2018 08:06:31 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBFCD3F5BD;
        Fri,  9 Nov 2018 08:06:30 -0800 (PST)
Subject: Re: WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c
To:     Qian Cai <cai@gmx.us>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>
References: <1541710771.12945.7.camel@gmx.us>
 <c8ff3004-33ee-19d5-8eb8-38d41f78c8ee@arm.com>
 <trinity-e1d06dde-12e1-4e2a-8871-d6c5f4af9f51-1541766480902@msvc-mesg-gmx023>
 <b23b62b4-9ecb-8b76-57e5-d323cc9926ce@arm.com>
 <13A11479-97FB-4EFD-A182-61DA63CB64D6@gmx.us>
 <b74e43d3-a7e1-08e9-c176-5584ad379629@arm.com>
 <F47320A5-4A6B-4AEB-A0DC-E4EBC6B4EC2A@gmx.us>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <930d61db-6e44-8501-983d-09cd3759d153@arm.com>
Date:   Fri, 9 Nov 2018 16:06:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <F47320A5-4A6B-4AEB-A0DC-E4EBC6B4EC2A@gmx.us>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/18 15:52, Qian Cai wrote:
> 
> 
>> On Nov 9, 2018, at 10:38 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>
>> On 09/11/18 15:28, Qian Cai wrote:
>>>
>>>
>>>> On Nov 9, 2018, at 8:50 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>>
>>>> On 09/11/18 12:28, Qian Cai wrote:
>>>>>
>>>>> On 11/9/18 at 7:08 AM, Marc Zyngier wrote:
>>>>>
>>>>>> [+Ard]
>>>>>>
>>>>>> On 08/11/18 20:59, Qian Cai wrote:
>>>>>>> Just booting up the latest git master (b00d209) on an aarch64 server and saw
>>>>>>> this. Not sure about the third warning (at kernel/cpu.c:315
>>>>>>> lockdep_assert_cpus_held+0x50/0x60) relates to irqchip or not, but appended it
>>>>>>> to here anyway just in case.
>>>>>>>
>>>>>>> [    0.000000] WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c:1696
>>>>>>> its_init+0x588/0xb54
>>>>>>
>>>>>> It looks like EFI cannot manage to reserve the memory for your GIC
>>>>>> redistributors. Pretty annoying. At the same time, you have reported
>>>>>> other issues with the EFI reservation mechanism, such as:
>>>>>>
>>>>>> https://lore.kernel.org/patchwork/patch/1008413/
>>>>>>
>>>>>> for which you have given a "Tested-by:". Is that related?
>>>>> No, I don’t think so. Those warnings are still there even after applied the patch above.
>>>>
>>>> Do you also have this series[1] applied? I'd otherwise need your
>>>> configuration to try and reproduce it, as I can't manage to trigger it
>>>> on my own setup.
>>>>
>>>> Thanks,
>>>>
>>>> 	M.
>>>>
>>>> [1] https://www.spinics.net/lists/arm-kernel/msg685751.html
>>> After applied the above series on the top of the mainline (b00d209), the only
>>> warning exist is,
>>
>> OK, so the EFI/GICv3 stuff is sorted.
>>
>>>
>>> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/cpu.c:315
>>> lockdep_assert_cpus_held+0x50/0x60
>>> [    0.000000] Modules linked in:
>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G                T 4.20.0-rc1+ #9
>>> [    0.000000] pstate: 20000085 (nzCv daIf -PAN -UAO)
>>> [    0.000000] pc : lockdep_assert_cpus_held+0x50/0x60
>>> [    0.000000] lr : lockdep_assert_cpus_held+0x4c/0x60
>>> [    0.000000] sp : ffff200009c97b10
>>> [    0.000000] x29: ffff200009c97b10 x28: ffff200009e39000 
>>> [    0.000000] x27: ffff200009cd1000 x26: ffff200009cd2000 
>>> [    0.000000] x25: ffff200009125000 x24: ffff200009cc9868 
>>> [    0.000000] x23: ffff200009c7c040 x22: 0000000000001000 
>>> [    0.000000] x21: 0000000000000012 x20: ffff200009cc9000 
>>> [    0.000000] x19: ffff200009cd5000 x18: 000000000000003f 
>>> [    0.000000] x17: 0000000000000000 x16: 0000000000000000 
>>> [    0.000000] x15: 0000000000000007 x14: ffff200009461cd4 
>>> [    0.000000] x13: ffff2000094695ac x12: ffff2000095149a4 
>>> [    0.000000] x11: ffff2000094e4478 x10: ffff2000094e0a50 
>>> [    0.000000] x9 : ffff200009516aa8 x8 : ffff0ffbffcc4004 
>>> [    0.000000] x7 : 1fffeffbffcc4003 x6 : ffff0ffbffcc4003 
>>> [    0.000000] x5 : ffff7fdffe62001b x4 : ffff0ffbffcc4004 
>>> [    0.000000] x3 : ffff0ffbffcc4004 x2 : dfff200000000000 
>>> [    0.000000] x1 : 0000000000000000 x0 : 0000000000000000 
>>> [    0.000000] Call trace:
>>> [    0.000000]  lockdep_assert_cpus_held+0x50/0x60
>>> [    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
>>> [    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
>>> [    0.000000]  arch_timer_acpi_init+0x274/0x6ac
>>> [    0.000000]  acpi_table_parse+0x1ac/0x218
>>> [    0.000000]  __acpi_probe_device_table+0x164/0x1ec
>>> [    0.000000]  timer_probe+0x1bc/0x254
>>> [    0.000000]  time_init+0x44/0x98
>>> [    0.000000]  start_kernel+0x4ec/0x7d4
>>> [    0.000000] irq event stamp: 0
>>> [    0.000000] hardirqs last  enabled at (0): [<0000000000000000>]           (null)
>>> [    0.000000] hardirqs last disabled at (0): [<0000000000000000>]           (null)
>>> [    0.000000] softirqs last  enabled at (0): [<0000000000000000>]           (null)
>>> [    0.000000] softirqs last disabled at (0): [<0000000000000000>]           (null)
>>> [    0.000000] ---[ end trace 1dc5085680256ac1 ]—
>>
>> Now this one: what machine is this? What is the workaround that gets
>> applied?
> 
> # dmidecode 
> # dmidecode 3.1
> Getting SMBIOS data from sysfs.
> SMBIOS 3.0.0 present.
> Table at 0x397D0000.
> 
> Handle 0x0000, DMI type 0, 24 bytes
> BIOS Information
> 	Vendor: Huawei
> 	Version: 1.50
> 	Release Date: 06/01/2018
> 	Address: 0xA4800
> 	Runtime Size: 366 kB
> 	ROM Size: 8192 kB
> 	Characteristics:
> 		PCI is supported
> 		BIOS is upgradeable
> 		BIOS shadowing is allowed
> 		Boot from CD is supported
> 		Selectable boot is supported
> 		EDD is supported
> 		Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
> 		Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
> 		5.25"/360 kB floppy services are supported (int 13h)
> 		5.25"/1.2 MB floppy services are supported (int 13h)
> 		3.5"/720 kB floppy services are supported (int 13h)
> 		3.5"/2.88 MB floppy services are supported (int 13h)
> 		8042 keyboard services are supported (int 9h)
> 		CGA/mono video services are supported (int 10h)
> 		ACPI is supported
> 		USB legacy is supported
> 		BIOS boot specification is supported
> 		Targeted content distribution is supported
> 		UEFI is supported
> 	BIOS Revision: 0.0
> 
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
> 	Manufacturer: Huawei
> 	Product Name: TaiShan 2280 
> 	Version: V100R001C00
> 	Serial Number: 2102311TBJ10H7000017
> 	UUID: 8d9f1d7e-639a-11e7-9a0a-a08cf8625acc
> 	Wake-up Type: Power Switch
> 	SKU Number: To be filled by O.E.M.
> 	Family: To be filled by O.E.M.

Great stuff. This is what I know as a D05. I used to have one, but it
dropped of the network and I need to find someone to locate it in the
server room.

> 
> I am not sure if I understand your second question, but there is no workaround
> to make this warning disappear that I am aware of.

it is not about having a workaround to disable the warning, but a
workaround that the kernel is applying because the HW is busted:

>>> [    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0

See bb42ca474010 and d003d029cea8 for details.

Now, activating this workaround leads to lockdep being really angry,
most likely because the cpus_read_lock is not taken, which is a change
in behaviour...

I'm trying to dig into this now.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
