Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A56C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0832F20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADVQ44sc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfBFMsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:48:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38834 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfBFMsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:48:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so7407799wrw.5;
        Wed, 06 Feb 2019 04:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ALJT2jkH9YP113QqstnP4ZayQfTKy8r6HIzW9U88Ehg=;
        b=ADVQ44sceceV38Jj+1lTXusXtuv35wHDObAyqkKLhP0VBYLw+GOsr3jMU2jQ9thq6v
         49srMKh5MYZpScDckWsGGnic/27+sE8qJWUWT+f75aIoLQOfhgs+qc7Ld1GMG4NICZBi
         K4yNYE5G9BREbFIb4nia1fGr4qJOXqYbfIXWyW4vpqLr3OX+gjUYa+LAu9dKnNyNseRz
         IwSnuP8cjKB9zCq1Jj5dZMbBJXzhR8/fJF87q77X9L/Bofq+WAXnBLX2HdyE8XSoEV4X
         6Xq0CVJIW99XjnxLOflZpVEp8xyq+YLS7FdvBMJLIUeeWbab5TNCOEYbHzBIUVh0Kyp7
         sdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ALJT2jkH9YP113QqstnP4ZayQfTKy8r6HIzW9U88Ehg=;
        b=LhQBSxabY+c9N7rvO1Uh9ILPqtmoHPytOtTE2LNLvX0XA3to4Cx2ce5s/KTwIdgEBN
         M9lHRKCGaJQIKu94t0EEPT68IzBtQpaQjS5M3kBLSJlKQ2RPnmpg7jROPBorWiZFRTxP
         A3/pAsbIMJmZsus0vU/jK69sGIyyuN1EyLEBc5h0zgrzEVsZjXjfh0MFXj999zMhRww9
         0QFjJhoNQe1a74iJzEcmtuqUaOIYLAkWlJOR358V5wusB349lBL8rdiWXLquhwe32BOV
         tQ1vA8zIR4xc9DE7m/QmV8sM/JZ+2cxT8E6w04kKNzktHjd7XEmyX0pqpbokkmf5kQmY
         vAAQ==
X-Gm-Message-State: AHQUAuaIn2rH8BQMRSCOVaS/IrUyzj1Lw/wqb/C34UKtkiu8dToSX2Sy
        3fBygIMZd1ToW/mlhnMhQm0=
X-Google-Smtp-Source: AHgI3IYW0I3SlHYOnO/Qj/yoTsNKp0fBS8Z/m5aHwqvADfvwNtM6ZBwSRTi8ah9PPLz5wq6cNk6zTg==
X-Received: by 2002:a5d:6244:: with SMTP id m4mr7595681wrv.314.1549457331784;
        Wed, 06 Feb 2019 04:48:51 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id z5sm2553159wmi.15.2019.02.06.04.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 04:48:51 -0800 (PST)
