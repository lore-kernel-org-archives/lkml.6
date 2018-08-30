Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BF9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C54A20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C54A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeH3Tmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:42:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:40425 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbeH3Tmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:42:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 08:39:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="258532279"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.93])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2018 08:39:50 -0700
Subject: Re: [lkp-robot] [mm] 15d36fecd0:
 WARNING:at_kernel/memremap.c:#devm_memremap_pages
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Robert Elliott <elliott@hpe.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
References: <20180823030558.GE13343@shao2-debian>
 <e358a00a-5981-97e3-2cec-4beab9064267@intel.com>
 <6c1eb1c3-a46e-8bc8-3647-b4e02d674cc6@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.jiang@intel.com; prefer-encrypt=mutual; keydata=
 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
 o6nmKbYpUAltQObU2w==
Message-ID: <40f58aed-f435-8a64-c78c-45dc59e3b769@intel.com>
Date:   Thu, 30 Aug 2018 08:39:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6c1eb1c3-a46e-8bc8-3647-b4e02d674cc6@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/2018 02:22 AM, Rong Chen wrote:
> 
> 
> On 08/24/2018 12:55 AM, Dave Jiang wrote:
>> I am not able to reproduce when I booted my test system with "mem=8G
>> memmap=4G!8G". I ended up with a single pmem:
> The issue seems to be related to specific machines,
> If you need any other debug log, please tell me.

I'm not so sure it's a valid test as no real pmem would be broken up in
weird size like this. This is the side effect of using memmap to create
fake pmem. And I think the patch did it's job by warning and refusing to
create the conflicting region. We do plan to eventually fix this so
regions reside within the section can be done.

