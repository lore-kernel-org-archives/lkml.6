Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753362AbeBERSR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:18:17 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:36034 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbeBERSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:18:08 -0500
Subject: Re: [PATCH 19/20] ARC: Fix malformed ARC_EMUL_UNALIGNED default
To: Ulf Magnusson <ulfalizer@gmail.com>, <linux-kernel@vger.kernel.org>
CC: <robh@kernel.org>, <linux-snps-arc@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <tony@atomide.com>,
        <linus.walleij@linaro.org>, <sboyd@codeaurora.org>,
        <mina86@mina86.com>, <tfiga@chromium.org>, <paulus@ozlabs.org>,
        <yamada.masahiro@socionext.com>, <paul.burton@mips.com>,
        <npiggin@gmail.com>, <will.deacon@arm.com>, <egtvedt@samfundet.no>,
        <mgorman@techsingularity.net>, <hch@lst.de>,
        <m.szyprowski@samsung.com>
Newsgroups: gmane.linux.kernel.arc,gmane.linux.kernel,gmane.linux.kbuild.devel
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <20180205012146.23981-20-ulfalizer@gmail.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <2e1dcff1-8bf6-39ce-9646-2441a78a3e34@synopsys.com>
Date: Mon, 5 Feb 2018 09:17:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205012146.23981-20-ulfalizer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.84]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2018 05:21 PM, Ulf Magnusson wrote:
> 'default N' should be 'default n', though they happen to have the same
> effect here, due to undefined symbols (N in this case) evaluating to n
> in a tristate sense.
> 
> Remove the default from ARC_EMUL_UNALIGNED instead of changing it. bool
> and tristate symbols implicitly default to n.
> 
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
> 
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>


Added to ARC for-curr.

Thx,
-Vineet

> ---
>   arch/arc/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index f3a80cf164cc..d76bf4a83740 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -484,7 +484,6 @@ config ARC_CURR_IN_REG
>   
>   config ARC_EMUL_UNALIGNED
>   	bool "Emulate unaligned memory access (userspace only)"
> -	default N
>   	select SYSCTL_ARCH_UNALIGN_NO_WARN
>   	select SYSCTL_ARCH_UNALIGN_ALLOW
>   	depends on ISA_ARCOMPACT
> 
