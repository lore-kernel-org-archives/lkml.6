Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeDJBZ4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:25:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:25449 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbeDJBZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:25:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,429,1517904000";
   d="scan'208";a="45569879"
Date: Tue, 10 Apr 2018 09:23:40 +0800
From: Ye Xiaolong <xiaolong.ye@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, lkp@01.org
Subject: Re: [lkp-robot] [init, tracing]  2580d6b795:
 BUG:kernel_reboot-without-warning_in_boot_stage
Message-ID: <20180410012340.GA17893@yexl-desktop>
References: <20180406191334.357550809@goodmis.org>
 <20180409053252.GB27349@yexl-desktop>
 <20180409180454.1310abea@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409180454.1310abea@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Steven

On 04/09, Steven Rostedt wrote:
>On Mon, 9 Apr 2018 13:32:52 +0800
>kernel test robot <xiaolong.ye@intel.com> wrote:
>
>> FYI, we noticed the following commit (built with gcc-7):
>> 
>> commit: 2580d6b795e25879c825a0891cf67390f665b11f ("init, tracing: Have printk come through the trace events for initcall_debug")
>> url: https://github.com/0day-ci/linux/commits/Steven-Rostedt/init-tracing/20180407-130743
>> 
>> 
>> in testcase: boot
>> 
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu Nehalem -smp 2 -m 512M
>> 
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>> 
>> 
>> +------------------------------------------------------------------+------------+------------+
>> |                                                                  | ecf6709d07 | 2580d6b795 |
>> +------------------------------------------------------------------+------------+------------+
>> | boot_successes                                                   | 0          | 0          |
>> | boot_failures                                                    | 8          | 8          |
>> | invoked_oom-killer:gfp_mask=0x                                   | 8          |            |
>> | Mem-Info                                                         | 8          |            |
>> | Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes | 8          |            |
>> | BUG:kernel_reboot-without-warning_in_boot_stage                  | 0          | 8          |
>> +------------------------------------------------------------------+------------+------------+
>
>What does this mean?

It means BUG:BUG:kernel_reboot-without-warning_in_boot_stage occurred 8 times
in boot tests for commit 2580d6b795, while 0 time for its parent ecf6709d07.

>
>> 
>> 
>> 
>> [    0.000000] RAMDISK: [mem 0x1b7e2000-0x1ffcffff]
>> [    0.000000] ACPI: Early table checksum verification disabled
>> [    0.000000] ACPI: RSDP 0x00000000000F6860 000014 (v00 BOCHS )
>> [    0.000000] ACPI: RSDT 0x000000001FFE1628 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
>> [    0.000000] ACPI: FACP 0x000000001FFE147C 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
>> BUG: kernel reboot-without-warning in boot stage
>> 
>> Elapsed time: 10
>> 
>> #!/bin/bash
>> 
>> 
>> 
>> To reproduce:
>> 
>>         git clone https://github.com/intel/lkp-tests.git
>>         cd lkp-tests
>>         bin/lkp qemu -k <bzImage> job-script  # job-script is attached in this email
>> 
>
>The config boots fine for me. But I don't have the setup to run the
>above and get it to work, nor the time to figure out why it doesn't
>work.

Could you paste your failure log here, we can see if there is something we can help.


Thanks,
Xiaolong

>
>-- Steve
