Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A63C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE064218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6IXmSZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbfAaMob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:44:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40572 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfAaMoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:44:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so3113350wrt.7;
        Thu, 31 Jan 2019 04:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cSINz4OacmERDX9NHFfr/6evTn5AIGl2G/0rHypbHTc=;
        b=h6IXmSZF9Edq8mPbmbPK1fQV4CccNIzzKthMdXgMQYT6V5kBt+0WRenri2hgHvvLkT
         gYRE9TIZQ0zwo9qxW24oJw9RIiBCh9ieE3xBtu1vXQkinTPSHho0RbxZtmBpA83+0gsP
         UhWUl59mLtl3sDVKJg9m76gdDXv4amZ4ljpfL5ZbFJCqqi9u5j+YBcSJYNdz6oX1k/Ox
         cpo6B6caN+c17IToPyZBoXMe55NUADo5LdEeOT+5LGzuCep5AG6hOBzeHPagGkKv4eRA
         LniDNZ5dOKXhI+KiN/S2C9K1NbnZTjxNRh1m70mYcVPj419w98y/5zE/fHh5ngWU15C5
         ITGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cSINz4OacmERDX9NHFfr/6evTn5AIGl2G/0rHypbHTc=;
        b=keUm0QVaetxNy0HV+apERZtkZY2SMacBrv47pnNCVauJC7BQBcm1cT+pweHppQxrQY
         IQzJOvot3iamoW6WXtYoCV4piKuSFlx4AgWpsBBLb5IdDlWdGDE6hDqCBefmU7c4jTV8
         sgC/7xcfDsBKv7rZdK03zRn0/ixpbhkcHreY0CJ2toPFxHPfY3N6UN6xSBa7YspbRsqT
         uADLgDL/S/d49KGJqHVxUhsoP956f2aEYYaVh8VB58kNNdMoWwBTGjCsuJS2JJrmlaJf
         hrvvchSrzfLhoGNmO6Pc59dXxHXQE0Bo4hWM1Kt+M+F0w+Kwpomw5ZC7ajEmtxp1p9dW
         yaog==
X-Gm-Message-State: AJcUukem4rpFUEcRx3Y3UHfqn1ifCKyusVJV05fPaKabP+gLfmG8Wtfz
        tvkvW/kdTNJKO6keHpfE3Ww=
X-Google-Smtp-Source: ALg8bN5nas9WeBtJxGW+BB6y8dNtVqPMog83q8otYsK1Iot6hl5VN6OxyR61Ugvputahuqr6hnbdrQ==
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr34112502wrn.89.1548938666347;
        Thu, 31 Jan 2019 04:44:26 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id w10sm6020605wmb.1.2019.01.31.04.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 04:44:25 -0800 (PST)
Date:   Thu, 31 Jan 2019 13:44:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Message-ID: <20190131124423.GG23438@ulmo>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
 <1548915387-28826-3-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="df+09Je9rNq3P+GE"
Content-Disposition: inline
In-Reply-To: <1548915387-28826-3-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--df+09Je9rNq3P+GE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 10:16:25PM -0800, Sowjanya Komatineni wrote:
> This patch adds DMA support for Tegra I2C.
>=20
> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
> transfer size of the max FIFO depth and DMA mode is used for
> transfer size higher than max FIFO depth to save CPU overhead.
>=20
> PIO mode needs full intervention of CPU to fill or empty FIFO's
> and also need to service multiple data requests interrupt for the
> same transaction. This adds delay between data bytes of the same
> transfer when CPU is fully loaded and some slave devices has
> internal timeout for no bus activity and stops transaction to
> avoid bus hang. DMA mode is helpful in such cases.
>=20
> DMA mode is also helpful for Large transfers during downloading or
> uploading FW over I2C to some external devices.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V8] : Moved back dma init to i2c probe, removed ALL_PACKETS_XFER_COMPLE=
TE
> 	interrupt and using PACKETS_XFER_COMPLETE interrupt only and some
> 	other fixes
> 	Updated Kconfig for APB_DMA dependency
>  [V7] : Same as V6
>  [V6] : Updated for proper buffer allocation/freeing, channel release.
> 	Updated to use exact xfer size for syncing dma buffer.
>  [V5] : Same as V4
>  [V4] : Updated to allocate DMA buffer only when DMA mode.
> 	Updated to fall back to PIO mode when DMA channel request or
> 	buffer allocation fails.
>  [V3] : Updated without additional buffer allocation.
>  [V2] : Updated based on V1 review feedback along with code cleanup for
> 	proper implementation of DMA.
>=20
>  drivers/i2c/busses/Kconfig     |   2 +-
>  drivers/i2c/busses/i2c-tegra.c | 362 +++++++++++++++++++++++++++++++++++=
+++---
>  2 files changed, 339 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index f2c681971201..046aeb92a467 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1016,7 +1016,7 @@ config I2C_SYNQUACER
> =20
>  config I2C_TEGRA
>  	tristate "NVIDIA Tegra internal I2C controller"
> -	depends on ARCH_TEGRA
> +	depends on (ARCH_TEGRA && TEGRA20_APB_DMA)

