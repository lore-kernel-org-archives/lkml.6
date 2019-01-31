Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6876BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA482184D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYVz8jXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfAaE3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 23:29:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45708 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfAaE3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 23:29:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so1250468lfa.12;
        Wed, 30 Jan 2019 20:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P47i+2zfvjQWQLH0J9PLLb7rxHkQV8NutJJc0QQhn4o=;
        b=FYVz8jXHjWsflxRDo6acH89Fe1EmX/Yhz66hiLTC9m/GEinEALafCXanu0ziNv7oQg
         f3YlEWx1eYSiRijeYlOnYC2KHiMjpLLUHgOTfLTAp6k+pZfXwXEnteFdn3ml7j0ePpoh
         DouSjQPHd23dexosqOZO9m9z/oqmyT8XdAhB+YBtDbgHYY4xWlhTPLdZ33kYQ2fIbx/X
         0d4OdYVj3istPKbfwdyICo+cHeE3BEg1HDsSm8AsXu2MU5+rV30kBLaJ2SdGiZ1DcHht
         SeY+ap6rFHYZqW5JWPd4nvx/C2zEIA7L6J7ou5MgtVwnsCqLRyucl+c9IMpX5G5lbW3A
         c9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P47i+2zfvjQWQLH0J9PLLb7rxHkQV8NutJJc0QQhn4o=;
        b=hFLYF4ss6vtNrT7vJHejgB6ipVPV+ppEwA3/ZOX7Fr1YL1SIrHxHTEafQ/K8qsA4uf
         6bJtXYmRLlclhNlKQ7UJeszzAVt+qG8iRwIpCxn9DSFq+4W2O6XpAoDPBNi26SdwTh+W
         I2NHt3srBn9P4hrmdA/JM1NcJd9bOxsrYF/azw+9bPadvP7Y6P+Pr+Y8DpI6+5eLwF9S
         bwUrMArRKQd2ayGzuOPp4QuDnIOz6p3duRMWODfNps9OzKG2i1ehx7Qp9ISjDtX0bGIt
         m71v/lf7WG/q1lB1fY9Nri/hxWM84y4gOT8DDsuFwY0vOtflsSPC+HsuenCoZQotUGtO
         c/Uw==
X-Gm-Message-State: AJcUukd+su9PTYf5J15L+eLTz4NJplFs9nMI1IgD06vnguTYwoQgaitk
        wQxRmg3jea3zGPQjGVukYxo=
X-Google-Smtp-Source: ALg8bN5DS+y3ZtS+4LNtFJgkvt3ctqQkEi7Zf0QdDYRkI4DsVMW0Bf2MqatJJMbwbUD7RNQmZrw+FQ==
X-Received: by 2002:a19:a60c:: with SMTP id p12mr26174873lfe.63.1548908990391;
        Wed, 30 Jan 2019 20:29:50 -0800 (PST)
Received: from dimatab (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id g15sm612094lfb.1.2019.01.30.20.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 20:29:50 -0800 (PST)
Date:   Thu, 31 Jan 2019 07:30:14 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V7 5/5] i2c: tegra: Add I2C interface timing support
Message-ID: <20190131073014.1ac6c35b@dimatab>
In-Reply-To: <1548864096-20974-5-git-send-email-skomatineni@nvidia.com>
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
        <1548864096-20974-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Wed, 30 Jan 2019 08:01:36 -0800
