Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754862AbeCSAlQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 20:41:16 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:63654 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754646AbeCSAlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 20:41:14 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37918255"
Subject: Re: [ACPI / processor] d619c81e24:
 WARNING:at_include/linux/cpumask.h:#cpumask_test_cpu
To: kernel test robot <fengguang.wu@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <tglx@linutronix.de>,
        <rafael@kernel.org>, <dedekind1@gmail.com>, <ming.lei@redhat.com>,
        <lkp@01.org>
References: <20180316111752.qi3u42mag367vx46@inn>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <6212a66a-e301-4f9f-d435-34063da9df4f@cn.fujitsu.com>
Date: Mon, 19 Mar 2018 08:41:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180316111752.qi3u42mag367vx46@inn>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 99BF54D0EFF9.ACF5B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lkp team

Thank you for testing.

At 03/16/2018 07:17 PM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: d619c81e246424e322f7a902bed6e60b90668d56 ("ACPI / processor: Get accurate possible CPU count")
> url: https://github.com/0day-ci/linux/commits/Dou-Liyang/ACPI-processor-Get-accurate-possible-CPU-count/20180316-140349
> 
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 1G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +------------------------------------------------------+------------+------------+
> |                                                      | 3266b5bd97 | d619c81e24 |
> +------------------------------------------------------+------------+------------+
> | boot_successes                                       | 16         | 2          |
> | boot_failures                                        | 0          | 18         |
> | WARNING:at_include/linux/cpumask.h:#cpumask_test_cpu | 0          | 18         |
> | WARNING:at_include/linux/cpumask.h:#cpumask_check    | 0          | 18         |
> | RIP:cpumask_check                                    | 0          | 18         |
> | RIP:cpumask_test_cpu                                 | 0          | 18         |
> | general_protection_fault:#[##]                       | 0          | 13         |
> | RIP:__lock_acquire                                   | 0          | 13         |
> | Kernel_panic-not_syncing:Fatal_exception             | 0          | 13         |
> | BUG:kernel_hang_in_boot_stage                        | 0          | 5          |
> +------------------------------------------------------+------------+------------+
> 
> 
> 
> [    0.830741] WARNING: CPU: 1 PID: 1 at include/linux/cpumask.h:122 cpumask_test_cpu+0x32/0x57
> [    0.830785] WARNING: CPU: 1 PID: 1 at include/linux/cpumask.h:122 cpumask_check+0x2d/0x48

Yes, this patch broke the number of CPUs, we will find out a new way,
please drop the test work of this patch.

Thanks,
	dou
