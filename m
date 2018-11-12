Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB5AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3B920881
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3B920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbeKLMhP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:37:15 -0500
Received: from mout.gmx.net ([212.227.15.18]:48741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729729AbeKLMhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:37:15 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LhwLy-1fiprx0bPG-00nD42; Mon, 12
 Nov 2018 03:45:51 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] efi: permit calling efi_mem_reserve_persistent from
 atomic context
From:   Qian Cai <cai@gmx.us>
In-Reply-To: <trinity-d366cf7f-4a38-4193-a636-b695d34d6c47-1541817914119@msvc-mesg-gmx024>
Date:   Sun, 11 Nov 2018 21:45:48 -0500
Cc:     linux-mm@kvack.org, linux-efi@vger.kernel.org, will.deacon@arm.com,
        linux kernel <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E591C777-E2A6-4624-ABCE-C08251F7484A@gmx.us>
References: <20181108180511.30239-1-ard.biesheuvel@linaro.org>
 <trinity-d366cf7f-4a38-4193-a636-b695d34d6c47-1541817914119@msvc-mesg-gmx024>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:D7hUbARlsu24M7mWhoscFI5tCNBxXUg+ZjTqVn/7UKqDa/6K4Go
 pH+dS/oEns48CHlP7tMGhxKxZ17jQfSjk4thsxwg8+IzQqjUJ1KMg0rd/Iys37kwx0NxS6J
 Os8ExJb/+amEYS4SNFxr9Gf6X0IIpKQmitSbwVYpz748QsQhXepr+K3+CdoiRE7bewZftrW
 qQKIBclTJzV1PaXlyK4og==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fRNsOCwAXH4=:bn+7C1hWbWyncMveXMG3ri
 TvMxCjDGD90ENKGwwguLq+RXOCiC6b1nBgyisoeYZTk8TSVv7EhwhvvE3CfT35xiv1BP2gxjB
 nvxVA2vpCXv+i0JKXgjIAxvDZDlKkIXtbM239GzqD83y6vw5y44leuUh4EaYxmVlWLToRT6g3
 vT2M2pGY8AXUNsfwTIkmfuzgXkV7+4mCx7EpPUTPUCj0vB6CwG7r80oNaS+yQGEzk6/JmNJvm
 Gw3CZoqx0EX6MSlEMCH26PHN8UoNL/SKtb3S/ZnjJAOhtcLO1AM7cRBCMYHg7Jli/i6iu1NMb
 EqiZFmMZ29X01ZHoE3Esl2/ekjMnhzNYei/UHQtMtsbeTAdhE4habKk2EzCCGfX/r3DaH52Sj
 ZZs+p8oNXPfDvjLKU3Tu7ptVz4V0SX4WlgcGpBQR3t1mcydgz/Occ3FPoSgcWJFRzo7yqfTXJ
 /bP7Cfsyg3qKES7hGNjEgmhzEF/8ZAMTGFQyZDCVKESqq3pLueIETsxAoOyWI1sKGDaf+iP0R
 HPHioB68eSiKUSOfZDYWHOg1c2CAV5ZnKGIj1IacR/tXubWRxPcRM3wNQ10ayb4HstSdHv6nw
 BZQxZ9gztMPC9RXpTlfbifUBl2SmzAoGygkNY64Fml2OvjjJU9Yhye+LEX7/CEV82a3cnQWck
 YTplgCZ6J/2xddhImYe2Lr4+UiXzKa9zCO5dS966kEBsWjtLefphV8KM8rlL8xGCHH/GVQ3dw
 4p1RihIB3FswtpofPr1d2V7lW86HbrbW9ot9eJVGw7CGxifG7/5iS1vh23A8JwVuH60SR3O3H
 KhOO43fvxz8tblQ1L9XbcNUMa3VES4/HCHbibgwZQIOwBLbKV59KbB8K3x9GgcEgdE90v4Uj5
 zXXgPrzn0ePRIipls6/bqHel/PElM408rGd0nMPT5INGH1U75zpAPsr9wAGQAx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 9, 2018, at 9:45 PM, Qian Cai <cai@gmx.us> wrote:
