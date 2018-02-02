Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbeBBEEm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 23:04:42 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15696 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751589AbeBBEEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 23:04:33 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="36655284"
Subject: Re: [PATCH v2 0/2] x86/apic/kexec: Legacy irq setting fixs in kdump
 kernel
To: Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <ebiederm@xmission.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <x86@kernel.org>, <joro@8bytes.org>,
        <uobergfe@redhat.com>, <prarit@redhat.com>
References: <20180125141134.25053-1-bhe@redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <69a94ca6-6974-deff-f194-abfcdcc028f1@cn.fujitsu.com>
Date: Fri, 2 Feb 2018 12:04:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180125141134.25053-1-bhe@redhat.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 7A08E486A78C.AD9B4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

At 01/25/2018 10:11 PM, Baoquan He wrote:
> This is v2 post.
> 
> In v2, no code change, just improve change log of patch 1 and 2.
> 
> And drop the old patch 3 in v1, a clean up patch. The current
> x86_io_apic_ops.disable() hook is still needed by irq remapping.
> 
> Baoquan He (2):

Test these patches in both 32bit and 64bit of x86 arches. feel free to
add my Tested-by.

Tested-by: Dou Liyang <douly.fnst@cn.fujitsu.com>

Thanks,
	dou.

>    x86/apic/kexec: Enable legacy irq mode before jump to kexec/kdump
>      kernel
>    x86/apic: Set up through-local-APIC on boot CPU's LINT0 if 'noapic'
>      specified
> 
>   arch/x86/include/asm/io_apic.h     |  3 ++-
>   arch/x86/kernel/apic/apic.c        |  2 +-
>   arch/x86/kernel/apic/io_apic.c     | 12 ++++--------
>   arch/x86/kernel/crash.c            |  2 +-
>   arch/x86/kernel/machine_kexec_32.c | 15 +++++----------
>   arch/x86/kernel/machine_kexec_64.c | 15 +++++----------
>   arch/x86/kernel/reboot.c           |  2 +-
>   7 files changed, 19 insertions(+), 32 deletions(-)
> 
