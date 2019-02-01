Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1268EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA73D20B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmKYNWGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfBAAw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:52:27 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40470 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfBAAw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:52:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so3781170lfe.7;
        Thu, 31 Jan 2019 16:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BL5K6Ln9mMu2nB10pTEMPJKH+40eIMXKLKdAVuUAZRg=;
        b=XmKYNWGmt6xjy+Oj5+xlMcsj58CLGA5wJPO2jAb+CAHdWuE1mD6Dacc4VcPJsWYCg/
         xCq89VIE+H5rkWlo5it687C1pp/5MmxDuZsGslbtJrdYsTT6TNi4rvEr5LZCEVh2aqFR
         XPz4h3GoVEI+EGG74YmPXYzYfVrCiun2EwP/4ZK/IUEE+GLUVk1Wcp104d0ov9qZB5lG
         JTHAvl3yBtwZQGz4yftQl6UyHBu3pL5a6T4Eg7OtWzlqbqRj5IH3l0WnzADeruhgTqBA
         2nq18WTqO93cgv7gqGAFSIuk9kV7Ol3s4qh97BSETcbMCOCyNPLWQ7VO+2nAsEWd55Ja
         p3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BL5K6Ln9mMu2nB10pTEMPJKH+40eIMXKLKdAVuUAZRg=;
        b=Z5xkgIOr5GW2NW6V4QoRm1MGWELFU9aHmxCWeVQ031OXTkEB76nFhORaSOQMAhqaze
         VbvC/5heojQoOo5NFiMi5rAiPvQeRp1+SKdc7W5+tvN6d5skN3JANJTbp//AcTxFddhx
         3+7DwnKh7MS1aI2ubqZwPfXV+cGy1WALCC7Z105pMMafkGqY1b7O0TuzL7q5qPA0veV+
         IRy3LbdIeymSaggZ/TIcNiRuVRaC/2t8lnH0TuHn7DyoNyqkFeBGGZC2JK3ZcvT4zwwV
         qKhdbM90aRAnsywznDqAHZWvbj+4k7URABZCXptVyd2G5qiDHVW+ca/5NHEVwURya7da
         8mjA==
X-Gm-Message-State: AJcUukdGDPu9nzgBLYevm5L3RtWW4O1AJvgJJ7WgQR6WplRp5xZw09VH
        moCxnzt1YGdBRrQq31gs3/4=
X-Google-Smtp-Source: ALg8bN6bCeJsZA2GLqQnZij/PzxNDR0uRFwhYCZvYBxdj75DlE4lFwYmBLHo5rug2CawP9F/Pm+sIA==
X-Received: by 2002:a19:280f:: with SMTP id o15mr30552696lfo.0.1548982343136;
        Thu, 31 Jan 2019 16:52:23 -0800 (PST)
