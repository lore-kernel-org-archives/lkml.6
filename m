Return-Path: <maxime.ripard@bootlin.com>
X-Google-Smtp-Source: AB8JxZosD2XSgdppc1Z3IudH/DfxSoHvMk8+YAWOz2tRGqlJqYLY1mPyVFdBAhOkpaTf+MxqGxXO
ARC-Seal: i=1; a=rsa-sha256; t=1525707732; cv=none;
        d=google.com; s=arc-20160816;
        b=t/Mq1YSjko6tF7RSuV+xB9oYlLXDuUbIcVDGzUs0hd+glTFnGOYnDjTgVjHA8MBRPl
         okzGWSBFs3UHIgIqp2pz6IT9Je0VhEbA8AWZrH6yeb8yNX8R2MHuKZ3WKSaxV14cZi0t
         LBcPe6CPmDlixHlYAdp0FW70O8DO30rHLqK0KSkq+j9XiqFqOW3h6h3MTdR+L1rc7gLJ
         kvkmBAUOqT8DCKCysaByr+VcedZSQLDmy9ZhIudbcAUy7cDFKwFfszhz0zcdZpeQpw7E
         45J6cmnjEjVOVmMcq4HEeHj0pZPBfZ0lvY8pe7YEVCX4GqdO1jvyAH4T17lINQgrbdS0
         FtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=2L0BBwvmMo+a9EBVtmB2bQnef6BcK/rAnECjZJjKjtI=;
        b=OhRAzIG6+B8yMtrQZlw4sDAbZB1Q09UrJZPwHCq+sRf3xe1GKhM7NtZtlN2Lwt4/uy
         G280v5QRcDFHSpxKoRnhQ1BrH4no8D3sQkbiiCZIZLbvi9kVNAlx69lRR1RpnEtWCC15
         lB4uqCMwl/8jxWjvglHVsWyoa90b5v8BxvwYoU85Tss9vNpPDaGAiGbDGMBdNmkL7YCR
         7RxEU3WdFVjskBFeIQatJZ9HD8AJH3z+iVffePyguuzEnEPwj9uS3UWu8IBAmnaRSj77
         FwtsckhiRxEArCSmRuUoab3+JKxJ+DgvWMnZgeUALSaXdlN/2MPEkAkoi5EX5o+yMUwl
         wZfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Date: Mon, 7 May 2018 17:42:01 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
	Yannick Fertre <yannick.fertre@st.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugues Fruchet <hugues.fruchet@st.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	Florent Revest <florent.revest@free-electrons.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Smitha T Murthy <smitha.t@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Randy Li <ayaka@soulik.info>
Subject: Re: [PATCH v3 11/14] media: platform: Add Sunxi-Cedrus VPU decoder
 driver
Message-ID: <20180507154201.4vz3y6j7u7kzfud6@flea>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
 <20180507124500.20434-12-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180507124500.20434-12-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809527197873190?=
X-GMAIL-MSGID: =?utf-8?q?1599820511231237398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 02:44:57PM +0200, Paul Kocialkowski wrote:
> +#define SYSCON_SRAM_CTRL_REG0	0x0
> +#define SYSCON_SRAM_C1_MAP_VE	0x7fffffff

This isn't needed anymore

> +	dev->ahb_clk =3D devm_clk_get(dev->dev, "ahb");
> +	if (IS_ERR(dev->ahb_clk)) {
> +		dev_err(dev->dev, "failed to get ahb clock\n");
> +		return PTR_ERR(dev->ahb_clk);
> +	}
> +	dev->mod_clk =3D devm_clk_get(dev->dev, "mod");
> +	if (IS_ERR(dev->mod_clk)) {
> +		dev_err(dev->dev, "failed to get mod clock\n");
> +		return PTR_ERR(dev->mod_clk);
> +	}
> +	dev->ram_clk =3D devm_clk_get(dev->dev, "ram");
> +	if (IS_ERR(dev->ram_clk)) {
> +		dev_err(dev->dev, "failed to get ram clock\n");
> +		return PTR_ERR(dev->ram_clk);
> +	}

Please add some blank lines between those blocks

> +	dev->rstc =3D devm_reset_control_get(dev->dev, NULL);

You're not checking the error code here

> +	dev->syscon =3D syscon_regmap_lookup_by_phandle(dev->dev->of_node,
> +						      "syscon");
> +	if (IS_ERR(dev->syscon)) {
> +		dev->syscon =3D NULL;
> +	} else {
> +		regmap_write_bits(dev->syscon, SYSCON_SRAM_CTRL_REG0,
> +				  SYSCON_SRAM_C1_MAP_VE,
> +				  SYSCON_SRAM_C1_MAP_VE);
> +	}

You don't need the syscon part anymore either

> +	ret =3D clk_prepare_enable(dev->ahb_clk);
> +	if (ret) {
> +		dev_err(dev->dev, "could not enable ahb clock\n");
> +		return -EFAULT;
> +	}
> +	ret =3D clk_prepare_enable(dev->mod_clk);
> +	if (ret) {
> +		clk_disable_unprepare(dev->ahb_clk);
> +		dev_err(dev->dev, "could not enable mod clock\n");
> +		return -EFAULT;
> +	}
> +	ret =3D clk_prepare_enable(dev->ram_clk);
> +	if (ret) {
> +		clk_disable_unprepare(dev->mod_clk);
> +		clk_disable_unprepare(dev->ahb_clk);
> +		dev_err(dev->dev, "could not enable ram clock\n");
> +		return -EFAULT;
> +	}
> +
> +	ret =3D reset_control_reset(dev->rstc);
> +	if (ret) {
> +		clk_disable_unprepare(dev->ram_clk);
> +		clk_disable_unprepare(dev->mod_clk);
> +		clk_disable_unprepare(dev->ahb_clk);
> +		dev_err(dev->dev, "could not reset device\n");
> +		return -EFAULT;

labels would simplify this greatly, and you should also release the
sram and the memory region here.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
