Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx4+CX8CG8f+1pyPVHu4cng3QoILaalSJof0FLNkjkI6FAtsckN13W8cMX8tCmFSbRLjUaOC9
ARC-Seal: i=1; a=rsa-sha256; t=1524584354; cv=none;
        d=google.com; s=arc-20160816;
        b=cd7R3bDuBmFZhY/IlpppZvDZjdCOTe2uykJ8YgUCnu2DjReORfYorJg17kG1E6fMBR
         t0pMbJM9WEn/xTZvdkfovjXWwPvPA64mI/XGYVQX9SJZ8q3MpQPxTzBviH8TlXmG4NDk
         74Qw6Fj45n8uHbtvr7WU2GSMAsD2WgJjwypIvedQkMghqtbDfw4Phm3k9jVs1GewwTMy
         Fv37r+NfzM29AF2W1xRO7OE1wumeUl6hlF2OkYbKWewN0nj3hK5QOms3N+8+B7ARiwSj
         KiK58qUYj2ewdRG5xKevY0+6gMAkVU7SV/EiKSHVs7X4qYJYiHVu4HBEsvP8AGeKV1gu
         ZeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=lAcsxrRZvsYgQ5WwE8NfUoONgRdKDP3j1hxq4gW09Rw=;
        b=o0f9LQeBsOi6XYf56zAfuLCV+asFyu1geh8nYkvubAG6thcfgQlT43aq8BLcQ8eY7T
         ghk1MWNSMDC8BfKVp39nLH45bjjCRBOdu670GFP/cJ4qqscNyeI094tCfRz4obOSugX2
         w1tuEkSCnnDZpFZF7uum1b1JRPbiGCLnWrlguivDVLfo7w/QKgyyVprYo1bpQf3s6Urj
         yAHnXgV1H0epIym9NbPRdtqcIRWuC4QqoM7CgsegkqMOsZAReQclAVMGdD7A+vK7Ff0i
         xgcBKXSIog/KG5W+n4235sZeH2tsoVhWkK4Ljh0cddTy2S/CZgI3jx7gUAjkTFPvNLyq
         Cvcg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=sjSQYfjr;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=sjSQYfjr;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [v2 resend 03/10] mfd: mtk-mmsys: Add mmsys driver
To: matthias.bgg@kernel.org, ulrich.hecht+renesas@gmail.com,
 laurent.pinchart@ideasonboard.com, ck.hu@mediatek.com,
 p.zabel@pengutronix.de, airlied@linux.ie, robh+dt@kernel.org,
 mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org,
 lee.jones@linaro.org
Cc: davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org,
 pi-cheng.chen@linaro.org, sean.wang@mediatek.com, linux-clk@vger.kernel.org,
 linux@armlinux.org.uk, matthias.bgg@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
 <99bef17c57ad60eff6104da780cf59b785bd3e42.1524563001.git.mbrugger@suse.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9b023ba1-fb66-a955-e54d-d0a9cbbd7b45@infradead.org>
Date: Tue, 24 Apr 2018 08:39:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <99bef17c57ad60eff6104da780cf59b785bd3e42.1524563001.git.mbrugger@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598620441795227441?=
X-GMAIL-MSGID: =?utf-8?q?1598642563516813673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/24/2018 02:47 AM, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The MMSYS subsystem includes clocks and drm components.
> This patch adds a MFD device to probe both drivers from the same
> device tree compatible.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  drivers/mfd/Kconfig     |  9 ++++++
>  drivers/mfd/Makefile    |  2 ++
>  drivers/mfd/mtk-mmsys.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
>  create mode 100644 drivers/mfd/mtk-mmsys.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b860eb5aa194..a2c928e26026 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -378,6 +378,15 @@ config MFD_MC13XXX_I2C
>  	help
>  	  Select this if your MC13xxx is connected via an I2C bus.
>  
> +config MFD_MEDIATEK_MMSYS
> +	tristate "Mediatek MMSYS interface"
> +	select MDF_CORE

	select MFD_CORE

tested??

> +	select REGMAP_MMIO
> +	help
> +	  Select this if you have a MMSYS subsystem in your SoC. The
> +	  MMSYS subsystem has at least a clock driver part and some
> +	  DRM components.
> +
>  config MFD_MXS_LRADC
>  	tristate "Freescale i.MX23/i.MX28 LRADC"
>  	depends on ARCH_MXS || COMPILE_TEST


-- 
~Randy