> 
> 
> On 11/8/18 at 1:05 PM, Ard Biesheuvel wrote:
> 
>> Currently, efi_mem_reserve_persistent() may not be called from atomic
>> context, since both the kmalloc() call and the memremap() call may
>> sleep.
>> 
>> The kmalloc() call is easy enough to fix, but the memremap() call
>> needs to be moved into an init hook since we cannot control the
>> memory allocation behavior of memremap() at the call site.
>> 
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>> drivers/firmware/efi/efi.c | 31 +++++++++++++++++++------------
>> 1 file changed, 19 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
>> index 249eb70691b0..cfc876e0b67b 100644
>> --- a/drivers/firmware/efi/efi.c
>> +++ b/drivers/firmware/efi/efi.c
>> @@ -963,36 +963,43 @@ bool efi_is_table_address(unsigned long phys_addr)
>> }
>> 
>> static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
>> +static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
>> 
>> int efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
>> {
>> -	struct linux_efi_memreserve *rsv, *parent;
>> +	struct linux_efi_memreserve *rsv;
>> 
>> -	if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
>> +	if (!efi_memreserve_root)
>> 		return -ENODEV;
>> 
>> -	rsv = kmalloc(sizeof(*rsv), GFP_KERNEL);
>> +	rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);
>> 	if (!rsv)
>> 		return -ENOMEM;
>> 
>> -	parent = memremap(efi.mem_reserve, sizeof(*rsv), MEMREMAP_WB);
>> -	if (!parent) {
>> -		kfree(rsv);
>> -		return -ENOMEM;
>> -	}
>> -
>> 	rsv->base = addr;
>> 	rsv->size = size;
>> 
>> 	spin_lock(&efi_mem_reserve_persistent_lock);
>> -	rsv->next = parent->next;
>> -	parent->next = __pa(rsv);
>> +	rsv->next = efi_memreserve_root->next;
>> +	efi_memreserve_root->next = __pa(rsv);
>> 	spin_unlock(&efi_mem_reserve_persistent_lock);
>> 
>> -	memunmap(parent);
>> +	return 0;
>> +}
>> 
>> +static int __init efi_memreserve_root_init(void)
>> +{
>> +	if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
>> +		return -ENODEV;
>> +
>> +	efi_memreserve_root = memremap(efi.mem_reserve,
>> +				       sizeof(*efi_memreserve_root),
>> +				       MEMREMAP_WB);
>> +	if (!efi_memreserve_root)
>> +		return -ENOMEM;
>> 	return 0;
>> }
>> +early_initcall(efi_memreserve_root_init);
>> 
>> #ifdef CONFIG_KEXEC
>> static int update_efi_random_seed(struct notifier_block *nb,
>> -- 
>> 2.19.1
> BTW, I won’t be able to apply this patch on top of this series [1]. After applied that series, the original BUG sleep from atomic is gone as well as two other GIC warnings. Do you think a new patch is needed here?
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg685751.html
OK, I was able to apply this patch on top of latest mainline (ccda4af0f4b9)
which also include one patch (1/6) from the above series,

However, the efi-related patches from the series (4/6, 5/6, and 6/6) are no
longer able to be cleanly applied. 

As the results, the above patch did fix the original BUG: sleep from atomic,
but it introduces 2 new warnings.

[    0.000000] WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c:1696 its_init+0x494/0x7e8
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0-rc2+ #11
[    0.000000] pstate: 00000085 (nzcv daIf -PAN -UAO)
[    0.000000] pc : its_init+0x494/0x7e8
[    0.000000] lr : its_init+0x490/0x7e8
[    0.000000] sp : ffff20000a0c7a60
[    0.000000] x29: ffff20000a0c7a60 x28: 1fffe40001418f6e 
[    0.000000] x27: ffff20000a1061a8 x26: ffff8016c0fb0000 
[    0.000000] x25: ffff20000a3d2300 x24: ffff20000c542000 
[    0.000000] x23: 00000016c0fb0000 x22: ffff20000a1061a8 
[    0.000000] x21: 1fffe40001418f5e x20: ffff20000c542fa0 
[    0.000000] x19: ffff2000091c1be0 x18: 000000000000003f 
[    0.000000] x17: 00000000001bb6ad x16: 0000000000000000 
[    0.000000] x15: 0000000000007fff x14: 6166306336314020 
[    0.000000] x13: 736e6f697463656c x12: ffff1002d81f8000 
[    0.000000] x11: 1ffff002d81f7fff x10: ffff1002d81f7fff 
[    0.000000] x9 : 0000000000000000 x8 : ffff8016c0fc0000 
[    0.000000] x7 : a2a2a2a2a2a2a2a2 x6 : ffff8016c0fbffff 
[    0.000000] x5 : ffff1002d81f8000 x4 : dfff200000000000 
[    0.000000] x3 : 000000000000003f x2 : 000000000000ffff 
[    0.000000] x1 : 0000000000010000 x0 : 00000000ffffffed 
[    0.000000] Call trace:
[    0.000000]  its_init+0x494/0x7e8
[    0.000000]  gic_init_bases+0x2c0/0x2e0
[    0.000000]  gic_acpi_init+0x180/0x2ac
[    0.000000]  acpi_match_madt+0x5c/0x98
[    0.000000]  acpi_table_parse_entries_array+0x1e8/0x2ec
[    0.000000]  acpi_table_parse_entries+0xd8/0x10c
[    0.000000]  acpi_table_parse_madt+0x44/0x54
[    0.000000]  __acpi_probe_device_table+0xa8/0x10c
[    0.000000]  irqchip_init+0x38/0x40
[    0.000000]  init_IRQ+0xa0/0xdc
[    0.000000]  start_kernel+0x3b8/0x5a8
[    0.000000] irq event stamp: 0
[    0.000000] hardirqs last  enabled at (0): [<0000000000000000>]           (null)
[    0.000000] hardirqs last disabled at (0): [<0000000000000000>]           (null)
[    0.000000] softirqs last  enabled at (0): [<0000000000000000>]           (null)
[    0.000000] softirqs last disabled at (0): [<0000000000000000>]           (null)
[    0.000000] ---[ end trace 598902d30712b79b ]---
[    0.000000] GICv3: using LPI property table @0x00000016c0fb0000
[    0.000000] ITS: Using DirectLPI for VPE invalidation
[    0.000000] ITS: Enabling GICv4 support
[    0.000000] WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c:2096 its_cpu_init_lpis+0x400/0x428
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         4.20.0-rc2+ #11
[    0.000000] pstate: 00000085 (nzcv daIf -PAN -UAO)
[    0.000000] pc : its_cpu_init_lpis+0x400/0x428
[    0.000000] lr : its_cpu_init_lpis+0x3fc/0x428
[    0.000000] sp : ffff20000a0c7a30
[    0.000000] x29: ffff20000a0c7a30 x28: ffff2000095d8000 
[    0.000000] x27: ffff20000a0f9848 x26: ffff20000c600000 
[    0.000000] x25: ffff2000095d85e0 x24: ffff20000c542000 
[    0.000000] x23: ffff20000a0c7ac0 x22: ffff7fe005b03f00 
[    0.000000] x21: ffff20000c542fa0 x20: 1fffe40001418f54 
[    0.000000] x19: 00000016c0fc0000 x18: 000000000000003f 
[    0.000000] x17: 0000000000000000 x16: ffff20000a10efc0 
[    0.000000] x15: 0000000000007fff x14: ffff20000992701c 
[    0.000000] x13: ffff20000991fafc x12: ffff040001418e0b 
[    0.000000] x11: 1fffe40001418e0a x10: ffff040001418e0a 
[    0.000000] x9 : dfff200000000000 x8 : dfff200000000000 
[    0.000000] x7 : dfff200000000000 x6 : 00000000f2f2f204 
[    0.000000] x5 : 00000000f1f1f1f1 x4 : dfff200000000000 
[    0.000000] x3 : 0000000000000010 x2 : 000000000000ffff 
[    0.000000] x1 : 0000000000010000 x0 : 00000000ffffffed 
[    0.000000] Call trace:
[    0.000000]  its_cpu_init_lpis+0x400/0x428
[    0.000000]  its_cpu_init+0x12c/0x290
[    0.000000]  gic_init_bases+0x2c4/0x2e0
[    0.000000]  gic_acpi_init+0x180/0x2ac
[    0.000000]  acpi_match_madt+0x5c/0x98
[    0.000000]  acpi_table_parse_entries_array+0x1e8/0x2ec
[    0.000000]  acpi_table_parse_entries+0xd8/0x10c
[    0.000000]  acpi_table_parse_madt+0x44/0x54
[    0.000000]  __acpi_probe_device_table+0xa8/0x10c
[    0.000000]  irqchip_init+0x38/0x40
[    0.000000]  init_IRQ+0xa0/0xdc
[    0.000000]  start_kernel+0x3b8/0x5a8
[    0.000000] irq event stamp: 0
[    0.000000] hardirqs last  enabled at (0): [<0000000000000000>]           (null)
[    0.000000] hardirqs last disabled at (0): [<0000000000000000>]           (null)
[    0.000000] softirqs last  enabled at (0): [<0000000000000000>]           (null)
[    0.000000] softirqs last disabled at (0): [<0000000000000000>]           (null)
[    0.000000] ---[ end trace 598902d30712b79c ]---
