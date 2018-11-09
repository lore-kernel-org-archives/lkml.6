Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786DBC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396B520825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396B520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeKJBdZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:33:25 -0500
Received: from mout.gmx.net ([212.227.17.20]:35257 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbeKJBdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:33:25 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LqQTl-1fpx3u1RoH-00e8OX; Fri, 09
 Nov 2018 16:52:07 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c
From:   Qian Cai <cai@gmx.us>
In-Reply-To: <b74e43d3-a7e1-08e9-c176-5584ad379629@arm.com>
Date:   Fri, 9 Nov 2018 10:52:04 -0500
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <F47320A5-4A6B-4AEB-A0DC-E4EBC6B4EC2A@gmx.us>
References: <1541710771.12945.7.camel@gmx.us>
 <c8ff3004-33ee-19d5-8eb8-38d41f78c8ee@arm.com>
 <trinity-e1d06dde-12e1-4e2a-8871-d6c5f4af9f51-1541766480902@msvc-mesg-gmx023>
 <b23b62b4-9ecb-8b76-57e5-d323cc9926ce@arm.com>
 <13A11479-97FB-4EFD-A182-61DA63CB64D6@gmx.us>
 <b74e43d3-a7e1-08e9-c176-5584ad379629@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:/PCX6Ak0ic2Q2qzycV6sqW3UQy6whQTpeSAYrOsV80BgQMkuT1y
 IPVoSpl4BToKhZr+nwInx8zQCNBwWCox8pBisZC7DyHq60qRuX26JBYre4t+TurM0vSxlfo
 QafJagWkjMHPY4HdbelBHtar2QDLqsvxa35UwLk2RvJ0jC22LQqhBXvMC1detPjAKh6RDnn
 uoTD6ZYGdXvO9Gm9LdKyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qQ8HD9N/DmE=:ccO1uGgLHY5T3nO1bU6+RI
 XNaWp+Wq2D4+olB42nm3QbXT3f6pyioUQb0G2rInPog8o0v58HTmGtAMf8qzOBum/7SAWbELl
 6TP+zvbCzTxKydzGDcpLeK0mEY/k9X8mH9tW89oZKPeVyWDhyFUQoBNbLaXUZnTnszQ2Bdqrb
 jIBr2GN4jLAy6xC/1/Ng70fHHyK98F8r897vGHyQIdpKeZ9UZ36mMAdFeuwycTM7a7gFlz5oj
 8nc/YzrlWUrNNH+csCg+esSjSm/i0ctlT1OGTH9kYRR1wc/L2RJC0ixh8SgJSLMwtE7CIrzSY
 Asx0r9l/+akCGRuvKTjCNLB1gGszSNT71cakBVJnLnuMpxJ4Ethh3Mw5ORNpjt3A23EZR5+6k
 01Cxe4zC1p0i8iVrTL/NXS52QVBbf7/ODuF7M++Y7GLgnj4VG45g6CClrTPlprWHug/A6SSvT
 wRRQ6sfaPLLhDquy7NKb7yhiQMRC6yEM9gizD3p2IzwdD4HF8SBHzlwWXteovEjqdQaKvzqHb
 6T/4lUzh62pxU//HCx2xafJKqMqrijvVYy/FzUFkeyW75DEhLrxdzeTCTy3h5EmZWtIlMGB6d
 ldPpVKzPfGxfemKlad9AjMVdienTBIETsfSkUubhfyBEU8rvH01DTShOMKtkgdDzpjzwyPdAV
 3eB4MiRYJhRMTYlrn1Wr30Nw5z1hYEBk+ifNzMm9Haxv2X0l7EMhEVYT5pmpEN7w5awAHy+G+
 nd1nDvE0WS/49FZbT3vcTHUqlgkvDU8hlfzgmOcz2A00W0v13JsYoIszI+tSKvpzzFsg3yy3J
 s7T7KHZ/FI2/xz5N0b1nFG9lUo5dHEW4tNyii2+RISOFfaAAHcMEjkLWZImaARCiHKiMv/TX8
 mPLZ5B/o+bRD9KlUkKw2kBUbxvVABc97YlqyduQcF8RG+0gX42RyhwlXaeV2fsb78qwQsdDRD
 kvU3vXOOvwTO8i045ET2xTRx4FVM8VNESu7kRE9wwgqaZ16UzD/O1pSscVXo+7Szxi79GKem3
 GQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 9, 2018, at 10:38 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> On 09/11/18 15:28, Qian Cai wrote:
>> 
>> 
>>> On Nov 9, 2018, at 8:50 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> 
>>> On 09/11/18 12:28, Qian Cai wrote:
>>>> 
>>>> On 11/9/18 at 7:08 AM, Marc Zyngier wrote:
>>>> 
>>>>> [+Ard]
>>>>> 
>>>>> On 08/11/18 20:59, Qian Cai wrote:
>>>>>> Just booting up the latest git master (b00d209) on an aarch64 server and saw
>>>>>> this. Not sure about the third warning (at kernel/cpu.c:315
>>>>>> lockdep_assert_cpus_held+0x50/0x60) relates to irqchip or not, but appended it
>>>>>> to here anyway just in case.
>>>>>> 
>>>>>> [    0.000000] WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c:1696
>>>>>> its_init+0x588/0xb54
>>>>> 
>>>>> It looks like EFI cannot manage to reserve the memory for your GIC
>>>>> redistributors. Pretty annoying. At the same time, you have reported
>>>>> other issues with the EFI reservation mechanism, such as:
>>>>> 
>>>>> https://lore.kernel.org/patchwork/patch/1008413/
>>>>> 
>>>>> for which you have given a "Tested-by:". Is that related?
>>>> No, I don’t think so. Those warnings are still there even after applied the patch above.
>>> 
>>> Do you also have this series[1] applied? I'd otherwise need your
>>> configuration to try and reproduce it, as I can't manage to trigger it
>>> on my own setup.
>>> 
>>> Thanks,
>>> 
>>> 	M.
>>> 
>>> [1] https://www.spinics.net/lists/arm-kernel/msg685751.html
>> After applied the above series on the top of the mainline (b00d209), the only
>> warning exist is,
> 
> OK, so the EFI/GICv3 stuff is sorted.
> 
>> 
>> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/cpu.c:315
>> lockdep_assert_cpus_held+0x50/0x60
>> [    0.000000] Modules linked in:
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G                T 4.20.0-rc1+ #9
>> [    0.000000] pstate: 20000085 (nzCv daIf -PAN -UAO)
>> [    0.000000] pc : lockdep_assert_cpus_held+0x50/0x60
>> [    0.000000] lr : lockdep_assert_cpus_held+0x4c/0x60
>> [    0.000000] sp : ffff200009c97b10
>> [    0.000000] x29: ffff200009c97b10 x28: ffff200009e39000 
>> [    0.000000] x27: ffff200009cd1000 x26: ffff200009cd2000 
>> [    0.000000] x25: ffff200009125000 x24: ffff200009cc9868 
>> [    0.000000] x23: ffff200009c7c040 x22: 0000000000001000 
>> [    0.000000] x21: 0000000000000012 x20: ffff200009cc9000 
>> [    0.000000] x19: ffff200009cd5000 x18: 000000000000003f 
>> [    0.000000] x17: 0000000000000000 x16: 0000000000000000 
>> [    0.000000] x15: 0000000000000007 x14: ffff200009461cd4 
>> [    0.000000] x13: ffff2000094695ac x12: ffff2000095149a4 
>> [    0.000000] x11: ffff2000094e4478 x10: ffff2000094e0a50 
>> [    0.000000] x9 : ffff200009516aa8 x8 : ffff0ffbffcc4004 
>> [    0.000000] x7 : 1fffeffbffcc4003 x6 : ffff0ffbffcc4003 
>> [    0.000000] x5 : ffff7fdffe62001b x4 : ffff0ffbffcc4004 
>> [    0.000000] x3 : ffff0ffbffcc4004 x2 : dfff200000000000 
>> [    0.000000] x1 : 0000000000000000 x0 : 0000000000000000 
>> [    0.000000] Call trace:
>> [    0.000000]  lockdep_assert_cpus_held+0x50/0x60
>> [    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
>> [    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
>> [    0.000000]  arch_timer_acpi_init+0x274/0x6ac
>> [    0.000000]  acpi_table_parse+0x1ac/0x218
>> [    0.000000]  __acpi_probe_device_table+0x164/0x1ec
>> [    0.000000]  timer_probe+0x1bc/0x254
>> [    0.000000]  time_init+0x44/0x98
>> [    0.000000]  start_kernel+0x4ec/0x7d4
>> [    0.000000] irq event stamp: 0
>> [    0.000000] hardirqs last  enabled at (0): [<0000000000000000>]           (null)
>> [    0.000000] hardirqs last disabled at (0): [<0000000000000000>]           (null)
>> [    0.000000] softirqs last  enabled at (0): [<0000000000000000>]           (null)
>> [    0.000000] softirqs last disabled at (0): [<0000000000000000>]           (null)
>> [    0.000000] ---[ end trace 1dc5085680256ac1 ]—
> 
> Now this one: what machine is this? What is the workaround that gets
> applied?

# dmidecode 
# dmidecode 3.1
Getting SMBIOS data from sysfs.
SMBIOS 3.0.0 present.
Table at 0x397D0000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Huawei
	Version: 1.50
	Release Date: 06/01/2018
	Address: 0xA4800
	Runtime Size: 366 kB
	ROM Size: 8192 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
		Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
		5.25"/360 kB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 kB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		8042 keyboard services are supported (int 9h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
		UEFI is supported
	BIOS Revision: 0.0

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Huawei
	Product Name: TaiShan 2280 
	Version: V100R001C00
	Serial Number: 2102311TBJ10H7000017
	UUID: 8d9f1d7e-639a-11e7-9a0a-a08cf8625acc
	Wake-up Type: Power Switch
	SKU Number: To be filled by O.E.M.
	Family: To be filled by O.E.M.

I am not sure if I understand your second question, but there is no workaround
to make this warning disappear that I am aware of.
