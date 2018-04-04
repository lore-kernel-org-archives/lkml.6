Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx49ScaIiMPU5L4YNqjnZqBkWiJo1F+8njwEVSd0DPV0X0P3yLM60fj5t/W/qoRjmPsXArAXD
ARC-Seal: i=1; a=rsa-sha256; t=1522863246; cv=none;
        d=google.com; s=arc-20160816;
        b=u/L0OUimBYkMr9NLHjALPae/sHXf/W0RzY55cl83eFTdfSuIo6or6zSbzSO50LWkEA
         4i+eIgn4PnLzyTvlJx3Da68gjsdlmbJPC3QziJFgLhhe5EgLtMRlMU4509TrXYUNUpdJ
         09+qbIeqbacG8T4744xRVFHeDQFjhjU3h0sHLFvlwZVyO8QjPVgVTaiQ7B8ZzY4+GYcU
         mmGJGZljkZW6Os4g+qggBPafuKzSnwNHk/Ne7TTxbFKJMxM7L1cEIdA5ADO5ExZmW7Hr
         65fN/ybPiDXcPRAHJ5vY1qRjUEym5EJuQk0wGd/fYx93DD3Cqcc4hcq3JsRMKtKjUGt1
         orhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=3FVAobO0Tz4JWuKIv5xmBcXk2XmkeyVxJE6EowAIF7s=;
        b=A+uLpaKmDqyhDTdeQIh7zRxL/EC9XcMPorSB5ks3l6z3+46U0Bwl2gJdx33O1dy2Cy
         uaihqcdS2274TLNwDjy4v/0wyebpqNYJSO+YtQEnf4cuXJsAJPr31kehNshFBLLnZv/i
         Liesje111tjpc+Pa4Vd29eMBDWe2csrngPxvQYau6HMnFF/utOxVsdn+YrYiiLZ6hm39
         pV26szbQg3pyJ27IDK7q//RBn+NAECpU+5QXj7Q2oca7FYeGqSEwCqR65N7DSvoeECgR
         S3i2YLT/DShx8+ArXJDF1NjqNzcWQzkt/dcSd9JG2ryubIz6KBnYsuoteXdV4GUYzrJt
         bucw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=gh5JKgtx;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=gh5JKgtx;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH 1/3] adp5061: New driver for ADP5061 I2C battery charger
To: Stefan Popa <stefan.popa@analog.com>, sre@kernel.org, robh+dt@kernel.org,
 mark.rutland@arm.com
Cc: davem@davemloft.net, mchehab@kernel.org, gregkh@linuxfoundation.org,
 linus.walleij@linaro.org, akpm@linux-foundation.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <66d5534b-d383-733e-8e56-992dfec6ee90@infradead.org>
Date: Wed, 4 Apr 2018 10:33:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596802855517909169?=
X-GMAIL-MSGID: =?utf-8?q?1596837851530372481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,
one small typo below:

On 04/04/2018 01:17 AM, Stefan Popa wrote:

> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 428b426..761cc52 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -75,6 +75,17 @@ config BATTERY_88PM860X
>  	help
>  	  Say Y here to enable battery monitor for Marvell 88PM860x chip.
>  
> +config CHARGER_ADP5061
> +	tristate "ADP5061 battery charger driver"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say Y here to enable support for the ADP5061 standalone battery
> +	  charger.
> +
> +	  This driver can be build as a module. If so, the module will be

	                     built

> +	  called adp5061.
> +
>  config BATTERY_ACT8945A
>  	tristate "Active-semi ACT8945A charger driver"
>  	depends on MFD_ACT8945A || COMPILE_TEST


-- 
~Randy
