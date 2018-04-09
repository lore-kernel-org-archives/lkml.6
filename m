Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbeDIWFB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 18:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeDIWE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 18:04:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E8C21785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 9 Apr 2018 18:04:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <xiaolong.ye@intel.com>
Cc: linux-kernel@vger.kernel.org, lkp@01.org
Subject: Re: [lkp-robot] [init, tracing]  2580d6b795:
 BUG:kernel_reboot-without-warning_in_boot_stage
Message-ID: <20180409180454.1310abea@gandalf.local.home>
In-Reply-To: <20180409053252.GB27349@yexl-desktop>
References: <20180406191334.357550809@goodmis.org>
        <20180409053252.GB27349@yexl-desktop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2018 13:32:52 +0800
kernel test robot <xiaolong.ye@intel.com> wrote:

> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 2580d6b795e25879c825a0891cf67390f665b11f ("init, tracing: Have printk come through the trace events for initcall_debug")
> url: https://github.com/0day-ci/linux/commits/Steven-Rostedt/init-tracing/20180407-130743
> 
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu Nehalem -smp 2 -m 512M
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +------------------------------------------------------------------+------------+------------+
> |                                                                  | ecf6709d07 | 2580d6b795 |
> +------------------------------------------------------------------+------------+------------+
> | boot_successes                                                   | 0          | 0          |
> | boot_failures                                                    | 8          | 8          |
> | invoked_oom-killer:gfp_mask=0x                                   | 8          |            |
> | Mem-Info                                                         | 8          |            |
> | Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes | 8          |            |
> | BUG:kernel_reboot-without-warning_in_boot_stage                  | 0          | 8          |
> +------------------------------------------------------------------+------------+------------+

What does this mean?

> 
> 
> 
> [    0.000000] RAMDISK: [mem 0x1b7e2000-0x1ffcffff]
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: RSDP 0x00000000000F6860 000014 (v00 BOCHS )
> [    0.000000] ACPI: RSDT 0x000000001FFE1628 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
> [    0.000000] ACPI: FACP 0x000000001FFE147C 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
> BUG: kernel reboot-without-warning in boot stage
> 
> Elapsed time: 10
> 
> #!/bin/bash
> 
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script  # job-script is attached in this email
> 

The config boots fine for me. But I don't have the setup to run the
above and get it to work, nor the time to figure out why it doesn't
work.

-- Steve
