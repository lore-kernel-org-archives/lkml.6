Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09792C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95F920663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY9jKoOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfAUKji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:39:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39370 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfAUKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:39:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so22698399wra.6;
        Mon, 21 Jan 2019 02:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7rSJDPBZzu87mALW7EUsHBrZSwnifLkA5ub+2qVobv0=;
        b=CY9jKoOdT7J6zlUIv/XmCMkA3wwi0Rshz36YyKXh8R6UX0SxOGpf4hVLX8BWQCrIR3
         6cCrlZr16rzTquVHEDPMidjq3NyU+1qAAJWfDZTdaI5JgofAjWYPSszTPBi9iK9+7xDK
         1ctKh+HqZj0TOJz8rJGuCoFvwOMIPLurazdljbW9OET3G0/cRVvIra/TEjME+xLZHcdi
         znzwZRRrKk3jW3M1b464MsVYMVr0rg0Z8YU3Iil/C8m0FGgysiu8CbWBodjfCh3RBXe0
         p59al2YzxBA/CquZwJihtWd2WGI9xbDQQwiLWtjCktxdwt+VN05tef0sZC42FmPawsDI
         NekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7rSJDPBZzu87mALW7EUsHBrZSwnifLkA5ub+2qVobv0=;
        b=aaNA0Xs8jWply4sqi/MVZzMAO/Wf0x8Ug+Tv2HbgM3Pz21TgCr/sw50zKZBJ9ynXYh
         YlI+n1oPrHzygSW/cN/PJwv+HkYgRe2SV58BjK9fiCZdMXqWx7A992IbwoVdx7j0F7p1
         b/f8xQ7QzhjYlD1UvUzya12YmyIujA++3/+ndNNhl0uaplr0Up+N8Nzv63H7dlpKVXja
         UPdERoAo6aTr+Fu4PMBv1Qm6kAQMbrXWsvGdjsPzs9yJGSN/OjFvDMNNOooBzz5UM0fz
         OZLLItVdMXZT19sEfIzvif9A1bVezxjrZfr4r+PTER+R4sXpA54nQTivv4d+MlKor0QQ
         Gf6A==
X-Gm-Message-State: AJcUukd+H4UFwiJNs6mJ8BOJWTOz6N36rGwi1AWtomer0MAzRkNTumJR
        V8XT3Fb2FIAolpDqiJtLKrNVAtGOoEY=
X-Google-Smtp-Source: ALg8bN5AKJ1A1yEP3/PDzC1m/LQ7abvEukowLq1G2ujQsWIvnPgRTLBUSOd5kXuYprJja124Ze6TQQ==
X-Received: by 2002:adf:be0f:: with SMTP id n15mr28301760wrh.267.1548067173853;
        Mon, 21 Jan 2019 02:39:33 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id s16sm77239108wrt.77.2019.01.21.02.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 02:39:32 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:39:32 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V1] i2c: tegra: Add DMA Support
Message-ID: <20190121103932.GB16756@ulmo>
References: <1547578806-17923-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <1547578806-17923-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 11:00:06AM -0800, Sowjanya Komatineni wrote:
> This patch adds DMA support for Tegra I2C.

In the subject: "Support" -> "support". And in the commit description
perhaps add some more details about why this is useful, maybe accompany
with some performance numbers (if you can come up with any) or describe
why there's a threshold for PIO vs. DMA transfers.

As it is, it's not immediately clear why we need or want these 400+
extra lines of code.

> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/i2c/busses/i2c-tegra.c | 494 +++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 456 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegr=
a.c
> index e417ebf7628c..abb576acc610 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -22,6 +22,9 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/iopoll.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>

I see that the include files here are not sorted at all. Well, it looks
as if they were sorted at some point and then got all scrambled again.
Might be worth adding a patch before this one that sorts them
alphabetically and then inserts the DMA related includes in the right
place. Or follow up with a patch that sorts them.

> =20
>  #include <asm/unaligned.h>
> =20
> @@ -47,6 +50,8 @@
>  #define I2C_FIFO_CONTROL_RX_FLUSH		BIT(0)
>  #define I2C_FIFO_CONTROL_TX_TRIG_SHIFT		5
>  #define I2C_FIFO_CONTROL_RX_TRIG_SHIFT		2
> +#define I2C_FIFO_CONTROL_RX_TRIG(x)		(((x) - 1) <<  2)

There's two spaces between << and 2. Should be a single one.

> +#define I2C_FIFO_CONTROL_TX_TRIG(x)		(((x) - 1) << 5)

Maybe reverse the order of these new defines to match the existing
TX_TRIG_SHIFT and RX_TRIG_SHIFT definitions.

>  #define I2C_FIFO_STATUS				0x060
>  #define I2C_FIFO_STATUS_TX_MASK			0xF0
>  #define I2C_FIFO_STATUS_TX_SHIFT		4
> @@ -118,6 +123,18 @@
>  #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
>  #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
> =20
> +#define DATA_DMA_DIR_TX				(1 << 0)
> +#define DATA_DMA_DIR_RX				(1 << 1)
> +
> +/* Upto I2C_PIO_MODE_MAX_LEN bytes, controller will use PIO mode,
> + * above this, controller will use DMA to fill FIFO.
> + * Here MAX PIO len is 20 bytes excluding packet header
> + */