Sowjanya Komatineni <skomatineni@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> This patch adds I2C interface timing registers support for
> proper bus rate configuration along with meeting the i2c spec
> setup and hold times based on the tuning performed on Tegra210,
> Tegra186 and Tegra194 platforms.
>=20
> I2C_INTERFACE_TIMING_0 register contains TLOW and THIGH field
> and Tegra I2C controller design uses them as a part of internal
> clock divisor.
>=20
> I2C_INTERFACE_TIMING_1 register contains the setup and hold times
> for start and stop conditions.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V7] : Minor updates to timing implementation
>  [V5/V6] : Added this Interface timing patch in V5 of the patch
> series.
>=20
>  drivers/i2c/busses/i2c-tegra.c | 192
> ++++++++++++++++++++++++++++++++++++----- 1 file changed, 169
> insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-tegra.c
> b/drivers/i2c/busses/i2c-tegra.c index 623bf4f275cd..ad8eeac5a745
> 100644 --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -130,6 +130,15 @@
>  #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
>  #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
> =20
> +#define I2C_INTERFACE_TIMING_0			0x94
> +#define I2C_THIGH_SHIFT				8
> +#define I2C_INTERFACE_TIMING_1			0x98
> +
> +#define I2C_STANDARD_MODE			100000
> +#define I2C_FAST_MODE				400000
> +#define I2C_FAST_PLUS_MODE			1000000
> +#define I2C_HS_MODE				3500000
> +
>  /* Packet header size in bytes */
>  #define I2C_PACKET_HEADER_SIZE			12
> =20
> @@ -167,7 +176,10 @@ enum msg_end_type {
>   * @has_config_load_reg: Has the config load register to load the new
>   *		configuration.
>   * @clk_divisor_hs_mode: Clock divisor in HS mode.
> - * @clk_divisor_std_fast_mode: Clock divisor in standard/fast mode.
> It is
> + * @clk_divisor_std_mode: Clock divisor in standard mode. It is
> + *		applicable if there is no fast clock source i.e.
> single clock
> + *		source.
> + * @clk_divisor_fast_mode: Clock divisor in fast mode. It is
>   *		applicable if there is no fast clock source i.e.
> single clock
>   *		source.
>   * @clk_divisor_fast_plus_mode: Clock divisor in fast mode plus. It
> is @@ -182,6 +194,16 @@ enum msg_end_type {
>   *		be transferred in one go.
>   * @supports_bus_clear: Bus Clear support to recover from bus hang
> during
>   *		SDA stuck low from device for some unknown reasons.
> + * @tlow_std_mode: Low period of the clock in standard mode.
> + * @thigh_std_mode: High period of the clock in standard mode.
> + * @tlow_fast_fastplus_mode: Low period of the clock in
> fast/fast-plus modes.
> + * @thigh_fast_fastplus_mode: High period of the clock in
> fast/fast-plus modes.
> + * @setup_hold_time_std_mode: Setup and hold time for start and stop
> conditions
> + *		in standard mode.
> + * @setup_hold_time_fast_fast_plus_mode: Setup and hold time for
> start and stop
> + *		conditions in fast/fast-plus modes.
> + * @setup_hold_time_hs_mode: Setup and hold time for start and stop
> conditions
> + *		in HS mode.
>   */
>  struct tegra_i2c_hw_feature {
>  	bool has_continue_xfer_support;
> @@ -189,12 +211,20 @@ struct tegra_i2c_hw_feature {
>  	bool has_single_clk_source;
>  	bool has_config_load_reg;
>  	int clk_divisor_hs_mode;
> -	int clk_divisor_std_fast_mode;
> +	int clk_divisor_std_mode;
> +	int clk_divisor_fast_mode;
>  	u16 clk_divisor_fast_plus_mode;
>  	bool has_multi_master_mode;
>  	bool has_slcg_override_reg;
>  	bool has_mst_fifo;
>  	bool supports_bus_clear;
> +	u8 tlow_std_mode;
> +	u8 thigh_std_mode;
> +	u8 tlow_fast_fastplus_mode;
> +	u8 thigh_fast_fastplus_mode;
> +	u32 setup_hold_time_std_mode;
> +	u32 setup_hold_time_fast_fast_plus_mode;
> +	u32 setup_hold_time_hs_mode;
>  };
> =20
>  /**
> @@ -262,6 +292,7 @@ struct tegra_i2c_dev {
>  };
> =20
>  static struct dma_chan *chan;
> +static bool first_init;

Same as for the chan, please don't use global variables.

>  static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
>  		       unsigned long reg)
> @@ -639,6 +670,49 @@ static int tegra_i2c_wait_for_config_load(struct
> tegra_i2c_dev *i2c_dev) return 0;
>  }
> =20
> +static int tegra_i2c_set_timing(struct tegra_i2c_dev *i2c_dev)
> +{
> +	u32 val;
> +	u32 tsu_thd =3D 0;
> +	u8 tlow =3D 0;
> +	u8 thigh =3D 0;
> +	u32 clk_multiplier;
> +	int err =3D 0;
> +
> +	if ((i2c_dev->bus_clk_rate > I2C_STANDARD_MODE) &&
> +	    (i2c_dev->bus_clk_rate <=3D I2C_FAST_PLUS_MODE)) {
> +		tlow =3D i2c_dev->hw->tlow_fast_fastplus_mode;
> +		thigh =3D i2c_dev->hw->thigh_fast_fastplus_mode;
> +		tsu_thd =3D
> i2c_dev->hw->setup_hold_time_fast_fast_plus_mode;
> +	} else {
> +		tlow =3D i2c_dev->hw->tlow_std_mode;
> +		thigh =3D i2c_dev->hw->thigh_std_mode;
> +		tsu_thd =3D i2c_dev->hw->setup_hold_time_std_mode;
> +	}
> +
> +	val =3D (thigh << I2C_THIGH_SHIFT) | tlow;
> +	if (val)
> +		i2c_writel(i2c_dev, val, I2C_INTERFACE_TIMING_0);
> +
> +	if (tsu_thd)
> +		i2c_writel(i2c_dev, tsu_thd, I2C_INTERFACE_TIMING_1);
> +
> +	if (first_init) {

Just add first_init to the arguments of
tegra_i2c_init(i2c_dev, first_init) and pass it to here.

> +		clk_multiplier =3D (tlow + thigh + 2);
> +		clk_multiplier *=3D (i2c_dev->clk_divisor_non_hs_mode
> + 1); +
> +		err =3D clk_set_rate(i2c_dev->div_clk,
> +				   i2c_dev->bus_clk_rate *
> clk_multiplier);
> +		if (err)
> +			dev_err(i2c_dev->dev,
> +				"failed changing clock rate: %d\n",
> err);
> +		else
> +			first_init =3D false;
> +	}
> +
> +	return err;
> +}
> +
>  static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
>  {
>  	u32 val;
> @@ -673,6 +747,10 @@ static int tegra_i2c_init(struct tegra_i2c_dev
> *i2c_dev) I2C_CLK_DIVISOR_STD_FAST_MODE_SHIFT;
>  	i2c_writel(i2c_dev, clk_divisor, I2C_CLK_DIVISOR);
> =20
> +	err =3D tegra_i2c_set_timing(i2c_dev);
> +	if (err < 0)
> +		goto err;
> +
>  	if (!i2c_dev->is_dvc) {
>  		u32 sl_cfg =3D i2c_readl(i2c_dev, I2C_SL_CNFG);
> =20

[snip]
