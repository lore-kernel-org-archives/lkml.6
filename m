Return-Path: <lee.jones@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520845937; cv=none;
        d=google.com; s=arc-20160816;
        b=pd3N6bJ/mxud9k+f5WpFrVLXRLSfXm1ijIqzoSJ8gIZJhS93awzIgYmatoCZj+njXC
         syNQiK0VmkQDdNExvJS4FiBBEqtMoe1buN9K9/YjmA7xjksuF9tuTMq3/QrhRqiYd8Sv
         x0mS7Ftf1NRa89EBeSeoetb0+D4NjFxHM3R2py+1ThMxkUAP0I58PKnE2QLeSwrjqWic
         yFXYrCrjMrFzT832auM6JoAMygn2Xv2zCTA7RSsU2UpLIZs1AOioAstEqLhsvEng76RD
         T1qW8jC2DznwCrgeijMXRv9J4LIOMcTKrEQrHJUPU3Gq7P2q8SxPs+T9nLZgkcsmmJuM
         LJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=DBXBok3qChWsQu40hztxzFSVT9wcj+6JznfBAyoWiCQ=;
        b=dNT9SHDVs3CPmvaRyN3E9pKkbdg8iVxUiOVAZSxfZ4se245WdWUnOYt4PeatERWxfe
         oeyxQPEb5kbc0NaajMXgIw6iyqoMfF5zJzBTGgAyjsJgDtMXMyMFgpyCujQBKixkQykj
         O67Bqt73FdBXFghpUIYy609SIDTyuBVvikWDNlqx2e8Qdpmwh2QepMxPYbu3J8ab2Ian
         lbBQvgU8vKaZUVJVJYu4oWCfawUC5NUaRVRTAnz0F1KYKJhu9VHANdU+emQUD1NM3ivA
         aAXEWKAx81y9kSUHXOAZ5iAD/KwpW5YoriR17xSTdKrxk1f6sACm8mlZ6wLfOOWExFQT
         npPw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=G4nSXlBz;
       spf=pass (google.com: domain of lee.jones@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=lee.jones@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=G4nSXlBz;
       spf=pass (google.com: domain of lee.jones@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=lee.jones@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsmGbUFnE/ULCw9CH6ayWGyebqSVfpmA0ELmJWs6fq+MnIvJMv0UPybcdeTaGdWU/01c5pfrQ==
Date: Mon, 12 Mar 2018 09:12:14 +0000
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
Subject: Re: [RESEND PATCH v4 1/4] mfd: syscon: Set name of regmap_config
Message-ID: <20180312091214.f6dwq6q3eqqblfnf@dell>
References: <20180309084351.32009-1-jeffy.chen@rock-chips.com>
 <20180309084351.32009-2-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180309084351.32009-2-jeffy.chen@rock-chips.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594449087814408748?=
X-GMAIL-MSGID: =?utf-8?q?1594722550402214123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 09 Mar 2018, Jeffy Chen wrote:

> We are now allowing to register debugfs without a valid device, and not
> having a valid name will end up using "dummy*" to create debugfs dir.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v4: None
> Changes in v3:
> Modify commit message.
> 
>  drivers/mfd/syscon.c | 1 +
>  1 file changed, 1 insertion(+)

Is this the RESEND I requested?  I can still only see this patch.

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
