Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752301AbeDHBfa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 21:35:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43570 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeDHBf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 21:35:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52BA160540
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date: Sat, 7 Apr 2018 20:35:25 -0500
From: Richard Kuo <rkuo@codeaurora.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hexagon: fix ffz/fls/ffs return type
Message-ID: <20180408013525.GE3036@codeaurora.org>
References: <20180406142832.2243021-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406142832.2243021-1-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 04:28:21PM +0200, Arnd Bergmann wrote:
> Let's use the same return type as the major architectures to
> avoid warnings like
> 
> drivers/ata/libahci_platform.c: In function 'ahci_platform_init_host':
> drivers/ata/libahci_platform.c:561:12: warning: comparison of distinct pointer types lacks a cast [enabled by default]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/hexagon/include/asm/bitops.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
> index 5e4a59b3ec1b..8790a50b1f5e 100644
> --- a/arch/hexagon/include/asm/bitops.h
> +++ b/arch/hexagon/include/asm/bitops.h
> @@ -194,7 +194,7 @@ static inline int __test_bit(int nr, const volatile unsigned long *addr)
>   *
>   * Undefined if no zero exists, so code should check against ~0UL first.
>   */
> -static inline long ffz(int x)
> +static inline int ffz(int x)
>  {
>  	int r;
>  
> @@ -211,7 +211,7 @@ static inline long ffz(int x)
>   * This is defined the same way as ffs.
>   * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
>   */
> -static inline long fls(int x)
> +static inline int fls(int x)
>  {
>  	int r;
>  
> @@ -232,7 +232,7 @@ static inline long fls(int x)
>   * the libc and compiler builtin ffs routines, therefore
>   * differs in spirit from the above ffz (man ffs).
>   */
> -static inline long ffs(int x)
> +static inline int ffs(int x)
>  {
>  	int r;
>  


Isn't ffz usually long/unsigned long on other architectures?





-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
