Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeBSKUA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:20:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45053 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752507AbeBSKT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:19:59 -0500
Subject: Re: [PATCH] arm64: Fix compilation error while accessing
 MPIDR_HWID_BITMASK from .S files
To: Bhupesh Sharma <bhsharma@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
CC: <bhupesh.linux@gmail.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <36bd758c-dd49-edef-cc1a-20f5b43f5011@huawei.com>
Date: Mon, 19 Feb 2018 10:19:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2018 06:39, Bhupesh Sharma wrote:
> Since commit e1a50de37860b3a93a9d643b09638db5aff47650 (arm64: cputype:
> Silence Sparse warnings), compilation of arm64 architecture is broken
> with the following error messages:
>
>   AR      arch/arm64/kernel/built-in.o
>   arch/arm64/kernel/head.S: Assembler messages:
>   arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>   arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>   arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>   arch/arm64/kernel/head.S:677: Error: junk at end of line, first
>   unrecognized character is `L'
>   arch/arm64/kernel/head.S:677: Error: unexpected characters following
>   instruction at operand 2 -- `movz x1,:abs_g1_s:0xff00ffffffUL'
>   arch/arm64/kernel/head.S:677: Error: unexpected characters following
>   instruction at operand 2 -- `movk x1,:abs_g0_nc:0xff00ffffffUL'
>
> This patch fixes the same by using the UL() macro correctly for
> assigning the MPIDR_HWID_BITMASK macro value.
>
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  arch/arm64/include/asm/cputype.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index eda8c5f629fc..350c76a1d15b 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -20,7 +20,7 @@
>
>  #define MPIDR_UP_BITMASK	(0x1 << 30)
>  #define MPIDR_MT_BITMASK	(0x1 << 24)
> -#define MPIDR_HWID_BITMASK	0xff00ffffffUL
> +#define MPIDR_HWID_BITMASK	UL(0xff00ffffff)

Works for me.

FYI, I am using (old) gcc-linaro-4.8-2015.06-x86_64_aarch64.

Thanks,
John

>
>  #define MPIDR_LEVEL_BITS_SHIFT	3
>  #define MPIDR_LEVEL_BITS	(1 << MPIDR_LEVEL_BITS_SHIFT)
>