Like I said in my reply in the v7 subthread, I don't think we want this.
The dependency that we have is on the DMA engine API, not the APB DMA
driver.

Technically there could be a runtime problem if the APB DMA driver is
disabled and we list a "dmas" property. If I understand correctly, the
DMA engine API would always return -EPROBE_DEFER in that case. That's
somewhat annoying, but I think that's fine because it points at an
integration issue. It lets you know that the driver is relying on a
resources that is not showing up, which usually means that either the
provider's driver is not enabled or the provider is failing to probe.

>  	help
>  	  If you say yes to this option, support will be included for the
>  	  I2C controller embedded in NVIDIA Tegra SOCs
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegr=
a.c
> index c4892a47a483..025d63972e50 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -8,6 +8,9 @@
> =20
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dmapool.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> @@ -44,6 +47,8 @@
>  #define I2C_FIFO_CONTROL_RX_FLUSH		BIT(0)
>  #define I2C_FIFO_CONTROL_TX_TRIG_SHIFT		5
>  #define I2C_FIFO_CONTROL_RX_TRIG_SHIFT		2
> +#define I2C_FIFO_CONTROL_TX_TRIG(x)		(((x) - 1) << 5)
> +#define I2C_FIFO_CONTROL_RX_TRIG(x)		(((x) - 1) << 2)
>  #define I2C_FIFO_STATUS				0x060
>  #define I2C_FIFO_STATUS_TX_MASK			0xF0
>  #define I2C_FIFO_STATUS_TX_SHIFT		4
> @@ -125,6 +130,19 @@
>  #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
>  #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
> =20
> +/* Packet header size in bytes */
> +#define I2C_PACKET_HEADER_SIZE			12
> +
> +#define DATA_DMA_DIR_TX				(1 << 0)
> +#define DATA_DMA_DIR_RX				(1 << 1)
> +
> +/*
> + * Upto I2C_PIO_MODE_MAX_LEN bytes, controller will use PIO mode,
> + * above this, controller will use DMA to fill FIFO.
> + * MAX PIO len is 20 bytes excluding packet header.
> + */
> +#define I2C_PIO_MODE_MAX_LEN			32
> +
>  /*
>   * msg_end_type: The bus control which need to be send at end of transfe=
r.
>   * @MSG_END_STOP: Send stop pulse at end of transfer.
> @@ -188,6 +206,7 @@ struct tegra_i2c_hw_feature {
>   * @fast_clk: clock reference for fast clock of I2C controller
>   * @rst: reset control for the I2C controller
>   * @base: ioremapped registers cookie
> + * @base_phys: Physical base address of the I2C controller
>   * @cont_id: I2C controller ID, used for packet header
>   * @irq: IRQ number of transfer complete interrupt
>   * @irq_disabled: used to track whether or not the interrupt is enabled
> @@ -201,6 +220,14 @@ struct tegra_i2c_hw_feature {
>   * @clk_divisor_non_hs_mode: clock divider for non-high-speed modes
>   * @is_multimaster_mode: track if I2C controller is in multi-master mode
>   * @xfer_lock: lock to serialize transfer submission and processing
> + * @has_dma: indicates if DMA can be utilized based on dma DT bindings

I don't think we need this. We can just rely on the DMA engine API to
tell us if the "dmas" property isn't there.

> + * @tx_dma_chan: DMA transmit channel
> + * @rx_dma_chan: DMA receive channel
> + * @dma_phys: handle to DMA resources
> + * @dma_buf: pointer to allocated DMA buffer
> + * @dma_buf_size: DMA buffer size
> + * @is_curr_dma_xfer: indicates active DMA transfer
> + * @dma_complete: DMA completion notifier
>   */
>  struct tegra_i2c_dev {
>  	struct device *dev;
> @@ -210,6 +237,7 @@ struct tegra_i2c_dev {
>  	struct clk *fast_clk;
>  	struct reset_control *rst;
>  	void __iomem *base;
> +	phys_addr_t base_phys;
>  	int cont_id;
>  	int irq;
>  	bool irq_disabled;
> @@ -223,6 +251,14 @@ struct tegra_i2c_dev {
>  	u16 clk_divisor_non_hs_mode;
>  	bool is_multimaster_mode;
>  	spinlock_t xfer_lock;
> +	bool has_dma;
> +	struct dma_chan *tx_dma_chan;
> +	struct dma_chan *rx_dma_chan;
> +	dma_addr_t dma_phys;
> +	u32 *dma_buf;
> +	unsigned int dma_buf_size;
> +	bool is_curr_dma_xfer;
> +	struct completion dma_complete;
>  };
> =20
>  static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
> @@ -291,6 +327,85 @@ static void tegra_i2c_unmask_irq(struct tegra_i2c_de=
v *i2c_dev, u32 mask)
>  	i2c_writel(i2c_dev, int_mask, I2C_INT_MASK);
>  }
> =20
> +static void tegra_i2c_dma_complete(void *args)
> +{
> +	struct tegra_i2c_dev *i2c_dev =3D args;
> +
> +	complete(&i2c_dev->dma_complete);
> +}
> +
> +static int tegra_i2c_dma_submit(struct tegra_i2c_dev *i2c_dev, size_t le=
n)
> +{
> +	struct dma_async_tx_descriptor *dma_desc;
> +	enum dma_transfer_direction dir;
> +	struct dma_chan *chan;
> +
> +	dev_dbg(i2c_dev->dev, "starting DMA for length: %zu\n", len);
> +	reinit_completion(&i2c_dev->dma_complete);
> +	dir =3D i2c_dev->msg_read ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
> +	chan =3D i2c_dev->msg_read ? i2c_dev->rx_dma_chan : i2c_dev->tx_dma_cha=
n;
> +	dma_desc =3D dmaengine_prep_slave_single(chan, i2c_dev->dma_phys,
> +					       len, dir, DMA_PREP_INTERRUPT |
> +					       DMA_CTRL_ACK);
> +	if (!dma_desc) {
> +		dev_err(i2c_dev->dev, "failed to get DMA descriptor\n");
> +		return -EIO;
> +	}
> +
> +	dma_desc->callback =3D tegra_i2c_dma_complete;
> +	dma_desc->callback_param =3D i2c_dev;
> +	dmaengine_submit(dma_desc);
> +	dma_async_issue_pending(chan);
> +	return 0;
> +}
> +
> +static int tegra_i2c_init_dma_param(struct tegra_i2c_dev *i2c_dev)
> +{
> +	struct dma_chan *dma_chan;
> +	u32 *dma_buf;
> +	dma_addr_t dma_phys;
> +
> +	if (!i2c_dev->has_dma)
> +		return -EINVAL;
> +
> +	if (!i2c_dev->rx_dma_chan) {
> +		dma_chan =3D dma_request_slave_channel_reason(i2c_dev->dev, "rx");
> +		if (IS_ERR(dma_chan))
> +			return PTR_ERR(dma_chan);

I think we want to fallback to PIO here if dma_chan is -ENODEV.

> +
> +		i2c_dev->rx_dma_chan =3D dma_chan;
> +	}
> +
> +	if (!i2c_dev->tx_dma_chan) {
> +		dma_chan =3D dma_request_slave_channel_reason(i2c_dev->dev, "tx");
> +		if (IS_ERR(dma_chan))
> +			return PTR_ERR(dma_chan);

Same here. We could use rx_dma_chan =3D=3D NULL as a condition to detect
that instead of the extra has_dma.

> +		i2c_dev->tx_dma_chan =3D dma_chan;
> +	}

Although, I'm not exactly sure I understand what you're trying to
achieve here. Shouldn't we move the channel request parts into probe and
remove them from here? Otherwise it seems like we could get into a state
where we keep trying to get the slave channels everytime we set up a DMA
transfer, even if we already failed to do so during probe.

> +
> +	if (!i2c_dev->dma_buf && i2c_dev->msg_buf_remaining) {
> +		dma_buf =3D dma_alloc_coherent(i2c_dev->dev,
> +					     i2c_dev->dma_buf_size,
> +					     &dma_phys, GFP_KERNEL);
> +
> +		if (!dma_buf) {
> +			dev_err(i2c_dev->dev,
> +				"failed to allocate the DMA buffer\n");
> +			dma_release_channel(i2c_dev->tx_dma_chan);
> +			dma_release_channel(i2c_dev->rx_dma_chan);
> +			i2c_dev->tx_dma_chan =3D NULL;
> +			i2c_dev->rx_dma_chan =3D NULL;
> +			return -ENOMEM;
> +		}
> +
> +		i2c_dev->dma_buf =3D dma_buf;
> +		i2c_dev->dma_phys =3D dma_phys;
> +	}
> +
> +	return 0;
> +}
> +
>  static int tegra_i2c_flush_fifos(struct tegra_i2c_dev *i2c_dev)
>  {
>  	unsigned long timeout =3D jiffies + HZ;
> @@ -656,25 +771,38 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev=
_id)
>  	if (i2c_dev->hw->supports_bus_clear && (status & I2C_INT_BUS_CLR_DONE))
>  		goto err;
> =20
> -	if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ)) {
> -		if (i2c_dev->msg_buf_remaining)
> -			tegra_i2c_empty_rx_fifo(i2c_dev);
> -		else
> -			BUG();
> -	}
> +	if (!i2c_dev->is_curr_dma_xfer) {
> +		if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ)) {
> +			if (i2c_dev->msg_buf_remaining)
> +				tegra_i2c_empty_rx_fifo(i2c_dev);
> +			else
> +				BUG();
> +		}
> =20
> -	if (!i2c_dev->msg_read && (status & I2C_INT_TX_FIFO_DATA_REQ)) {
> -		if (i2c_dev->msg_buf_remaining)
> -			tegra_i2c_fill_tx_fifo(i2c_dev);
> -		else
> -			tegra_i2c_mask_irq(i2c_dev, I2C_INT_TX_FIFO_DATA_REQ);
> +		if (!i2c_dev->msg_read &&
> +		   (status & I2C_INT_TX_FIFO_DATA_REQ)) {
> +			if (i2c_dev->msg_buf_remaining)
> +				tegra_i2c_fill_tx_fifo(i2c_dev);
> +			else
> +				tegra_i2c_mask_irq(i2c_dev,
> +						   I2C_INT_TX_FIFO_DATA_REQ);
> +		}
>  	}
> =20
>  	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
>  	if (i2c_dev->is_dvc)
>  		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
> =20
> +	/*
> +	 * During message read XFER_COMPLETE interrupt is triggered prior to
> +	 * DMA completion and during message write XFER_COMPLETE interrupt is
> +	 * triggered after DMA completion.
> +	 * PACKETS_XFER_COMPLETE indicates completion of all bytes of transfer.
> +	 * so forcing msg_buf_remaining to 0 in DMA mode.
> +	 */
>  	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
> +		if (i2c_dev->is_curr_dma_xfer)
> +			i2c_dev->msg_buf_remaining =3D 0;
>  		BUG_ON(i2c_dev->msg_buf_remaining);
>  		complete(&i2c_dev->msg_complete);
>  	}
> @@ -690,12 +818,69 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev=
_id)
>  	if (i2c_dev->is_dvc)
>  		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
> =20
> +	if (i2c_dev->is_curr_dma_xfer) {
> +		if (i2c_dev->msg_read)
> +			dmaengine_terminate_all(i2c_dev->rx_dma_chan);
> +		else
> +			dmaengine_terminate_all(i2c_dev->tx_dma_chan);
> +
> +		complete(&i2c_dev->dma_complete);
> +	}
> +
>  	complete(&i2c_dev->msg_complete);
>  done:
>  	spin_unlock(&i2c_dev->xfer_lock);
>  	return IRQ_HANDLED;
>  }
> =20
> +static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
> +				       size_t len, int direction)
> +{
> +	u32 val, reg;
> +	u8 dma_burst =3D 0;
> +	struct dma_slave_config dma_sconfig;
> +	struct dma_chan *chan;
> +
> +	if (i2c_dev->hw->has_mst_fifo)
> +		reg =3D I2C_MST_FIFO_CONTROL;
> +	else
> +		reg =3D I2C_FIFO_CONTROL;
> +	val =3D i2c_readl(i2c_dev, reg);
> +
> +	if (len & 0xF)
> +		dma_burst =3D 1;
> +	else if (len & 0x10)
> +		dma_burst =3D 4;
> +	else
> +		dma_burst =3D 8;
> +
> +	if (direction =3D=3D DATA_DMA_DIR_TX) {
> +		if (i2c_dev->hw->has_mst_fifo)
> +			val |=3D I2C_MST_FIFO_CONTROL_TX_TRIG(dma_burst);
> +		else
> +			val |=3D I2C_FIFO_CONTROL_TX_TRIG(dma_burst);
> +	} else {
> +		if (i2c_dev->hw->has_mst_fifo)
> +			val |=3D I2C_MST_FIFO_CONTROL_RX_TRIG(dma_burst);
> +		else
> +			val |=3D I2C_FIFO_CONTROL_RX_TRIG(dma_burst);
> +	}
> +	i2c_writel(i2c_dev, val, reg);
> +
> +	if (direction =3D=3D DATA_DMA_DIR_TX) {
> +		dma_sconfig.dst_addr =3D i2c_dev->base_phys + I2C_TX_FIFO;
> +		dma_sconfig.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		dma_sconfig.dst_maxburst =3D dma_burst;
> +	} else {
> +		dma_sconfig.src_addr =3D i2c_dev->base_phys + I2C_RX_FIFO;
> +		dma_sconfig.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		dma_sconfig.src_maxburst =3D dma_burst;
> +	}
> +
> +	chan =3D i2c_dev->msg_read ? i2c_dev->rx_dma_chan : i2c_dev->tx_dma_cha=
n;
> +	dmaengine_slave_config(chan, &dma_sconfig);
> +}
> +
>  static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
>  {
>  	int err;
> @@ -740,6 +925,11 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *=
i2c_dev,
>  	u32 int_mask;
>  	unsigned long time_left;
>  	unsigned long flags;
> +	size_t xfer_size;
> +	u32 *buffer =3D 0;

Usually this should be =3D NULL for pointers.

> +	int err =3D 0;
> +	bool dma =3D false;
> +	struct dma_chan *chan;
> =20
>  	tegra_i2c_flush_fifos(i2c_dev);
> =20
> @@ -749,19 +939,69 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev =
*i2c_dev,
>  	i2c_dev->msg_read =3D (msg->flags & I2C_M_RD);
>  	reinit_completion(&i2c_dev->msg_complete);
> =20
> +	if (i2c_dev->msg_read)
> +		xfer_size =3D msg->len;
> +	else
> +		xfer_size =3D msg->len + I2C_PACKET_HEADER_SIZE;
> +
> +	xfer_size =3D ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
> +	dma =3D (xfer_size > I2C_PIO_MODE_MAX_LEN);
> +	if (dma) {
> +		err =3D tegra_i2c_init_dma_param(i2c_dev);
> +		if (err < 0) {
> +			dev_dbg(i2c_dev->dev, "switching to PIO transfer\n");
> +			dma =3D false;
> +		}

If we successfully got DMA channels at probe time, doesn't this turn
into an error condition that is worth reporting? It seems to me like the
only reason it could fail is if we fail the allocation, but then again,
why don't we move the DMA buffer allocation into probe()? We already use
a fixed size for that allocation, so there's no reason it couldn't be
allocated at probe time.

Seems like maybe you just overlooked that as you were moving around the
code pieces.

> +	}
> +
> +	i2c_dev->is_curr_dma_xfer =3D dma;
>  	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
> =20
>  	int_mask =3D I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
>  	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> =20
> +	if (dma) {
> +		if (i2c_dev->msg_read) {
> +			chan =3D i2c_dev->rx_dma_chan;
> +			tegra_i2c_config_fifo_trig(i2c_dev, xfer_size,
> +						   DATA_DMA_DIR_RX);
> +			dma_sync_single_for_device(i2c_dev->dev,
> +						   i2c_dev->dma_phys,
> +						   xfer_size,
> +						   DMA_FROM_DEVICE);

Do we really need this? We're not actually passing the device any data,
so no caches to flush here. I we're cautious about flushing caches when
we do write to the buffer (and I think we do that properly already),
then there should be no need to do it here again.

> +			err =3D tegra_i2c_dma_submit(i2c_dev, xfer_size);
> +			if (err < 0) {
> +				dev_err(i2c_dev->dev,
> +					"starting RX DMA failed, err %d\n",
> +					err);
> +				goto unlock;
> +			}
> +		} else {
> +			chan =3D i2c_dev->tx_dma_chan;
> +			tegra_i2c_config_fifo_trig(i2c_dev, xfer_size,
> +						   DATA_DMA_DIR_TX);
> +			dma_sync_single_for_cpu(i2c_dev->dev,
> +						i2c_dev->dma_phys,
> +						xfer_size,
> +						DMA_TO_DEVICE);

This, on the other hand seems correct because we need to invalidate the
caches for this buffer to make sure the data that we put there doesn't
get overwritten.

> +			buffer =3D i2c_dev->dma_buf;
> +		}
> +	}
> +
>  	packet_header =3D (0 << PACKET_HEADER0_HEADER_SIZE_SHIFT) |
>  			PACKET_HEADER0_PROTOCOL_I2C |
>  			(i2c_dev->cont_id << PACKET_HEADER0_CONT_ID_SHIFT) |
>  			(1 << PACKET_HEADER0_PACKET_ID_SHIFT);
> -	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> +	if (dma && !i2c_dev->msg_read)
> +		*buffer++ =3D packet_header;
> +	else
> +		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> =20
>  	packet_header =3D msg->len - 1;
> -	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> +	if (dma && !i2c_dev->msg_read)
> +		*buffer++ =3D packet_header;
> +	else
> +		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> =20
>  	packet_header =3D I2C_HEADER_IE_ENABLE;
>  	if (end_state =3D=3D MSG_END_CONTINUE)
> @@ -778,30 +1018,79 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev=
 *i2c_dev,
>  		packet_header |=3D I2C_HEADER_CONT_ON_NAK;
>  	if (msg->flags & I2C_M_RD)
>  		packet_header |=3D I2C_HEADER_READ;
> -	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> -
> -	if (!(msg->flags & I2C_M_RD))
> -		tegra_i2c_fill_tx_fifo(i2c_dev);
> -
> +	if (dma && !i2c_dev->msg_read)
> +		*buffer++ =3D packet_header;
> +	else
> +		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> +
> +	if (!i2c_dev->msg_read) {
> +		if (dma) {
> +			memcpy(buffer, msg->buf, msg->len);
> +			dma_sync_single_for_device(i2c_dev->dev,
> +						   i2c_dev->dma_phys,
> +						   xfer_size,
> +						   DMA_TO_DEVICE);

Again, here we properly flush the caches to make sure the data that
we've written to the DMA buffer is visible to the DMA engine.

> +			err =3D tegra_i2c_dma_submit(i2c_dev, xfer_size);
> +			if (err < 0) {
> +				dev_err(i2c_dev->dev,
> +					"starting TX DMA failed, err %d\n",
> +					err);
> +				goto unlock;
> +			}
> +		} else {
> +			tegra_i2c_fill_tx_fifo(i2c_dev);
> +		}
> +	}
>  	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
>  		int_mask |=3D I2C_INT_PACKET_XFER_COMPLETE;
> -	if (msg->flags & I2C_M_RD)
> -		int_mask |=3D I2C_INT_RX_FIFO_DATA_REQ;
> -	else if (i2c_dev->msg_buf_remaining)
> -		int_mask |=3D I2C_INT_TX_FIFO_DATA_REQ;
> +	if (!dma) {
> +		if (msg->flags & I2C_M_RD)
> +			int_mask |=3D I2C_INT_RX_FIFO_DATA_REQ;
> +		else if (i2c_dev->msg_buf_remaining)
> +			int_mask |=3D I2C_INT_TX_FIFO_DATA_REQ;
> +	}
> =20
>  	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> -	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
>  	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
>  		i2c_readl(i2c_dev, I2C_INT_MASK));
> =20
> +unlock:
> +	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
> +
> +	if (dma) {
> +		if (err)
> +			return err;
> +
> +		time_left =3D wait_for_completion_timeout(
> +						&i2c_dev->dma_complete,
> +						TEGRA_I2C_TIMEOUT);
> +
> +		if (time_left =3D=3D 0) {
> +			dev_err(i2c_dev->dev, "DMA transfer timeout\n");
> +			dmaengine_terminate_all(chan);
> +			tegra_i2c_init(i2c_dev);
> +			return -ETIMEDOUT;
> +		}
> +
> +		if (i2c_dev->msg_read) {
> +			if (likely(i2c_dev->msg_err =3D=3D I2C_ERR_NONE)) {
> +				dma_sync_single_for_cpu(i2c_dev->dev,
> +							i2c_dev->dma_phys,
> +							xfer_size,
> +							DMA_FROM_DEVICE);

Here we invalidate the caches to make sure we don't get stale data that
may be in the caches for data that we're copying out of the DMA buffer.
I think that's about all the cache maintenance that we really need.

> +
> +				memcpy(i2c_dev->msg_buf, i2c_dev->dma_buf,
> +					msg->len);
> +			}
> +		}
> +	}
> +
>  	time_left =3D wait_for_completion_timeout(&i2c_dev->msg_complete,
>  						TEGRA_I2C_TIMEOUT);
>  	tegra_i2c_mask_irq(i2c_dev, int_mask);
> =20
>  	if (time_left =3D=3D 0) {
>  		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
> -
>  		tegra_i2c_init(i2c_dev);
>  		return -ETIMEDOUT;
>  	}
> @@ -884,6 +1173,8 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_dev =
*i2c_dev)
> =20
>  	i2c_dev->is_multimaster_mode =3D of_property_read_bool(np,
>  			"multi-master");
> +
> +	i2c_dev->has_dma =3D of_property_read_bool(np, "dmas");
>  }
> =20
>  static const struct i2c_algorithm tegra_i2c_algo =3D {
> @@ -1002,11 +1293,13 @@ static int tegra_i2c_probe(struct platform_device=
 *pdev)
>  	struct clk *div_clk;
>  	struct clk *fast_clk;
>  	void __iomem *base;
> +	phys_addr_t base_phys;
>  	int irq;
>  	int ret =3D 0;
>  	int clk_multiplier =3D I2C_CLK_MULTIPLIER_STD_FAST_MODE;
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base_phys =3D res->start;
>  	base =3D devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> @@ -1029,6 +1322,7 @@ static int tegra_i2c_probe(struct platform_device *=
pdev)
>  		return -ENOMEM;
> =20
>  	i2c_dev->base =3D base;
> +	i2c_dev->base_phys =3D base_phys;

We could probably do without the extra local variable by just moving the
assignment here. res is still valid at this point.

>  	i2c_dev->div_clk =3D div_clk;
>  	i2c_dev->adapter.algo =3D &tegra_i2c_algo;
>  	i2c_dev->adapter.quirks =3D &tegra_i2c_quirks;
> @@ -1036,6 +1330,7 @@ static int tegra_i2c_probe(struct platform_device *=
pdev)
>  	i2c_dev->irq =3D irq;
>  	i2c_dev->cont_id =3D pdev->id;
>  	i2c_dev->dev =3D &pdev->dev;
> +	i2c_dev->dma_buf_size =3D i2c_dev->adapter.quirks->max_write_len;
> =20
>  	i2c_dev->rst =3D devm_reset_control_get_exclusive(&pdev->dev, "i2c");
>  	if (IS_ERR(i2c_dev->rst)) {
> @@ -1049,6 +1344,7 @@ static int tegra_i2c_probe(struct platform_device *=
pdev)
>  	i2c_dev->is_dvc =3D of_device_is_compatible(pdev->dev.of_node,
>  						  "nvidia,tegra20-i2c-dvc");
>  	init_completion(&i2c_dev->msg_complete);
> +	init_completion(&i2c_dev->dma_complete);
>  	spin_lock_init(&i2c_dev->xfer_lock);
> =20
>  	if (!i2c_dev->hw->has_single_clk_source) {
> @@ -1109,6 +1405,10 @@ static int tegra_i2c_probe(struct platform_device =
*pdev)
>  		}
>  	}
> =20
> +	ret =3D tegra_i2c_init_dma_param(i2c_dev);
> +	if (ret =3D=3D -EPROBE_DEFER)
> +		goto disable_div_clk;
> +
>  	ret =3D tegra_i2c_init(i2c_dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to initialize i2c controller\n");
> @@ -1173,6 +1473,20 @@ static int tegra_i2c_remove(struct platform_device=
 *pdev)
>  	if (!i2c_dev->hw->has_single_clk_source)
>  		clk_unprepare(i2c_dev->fast_clk);
> =20
> +	if (i2c_dev->dma_buf)
> +		dma_free_coherent(i2c_dev->dev, i2c_dev->dma_buf_size,
> +				  i2c_dev->dma_buf, i2c_dev->dma_phys);
> +
> +	if (i2c_dev->tx_dma_chan) {
> +		dma_release_channel(i2c_dev->tx_dma_chan);
> +		i2c_dev->tx_dma_chan =3D NULL;
> +	}
> +
> +	if (i2c_dev->rx_dma_chan) {
> +		dma_release_channel(i2c_dev->rx_dma_chan);
> +		i2c_dev->rx_dma_chan =3D NULL;
> +	}

No need to explicitly set these to NULL, the memory is going to go away
in a few instructions anyway.

Thierry

--df+09Je9rNq3P+GE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxS7aUACgkQ3SOs138+
s6GpoBAArx748odaZGLZvDqgAZWByEchDb7K3pIgC9YQMaV+aDOfbPRd0Kpr46Yl
IDNDZhY/Z+St596/ddBjmH2u8RLM56og9xmgV3qSM+M5r9k+ZVjjZHNpfwfmzwFy
v52yU5KUuAY9C3KQa8AdnQv8wxfqtLvTat1X6bA2AaKYFq+2ToUs04XQIta9Nt8r
narums2Knztwd/pMvo5iFwUAU/VH4pCAveDbGx2M/cXtw9dIAp+geAYgU1irXXTv
QiPj2KA7I5Ende1MmJiqSTAMauH1fY6SSWdLj/or+Fzxqk+OIfCF7J4enfV+XWG7
PBwfwLtrNj1oRKbanMutRCNaZp8CU6hOE4lXU1yVuuz9tohDMM7XyRc5meXMz94r
BsPG/hEsVVEsprfMHY7j4JsNyiyau3Ir2m1Cqx3xIXqNlpIK1tqPhRX1BN9Q3XUb
uGWWYsGp6UlB60I5E2Hhx7GgbOBEljJNcf6iU2HXDdkUO7PquBQh1BKnmXId8TCE
JNc33jZdKbGpu9ZPE8VCiZaEr1YW4GuKP3VyP+0J/lbcNb5GLsGxQjzVk39PJTtM
pK8JjUztOt9ww0o8Js6+aIpBgUbmJ4fVXw+ykbXvzWPUcZL++7qdX7vkMSPpI9vh
9icU1isQuKXTnirBzJQwMImc2BHVzXXCgakRyl4f1Ob7qJLvD/I=
=m0p/
-----END PGP SIGNATURE-----

--df+09Je9rNq3P+GE--
