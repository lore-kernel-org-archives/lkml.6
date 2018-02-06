Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeBFQQS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:16:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39374 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752369AbeBFQQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:16:14 -0500
Subject: Re: [PATCH 10/20] lib/Kconfig: Remove leftover select of GENERIC_IO
To: Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com,
        m.szyprowski@samsung.com, egtvedt@samfundet.no,
        linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com,
        yamada.masahiro@socionext.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Dave Airlie <airlied@redhat.com>,
        Jeremy Kerr <jk@ozlabs.org>, Bart Van Assche <bart.vanassche@wdc.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <20180205012146.23981-11-ulfalizer@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f39ad6ff-b4f7-0901-21e4-1469ed0ed9f2@arm.com>
Date: Tue, 6 Feb 2018 16:16:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205012146.23981-11-ulfalizer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/18 01:21, Ulf Magnusson wrote:
> GENERIC_IO was removed by commit 9de8da47742b ("kconfig: kill off
> GENERIC_IO option"), but HAS_IOMEM still selects it.
> 
> Remove the select of GENERIC_IO from HAS_IOMEM.
> 
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.

Since I also stumbled over this and tried to fix it,

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>   lib/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index e96089499371..8ce8bcad6eff 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -396,7 +396,6 @@ config ASSOCIATIVE_ARRAY
>   config HAS_IOMEM
>   	bool
>   	depends on !NO_IOMEM
> -	select GENERIC_IO
>   	default y
>   
>   config HAS_IOPORT_MAP
> 
