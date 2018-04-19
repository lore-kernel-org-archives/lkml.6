Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeDSSio (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 14:38:44 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:57313 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeDSSin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 14:38:43 -0400
Date: Thu, 19 Apr 2018 11:38:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greentime Hu <green.hu@gmail.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        private@roeck-us.net
Subject: Re: [9/9] nds32: Fix the allmodconfig build. To make sure
 CONFIG_CPU_LITTLE_ENDIAN is default y
Message-ID: <20180419183840.GA500@roeck-us.net>
References: <21ef6561299cdbbe0f3571c5048a2eaf5eb43bc7.1524143428.git.greentime@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ef6561299cdbbe0f3571c5048a2eaf5eb43bc7.1524143428.git.greentime@andestech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 09:18:15PM +0800, Greentime Hu wrote:
> This way we can build kernel with CONFIG_CPU_LITTLE_ENDIAN=y and allmodconfig
> will be available.
> 
> Signed-off-by: Greentime Hu <greentime@andestech.com>

As Arnd suspected, this causes allnoconfig to fail.
The failure is due to endianness mismatches in vdso code.

Not sure if that is really an improvement.

Guenter

> ---
>  arch/nds32/Kconfig.cpu | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
> index ba44cc539da9..b8c8984d1456 100644
> --- a/arch/nds32/Kconfig.cpu
> +++ b/arch/nds32/Kconfig.cpu
> @@ -1,10 +1,11 @@
>  comment "Processor Features"
>  
>  config CPU_BIG_ENDIAN
> -	bool "Big endian"
> +	def_bool !CPU_LITTLE_ENDIAN
>  
>  config CPU_LITTLE_ENDIAN
> -        def_bool !CPU_BIG_ENDIAN
> +	bool "Little endian"
> +	default y
>  
>  config HWZOL
>  	bool "hardware zero overhead loop support"