Received: from dimatab (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id y131sm1079169lfc.43.2019.01.31.16.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 16:52:22 -0800 (PST)
Date:   Fri, 1 Feb 2019 03:52:49 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Message-ID: <20190201035249.5b1cdfe2@dimatab>
In-Reply-To: <20190131124423.GG23438@ulmo>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
        <1548915387-28826-3-git-send-email-skomatineni@nvidia.com>
        <20190131124423.GG23438@ulmo>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Thu, 31 Jan 2019 13:44:23 +0100
Thierry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On Wed, Jan 30, 2019 at 10:16:25PM -0800, Sowjanya Komatineni wrote:
> > This patch adds DMA support for Tegra I2C.
> >=20
> > Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
> > transfer size of the max FIFO depth and DMA mode is used for
> > transfer size higher than max FIFO depth to save CPU overhead.
> >=20
> > PIO mode needs full intervention of CPU to fill or empty FIFO's
> > and also need to service multiple data requests interrupt for the
> > same transaction. This adds delay between data bytes of the same
> > transfer when CPU is fully loaded and some slave devices has
> > internal timeout for no bus activity and stops transaction to
> > avoid bus hang. DMA mode is helpful in such cases.
> >=20
> > DMA mode is also helpful for Large transfers during downloading or
> > uploading FW over I2C to some external devices.
> >=20
> > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > ---
> >  [V8] : Moved back dma init to i2c probe, removed
> > ALL_PACKETS_XFER_COMPLETE interrupt and using PACKETS_XFER_COMPLETE
> > interrupt only and some other fixes
> > 	Updated Kconfig for APB_DMA dependency
> >  [V7] : Same as V6
> >  [V6] : Updated for proper buffer allocation/freeing, channel
> > release. Updated to use exact xfer size for syncing dma buffer.
> >  [V5] : Same as V4
> >  [V4] : Updated to allocate DMA buffer only when DMA mode.
> > 	Updated to fall back to PIO mode when DMA channel request or
> > 	buffer allocation fails.
> >  [V3] : Updated without additional buffer allocation.
> >  [V2] : Updated based on V1 review feedback along with code cleanup
> > for proper implementation of DMA.
> >=20
> >  drivers/i2c/busses/Kconfig     |   2 +-
> >  drivers/i2c/busses/i2c-tegra.c | 362
> > ++++++++++++++++++++++++++++++++++++++--- 2 files changed, 339
> > insertions(+), 25 deletions(-)
> >=20
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index f2c681971201..046aeb92a467 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -1016,7 +1016,7 @@ config I2C_SYNQUACER
> > =20
> >  config I2C_TEGRA
> >  	tristate "NVIDIA Tegra internal I2C controller"
> > -	depends on ARCH_TEGRA
> > +	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) =20
>=20
> Like I said in my reply in the v7 subthread, I don't think we want
> this. The dependency that we have is on the DMA engine API, not the
> APB DMA driver.
>=20
> Technically there could be a runtime problem if the APB DMA driver is
> disabled and we list a "dmas" property. If I understand correctly, the
> DMA engine API would always return -EPROBE_DEFER in that case. That's
> somewhat annoying, but I think that's fine because it points at an
> integration issue. It lets you know that the driver is relying on a
> resources that is not showing up, which usually means that either the
> provider's driver is not enabled or the provider is failing to probe.
>=20
> >  	help
> >  	  If you say yes to this option, support will be included
> > for the I2C controller embedded in NVIDIA Tegra SOCs
> > diff --git a/drivers/i2c/busses/i2c-tegra.c
> > b/drivers/i2c/busses/i2c-tegra.c index c4892a47a483..025d63972e50
> > 100644 --- a/drivers/i2c/busses/i2c-tegra.c
> > +++ b/drivers/i2c/busses/i2c-tegra.c
> > @@ -8,6 +8,9 @@
> > =20
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/dmapool.h>
> > +#include <linux/dma-mapping.h>
> >  #include <linux/err.h>
> >  #include <linux/i2c.h>
> >  #include <linux/init.h>
> > @@ -44,6 +47,8 @@
> >  #define I2C_FIFO_CONTROL_RX_FLUSH		BIT(0)
> >  #define I2C_FIFO_CONTROL_TX_TRIG_SHIFT		5
> >  #define I2C_FIFO_CONTROL_RX_TRIG_SHIFT		2
> > +#define I2C_FIFO_CONTROL_TX_TRIG(x)		(((x) - 1) << 5)
> > +#define I2C_FIFO_CONTROL_RX_TRIG(x)		(((x) - 1) << 2)
> >  #define I2C_FIFO_STATUS				0x060
> >  #define I2C_FIFO_STATUS_TX_MASK			0xF0
> >  #define I2C_FIFO_STATUS_TX_SHIFT		4
> > @@ -125,6 +130,19 @@
> >  #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
> >  #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
> > =20
> > +/* Packet header size in bytes */
> > +#define I2C_PACKET_HEADER_SIZE			12
> > +
> > +#define DATA_DMA_DIR_TX				(1 << 0)
> > +#define DATA_DMA_DIR_RX				(1 << 1)
> > +
> > +/*
> > + * Upto I2C_PIO_MODE_MAX_LEN bytes, controller will use PIO mode,
> > + * above this, controller will use DMA to fill FIFO.
> > + * MAX PIO len is 20 bytes excluding packet header.
> > + */
> > +#define I2C_PIO_MODE_MAX_LEN			32
> > +
> >  /*
> >   * msg_end_type: The bus control which need to be send at end of
> > transfer.
> >   * @MSG_END_STOP: Send stop pulse at end of transfer.
> > @@ -188,6 +206,7 @@ struct tegra_i2c_hw_feature {
> >   * @fast_clk: clock reference for fast clock of I2C controller
> >   * @rst: reset control for the I2C controller
> >   * @base: ioremapped registers cookie
> > + * @base_phys: Physical base address of the I2C controller
> >   * @cont_id: I2C controller ID, used for packet header
> >   * @irq: IRQ number of transfer complete interrupt
> >   * @irq_disabled: used to track whether or not the interrupt is
> > enabled @@ -201,6 +220,14 @@ struct tegra_i2c_hw_feature {
> >   * @clk_divisor_non_hs_mode: clock divider for non-high-speed modes
> >   * @is_multimaster_mode: track if I2C controller is in
> > multi-master mode
> >   * @xfer_lock: lock to serialize transfer submission and processing
> > + * @has_dma: indicates if DMA can be utilized based on dma DT
> > bindings =20
>=20
> I don't think we need this. We can just rely on the DMA engine API to
> tell us if the "dmas" property isn't there.
>=20
> > + * @tx_dma_chan: DMA transmit channel
> > + * @rx_dma_chan: DMA receive channel
> > + * @dma_phys: handle to DMA resources
> > + * @dma_buf: pointer to allocated DMA buffer
> > + * @dma_buf_size: DMA buffer size
> > + * @is_curr_dma_xfer: indicates active DMA transfer
> > + * @dma_complete: DMA completion notifier
> >   */
> >  struct tegra_i2c_dev {
> >  	struct device *dev;
> > @@ -210,6 +237,7 @@ struct tegra_i2c_dev {
> >  	struct clk *fast_clk;
> >  	struct reset_control *rst;
> >  	void __iomem *base;
> > +	phys_addr_t base_phys;
> >  	int cont_id;
> >  	int irq;
> >  	bool irq_disabled;
> > @@ -223,6 +251,14 @@ struct tegra_i2c_dev {
> >  	u16 clk_divisor_non_hs_mode;
> >  	bool is_multimaster_mode;
> >  	spinlock_t xfer_lock;
> > +	bool has_dma;
> > +	struct dma_chan *tx_dma_chan;
> > +	struct dma_chan *rx_dma_chan;
> > +	dma_addr_t dma_phys;
> > +	u32 *dma_buf;
> > +	unsigned int dma_buf_size;
> > +	bool is_curr_dma_xfer;
> > +	struct completion dma_complete;
> >  };
> > =20
> >  static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
> > @@ -291,6 +327,85 @@ static void tegra_i2c_unmask_irq(struct
> > tegra_i2c_dev *i2c_dev, u32 mask) i2c_writel(i2c_dev, int_mask,
> > I2C_INT_MASK); }
> > =20
> > +static void tegra_i2c_dma_complete(void *args)
> > +{
> > +	struct tegra_i2c_dev *i2c_dev =3D args;
> > +
> > +	complete(&i2c_dev->dma_complete);
> > +}
> > +
> > +static int tegra_i2c_dma_submit(struct tegra_i2c_dev *i2c_dev,
> > size_t len) +{
> > +	struct dma_async_tx_descriptor *dma_desc;
> > +	enum dma_transfer_direction dir;
> > +	struct dma_chan *chan;
> > +
> > +	dev_dbg(i2c_dev->dev, "starting DMA for length: %zu\n",
> > len);
> > +	reinit_completion(&i2c_dev->dma_complete);
> > +	dir =3D i2c_dev->msg_read ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
> > +	chan =3D i2c_dev->msg_read ? i2c_dev->rx_dma_chan :
> > i2c_dev->tx_dma_chan;
> > +	dma_desc =3D dmaengine_prep_slave_single(chan,
> > i2c_dev->dma_phys,
> > +					       len, dir,
> > DMA_PREP_INTERRUPT |
> > +					       DMA_CTRL_ACK);
> > +	if (!dma_desc) {
> > +		dev_err(i2c_dev->dev, "failed to get DMA
> > descriptor\n");
> > +		return -EIO;
> > +	}
> > +
> > +	dma_desc->callback =3D tegra_i2c_dma_complete;
> > +	dma_desc->callback_param =3D i2c_dev;
> > +	dmaengine_submit(dma_desc);
> > +	dma_async_issue_pending(chan);
> > +	return 0;
> > +}
> > +
> > +static int tegra_i2c_init_dma_param(struct tegra_i2c_dev *i2c_dev)
> > +{
> > +	struct dma_chan *dma_chan;
> > +	u32 *dma_buf;
> > +	dma_addr_t dma_phys;
> > +
> > +	if (!i2c_dev->has_dma)
> > +		return -EINVAL;
> > +
> > +	if (!i2c_dev->rx_dma_chan) {
> > +		dma_chan =3D
> > dma_request_slave_channel_reason(i2c_dev->dev, "rx");
> > +		if (IS_ERR(dma_chan))
> > +			return PTR_ERR(dma_chan); =20
>=20
> I think we want to fallback to PIO here if dma_chan is -ENODEV.
>=20
> > +
> > +		i2c_dev->rx_dma_chan =3D dma_chan;
> > +	}
> > +
> > +	if (!i2c_dev->tx_dma_chan) {
> > +		dma_chan =3D
> > dma_request_slave_channel_reason(i2c_dev->dev, "tx");
> > +		if (IS_ERR(dma_chan))
> > +			return PTR_ERR(dma_chan); =20
>=20
> Same here. We could use rx_dma_chan =3D=3D NULL as a condition to detect
> that instead of the extra has_dma.
>=20
> > +		i2c_dev->tx_dma_chan =3D dma_chan;
> > +	} =20
>=20
> Although, I'm not exactly sure I understand what you're trying to
> achieve here. Shouldn't we move the channel request parts into probe
> and remove them from here? Otherwise it seems like we could get into
> a state where we keep trying to get the slave channels everytime we
> set up a DMA transfer, even if we already failed to do so during
> probe.
>=20
> > +
> > +	if (!i2c_dev->dma_buf && i2c_dev->msg_buf_remaining) {
> > +		dma_buf =3D dma_alloc_coherent(i2c_dev->dev,
> > +					     i2c_dev->dma_buf_size,
> > +					     &dma_phys,
> > GFP_KERNEL); +
> > +		if (!dma_buf) {
> > +			dev_err(i2c_dev->dev,
> > +				"failed to allocate the DMA
> > buffer\n");
> > +			dma_release_channel(i2c_dev->tx_dma_chan);
> > +			dma_release_channel(i2c_dev->rx_dma_chan);
> > +			i2c_dev->tx_dma_chan =3D NULL;
> > +			i2c_dev->rx_dma_chan =3D NULL;
> > +			return -ENOMEM;
> > +		}
> > +
> > +		i2c_dev->dma_buf =3D dma_buf;
> > +		i2c_dev->dma_phys =3D dma_phys;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int tegra_i2c_flush_fifos(struct tegra_i2c_dev *i2c_dev)
> >  {
> >  	unsigned long timeout =3D jiffies + HZ;
> > @@ -656,25 +771,38 @@ static irqreturn_t tegra_i2c_isr(int irq,
> > void *dev_id) if (i2c_dev->hw->supports_bus_clear && (status &
> > I2C_INT_BUS_CLR_DONE)) goto err;
> > =20
> > -	if (i2c_dev->msg_read && (status &
> > I2C_INT_RX_FIFO_DATA_REQ)) {
> > -		if (i2c_dev->msg_buf_remaining)
> > -			tegra_i2c_empty_rx_fifo(i2c_dev);
> > -		else
> > -			BUG();
> > -	}
> > +	if (!i2c_dev->is_curr_dma_xfer) {
> > +		if (i2c_dev->msg_read && (status &
> > I2C_INT_RX_FIFO_DATA_REQ)) {
> > +			if (i2c_dev->msg_buf_remaining)
> > +				tegra_i2c_empty_rx_fifo(i2c_dev);
> > +			else
> > +				BUG();
> > +		}
> > =20
> > -	if (!i2c_dev->msg_read && (status &
> > I2C_INT_TX_FIFO_DATA_REQ)) {
> > -		if (i2c_dev->msg_buf_remaining)
> > -			tegra_i2c_fill_tx_fifo(i2c_dev);
> > -		else
> > -			tegra_i2c_mask_irq(i2c_dev,
> > I2C_INT_TX_FIFO_DATA_REQ);
> > +		if (!i2c_dev->msg_read &&
> > +		   (status & I2C_INT_TX_FIFO_DATA_REQ)) {
> > +			if (i2c_dev->msg_buf_remaining)
> > +				tegra_i2c_fill_tx_fifo(i2c_dev);
> > +			else
> > +				tegra_i2c_mask_irq(i2c_dev,
> > +
> > I2C_INT_TX_FIFO_DATA_REQ);
> > +		}
> >  	}
> > =20
> >  	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
> >  	if (i2c_dev->is_dvc)
> >  		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR,
> > DVC_STATUS);=20
> > +	/*
> > +	 * During message read XFER_COMPLETE interrupt is
> > triggered prior to
> > +	 * DMA completion and during message write XFER_COMPLETE
> > interrupt is
> > +	 * triggered after DMA completion.
> > +	 * PACKETS_XFER_COMPLETE indicates completion of all bytes
> > of transfer.
> > +	 * so forcing msg_buf_remaining to 0 in DMA mode.
> > +	 */
> >  	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
> > +		if (i2c_dev->is_curr_dma_xfer)
> > +			i2c_dev->msg_buf_remaining =3D 0;
> >  		BUG_ON(i2c_dev->msg_buf_remaining);
> >  		complete(&i2c_dev->msg_complete);
> >  	}
> > @@ -690,12 +818,69 @@ static irqreturn_t tegra_i2c_isr(int irq,
> > void *dev_id) if (i2c_dev->is_dvc)
> >  		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR,
> > DVC_STATUS);=20
> > +	if (i2c_dev->is_curr_dma_xfer) {
> > +		if (i2c_dev->msg_read)
> > +
> > dmaengine_terminate_all(i2c_dev->rx_dma_chan);
> > +		else
> > +
> > dmaengine_terminate_all(i2c_dev->tx_dma_chan); +
> > +		complete(&i2c_dev->dma_complete);
> > +	}
> > +
> >  	complete(&i2c_dev->msg_complete);
> >  done:
> >  	spin_unlock(&i2c_dev->xfer_lock);
> >  	return IRQ_HANDLED;
> >  }
> > =20
> > +static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev
> > *i2c_dev,
> > +				       size_t len, int direction)
> > +{
> > +	u32 val, reg;
> > +	u8 dma_burst =3D 0;
> > +	struct dma_slave_config dma_sconfig;
> > +	struct dma_chan *chan;
> > +
> > +	if (i2c_dev->hw->has_mst_fifo)
> > +		reg =3D I2C_MST_FIFO_CONTROL;
> > +	else
> > +		reg =3D I2C_FIFO_CONTROL;
> > +	val =3D i2c_readl(i2c_dev, reg);
> > +
> > +	if (len & 0xF)
> > +		dma_burst =3D 1;
> > +	else if (len & 0x10)
> > +		dma_burst =3D 4;
> > +	else
> > +		dma_burst =3D 8;
> > +
> > +	if (direction =3D=3D DATA_DMA_DIR_TX) {
> > +		if (i2c_dev->hw->has_mst_fifo)
> > +			val |=3D
> > I2C_MST_FIFO_CONTROL_TX_TRIG(dma_burst);
> > +		else
> > +			val |=3D I2C_FIFO_CONTROL_TX_TRIG(dma_burst);
> > +	} else {
> > +		if (i2c_dev->hw->has_mst_fifo)
> > +			val |=3D
> > I2C_MST_FIFO_CONTROL_RX_TRIG(dma_burst);
> > +		else
> > +			val |=3D I2C_FIFO_CONTROL_RX_TRIG(dma_burst);
> > +	}
> > +	i2c_writel(i2c_dev, val, reg);
> > +
> > +	if (direction =3D=3D DATA_DMA_DIR_TX) {
> > +		dma_sconfig.dst_addr =3D i2c_dev->base_phys +
> > I2C_TX_FIFO;
> > +		dma_sconfig.dst_addr_width =3D
> > DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +		dma_sconfig.dst_maxburst =3D dma_burst;
> > +	} else {
> > +		dma_sconfig.src_addr =3D i2c_dev->base_phys +
> > I2C_RX_FIFO;
> > +		dma_sconfig.src_addr_width =3D
> > DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +		dma_sconfig.src_maxburst =3D dma_burst;
> > +	}
> > +
> > +	chan =3D i2c_dev->msg_read ? i2c_dev->rx_dma_chan :
> > i2c_dev->tx_dma_chan;
> > +	dmaengine_slave_config(chan, &dma_sconfig);
> > +}
> > +
> >  static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
> >  {
> >  	int err;
> > @@ -740,6 +925,11 @@ static int tegra_i2c_xfer_msg(struct
> > tegra_i2c_dev *i2c_dev, u32 int_mask;
> >  	unsigned long time_left;
> >  	unsigned long flags;
> > +	size_t xfer_size;
> > +	u32 *buffer =3D 0; =20
>=20
> Usually this should be =3D NULL for pointers.
>=20
> > +	int err =3D 0;
> > +	bool dma =3D false;
> > +	struct dma_chan *chan;
> > =20
> >  	tegra_i2c_flush_fifos(i2c_dev);
> > =20
> > @@ -749,19 +939,69 @@ static int tegra_i2c_xfer_msg(struct
> > tegra_i2c_dev *i2c_dev, i2c_dev->msg_read =3D (msg->flags & I2C_M_RD);
> >  	reinit_completion(&i2c_dev->msg_complete);
> > =20
> > +	if (i2c_dev->msg_read)
> > +		xfer_size =3D msg->len;
> > +	else
> > +		xfer_size =3D msg->len + I2C_PACKET_HEADER_SIZE;
> > +
> > +	xfer_size =3D ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
> > +	dma =3D (xfer_size > I2C_PIO_MODE_MAX_LEN);
> > +	if (dma) {
> > +		err =3D tegra_i2c_init_dma_param(i2c_dev);
> > +		if (err < 0) {
> > +			dev_dbg(i2c_dev->dev, "switching to PIO
> > transfer\n");
> > +			dma =3D false;
> > +		} =20
>=20
> If we successfully got DMA channels at probe time, doesn't this turn
> into an error condition that is worth reporting? It seems to me like
> the only reason it could fail is if we fail the allocation, but then
> again, why don't we move the DMA buffer allocation into probe()? We
> already use a fixed size for that allocation, so there's no reason it
> couldn't be allocated at probe time.
>=20
> Seems like maybe you just overlooked that as you were moving around
> the code pieces.
>=20
> > +	}
> > +
> > +	i2c_dev->is_curr_dma_xfer =3D dma;
> >  	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
> > =20
> >  	int_mask =3D I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
> >  	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> > =20
> > +	if (dma) {
> > +		if (i2c_dev->msg_read) {
> > +			chan =3D i2c_dev->rx_dma_chan;
> > +			tegra_i2c_config_fifo_trig(i2c_dev,
> > xfer_size,
> > +
> > DATA_DMA_DIR_RX);
> > +			dma_sync_single_for_device(i2c_dev->dev,
> > +
> > i2c_dev->dma_phys,
> > +						   xfer_size,
> > +
> > DMA_FROM_DEVICE); =20
>=20
> Do we really need this? We're not actually passing the device any
> data, so no caches to flush here. I we're cautious about flushing
> caches when we do write to the buffer (and I think we do that
> properly already), then there should be no need to do it here again.
>=20

IIUC, DMA API has a concept of buffer handing which tells to use
dma_sync_single_for_device() before issuing hardware job that touches
the buffer and to use dma_sync_single_for_cpu() after hardware done the
execution. In fact the CPU caches are getting flushed or invalidated as
appropriate in a result.

dma_sync_single_for_device(DMA_FROM_DEVICE) invalidates buffer in the
CPU cache, probably to avoid CPU evicting data from cache to
DRAM while hardware writes to the buffer. Hence this hunk is correct.

> > +			err =3D tegra_i2c_dma_submit(i2c_dev,
> > xfer_size);
> > +			if (err < 0) {
> > +				dev_err(i2c_dev->dev,
> > +					"starting RX DMA failed,
> > err %d\n",
> > +					err);
> > +				goto unlock;
> > +			}
> > +		} else {
> > +			chan =3D i2c_dev->tx_dma_chan;
> > +			tegra_i2c_config_fifo_trig(i2c_dev,
> > xfer_size,
> > +
> > DATA_DMA_DIR_TX);
> > +			dma_sync_single_for_cpu(i2c_dev->dev,
> > +						i2c_dev->dma_phys,
> > +						xfer_size,
> > +						DMA_TO_DEVICE); =20
>=20
> This, on the other hand seems correct because we need to invalidate
> the caches for this buffer to make sure the data that we put there
> doesn't get overwritten.

As I stated before in a comment to v6, this particular case of
dma_sync_single_for_cpu() usage is incorrect because CPU should take
ownership of the buffer after completion of hardwate job. But in fact
dma_sync_single_for_cpu(DMA_TO_DEVICE) is a NO-OP because CPU doesn't
need to flush or invalidate anything to take ownership of the buffer if
hardware did a read-only access.

>=20
> > +			buffer =3D i2c_dev->dma_buf;
> > +		}
> > +	}
> > +
> >  	packet_header =3D (0 << PACKET_HEADER0_HEADER_SIZE_SHIFT) |
> >  			PACKET_HEADER0_PROTOCOL_I2C |
> >  			(i2c_dev->cont_id <<
> > PACKET_HEADER0_CONT_ID_SHIFT) | (1 <<
> > PACKET_HEADER0_PACKET_ID_SHIFT);
> > -	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> > +	if (dma && !i2c_dev->msg_read)
> > +		*buffer++ =3D packet_header;
> > +	else
> > +		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> > =20
> >  	packet_header =3D msg->len - 1;
> > -	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> > +	if (dma && !i2c_dev->msg_read)
> > +		*buffer++ =3D packet_header;
> > +	else
> > +		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> > =20
> >  	packet_header =3D I2C_HEADER_IE_ENABLE;
> >  	if (end_state =3D=3D MSG_END_CONTINUE)
> > @@ -778,30 +1018,79 @@ static int tegra_i2c_xfer_msg(struct
> > tegra_i2c_dev *i2c_dev, packet_header |=3D I2C_HEADER_CONT_ON_NAK;
> >  	if (msg->flags & I2C_M_RD)
> >  		packet_header |=3D I2C_HEADER_READ;
> > -	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> > -
> > -	if (!(msg->flags & I2C_M_RD))
> > -		tegra_i2c_fill_tx_fifo(i2c_dev);
> > -
> > +	if (dma && !i2c_dev->msg_read)
> > +		*buffer++ =3D packet_header;
> > +	else
> > +		i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> > +
> > +	if (!i2c_dev->msg_read) {
> > +		if (dma) {
> > +			memcpy(buffer, msg->buf, msg->len);
> > +			dma_sync_single_for_device(i2c_dev->dev,
> > +
> > i2c_dev->dma_phys,
> > +						   xfer_size,
> > +
> > DMA_TO_DEVICE); =20
>=20
> Again, here we properly flush the caches to make sure the data that
> we've written to the DMA buffer is visible to the DMA engine.
>=20

+1 this is correct

> > +			err =3D tegra_i2c_dma_submit(i2c_dev,
> > xfer_size);
> > +			if (err < 0) {
> > +				dev_err(i2c_dev->dev,
> > +					"starting TX DMA failed,
> > err %d\n",
> > +					err);
> > +				goto unlock;
> > +			}
> > +		} else {
> > +			tegra_i2c_fill_tx_fifo(i2c_dev);
> > +		}
> > +	}
> >  	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
> >  		int_mask |=3D I2C_INT_PACKET_XFER_COMPLETE;
> > -	if (msg->flags & I2C_M_RD)
> > -		int_mask |=3D I2C_INT_RX_FIFO_DATA_REQ;
> > -	else if (i2c_dev->msg_buf_remaining)
> > -		int_mask |=3D I2C_INT_TX_FIFO_DATA_REQ;
> > +	if (!dma) {
> > +		if (msg->flags & I2C_M_RD)
> > +			int_mask |=3D I2C_INT_RX_FIFO_DATA_REQ;
> > +		else if (i2c_dev->msg_buf_remaining)
> > +			int_mask |=3D I2C_INT_TX_FIFO_DATA_REQ;
> > +	}
> > =20
> >  	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> > -	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
> >  	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
> >  		i2c_readl(i2c_dev, I2C_INT_MASK));
> > =20
> > +unlock:
> > +	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
> > +
> > +	if (dma) {
> > +		if (err)
> > +			return err;
> > +
> > +		time_left =3D wait_for_completion_timeout(
> > +
> > &i2c_dev->dma_complete,
> > +						TEGRA_I2C_TIMEOUT);
> > +
> > +		if (time_left =3D=3D 0) {
> > +			dev_err(i2c_dev->dev, "DMA transfer
> > timeout\n");
> > +			dmaengine_terminate_all(chan);
> > +			tegra_i2c_init(i2c_dev);
> > +			return -ETIMEDOUT;
> > +		}
> > +
> > +		if (i2c_dev->msg_read) {
> > +			if (likely(i2c_dev->msg_err =3D=3D
> > I2C_ERR_NONE)) {
> > +
> > dma_sync_single_for_cpu(i2c_dev->dev,
> > +
> > i2c_dev->dma_phys,
> > +							xfer_size,
> > +
> > DMA_FROM_DEVICE); =20
>=20
> Here we invalidate the caches to make sure we don't get stale data
> that may be in the caches for data that we're copying out of the DMA
> buffer. I think that's about all the cache maintenance that we
> real
> need.

Correct.

And technically here should be dma_sync_single_for_cpu(DMA_TO_DEVICE)
for the TX. But again, it's a NO-OP.
