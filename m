Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751802AbeEDGFT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 02:05:19 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38115 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDGFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 02:05:07 -0400
X-Google-Smtp-Source: AB8JxZpx8+v5PY/5M80rwmJl8w6sRs0ltEknFwQGUpfm3NU4TTDD0IrTyDzm+Aj7inFcpgmXhQp5RakHKyGw6LoJEIM=
MIME-Version: 1.0
In-Reply-To: <20180502122314.GB30246@arm.com>
References: <1525247602-1565-1-git-send-email-opensource.ganesh@gmail.com> <20180502122314.GB30246@arm.com>
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Date: Fri, 4 May 2018 14:05:06 +0800
Message-ID: <CADAEsF86bXkK3qjJTKR6aqEEp_ch6HqSHeDy3afZF0wcVPFPRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
To: Will Deacon <will.deacon@arm.com>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-02 20:23 GMT+08:00 Will Deacon <will.deacon@arm.com>:
> On Wed, May 02, 2018 at 03:53:21PM +0800, Ganesh Mahendran wrote:
>> Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT for arm64. This
>> enables Speculative Page Fault handler.
>
> Are there are tests for this? I'm really nervous about enabling it...

Hi, Will

I test the arm64 spf on Qcom SDM845 cpu with kernel 4.9.
It looks good for performance, and have not found stability issue yet.

Thanks.

>
> Will
>
>>
>> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
>> ---
>> This patch is on top of Laurent's v10 spf
>> ---
>>  arch/arm64/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index eb2cf49..cd583a9 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -144,6 +144,7 @@ config ARM64
>>       select SPARSE_IRQ
>>       select SYSCTL_EXCEPTION_TRACE
>>       select THREAD_INFO_IN_TASK
>> +     select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT if SMP
>>       help
>>         ARM 64-bit (AArch64) Linux support.
>>
>> --
>> 1.9.1
>>