> 
> Best Regards,
> Rong Chen
> 
>> [   57.750556] nd_pmem namespace0.0: unable to guarantee persistence of
>> writes
>> [   57.881573] pmem0: detected capacity change from 0 to 4294967296
>>
>> However in the reported kmsg, it appears that memmap is splitting into 2
>> namespaces rather than providing a single one, and the first region
>> ended up ending in the same section as start of the second region and
>> thus triggered the warning and having the second namespace rejected.
>>
>> kern  :warn  : [   76.646531] nd_pmem namespace0.0: unable to guarantee
>> persistence of writes
>> kern  :info  : [   76.661660] pmem0: detected capacity change from 0 to
>> 534773760
>> kern  :warn  : [   76.670129] nd_pmem namespace1.0: unable to guarantee
>> persistence of writes
>> kern  :warn  : [   76.670290] ------------[ cut here ]------------
>> kern  :warn  : [   76.670372] nd_pmem namespace1.0: Conflicting mapping
>> in same section
>>
>>
>> On 08/22/2018 08:05 PM, kernel test robot wrote:
>>> FYI, we noticed the following commit (built with gcc-7):
>>>
>>> commit: 15d36fecd0bdc7510b70a0e5ec6671140b3fce0c ("mm: disallow
>>> mappings that conflict for devm_memremap_pages()")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git  master
>>>
>>> in testcase: ndctl
>>> with following parameters:
>>>
>>>
>>>
>>>
>>> on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz
>>> with 8G memory
>>>
>>> caused below changes (please refer to attached dmesg/kmsg for entire
>>> log/backtrace):
>>>
>>>
>>> +----------------+------------+------------+
>>> |                | 03758dbbe2 | 15d36fecd0 |
>>> +----------------+------------+------------+
>>> | boot_successes | 4          | 4          |
>>> +----------------+------------+------------+
>>>
>>>
>>>
>>> kern  :warn  : [   76.670496] WARNING: CPU: 2 PID: 213 at
>>> kernel/memremap.c:188 devm_memremap_pages+0x9f/0x470
>>> kern  :warn  : [   76.670665] Modules linked in: nd_pmem(O+)
>>> dax_pmem(O) device_dax(O) nd_btt(O) x86_pkg_temp_thermal
>>> intel_powerclamp coretemp snd_hda_codec_idt kvm_intel
>>> snd_hda_codec_generic kvm irqbypass crct10dif_pclmul crc32_pclmul
>>> crc32c_intel ghash_clmulni_intel cryptd nd_e820(O) pcspkr
>>> libnvdimm(O) ahci libahci nfit_test_iomap(O) libata snd_hda_intel
>>> i915 snd_hda_codec snd_hda_core snd_hwdep snd_pcm drm_kms_helper
>>> snd_timer syscopyarea sysfillrect sysimgblt fb_sys_fops snd soundcore
>>> drm video pcc_cpufreq ip_tables
>>> kern  :warn  : [   76.671408] CPU: 2 PID: 213 Comm: systemd-udevd
>>> Tainted: G           O      4.18.0-rc6-00155-g15d36fe #1
>>> kern  :warn  : [   76.671564] Hardware name: Hewlett-Packard
>>> p6-1451cx/2ADA, BIOS 8.15 02/05/2013
>>> kern  :warn  : [   76.671690] RIP: 0010:devm_memremap_pages+0x9f/0x470
>>> kern  :warn  : [   76.671774] Code: c6 74 78 49 8b 5f 50 48 85 db 75
>>> 04 49 8b 5f 10 4c 89 ff e8 13 77 42 00 48 89 da 48 89 c6 48 c7 c7 a8
>>> 62 0e 82 e8 51 8c eb ff <0f> 0b 49 8b be 80 00 00 00 65 ff 05 f1 59
>>> e4 7e 48 8b 47 08 a8 03
>>> kern  :warn  : [   76.672107] RSP: 0018:ffffc9000125fad8 EFLAGS:
>>> 00010282
>>> kern  :warn  : [   76.672197] RAX: 0000000000000000 RBX:
>>> ffff8801a969e310 RCX: 0000000000000006
>>> kern  :warn  : [   76.672316] RDX: 0000000000000007 RSI:
>>> 0000000000000086 RDI: ffff8801ffd16950
>>> kern  :warn  : [   76.672434] RBP: ffff8801a98030a0 R08:
>>> 000000000000036e R09: 000000000000000a
>>> kern  :warn  : [   76.672555] R10: 0000000000000000 R11:
>>> ffffffff82d6434d R12: 00000002ffffffff
>>> kern  :warn  : [   76.672673] R13: 0000000000000000 R14:
>>> ffff8801a98024a0 R15: ffff8801aae09808
>>> kern  :warn  : [   76.672793] FS:  00007fae9129e8c0(0000)
>>> GS:ffff8801ffd00000(0000) knlGS:0000000000000000
>>> kern  :warn  : [   76.672929] CS:  0010 DS: 0000 ES: 0000 CR0:
>>> 0000000080050033
>>> kern  :warn  : [   76.673026] CR2: 00007fae9127ec28 CR3:
>>> 00000001aafe8003 CR4: 00000000001606e0
>>> kern  :warn  : [   76.673145] Call Trace:
>>> kern  :warn  : [   76.673199]  ? devres_add+0x2f/0x40
>>> kern  :warn  : [   76.673266]  pmem_attach_disk+0x542/0x6a0 [nd_pmem]
>>> kern  :warn  : [   76.673354]  ? kobject_release+0x69/0x1a0
>>> kern  :warn  : [   76.673431]  ? nd_dax_probe+0xfc/0x120 [libnvdimm]
>>> kern  :warn  : [   76.673520]  nvdimm_bus_probe+0x69/0x150 [libnvdimm]
>>> kern  :warn  : [   76.673608]  driver_probe_device+0x2fa/0x470
>>> kern  :warn  : [   76.673685]  __driver_attach+0xdc/0x100
>>> kern  :warn  : [   76.673753]  ? driver_probe_device+0x470/0x470
>>> kern  :warn  : [   76.673831]  bus_for_each_dev+0x76/0xc0
>>> kern  :warn  : [   76.673900]  ? klist_add_tail+0x3b/0x70
>>> kern  :warn  : [   76.673968]  bus_add_driver+0x161/0x260
>>> kern  :warn  : [   76.674035]  ? 0xffffffffa0504000
>>> kern  :warn  : [   76.674096]  driver_register+0x5b/0xe0
>>> kern  :warn  : [   76.674162]  ? 0xffffffffa0504000
>>> kern  :warn  : [   76.674223]  do_one_initcall+0x46/0x1e4
>>> kern  :warn  : [   76.674293]  ? preempt_schedule_common+0x15/0x30
>>> kern  :warn  : [   76.674373]  ? _cond_resched+0x22/0x30
>>> kern  :warn  : [   76.674442]  ? kmem_cache_alloc_trace+0x3e/0x1e0
>>> kern  :warn  : [   76.674525]  do_init_module+0x5b/0x203
>>> kern  :warn  : [   76.674593]  load_module+0x1489/0x1b80
>>> kern  :warn  : [   76.674662]  ? ima_post_read_file+0x102/0x110
>>> kern  :warn  : [   76.674741]  ? __do_sys_finit_module+0xe9/0x110
>>> kern  :warn  : [   76.674820]  __do_sys_finit_module+0xe9/0x110
>>> kern  :warn  : [   76.674901]  do_syscall_64+0x5b/0x180
>>> kern  :warn  : [   76.674967]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> kern  :warn  : [   76.675055] RIP: 0033:0x7fae9011b229
>>> kern  :warn  : [   76.675116] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00
>>> 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89
>>> c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3f 4c
>>> 2b 00 f7 d8 64 89 01 48
>>> kern  :warn  : [   76.675449] RSP: 002b:00007ffeb0452908 EFLAGS:
>>> 00000246 ORIG_RAX: 0000000000000139
>>> kern  :warn  : [   76.675576] RAX: ffffffffffffffda RBX:
>>> 0000557dd7cccdf0 RCX: 00007fae9011b229
>>> kern  :warn  : [   76.675696] RDX: 0000000000000000 RSI:
>>> 00007fae90a34265 RDI: 000000000000000f
>>> kern  :warn  : [   76.675814] RBP: 00007fae90a34265 R08:
>>> 0000000000000000 R09: 00007ffeb0452e80
>>> kern  :warn  : [   76.675934] R10: 000000000000000f R11:
>>> 0000000000000246 R12: 0000000000000000
>>> kern  :warn  : [   76.676053] R13: 0000557dd7cde3c0 R14:
>>> 0000000000020000 R15: 0000557dd5d7dcbc
>>> kern  :warn  : [   76.676175] ---[ end trace 72888cbe8943c229 ]---
>>>
>>>
>>> To reproduce:
>>>
>>>          git clonehttps://github.com/intel/lkp-tests.git
>>>          cd lkp-tests
>>>          bin/lkp install job.yaml  # job file is attached in this email
>>>          bin/lkp run     job.yaml
>>>
>>>
>>>
>>> Thanks,
>>> lkp
>>>
> 
