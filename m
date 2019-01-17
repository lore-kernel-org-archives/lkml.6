Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA98C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205E320851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ypLVR4O1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfAQMmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:42:47 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47058 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfAQMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:42:47 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0HCgL0g107826;
        Thu, 17 Jan 2019 06:42:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547728941;
        bh=8Or3VrkNirQ12Q3+vnoWE6DAY4MdJCWb/qU8lUtw4tE=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=ypLVR4O1dpHZHTmOxEN6/5Dn7UdRSjBrs1jtaUsjHIRzwCxJ8VQdN3ukdLFCraN3E
         5phE9ks6R1XChvfUYp/ct9+l2cJnp8ackpZrKPkvzl223YFjvkb8q3ZLFYHY1hPepj
         AjjqKjBec5wPPIFnJib3nj7WDvSEVhs33xnQ0yeA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0HCgL8n116640
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 06:42:21 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 17
 Jan 2019 06:42:21 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 17 Jan 2019 06:42:21 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0HCgHva011564;
        Thu, 17 Jan 2019 06:42:18 -0600
Subject: Re: [PATCH 02/17] clocksource: davinci-timer: new driver
From:   Sekhar Nori <nsekhar@ti.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190111172134.30147-1-brgl@bgdev.pl>
 <20190111172134.30147-3-brgl@bgdev.pl>
 <08200de1-fde5-c525-c874-c7872259067b@ti.com>
 <CAMRc=McrT4KTW45=3CTBxspVb+z8k=DDjOvKi9NH0aA9eJ8=cQ@mail.gmail.com>
 <a7d4994d-7740-c845-da67-9d06e6d874cc@ti.com>
Message-ID: <d9bc1153-3b65-19a8-67ef-e131296cd8b1@ti.com>
Date:   Thu, 17 Jan 2019 18:12:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a7d4994d-7740-c845-da67-9d06e6d874cc@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/19 2:48 PM, Sekhar Nori wrote:
> On 14/01/19 10:09 PM, Bartosz Golaszewski wrote:
>> pon., 14 sty 2019 o 13:20 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>>
>>> Hi Bartosz,
>>>
>>> On 11/01/19 10:51 PM, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> Currently the clocksource and clockevent support for davinci platforms
>>>> lives in mach-davinci. It hard-codes many things, used global variables,
>>>> implements functionalities unused by any platform and has code fragments
>>>> scattered across many (often unrelated) files.
>>>>
>>>> Implement a new, modern and simplified timer driver and put it into
>>>> drivers/clocksource. We still need to support legacy board files so
>>>> export a config structure and a function that allows machine code to
>>>> register the timer.
>>>>
>>>> We don't check the return values of regmap reads and writes since with
>>>> mmio it's only likely to fail due to programmer's errors.
>>>>
>>>> We also don't bother freeing resources on errors in
>>>> davinci_timer_register() as the system won't boot without a timer anyway.
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> With this series, DA830 fails to boot. Rest of the devices are okay from
>>> boot perspective.
>>>
>>> DA830 is pretty unique because it uses the same timer-half for both
>>> clocksource and clockevent. May be you can set the same configuration on
>>> your DA850 to see the same issue? Else, I will enable low-level debug
>>> and try to provide more debug data.
>>>
>>
>> I can't boot da850 with the same config as da830 (0x60 compare
>> register, compare irq 74) even with the old timer code. Just to make
>> sure: does da830 boot fine with mainline v5.0-rc2?
> 
> Yeah, I did check that without the patch DA830 does boot.

You are right that DA850 lacks compare interrupts for timers 0 and 1.
So, yes, it seems like we will have to shift to timer2 to test
compare interrupts on DA850.

Just to confirm, DA830 boots fine with the compare section removed:

---8<---
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 0d81a8fdd9e6..f34398a7e47c 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -788,14 +788,6 @@ static const struct davinci_timer_cfg da830_timer_cfg = {
 			.flags	= IORESOURCE_IRQ,
 		},
 	},
-	.cmp = {
-		.irq = {
-			.start	= IRQ_DA830_T12CMPINT0_0,
-			.end	= IRQ_DA830_T12CMPINT0_0,
-			.flags	= IORESOURCE_IRQ,
-		},
-		.offset		= DA830_CMP12_0,
-	}
 };
 
 static const struct davinci_soc_info davinci_soc_info_da830 = {
---8<---

And the low-level debug with your patches shows that its hanging at 
delay loop calibration.

Uncompressing Linux... done, booting the kernel.                                
Booting Linux on physical CPU 0x0                                               
Linux version 5.0.0-rc1-08699-gc87d386784f3-dirty (a0875516@psplinux063) (gcc v9
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f                   
CPU: VIVT data cache, VIVT instruction cache                                    
Machine: DaVinci DA830/OMAP-L137/AM17x EVM                                      
Memory policy: Data cache writethrough                                          
cma: Reserved 16 MiB at 0xc2800000                                              
DaVinci da830/omap-l137 rev2.0 variant 0x9                                      
On node 0 totalpages: 14336                                                     
  DMA zone: 112 pages used for memmap                                           
  DMA zone: 0 pages reserved                                                    
  DMA zone: 14336 pages, LIFO batch:3                                           
random: get_random_bytes called from start_kernel+0x80/0x3ec with crng_init=0   
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768                                   
pcpu-alloc: [0] 0                                                               
Built 1 zonelists, mobility grouping on.  Total pages: 14224                    
Kernel command line: console=ttyS2,115200n8                                     
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)                   
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)                    
Memory: 33876K/57344K available (4607K kernel code, 308K rwdata, 1072K rodata, )
Virtual kernel memory layout:                                                   
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)                               
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)                               
    vmalloc : 0xc4000000 - 0xff800000   ( 952 MB)                               
    lowmem  : 0xc0000000 - 0xc3800000   (  56 MB)                               
    modules : 0xbf000000 - 0xc0000000   (  16 MB)                               
      .text : 0x(ptrval) - 0x(ptrval)   (4609 kB)                               
      .init : 0x(ptrval) - 0x(ptrval)   ( 212 kB)                               
      .data : 0x(ptrval) - 0x(ptrval)   ( 309 kB)                               
       .bss : 0x(ptrval) - 0x(ptrval)   ( 137 kB)                               
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1                      
rcu: Preemptible hierarchical RCU implementation.                               
        Tasks RCU enabled.                                                      
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.          
NR_IRQS: 245                                                                    
clocksource: timer0_0: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79s
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns       
Console: colour dummy device 80x30                                              
Calibrating delay loop... 
<hangs>

Thanks,
Sekhar