Also, correct block comment style is:

	/*
	 * ...
	 */

Note how the first line doesn't have text after /*.

> +#define I2C_PIO_MODE_MAX_LEN			(32)
> +
> +/* Packet header size in bytes */
> +#define I2C_PACKET_HEADER_SIZE			(12)
> +

Maybe reverse the order of these definitions so that when you read the
comment for I2C_PIO_MODE_MAX_LEN, you already know that the I2C packet
header size is 12 bytes.

>  /*
>   * msg_end_type: The bus control which need to be send at end of transfe=
r.
>   * @MSG_END_STOP: Send stop pulse at end of transfer.
> @@ -191,6 +208,19 @@ struct tegra_i2c_hw_feature {
>   * @clk_divisor_non_hs_mode: clock divider for non-high-speed modes
>   * @is_multimaster_mode: track if I2C controller is in multi-master mode
>   * @xfer_lock: lock to serialize transfer submission and processing
> + * @has_dma: indicated if controller supports dma
> + * @rx_dma_desc: dma receive descriptor
> + * @rx_dma_chan: dma receive channel
> + * @rx_dma_buf: dma receive buffer
> + * @rx_dma_phys: dma receive handle
> + * @tx_dma_desc: dma transmit descriptor
> + * @tx_dma_chan: dma transmit channel
> + * @tx_dma_buf: dma transmit buffer
> + * @tx_dma_phys: dma transmit handle
> + * @dma_buf_size: dma transfer buffer size
> + * @is_curr_dma_xfer: indicates active dma transfer
> + * @rx_dma_complete: dma receive completion notifier
> + * @tx_dma_complete: dma transmit completion notifier

DMA is an abbreviation, so should be all caps in the description.

>   */
>  struct tegra_i2c_dev {
>  	struct device *dev;
> @@ -200,6 +230,7 @@ struct tegra_i2c_dev {
>  	struct clk *fast_clk;
>  	struct reset_control *rst;
>  	void __iomem *base;
> +	phys_addr_t phys_addr;

Looks like kerneldoc is missing for phys_addr.

>  	int cont_id;
>  	int irq;
>  	bool irq_disabled;
> @@ -213,6 +244,19 @@ struct tegra_i2c_dev {
>  	u16 clk_divisor_non_hs_mode;
>  	bool is_multimaster_mode;
>  	spinlock_t xfer_lock;
> +	bool has_dma;
> +	struct dma_async_tx_descriptor *rx_dma_desc;
> +	struct dma_chan *rx_dma_chan;
> +	u32 *rx_dma_buf;
> +	dma_addr_t rx_dma_phys;
> +	struct dma_async_tx_descriptor *tx_dma_desc;
> +	struct dma_chan *tx_dma_chan;
> +	u32 *tx_dma_buf;
> +	dma_addr_t tx_dma_phys;
> +	unsigned int dma_buf_size;
> +	bool is_curr_dma_xfer;
> +	struct completion rx_dma_complete;
> +	struct completion tx_dma_complete;
>  };

You may want to consider namespacing this a little:

	struct {
		struct dma_async_tx_descriptor *desc;
		struct dma_chan *chan;
		u32 *buf;
		dma_addr_t phys;
		struct completion complete;
	} rx, tx;

	unsigned int dma_buf_size;
	bool is_curr_dma_xfer;

But that's just cosmetic, feel free to ignore.

>  static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
> @@ -265,6 +309,110 @@ static void i2c_readsl(struct tegra_i2c_dev *i2c_de=
v, void *data,
>  	readsl(i2c_dev->base + tegra_i2c_reg_addr(i2c_dev, reg), data, len);
>  }
> =20
> +static void tegra_i2c_dma_complete(void *args)
> +{
> +	struct completion *dma_complete =3D args;
> +
> +	complete(dma_complete);
> +}
> +
> +static int tegra_i2c_start_tx_dma(struct tegra_i2c_dev *i2c_dev, int len)

It's usually a good idea to keep data types consistent. int len here
will be passed a value that's ultimately derived from a size_t field
i2c_dev->msg_bug_remaining. size_t is the right choice for any value
that is a length or size, so len should be size_t here.

> +{
> +	reinit_completion(&i2c_dev->tx_dma_complete);
> +	dev_dbg(i2c_dev->dev, "Starting tx dma for len:%d\n", len);

s/tx dma/TX DMA/. In debug messages, I find it clearer to write out text
instead of abbreviating. So s/len/length/. Also, leave a space after the
colon and use %zu for size_t variables.

> +	i2c_dev->tx_dma_desc =3D dmaengine_prep_slave_single(i2c_dev->tx_dma_ch=
an,
> +				i2c_dev->tx_dma_phys, len, DMA_MEM_TO_DEV,
> +				DMA_PREP_INTERRUPT |  DMA_CTRL_ACK);
> +	if (!i2c_dev->tx_dma_desc) {
> +		dev_err(i2c_dev->dev, "Not able to get desc for Tx\n");

Maybe:

	"failed to get TX descriptor\n"

?

> +		return -EIO;
> +	}
> +
> +	i2c_dev->tx_dma_desc->callback =3D tegra_i2c_dma_complete;
> +	i2c_dev->tx_dma_desc->callback_param =3D &i2c_dev->tx_dma_complete;
> +
> +	dmaengine_submit(i2c_dev->tx_dma_desc);
> +	dma_async_issue_pending(i2c_dev->tx_dma_chan);
> +	return 0;
> +}
> +
> +static int tegra_i2c_start_rx_dma(struct tegra_i2c_dev *i2c_dev, int len)
> +{
> +	reinit_completion(&i2c_dev->rx_dma_complete);
> +	dev_dbg(i2c_dev->dev, "Starting rx dma for len:%d\n", len);

Same comments as for transmission above.

> +	i2c_dev->rx_dma_desc =3D dmaengine_prep_slave_single(i2c_dev->rx_dma_ch=
an,
> +				i2c_dev->rx_dma_phys, len, DMA_DEV_TO_MEM,
> +				DMA_PREP_INTERRUPT |  DMA_CTRL_ACK);
> +	if (!i2c_dev->rx_dma_desc) {
> +		dev_err(i2c_dev->dev, "Not able to get desc for Rx\n");
> +		return -EIO;
> +	}
> +
> +	i2c_dev->rx_dma_desc->callback =3D tegra_i2c_dma_complete;
> +	i2c_dev->rx_dma_desc->callback_param =3D &i2c_dev->rx_dma_complete;
> +
> +	dmaengine_submit(i2c_dev->rx_dma_desc);
> +	dma_async_issue_pending(i2c_dev->rx_dma_chan);
> +	return 0;
> +}
> +
> +static int tegra_i2c_init_dma_param(struct tegra_i2c_dev *i2c_dev,
> +							bool dma_to_memory)

Please make sure to align arguments on subsequent lines with the first
argument on the first line. Use tabs and then spaces to align them up to
increase readability.

> +{
> +	struct dma_chan *dma_chan;
> +	u32 *dma_buf;
> +	dma_addr_t dma_phys;
> +	int ret;
> +	struct dma_slave_config dma_sconfig;
> +
> +	dma_chan =3D dma_request_slave_channel_reason(i2c_dev->dev,
> +						dma_to_memory ? "rx" : "tx");

Same here and elsewhere. If you run into issues with line length
constraints (like here because the function name is awfully long) try to
work around that by using temporary variables, for example. In this case
something like this would work:

	const char *reason =3D dma_to_memory ? "rx" : "tx";
	...
	dma_chan =3D dma_request_slave_channel_reason(i2c_dev->dev, reason);

> +	if (IS_ERR(dma_chan)) {
> +		ret =3D PTR_ERR(dma_chan);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(i2c_dev->dev,
> +				"Dma channel is not available: %d\n", ret);

s/Dma/DMA/

> +		return ret;
> +	}
> +	dma_buf =3D dma_alloc_coherent(i2c_dev->dev, i2c_dev->dma_buf_size,

It's usually a good idea to add a blank line after a block for
readability. You already do that elsewhere, so be consistent.

> +			&dma_phys, GFP_KERNEL);
> +	if (!dma_buf) {
> +		dev_err(i2c_dev->dev, "Not able to allocate the dma buffer\n");

s/dma/DMA/ here and elsewhere.

> +		dma_release_channel(dma_chan);

You already have this in the error cleanup path. Why not reuse it? You
can do:

		ret =3D -ENOMEM;
		goto release;

> +		return -ENOMEM;
> +	}
> +
> +	if (dma_to_memory) {
> +		dma_sconfig.src_addr =3D i2c_dev->phys_addr + I2C_RX_FIFO;
> +		dma_sconfig.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		dma_sconfig.src_maxburst =3D 0;
> +	} else {
> +		dma_sconfig.dst_addr =3D i2c_dev->phys_addr + I2C_TX_FIFO;
> +		dma_sconfig.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		dma_sconfig.dst_maxburst =3D 0;
> +	}

The second and third lines of these conditionals are identical, so you
can make this more compact by moving them out of the conditional.

> +
> +	ret =3D dmaengine_slave_config(dma_chan, &dma_sconfig);
> +	if (ret)
> +		goto scrub;
> +	if (dma_to_memory) {
> +		i2c_dev->rx_dma_chan =3D dma_chan;
> +		i2c_dev->rx_dma_buf =3D dma_buf;
> +		i2c_dev->rx_dma_phys =3D dma_phys;
> +	} else {
> +		i2c_dev->tx_dma_chan =3D dma_chan;
> +		i2c_dev->tx_dma_buf =3D dma_buf;
> +		i2c_dev->tx_dma_phys =3D dma_phys;
> +	}
> +	return 0;
> +
> +scrub:
> +	dma_free_coherent(i2c_dev->dev, i2c_dev->dma_buf_size,
> +							dma_buf, dma_phys);
> +	dma_release_channel(dma_chan);
> +	return ret;
> +}
> +
>  static void tegra_i2c_mask_irq(struct tegra_i2c_dev *i2c_dev, u32 mask)
>  {
>  	u32 int_mask;
> @@ -527,6 +675,7 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_d=
ev)
>  		return err;
>  	}
> =20
> +	i2c_dev->is_curr_dma_xfer =3D false;
>  	reset_control_assert(i2c_dev->rst);

Again, try to use spacing to make this code less cluttered.

>  	udelay(2);
>  	reset_control_deassert(i2c_dev->rst);
> @@ -640,14 +789,16 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev=
_id)
>  		goto err;
>  	}
> =20
> -	if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ)) {
> +	if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ) &&
> +						!i2c_dev->is_curr_dma_xfer) {
>  		if (i2c_dev->msg_buf_remaining)
>  			tegra_i2c_empty_rx_fifo(i2c_dev);
>  		else
>  			BUG();
>  	}
> =20
> -	if (!i2c_dev->msg_read && (status & I2C_INT_TX_FIFO_DATA_REQ)) {
> +	if (!i2c_dev->msg_read && (status & I2C_INT_TX_FIFO_DATA_REQ) &&
> +						!i2c_dev->is_curr_dma_xfer) {
>  		if (i2c_dev->msg_buf_remaining)
>  			tegra_i2c_fill_tx_fifo(i2c_dev);
>  		else

This seems like you could wrap the above inside a:

	if (!i2c_dev->is_curr_dma_xfer) {
	}

and avoid sprinkling so many extra checks around.

> @@ -658,7 +809,16 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_=
id)
>  	if (i2c_dev->is_dvc)
>  		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
> =20
> -	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
> +	if (status & I2C_INT_ALL_PACKETS_XFER_COMPLETE) {
> +		if (i2c_dev->is_curr_dma_xfer)
> +			i2c_dev->msg_buf_remaining =3D 0;

Why are we forcing msg_buf_remaining to 0 here and below? Doesn't the
rest of the code take care of that already? Is it always guaranteed that
all bytes will have been transferred in DMA mode?

> +		status |=3D I2C_INT_PACKET_XFER_COMPLETE;
> +		i2c_writel(i2c_dev, status, I2C_INT_STATUS);
> +		if (!i2c_dev->msg_buf_remaining)
> +			complete(&i2c_dev->msg_complete);
> +	} else if (status & I2C_INT_PACKET_XFER_COMPLETE) {
> +		if (i2c_dev->is_curr_dma_xfer)
> +			i2c_dev->msg_buf_remaining =3D 0;
>  		BUG_ON(i2c_dev->msg_buf_remaining);
>  		complete(&i2c_dev->msg_complete);
>  	}
> @@ -667,90 +827,318 @@ static irqreturn_t tegra_i2c_isr(int irq, void *de=
v_id)
>  	/* An error occurred, mask all interrupts */
>  	tegra_i2c_mask_irq(i2c_dev, I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST |
>  		I2C_INT_PACKET_XFER_COMPLETE | I2C_INT_TX_FIFO_DATA_REQ |
> -		I2C_INT_RX_FIFO_DATA_REQ);
> +		I2C_INT_RX_FIFO_DATA_REQ | I2C_INT_ALL_PACKETS_XFER_COMPLETE);
>  	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
>  	if (i2c_dev->is_dvc)
>  		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
> =20
> +	if (i2c_dev->is_curr_dma_xfer) {
> +		if (i2c_dev->msg_read) {
> +			dmaengine_terminate_all(i2c_dev->rx_dma_chan);
> +			complete(&i2c_dev->rx_dma_complete);
> +		} else {
> +			dmaengine_terminate_all(i2c_dev->tx_dma_chan);
> +			complete(&i2c_dev->tx_dma_complete);
> +		}
> +	}
> +
>  	complete(&i2c_dev->msg_complete);
>  done:
>  	spin_unlock(&i2c_dev->xfer_lock);
>  	return IRQ_HANDLED;
>  }
> =20
> +static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
> +		int len, int direction)

