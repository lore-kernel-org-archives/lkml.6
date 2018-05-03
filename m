Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeECIs5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:48:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35552 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbeECIsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:48:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4AE2E601A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH 1/2] arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
To: Ganesh Mahendran <opensource.ganesh@gmail.com>,
        ldufour@linux.vnet.ibm.com, catalin.marinas@arm.com,
        will.deacon@arm.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1525247672-2165-1-git-send-email-opensource.ganesh@gmail.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <1bc3ec9e-606b-e019-f870-ce4a2520cdbf@codeaurora.org>
Date: Thu, 3 May 2018 14:18:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525247672-2165-1-git-send-email-opensource.ganesh@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/2018 1:24 PM, Ganesh Mahendran wrote:
> Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT for arm64. This
> enables Speculative Page Fault handler.
> 
> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
> ---
> This patch is on top of Laurent's v10 spf
> ---
>   arch/arm64/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index eb2cf49..cd583a9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -144,6 +144,7 @@ config ARM64
>   	select SPARSE_IRQ
>   	select SYSCTL_EXCEPTION_TRACE
>   	select THREAD_INFO_IN_TASK
> +	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT if SMP
>   	help
>   	  ARM 64-bit (AArch64) Linux support.
>   
> 

You may also consider re-ordering of patches in next version. Generally,
config enablement assumes effectiveness of that config.

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