Date:   Wed, 6 Feb 2019 13:48:50 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V12 3/5] i2c: tegra: Add DMA support
Message-ID: <20190206124850.GH21676@ulmo>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <feb6bb13-644f-0ac8-6c82-3771b5dba584@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gKijDXBCEH69PxaN"
Content-Disposition: inline
In-Reply-To: <feb6bb13-644f-0ac8-6c82-3771b5dba584@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKijDXBCEH69PxaN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 03:40:52PM +0300, Dmitry Osipenko wrote:
> 06.02.2019 1:46, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
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
> >  [V12] : Replaced dma_alloc_coherent with dma_alloc_attrs to force the =
allocated
> > 	 buffer to be contiguous also in physical memory as Tegra194 supports =
max
> > 	 64K and dma_alloc_coherent doesnt guarentee contiguous memory.
> > 	 Changed return code from EIO to EINVAL incase of failure to obtain dma
> > 	 descriptor.
> > 	 Fixed coding style check issues.	=20
> >  [V11] : Replaced deprecated dmaengine_terminate_all with dmaengine_ter=
mine_async
> > 	 from non-atomic context and dmaengine_terminate_sync from atomic cont=
ext.
> > 	 Fixed to program fifo trigger levels properly when transfer falls bac=
k to
> > 	 pio mode in case of dma slave configuration failure and other minor f=
ixes.
> >  [V10] : APBDMA is replaced with GPCDMA on Tegra186 and Tegra194 design=
s.
> > 	 Added apbdma hw support flag to now allow Tegra186 and later use
> > 	 APBDMA driver.
> > 	 Added explicit flow control enable for DMA slave config and error han=
dling.
> > 	 Moved releasing DMA resources to seperate function to reuse in
> > 	 multiple places.
> > 	 Updated to register tegra_i2c_driver from module level rather than su=
bsys
> > 	 level.
> > 	 Other minor feedback
> >  [V9] :  Rebased to 5.0-rc4
> > 	 Removed dependency of APB DMA in Kconfig and added conditional check
> >  	 in I2C driver to decide on using DMA mode.
> > 	 Changed back the allocation of dma buffer during i2c probe.
> > 	 Fixed FIFO triggers depending on DMA Vs PIO.
> >  [V8] :  Moved back dma init to i2c probe, removed ALL_PACKETS_XFER_COM=
PLETE
> > 	 interrupt and using PACKETS_XFER_COMPLETE interrupt only and some
> > 	 other fixes
> > 	 Updated Kconfig for APB_DMA dependency
> >  [V7] :  Same as V6
> >  [V6] :  Updated for proper buffer allocation/freeing, channel release.
> > 	 Updated to use exact xfer size for syncing dma buffer.
> >  [V5] :  Same as V4
> >  [V4] :  Updated to allocate DMA buffer only when DMA mode.
> > 	 Updated to fall back to PIO mode when DMA channel request or
> > 	 buffer allocation fails.
> >  [V3] :  Updated without additional buffer allocation.
> >  [V2] :  Updated based on V1 review feedback along with code cleanup for
> > 	 proper implementation of DMA.
> >=20
> >=20
> >  drivers/i2c/busses/i2c-tegra.c | 413 +++++++++++++++++++++++++++++++++=
+++-----
> >  1 file changed, 369 insertions(+), 44 deletions(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-te=
gra.c
> > index 118b7023a0f4..77277a09e485 100644
> > --- a/drivers/i2c/busses/i2c-tegra.c
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
> > +#define DATA_DMA_DIR_TX				BIT(0)
> > +#define DATA_DMA_DIR_RX				BIT(1)
> > +
> > +/*
> > + * Upto I2C_PIO_MODE_MAX_LEN bytes, controller will use PIO mode,
> > + * above this, controller will use DMA to fill FIFO.
> > + * MAX PIO len is 20 bytes excluding packet header.
> > + */
> > +#define I2C_PIO_MODE_MAX_LEN			32
> > +
> >  /*
> >   * msg_end_type: The bus control which need to be send at end of trans=
fer.
> >   * @MSG_END_STOP: Send stop pulse at end of transfer.
> > @@ -166,6 +184,7 @@ enum msg_end_type {
> >   *		allowing 0 length transfers.
> >   * @supports_bus_clear: Bus Clear support to recover from bus hang dur=
ing
> >   *		SDA stuck low from device for some unknown reasons.
> > + * @has_apb_dma: Support of APBDMA on corresponding Tegra chip.
> >   */
> >  struct tegra_i2c_hw_feature {
> >  	bool has_continue_xfer_support;
> > @@ -180,6 +199,7 @@ struct tegra_i2c_hw_feature {
> >  	bool has_mst_fifo;
> >  	const struct i2c_adapter_quirks *quirks;
> >  	bool supports_bus_clear;
> > +	bool has_apb_dma;
> >  };
> > =20
> >  /**
> > @@ -191,6 +211,7 @@ struct tegra_i2c_hw_feature {
> >   * @fast_clk: clock reference for fast clock of I2C controller
> >   * @rst: reset control for the I2C controller
> >   * @base: ioremapped registers cookie
> > + * @base_phys: Physical base address of the I2C controller
> >   * @cont_id: I2C controller ID, used for packet header
> >   * @irq: IRQ number of transfer complete interrupt
> >   * @irq_disabled: used to track whether or not the interrupt is enabled
> > @@ -204,6 +225,13 @@ struct tegra_i2c_hw_feature {
> >   * @clk_divisor_non_hs_mode: clock divider for non-high-speed modes
> >   * @is_multimaster_mode: track if I2C controller is in multi-master mo=
de
> >   * @xfer_lock: lock to serialize transfer submission and processing
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
> > @@ -213,6 +241,7 @@ struct tegra_i2c_dev {
> >  	struct clk *fast_clk;
> >  	struct reset_control *rst;
> >  	void __iomem *base;
> > +	phys_addr_t base_phys;
> >  	int cont_id;
> >  	int irq;
> >  	bool irq_disabled;
> > @@ -226,6 +255,13 @@ struct tegra_i2c_dev {
> >  	u16 clk_divisor_non_hs_mode;
> >  	bool is_multimaster_mode;
> >  	spinlock_t xfer_lock;
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
> > @@ -294,6 +330,111 @@ static void tegra_i2c_unmask_irq(struct tegra_i2c=
_dev *i2c_dev, u32 mask)
> >  	i2c_writel(i2c_dev, int_mask, I2C_INT_MASK);
> >  }
> > =20
> > +static void tegra_i2c_dma_complete(void *args)
> > +{
> > +	struct tegra_i2c_dev *i2c_dev =3D args;
> > +
> > +	complete(&i2c_dev->dma_complete);
> > +}
> > +
> > +static int tegra_i2c_dma_submit(struct tegra_i2c_dev *i2c_dev, size_t =
len)
> > +{
> > +	struct dma_async_tx_descriptor *dma_desc;
> > +	enum dma_transfer_direction dir;
> > +	struct dma_chan *chan;
> > +
> > +	dev_dbg(i2c_dev->dev, "starting DMA for length: %zu\n", len);
> > +	reinit_completion(&i2c_dev->dma_complete);
> > +	dir =3D i2c_dev->msg_read ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
> > +	chan =3D i2c_dev->msg_read ? i2c_dev->rx_dma_chan : i2c_dev->tx_dma_c=
han;
> > +	dma_desc =3D dmaengine_prep_slave_single(chan, i2c_dev->dma_phys,
> > +					       len, dir, DMA_PREP_INTERRUPT |
> > +					       DMA_CTRL_ACK);
> > +	if (!dma_desc) {
> > +		dev_err(i2c_dev->dev, "failed to get DMA descriptor\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	dma_desc->callback =3D tegra_i2c_dma_complete;
> > +	dma_desc->callback_param =3D i2c_dev;
> > +	dmaengine_submit(dma_desc);
> > +	dma_async_issue_pending(chan);
> > +	return 0;
> > +}
> > +
> > +static void tegra_i2c_release_dma(struct tegra_i2c_dev *i2c_dev)
> > +{
> > +	if (i2c_dev->dma_buf) {
> > +		dma_free_attrs(i2c_dev->dev, i2c_dev->dma_buf_size,
> > +			       i2c_dev->dma_buf, i2c_dev->dma_phys,
> > +			       DMA_ATTR_FORCE_CONTIGUOUS);
> > +		i2c_dev->dma_buf =3D NULL;
> > +	}
> > +
> > +	if (i2c_dev->tx_dma_chan) {
> > +		dma_release_channel(i2c_dev->tx_dma_chan);
> > +		i2c_dev->tx_dma_chan =3D NULL;
> > +	}
> > +
> > +	if (i2c_dev->rx_dma_chan) {
> > +		dma_release_channel(i2c_dev->rx_dma_chan);
> > +		i2c_dev->rx_dma_chan =3D NULL;
> > +	}
> > +}
> > +
> > +static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
> > +{
> > +	struct dma_chan *chan;
> > +	u32 *dma_buf;
> > +	dma_addr_t dma_phys;
> > +	int err;
> > +
> > +	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA) ||
> > +	    !i2c_dev->hw->has_apb_dma) {
> > +		err =3D -ENODEV;
> > +		goto err_out;
> > +	}
> > +
> > +	chan =3D dma_request_slave_channel_reason(i2c_dev->dev, "rx");
> > +	if (IS_ERR(chan)) {
> > +		err =3D PTR_ERR(chan);
> > +		goto err_out;
> > +	}
> > +
> > +	i2c_dev->rx_dma_chan =3D chan;
> > +
> > +	chan =3D dma_request_slave_channel_reason(i2c_dev->dev, "tx");
> > +	if (IS_ERR(chan)) {
> > +		err =3D PTR_ERR(chan);
> > +		goto err_out;
> > +	}
> > +
> > +	i2c_dev->tx_dma_chan =3D chan;
> > +
> > +	dma_buf =3D dma_alloc_attrs(i2c_dev->dev, i2c_dev->dma_buf_size,
> > +				  &dma_phys, GFP_KERNEL | __GFP_NOWARN,
> > +				  DMA_ATTR_FORCE_CONTIGUOUS);
> > +	if (!dma_buf) {
> > +		dev_err(i2c_dev->dev, "failed to allocate the DMA buffer\n");
> > +		err =3D -ENOMEM;
> > +		goto err_out;
> > +	}
> > +
> > +	i2c_dev->dma_buf =3D dma_buf;
> > +	i2c_dev->dma_phys =3D dma_phys;
> > +	return 0;
> > +
> > +err_out:
> > +	tegra_i2c_release_dma(i2c_dev);
> > +	if (err !=3D -EPROBE_DEFER) {
> > +		dev_err(i2c_dev->dev, "can't use DMA, err: %d, using PIO\n",
> > +			err);
> > +		return 0;
> > +	}
> > +
> > +	return err;
> > +}
> > +
> >  static int tegra_i2c_flush_fifos(struct tegra_i2c_dev *i2c_dev)
> >  {
> >  	unsigned long timeout =3D jiffies + HZ;
> > @@ -571,16 +712,6 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2=
c_dev)
> >  		i2c_writel(i2c_dev, 0x00, I2C_SL_ADDR2);
> >  	}
> > =20
> > -	if (i2c_dev->hw->has_mst_fifo) {
> > -		val =3D I2C_MST_FIFO_CONTROL_TX_TRIG(8) |
> > -		      I2C_MST_FIFO_CONTROL_RX_TRIG(1);
> > -		i2c_writel(i2c_dev, val, I2C_MST_FIFO_CONTROL);
> > -	} else {
> > -		val =3D 7 << I2C_FIFO_CONTROL_TX_TRIG_SHIFT |
> > -			0 << I2C_FIFO_CONTROL_RX_TRIG_SHIFT;
> > -		i2c_writel(i2c_dev, val, I2C_FIFO_CONTROL);
> > -	}
> > -
> >  	err =3D tegra_i2c_flush_fifos(i2c_dev);
> >  	if (err)
> >  		goto err;
> > @@ -660,25 +791,37 @@ static irqreturn_t tegra_i2c_isr(int irq, void *d=
ev_id)
> >  	if (i2c_dev->hw->supports_bus_clear && (status & I2C_INT_BUS_CLR_DONE=
))
> >  		goto err;
> > =20
> > -	if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ)) {
> > -		if (i2c_dev->msg_buf_remaining)
> > -			tegra_i2c_empty_rx_fifo(i2c_dev);
> > -		else
> > -			BUG();
> > -	}
> > +	if (!i2c_dev->is_curr_dma_xfer) {
> > +		if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ)) {
> > +			if (i2c_dev->msg_buf_remaining)
> > +				tegra_i2c_empty_rx_fifo(i2c_dev);
> > +			else
> > +				BUG();
> > +		}
> > =20
> > -	if (!i2c_dev->msg_read && (status & I2C_INT_TX_FIFO_DATA_REQ)) {
> > -		if (i2c_dev->msg_buf_remaining)
> > -			tegra_i2c_fill_tx_fifo(i2c_dev);
> > -		else
> > -			tegra_i2c_mask_irq(i2c_dev, I2C_INT_TX_FIFO_DATA_REQ);
> > +		if (!i2c_dev->msg_read && (status & I2C_INT_TX_FIFO_DATA_REQ)) {
> > +			if (i2c_dev->msg_buf_remaining)
> > +				tegra_i2c_fill_tx_fifo(i2c_dev);
> > +			else
> > +				tegra_i2c_mask_irq(i2c_dev,
> > +						   I2C_INT_TX_FIFO_DATA_REQ);
> > +		}
> >  	}
> > =20
> >  	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
> >  	if (i2c_dev->is_dvc)
> >  		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
> > =20
> > +	/*
> > +	 * During message read XFER_COMPLETE interrupt is triggered prior to
> > +	 * DMA completion and during message write XFER_COMPLETE interrupt is
> > +	 * triggered after DMA completion.
> > +	 * PACKETS_XFER_COMPLETE indicates completion of all bytes of transfe=
r.
> > +	 * so forcing msg_buf_remaining to 0 in DMA mode.
> > +	 */
> >  	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
> > +		if (i2c_dev->is_curr_dma_xfer)
> > +			i2c_dev->msg_buf_remaining =3D 0;
> >  		BUG_ON(i2c_dev->msg_buf_remaining);
> >  		complete(&i2c_dev->msg_complete);
> >  	}
> > @@ -694,12 +837,89 @@ static irqreturn_t tegra_i2c_isr(int irq, void *d=
ev_id)
> >  	if (i2c_dev->is_dvc)
> >  		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
> > =20
> > +	if (i2c_dev->is_curr_dma_xfer) {
> > +		if (i2c_dev->msg_read)
> > +			dmaengine_terminate_async(i2c_dev->rx_dma_chan);
> > +		else
> > +			dmaengine_terminate_async(i2c_dev->tx_dma_chan);
> > +
> > +		complete(&i2c_dev->dma_complete);
> > +	}
> > +
> >  	complete(&i2c_dev->msg_complete);
> >  done:
> >  	spin_unlock(&i2c_dev->xfer_lock);
> >  	return IRQ_HANDLED;
> >  }
> > =20
> > +static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
> > +				       size_t len)
> > +{
> > +	u32 val, reg;
> > +	u8 dma_burst =3D 0;
> > +	struct dma_slave_config slv_config =3D {0};
> > +	struct dma_chan *chan;
> > +	int ret;
> > +
> > +	if (i2c_dev->hw->has_mst_fifo)
> > +		reg =3D I2C_MST_FIFO_CONTROL;
> > +	else
> > +		reg =3D I2C_FIFO_CONTROL;
> > +	val =3D i2c_readl(i2c_dev, reg);
> > +
> > +	if (i2c_dev->is_curr_dma_xfer) {
> > +		if (len & 0xF)
> > +			dma_burst =3D 1;
> > +		else if (len & 0x10)
> > +			dma_burst =3D 4;
> > +		else
> > +			dma_burst =3D 8;
> > +
> > +		if (i2c_dev->msg_read) {
> > +			chan =3D i2c_dev->rx_dma_chan;
> > +			slv_config.src_addr =3D i2c_dev->base_phys + I2C_RX_FIFO;
> > +			slv_config.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +			slv_config.src_maxburst =3D dma_burst;
> > +
> > +			if (i2c_dev->hw->has_mst_fifo)
> > +				val |=3D I2C_MST_FIFO_CONTROL_RX_TRIG(dma_burst);
> > +			else
> > +				val |=3D I2C_FIFO_CONTROL_RX_TRIG(dma_burst);
> > +		} else {
> > +			chan =3D i2c_dev->tx_dma_chan;
> > +			slv_config.dst_addr =3D i2c_dev->base_phys + I2C_TX_FIFO;
> > +			slv_config.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +			slv_config.dst_maxburst =3D dma_burst;
> > +
> > +			if (i2c_dev->hw->has_mst_fifo)
> > +				val |=3D I2C_MST_FIFO_CONTROL_TX_TRIG(dma_burst);
> > +			else
> > +				val |=3D I2C_FIFO_CONTROL_TX_TRIG(dma_burst);
> > +		}
> > +
> > +		slv_config.device_fc =3D true;
> > +		ret =3D dmaengine_slave_config(chan, &slv_config);
> > +		if (ret < 0) {
> > +			dev_err(i2c_dev->dev, "DMA slave config failed: %d\n",
> > +				ret);
> > +			dev_err(i2c_dev->dev, "fallbacking to PIO\n");
> > +			tegra_i2c_release_dma(i2c_dev);
> > +			i2c_dev->is_curr_dma_xfer =3D false;
> > +		} else {
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	if (i2c_dev->hw->has_mst_fifo)
> > +		val =3D I2C_MST_FIFO_CONTROL_TX_TRIG(8) |
> > +		      I2C_MST_FIFO_CONTROL_RX_TRIG(1);
> > +	else
> > +		val =3D I2C_FIFO_CONTROL_TX_TRIG(8) |
> > +		      I2C_FIFO_CONTROL_RX_TRIG(1);
> > +out:
> > +	i2c_writel(i2c_dev, val, reg);
> > +}
> > +
> >  static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
> >  {
> >  	int err;
> > @@ -744,6 +964,10 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev=
 *i2c_dev,
> >  	u32 int_mask;
> >  	unsigned long time_left;
> >  	unsigned long flags;
> > +	size_t xfer_size;
> > +	u32 *buffer =3D NULL;
> > +	int err =3D 0;
> > +	bool dma;
> > =20
> >  	tegra_i2c_flush_fifos(i2c_dev);
> > =20
> > @@ -753,19 +977,57 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_de=
v *i2c_dev,
> >  	i2c_dev->msg_read =3D (msg->flags & I2C_M_RD);
> >  	reinit_completion(&i2c_dev->msg_complete);
> > =20
> > +	if (i2c_dev->msg_read)
> > +		xfer_size =3D msg->len;
> > +	else
> > +		xfer_size =3D msg->len + I2C_PACKET_HEADER_SIZE;
> > +
> > +	xfer_size =3D ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
> > +	i2c_dev->is_curr_dma_xfer =3D (xfer_size > I2C_PIO_MODE_MAX_LEN) &&
> > +				    i2c_dev->dma_buf;
> > +	tegra_i2c_config_fifo_trig(i2c_dev, xfer_size);
> > +	dma =3D i2c_dev->is_curr_dma_xfer;
> > +
> >  	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
> > =20
> >  	int_mask =3D I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
> >  	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> > +	if (dma) {
> > +		if (i2c_dev->msg_read) {
> > +			dma_sync_single_for_device(i2c_dev->dev,
> > +						   i2c_dev->dma_phys,
> > +						   xfer_size,
> > +						   DMA_FROM_DEVICE);
> > +			err =3D tegra_i2c_dma_submit(i2c_dev, xfer_size);
> > +			if (err < 0) {
> > +				dev_err(i2c_dev->dev,
> > +					"starting RX DMA failed, err %d\n",
> > +					err);
> > +				goto unlock;
> > +			}
> > +		} else {
> > +			dma_sync_single_for_cpu(i2c_dev->dev,
> > +						i2c_dev->dma_phys,
> > +						xfer_size,
> > +						DMA_TO_DEVICE);
> > +			buffer =3D i2c_dev->dma_buf;
> > +		}
> > +	}
> > =20
> >  	packet_header =3D (0 << PACKET_HEADER0_HEADER_SIZE_SHIFT) |
> >  			PACKET_HEADER0_PROTOCOL_I2C |
> >  			(i2c_dev->cont_id << PACKET_HEADER0_CONT_ID_SHIFT) |
> >  			(1 << PACKET_HEADER0_PACKET_ID_SHIFT);
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
>=20
> I'm now also wondering whether that putting packet_header into the
> dma_buf is really needed at all.. Isn't possible to push packet_header
> using PIO regardless of whether the rest of the transfer will be in
> DMA or PIO modes?
>=20
> Actually I tried to always push packet_header using PIO and apparently
> DMA works just fine with that:

I don't see a reason why that wouldn't work. After all the DMA support
here is really just about some external DMA engine writing to the FIFO
register, so from an I2C controller's point of view it's exactly the
same thing.

But if we already set up DMA for a transfer, might as well transfer the
3 packet header words with that.

Thierry

--gKijDXBCEH69PxaN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxa17IACgkQ3SOs138+
s6EDuBAAgQi3CUAbPaHeBYcwDX9+63+rd0QZ88eSYEbrbHU4N4OxuuZfdITgZhWG
4S7Ocz/TIvQPXm2VtG7o2eW/KIVFrDmW64CWM8vzLcz2qRlnm5csClkpaQsmyIL4
cdNJlAz5XBsAhhTju2rROxPiyLVoctuSLNEuWvJTGbgrsh0DVd4iTtPexNQH+sMW
fEqW3Uc5GjtTZGhVMB61hHOKCwf8yIv8+5CVxach/ynU/rPdqfpRpD91TDa+4dJt
jnOZELX+qeTKuy7c3xXDKRhUrDEcJuoVymTGCSKHYIA+jQdOPe2pygbVnO8RvyHX
7Pf/jt1HfETGLOGn5Ee+iK0Rk1mx2IhlwbqetpYyx6Fg3665phl/RbRM4me1dZol
1o3KMFU1Nj/M0PW5w4Au77eXvNc2b6VwsddHgu/B/6hNRwCNa0Oz/fDi/x9L5pTE
ltv3wfnAV7Ny4j7W7Sq0TCIBMt5AZ6XTCwG76uB2dvLd1xConc+2hQNJvh23RQ4I
AnmDfWsZBv2rZtcHHHHgBK4CzEPVo0UagBq5xkhDAVnN7Mah1YyX4i3hwrc5HCtc
BRb7XBUZ5DnLV9EStKwmpmNzzN8TLkLSuGjPDr+J/WsoksPLi+gRetcCmPW+Ivrf
YdJoPAIxj8YVjma1Txuanljt5vQYN+dJ1JSf9ixx6QJPxGWK930=
=1P5L
-----END PGP SIGNATURE-----

--gKijDXBCEH69PxaN--
