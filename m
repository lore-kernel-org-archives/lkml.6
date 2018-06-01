Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753291AbeFATEQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:04:16 -0400
Received: from s153.web-hosting.com ([198.54.120.75]:54899 "EHLO
        s153.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbeFATEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:04:14 -0400
Subject: Re: [linux-sunxi] [PATCH] arm: sun4i: Add support for Pengpod 1000
 tablet
To: rah@settrans.net, Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180601175538.16716-1-rah@settrans.net>
From: Jagan Teki <jagan@openedev.com>
Message-ID: <29aec3c3-61af-b814-351b-6faf31a8cea3@openedev.com>
Date: Fri, 1 Jun 2018 23:46:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180601175538.16716-1-rah@settrans.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server153.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - openedev.com
X-Get-Message-Sender-Via: server153.web-hosting.com: authenticated_id: jagan@openedev.com
X-Authenticated-Sender: server153.web-hosting.com: jagan@openedev.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2018 11:25 PM, Bob Ham wrote:
> This is initial support for the Pengpod 1000 tablet.  The display is
> not currently working but the UART, SD card and USB all work fine.
> 
> Signed-off-by: Bob Ham <rah@settrans.net>
> ---
>   arch/arm/boot/dts/Makefile                   |   1 +
>   arch/arm/boot/dts/sun4i-a10-pengpod-1000.dts | 232 +++++++++++++++++++++++++++
>   2 files changed, 233 insertions(+)
>   create mode 100644 arch/arm/boot/dts/sun4i-a10-pengpod-1000.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38543dc..e6e93e7ffc8b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -893,6 +893,7 @@ dtb-$(CONFIG_MACH_SUN4I) += \
>   	sun4i-a10-olinuxino-lime.dtb \
>   	sun4i-a10-pcduino.dtb \
>   	sun4i-a10-pcduino2.dtb \
> +	sun4i-a10-pengpod-1000.dtb \
>   	sun4i-a10-pov-protab2-ips9.dtb
>   dtb-$(CONFIG_MACH_SUN5I) += \
>   	sun5i-a10s-auxtek-t003.dtb \
> diff --git a/arch/arm/boot/dts/sun4i-a10-pengpod-1000.dts b/arch/arm/boot/dts/sun4i-a10-pengpod-1000.dts
> new file mode 100644
> index 000000000000..94560400114d
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun4i-a10-pengpod-1000.dts
> @@ -0,0 +1,232 @@
> +/*
> + * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
> + * Copyright 2017 Robert Ham <rah@settrans.net>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */

We need to use SPDX-License for new dts files.
