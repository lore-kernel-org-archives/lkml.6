Return-Path: <lee.jones@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520863616; cv=none;
        d=google.com; s=arc-20160816;
        b=IQQEh9X4XoNb7Dh2y3BwCF5b+PT45zYTbNT9Vz8dIV4OkYRqOuM5vqcS18fJaMSdTO
         2zRmLdpdetlPcqcSm89NQYm5p0QzkqmN2MfeXGcgZ3dnIksrUBGOIwH3R3VNqNWkaBbT
         8juIlwsflUFb+Yuw6KPbbxNtDoK4Qzp1dAE2FKa7wzotlzH8EWEggGawWLOKXn9r8XRE
         rm+SNCvHsfMcIUMaYGvAmjeKK+7Upg5Ef6k9WQaAwJNbMmyWLi85A0mzkFcvp11TO50d
         S4Yzm9VwPjQd6NTAPUay7l0bw7hOVagVtBZM1n31r1KEYGBX9wapfOncMfQdAGdmNWw6
         0TCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=XiXwxzOP3Vn4euSdm5E0MctD1pEv+T/tdG+utHUecoU=;
        b=XjLnZY8Jsp5wHEnLOWco+Fzn6dp68gKgnTGXB+DJV/WnERpxVaPq2TSbrSkyHh+6aI
         wF/GM3KbU/tnkdiBC/HEzxvq6IGmUeUlWeYiBtSHkUMGGDeCUHi20cIMZS5QkKKL0HPe
         ppofA25gyF82mLY4U4GFOAO8WYnFrOBJcPcFrOvFAq3dn3PrZ4Vlz3Q6O05nnMct6RIj
         hhuuODJDL0oJCyi2iCVfutk16NW8UBnEwNGpNPVP4QpbSxq0HbWtbGRl9nbEBiTns7gz
         ccx1AlXjlgg0rE2OpWtpoZbP/dOEF2ckAhnq6rpa8heZOnd8meWlS7ouTUHlTLsxYQBV
         i03A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kd4DTFFk;
       spf=pass (google.com: domain of lee.jones@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=lee.jones@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kd4DTFFk;
       spf=pass (google.com: domain of lee.jones@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=lee.jones@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvO18EXrbUkXgZVC1zEghsXkLDxGsPUrfgbo5ZfqgAcV9kAh2SsVKQEW7IyI+BKCLS4J+P0rA==
Date: Mon, 12 Mar 2018 14:06:52 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org,
	alexandre.belloni@bootlin.com, Guenter Roeck <linux@roeck-us.net>,
	Arnd Bergmann <arnd@arndb.de>, Joseph Lo <josephl@nvidia.com>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Heiko Stuebner <heiko@sntech.de>,
	Brian Norris <briannorris@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	linux-rockchip@lists.infradead.org,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-input@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org,
	stephen lu <lumotuwe@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 1/4] mfd: syscon: Set name of regmap_config
Message-ID: <20180312140652.7ffdls4pccih32vk@dell>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
 <20180312095142.30854-2-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180312095142.30854-2-jeffy.chen@rock-chips.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594449087814408748?=
X-GMAIL-MSGID: =?utf-8?q?1594741087020795157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 12 Mar 2018, Jeffy Chen wrote:

> We are now allowing to register debugfs without a valid device, and not
> having a valid name will end up using "dummy*" to create debugfs dir.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v5:
> CC lee.jones@linaro.org
> 
> Changes in v4: None
> Changes in v3:
> Modify commit message.
> 
>  drivers/mfd/syscon.c | 1 +
>  1 file changed, 1 insertion(+)

Looks okay.  Applied, thanks.

> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index fc9ba0ea4e44..b6d05cd934e6 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -110,6 +110,7 @@ static struct syscon *of_syscon_register(struct device_node *np)
>  	syscon_config.reg_stride = reg_io_width;
>  	syscon_config.val_bits = reg_io_width * 8;
>  	syscon_config.max_register = resource_size(&res) - reg_io_width;
> +	syscon_config.name = of_node_full_name(np);
>  
>  	regmap = regmap_init_mmio(NULL, base, &syscon_config);
>  	if (IS_ERR(regmap)) {

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