Alignment again. Please go over this patch again and align consistently.

> +{
> +	u32 val, reg;
> +	u8 tx_burst =3D 0, rx_burst =3D 0;
> +	struct dma_slave_config tx_dma_sconfig, rx_dma_sconfig;
> +
> +	if (i2c_dev->hw->has_mst_fifo)
> +		reg =3D I2C_MST_FIFO_CONTROL;
> +	else
> +		reg =3D I2C_FIFO_CONTROL;
> +	val =3D i2c_readl(i2c_dev, reg);
> +
> +	if (direction =3D=3D DATA_DMA_DIR_TX) {
> +		if (len & 0xF)
> +			tx_burst =3D 1;
> +		else if (((len) >> 4) & 0x1)

I think this would be cleaner as:

		else if (len & 0x10)

> +			tx_burst =3D 4;
> +		else
> +			tx_burst =3D 8;
> +		if (i2c_dev->hw->has_mst_fifo)
> +			val |=3D I2C_MST_FIFO_CONTROL_TX_TRIG(tx_burst);
> +		else
> +			val |=3D I2C_FIFO_CONTROL_TX_TRIG(tx_burst);
> +	}
> +	if (direction =3D=3D DATA_DMA_DIR_RX) {
> +		if (len & 0xF)
> +			rx_burst =3D 1;
> +		else if (((len) >> 4) & 0x1)

Ditto.

> +			rx_burst =3D 4;
> +		else
> +			rx_burst =3D 8;
> +		if (i2c_dev->hw->has_mst_fifo)
> +			val |=3D I2C_MST_FIFO_CONTROL_RX_TRIG(rx_burst);
> +		else
> +			val |=3D I2C_FIFO_CONTROL_RX_TRIG(rx_burst);
> +	}
> +	i2c_writel(i2c_dev, val, reg);
> +
> +	if (direction =3D=3D DATA_DMA_DIR_TX) {
> +		tx_dma_sconfig.dst_addr =3D i2c_dev->phys_addr + I2C_TX_FIFO;
> +		tx_dma_sconfig.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		tx_dma_sconfig.dst_maxburst =3D tx_burst;
> +		dmaengine_slave_config(i2c_dev->tx_dma_chan, &tx_dma_sconfig);
> +	}
> +	if (direction =3D=3D DATA_DMA_DIR_RX) {
> +		rx_dma_sconfig.src_addr =3D i2c_dev->phys_addr + I2C_RX_FIFO;
> +		rx_dma_sconfig.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		rx_dma_sconfig.src_maxburst =3D rx_burst;
> +		dmaengine_slave_config(i2c_dev->rx_dma_chan, &rx_dma_sconfig);
> +	}

Didn't you do this already in tegra_i2c_init_dma_param()?

> +}
> +
> +static int tegra_i2c_start_dma_xfer(struct tegra_i2c_dev *i2c_dev)
> +{
> +	u32 *buffer =3D (u32 *)i2c_dev->msg_buf;
> +	unsigned long time_left, flags;
> +	int ret =3D 0;
> +	u32 int_mask;
> +	u32 tx_len =3D 0;
> +	u32 rx_len =3D 0;
> +
> +	if (i2c_dev->msg_read) {
> +		tx_len =3D I2C_PACKET_HEADER_SIZE;
> +		rx_len =3D ALIGN(i2c_dev->msg_buf_remaining,
> +							BYTES_PER_FIFO_WORD);
> +	} else {
> +		tx_len =3D ALIGN(i2c_dev->msg_buf_remaining,
> +				BYTES_PER_FIFO_WORD) + I2C_PACKET_HEADER_SIZE;
> +		rx_len =3D 0;
> +	}
> +
> +	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
> +	int_mask =3D I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
> +	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> +
> +	if (i2c_dev->msg_read) {
> +		/* make the dma buffer to read by dma */
> +		dma_sync_single_for_device(i2c_dev->dev, i2c_dev->rx_dma_phys,
> +					i2c_dev->dma_buf_size, DMA_TO_DEVICE);
> +		tegra_i2c_config_fifo_trig(i2c_dev, rx_len, DATA_DMA_DIR_RX);
> +		ret =3D tegra_i2c_start_rx_dma(i2c_dev, rx_len);
> +		if (ret < 0) {
> +			dev_err(i2c_dev->dev,
> +				"Starting rx dma failed, err %d\n", ret);
> +			goto exit;
> +		}
> +		i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
> +		i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
> +		i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
> +	} else {
> +		/* Make the dma buffer to read by cpu */
> +		dma_sync_single_for_cpu(i2c_dev->dev, i2c_dev->tx_dma_phys,
> +				i2c_dev->dma_buf_size, DMA_TO_DEVICE);
> +		memcpy(i2c_dev->tx_dma_buf, buffer, tx_len);
> +		/* make the dma buffer to read by dma */
> +		dma_sync_single_for_device(i2c_dev->dev, i2c_dev->tx_dma_phys,
> +				i2c_dev->dma_buf_size, DMA_TO_DEVICE);
> +
> +		tegra_i2c_config_fifo_trig(i2c_dev, tx_len, DATA_DMA_DIR_TX);
> +		ret =3D tegra_i2c_start_tx_dma(i2c_dev, tx_len);
> +		if (ret < 0) {
> +			dev_err(i2c_dev->dev,
> +				"Starting tx dma failed, err %d\n", ret);
> +			goto exit;
> +		}
> +	}
> +
> +	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
> +		int_mask |=3D I2C_INT_PACKET_XFER_COMPLETE;
> +	int_mask |=3D I2C_INT_ALL_PACKETS_XFER_COMPLETE;
> +	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> +
> +exit:
> +	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
> +		i2c_readl(i2c_dev, I2C_INT_MASK));
> +
> +	if (!i2c_dev->msg_read) {

Any specific reason why you use inverted logic here? Wouldn't this be
simpler as:

	if (i2c_dev->msg_read) {
		...
	} else {
		...
	}

> +		time_left =3D wait_for_completion_timeout(
> +					&i2c_dev->tx_dma_complete,
> +					TEGRA_I2C_TIMEOUT);
> +		if (time_left =3D=3D 0) {
> +			dev_err(i2c_dev->dev,
> +					"tx dma timeout txlen:%d rxlen:%d\n",
> +					tx_len, rx_len);
> +			dmaengine_terminate_all(i2c_dev->tx_dma_chan);
> +			return -ETIMEDOUT;
> +		}
> +	} else {
> +		time_left =3D wait_for_completion_timeout(
> +					&i2c_dev->rx_dma_complete,
> +					TEGRA_I2C_TIMEOUT);
> +		if (time_left =3D=3D 0) {
> +			dev_err(i2c_dev->dev,
> +					"rx dma timeout txlen:%d rxlen:%d\n",
> +					tx_len, rx_len);
> +			dmaengine_terminate_all(i2c_dev->rx_dma_chan);
> +			return -ETIMEDOUT;
> +		}
> +		if (likely(i2c_dev->msg_err =3D=3D I2C_ERR_NONE)) {
> +			dma_sync_single_for_cpu(i2c_dev->dev,
> +						i2c_dev->rx_dma_phys,
> +						i2c_dev->dma_buf_size,
> +						DMA_FROM_DEVICE);
> +			memcpy(i2c_dev->msg_buf, i2c_dev->rx_dma_buf, rx_len);
> +			dma_sync_single_for_device(i2c_dev->dev,
> +						i2c_dev->rx_dma_phys,
> +						i2c_dev->dma_buf_size,
> +						DMA_FROM_DEVICE);

Why dma_sync_single_for_device()? You haven't modified the DMA buffer,
so there's no need to flush the corresponding cache lines.

> +		}
> +	}
> +	return 0;
> +}
> +
> +static int tegra_i2c_start_pio_xfer(struct tegra_i2c_dev *i2c_dev)
> +{
> +	u32 *buffer =3D (u32 *)i2c_dev->msg_buf;
> +	unsigned long flags;
> +	int ret =3D 0;

ret is unused?

> +	u32 int_mask;
> +
> +	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
> +	int_mask =3D I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
> +	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> +
> +	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
> +	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
> +	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
> +
> +	i2c_dev->msg_buf =3D (u8 *) buffer;
> +
> +	if (!i2c_dev->msg_read)
> +		tegra_i2c_fill_tx_fifo(i2c_dev);
> +
> +	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
> +		int_mask |=3D I2C_INT_PACKET_XFER_COMPLETE;
> +	if (i2c_dev->msg_read)
> +		int_mask |=3D I2C_INT_RX_FIFO_DATA_REQ;
> +	else if (i2c_dev->msg_buf_remaining)
> +		int_mask |=3D I2C_INT_TX_FIFO_DATA_REQ;
> +
> +	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> +	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
> +	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
> +		i2c_readl(i2c_dev, I2C_INT_MASK));
> +
> +	return 0;
> +}
> +
>  static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
>  	struct i2c_msg *msg, enum msg_end_type end_state)
>  {
> -	u32 packet_header;
> +	u32 val =3D 0;

There doesn't seem to be a need for this rename. It causes a lot of
churn below and make this really difficult to review.

> +	u32 *buffer;
>  	u32 int_mask;
>  	unsigned long time_left;
>  	unsigned long flags;
> +	int ret =3D 0;
> +	u32 xfer_size =3D 0;
> +	bool dma =3D false;
> =20
>  	tegra_i2c_flush_fifos(i2c_dev);
> =20
> -	i2c_dev->msg_buf =3D msg->buf;
> +	if (msg->flags & I2C_M_RD)
> +		xfer_size =3D msg->len;
> +	else
> +		xfer_size =3D ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
> +							I2C_PACKET_HEADER_SIZE;
> +	dma =3D ((xfer_size > I2C_PIO_MODE_MAX_LEN) &&
> +				i2c_dev->tx_dma_chan && i2c_dev->rx_dma_chan);
> +	i2c_dev->is_curr_dma_xfer =3D dma;
>  	i2c_dev->msg_buf_remaining =3D msg->len;
>  	i2c_dev->msg_err =3D I2C_ERR_NONE;
>  	i2c_dev->msg_read =3D (msg->flags & I2C_M_RD);
>  	reinit_completion(&i2c_dev->msg_complete);
> =20
> -	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
> -
> -	int_mask =3D I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
> -	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> +	buffer =3D kmalloc(ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
> +					I2C_PACKET_HEADER_SIZE, GFP_KERNEL);

I didn't spot where this memory was freed again. Are we leaking this
memory? Or is it freed elsewhere?

> +	i2c_dev->msg_buf =3D (u8 *)buffer;
> =20
> -	packet_header =3D (0 << PACKET_HEADER0_HEADER_SIZE_SHIFT) |
> +	*(buffer++) =3D (0 << PACKET_HEADER0_HEADER_SIZE_SHIFT) |
>  			PACKET_HEADER0_PROTOCOL_I2C |
>  			(i2c_dev->cont_id << PACKET_HEADER0_CONT_ID_SHIFT) |
>  			(1 << PACKET_HEADER0_PACKET_ID_SHIFT);
> -	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> =20
> -	packet_header =3D msg->len - 1;
> -	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> +	*(buffer++) =3D msg->len - 1;
> =20
> -	packet_header =3D I2C_HEADER_IE_ENABLE;
> +	val =3D I2C_HEADER_IE_ENABLE;
>  	if (end_state =3D=3D MSG_END_CONTINUE)
> -		packet_header |=3D I2C_HEADER_CONTINUE_XFER;
> +		val |=3D I2C_HEADER_CONTINUE_XFER;
>  	else if (end_state =3D=3D MSG_END_REPEAT_START)
> -		packet_header |=3D I2C_HEADER_REPEAT_START;
> +		val |=3D I2C_HEADER_REPEAT_START;
>  	if (msg->flags & I2C_M_TEN) {
> -		packet_header |=3D msg->addr;
> -		packet_header |=3D I2C_HEADER_10BIT_ADDR;
> +		val |=3D msg->addr;
> +		val |=3D I2C_HEADER_10BIT_ADDR;
>  	} else {
> -		packet_header |=3D msg->addr << I2C_HEADER_SLAVE_ADDR_SHIFT;
> +		val |=3D msg->addr << I2C_HEADER_SLAVE_ADDR_SHIFT;
>  	}
>  	if (msg->flags & I2C_M_IGNORE_NAK)
> -		packet_header |=3D I2C_HEADER_CONT_ON_NAK;
> +		val |=3D I2C_HEADER_CONT_ON_NAK;
>  	if (msg->flags & I2C_M_RD)
> -		packet_header |=3D I2C_HEADER_READ;
> -	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> +		val |=3D I2C_HEADER_READ;
> +	*(buffer++) =3D val;
> =20
> -	if (!(msg->flags & I2C_M_RD))
> -		tegra_i2c_fill_tx_fifo(i2c_dev);
> +	if (!i2c_dev->msg_read)
> +		memcpy(buffer, msg->buf, msg->len);

A lot of the changes in this function are due to renamed variables and
due to the fact that we're now storing the FIFO contents in a buffer
first. Might be worth splitting that off into a separate patch to make
this one easier to review. But I don't feel too strongly about it, just
something to keep in mind for future patches. If you need largish
changes that are not immediately related to the change you want to make,
split that work off into a separate patch. Doing so makes both patches a
lot easier to review because reviewers can deal with one set of changes
at a time and don't have to keep both changes in mind when reviewing.

> =20
> -	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
> -		int_mask |=3D I2C_INT_PACKET_XFER_COMPLETE;
> -	if (msg->flags & I2C_M_RD)
> -		int_mask |=3D I2C_INT_RX_FIFO_DATA_REQ;
> -	else if (i2c_dev->msg_buf_remaining)
> -		int_mask |=3D I2C_INT_TX_FIFO_DATA_REQ;
> +	if (dma)
> +		ret =3D tegra_i2c_start_dma_xfer(i2c_dev);
> +	else
> +		ret =3D tegra_i2c_start_pio_xfer(i2c_dev);
> =20
> -	tegra_i2c_unmask_irq(i2c_dev, int_mask);
> -	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
> -	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
> -		i2c_readl(i2c_dev, I2C_INT_MASK));
> +	if (ret =3D=3D -EIO)
> +		return ret;
> +	else if (ret =3D=3D -ETIMEDOUT)
> +		goto end_xfer;
> =20
>  	time_left =3D wait_for_completion_timeout(&i2c_dev->msg_complete,
>  						TEGRA_I2C_TIMEOUT);
> -	tegra_i2c_mask_irq(i2c_dev, int_mask);
> -
>  	if (time_left =3D=3D 0) {
>  		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
> -
> +		if (i2c_dev->is_curr_dma_xfer) {
> +			if (i2c_dev->msg_read) {
> +				dmaengine_terminate_all(i2c_dev->rx_dma_chan);
> +				complete(&i2c_dev->rx_dma_complete);
> +			} else {
> +				dmaengine_terminate_all(i2c_dev->tx_dma_chan);
> +				complete(&i2c_dev->tx_dma_complete);
> +			}
> +		}
>  		tegra_i2c_init(i2c_dev);
>  		return -ETIMEDOUT;
>  	}
> +	if (i2c_dev->msg_read) {
> +		if (!dma)
> +			i2c_dev->msg_buf =3D (u8 *)buffer;
> +		memcpy(msg->buf, i2c_dev->msg_buf, msg->len);
> +	}
> =20
> +end_xfer:
> +	int_mask =3D i2c_readl(i2c_dev, I2C_INT_MASK);
> +	tegra_i2c_mask_irq(i2c_dev, int_mask);
> +	if (i2c_dev->is_curr_dma_xfer && (ret < 0)) {
> +		dev_err(i2c_dev->dev, "i2c dma transfer timed out\n");
> +		tegra_i2c_init(i2c_dev);
> +		return -ETIMEDOUT;
> +	}
>  	dev_dbg(i2c_dev->dev, "transfer complete: %lu %d %d\n",
>  		time_left, completion_done(&i2c_dev->msg_complete),
>  		i2c_dev->msg_err);
> @@ -781,6 +1169,19 @@ static int tegra_i2c_xfer(struct i2c_adapter *adap,=
 struct i2c_msg msgs[],
>  		return ret;
>  	}
> =20
> +	if (i2c_dev->has_dma) {
> +		if (!i2c_dev->rx_dma_chan) {
> +			ret =3D tegra_i2c_init_dma_param(i2c_dev, true);
> +			if (ret && (ret !=3D -EPROBE_DEFER) && (ret !=3D -ENODEV))
> +				return ret;
> +		}
> +		if (!i2c_dev->tx_dma_chan) {
> +			ret =3D tegra_i2c_init_dma_param(i2c_dev, false);
> +			if (ret && (ret !=3D -EPROBE_DEFER) && (ret !=3D -ENODEV))
> +				return ret;
> +		}
> +	}
> +
>  	for (i =3D 0; i < num; i++) {
>  		enum msg_end_type end_type =3D MSG_END_STOP;
> =20
> @@ -823,6 +1224,8 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_dev =
*i2c_dev)
> =20
>  	i2c_dev->is_multimaster_mode =3D of_property_read_bool(np,
>  			"multi-master");
> +
> +	i2c_dev->has_dma =3D of_property_read_bool(np, "dmas");
>  }
> =20
>  static const struct i2c_algorithm tegra_i2c_algo =3D {
> @@ -935,11 +1338,13 @@ static int tegra_i2c_probe(struct platform_device =
*pdev)
>  	struct clk *div_clk;
>  	struct clk *fast_clk;
>  	void __iomem *base;
> +	phys_addr_t phys_addr;
>  	int irq;
>  	int ret =3D 0;
>  	int clk_multiplier =3D I2C_CLK_MULTIPLIER_STD_FAST_MODE;
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	phys_addr =3D res->start;
>  	base =3D devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> @@ -962,12 +1367,14 @@ static int tegra_i2c_probe(struct platform_device =
*pdev)
>  		return -ENOMEM;
> =20
>  	i2c_dev->base =3D base;
> +	i2c_dev->phys_addr =3D phys_addr;
>  	i2c_dev->div_clk =3D div_clk;
>  	i2c_dev->adapter.algo =3D &tegra_i2c_algo;
>  	i2c_dev->adapter.quirks =3D &tegra_i2c_quirks;
>  	i2c_dev->irq =3D irq;
>  	i2c_dev->cont_id =3D pdev->id;
>  	i2c_dev->dev =3D &pdev->dev;
> +	i2c_dev->dma_buf_size =3D i2c_dev->adapter.quirks->max_write_len;
> =20
>  	i2c_dev->rst =3D devm_reset_control_get_exclusive(&pdev->dev, "i2c");
>  	if (IS_ERR(i2c_dev->rst)) {
> @@ -982,6 +1389,8 @@ static int tegra_i2c_probe(struct platform_device *p=
dev)
>  						  "nvidia,tegra20-i2c-dvc");
>  	init_completion(&i2c_dev->msg_complete);
>  	spin_lock_init(&i2c_dev->xfer_lock);
> +	init_completion(&i2c_dev->tx_dma_complete);
> +	init_completion(&i2c_dev->rx_dma_complete);
> =20
>  	if (!i2c_dev->hw->has_single_clk_source) {
>  		fast_clk =3D devm_clk_get(&pdev->dev, "fast-clk");
> @@ -1041,6 +1450,15 @@ static int tegra_i2c_probe(struct platform_device =
*pdev)
>  		}
>  	}
> =20
> +	if (i2c_dev->has_dma) {
> +		ret =3D tegra_i2c_init_dma_param(i2c_dev, true);
> +		if (ret && (ret !=3D -EPROBE_DEFER) && (ret !=3D -ENODEV))
> +			goto disable_div_clk;
> +		ret =3D tegra_i2c_init_dma_param(i2c_dev, false);
> +		if (ret && (ret !=3D -EPROBE_DEFER) && (ret !=3D -ENODEV))
> +			goto disable_div_clk;

Can the -ENODEV even happen if i2c_dev->has_dma =3D=3D true?

Thierry

> +	}
> +
>  	ret =3D tegra_i2c_init(i2c_dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to initialize i2c controller\n");
> --=20
> 2.7.4
>=20

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxFoWEACgkQ3SOs138+
s6HRXQ//bGlpRQQj5OGQ0Ci4BKuhPwLo2TD+2lHO6mgutgIgeN8fqtST9awAu29M
KMfpbWZAtQH0qdNn8B3IXvuK4GRofcsl54336SxhDsdhY4fBCYSr85X5kC8r4GVE
JdAF8N5WUmnQ4v3zFfsYkLRryjfw4V015nyCtBnJxjnkuK/xRxuJZ8b0ekRDPcDi
bxGPPNhqRMnTO0l+6wNrB8b+3g3i2OVVsl6Ni1LhIv/jpA4Zb8/ITiKZejG9jPJH
03qm7DIzTEhmFYtXd4+PkSzYo/E4ThRNFFmMxtraEE7GIwcaPlzcf5h88XMujaTy
/xJIp8LwKCxgddBtbr8l3xj1ZlGmh26+jgVly0GM7b3EJxZhnwmfzkFFRcyyZNb9
dZUFjPyghbD6Ughmg36MiGoGI0JMHpue9r2w+6g5ghytvCC3Lj77OATeLiW9BBpu
Sg9RsYJltRWH77OUMv5Y9MefTyxVXQCLaabDQ1jHDYxJ7g8XOUh6yPUYTQKk3GdU
LsJHHl9r7QsIkS2bWbzCZCkQ8TDPVIdjuN5oQtXUBaYW117l0RDEckEu4/wzItMp
vgLu/EVRBMZdOwKZv+jq3/Jhqpo5RPM5YF6wo0cVlHbwMCJcdjkj6mpwiEcXzXkp
HiKFeo3rYh5NKL2flLCbakXBxwWnLm1XU9BWTikCBJoY7gdP3rg=
=uqSU
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
