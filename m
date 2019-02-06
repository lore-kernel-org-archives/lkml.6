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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206E2C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18AF2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uD2D56YG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfBFNJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:09:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42331 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfBFNJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:09:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so7452036wrx.9;
        Wed, 06 Feb 2019 05:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ThoeZZJLW7CSZLlO/J2FZrXSEsi4tMKBoK3w906BUqk=;
        b=uD2D56YGGNOvgyFI47A1WzsVgoJj9onsCajkL5NbLqEdLyin7c8XGw1h2TEv96VWYM
         AePx88nQjAlxquaSlEnt1N43RgnYAliLiue4Bbys8AaARrX3tRs6hpqarlBN5BnLXn4z
         LJpuGWO8z5XLzqQPy0zaPNtfakYJmhaS29KYgFO7GzKKrX00spAkzoK1faBfCY2acxii
         eXftMqbq+YW/aTeFrAPI56g318JHqiLigkHMvb34XCzElX8SMn3LGeJbB/+stjW7a0lW
         bGVH1X0KAxUlc9Rr2IA+tud84iSTOqrHeuHW8C6J+r9sO9npp/ZfSgr3IFfcWSyiv1eX
         ksKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ThoeZZJLW7CSZLlO/J2FZrXSEsi4tMKBoK3w906BUqk=;
        b=W5BiLdLuk6P/lgC6cY+d+k00E5bec8WHmgxgvdUuUV7ZfDtU85f8CTD5zMZWBkEsPf
         FNrlEPl5zTFF4VPXVUnQkt/+1xpKFFVziS9JpW99Gi23eXnL/4Uu25Gmk11hvD3JnFfO
         4cq5ywZxMiQ2e8GPc6x2hmDwxfqsOoJmp1E/nk42+FuH4mYDAZ5AOkGrGy5x9jmou8pS
         eY8YsYkBMWcM0970FtLpMKwXlVU2K3CPZwqWAEKe4FQKTGHtcmwaRrKiFoRGc4FKT2yU
         Uiae+ffqgYCFJ/DKIa7UePyYId47B58FqOxSNxBlMSVXMffULmRs3FPcrT54VTDF19Dy
         QUUA==
X-Gm-Message-State: AHQUAuYhd4K6NKe32U/zKwUssy3y88yPLubjT0Sveq7s4NovUnjVCMUl
        dGGnsNQmyXlChHIo2rdjuJQ=
X-Google-Smtp-Source: AHgI3IY4cKxd9nYeArs0H1+N7S5pEHy1nbZphLPwsDCl9n5l+FPMw7foA1EKwng88vgc7YXsAaZEaA==
X-Received: by 2002:adf:ee07:: with SMTP id y7mr8157876wrn.187.1549458551709;
        Wed, 06 Feb 2019 05:09:11 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id a15sm7672869wrx.58.2019.02.06.05.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 05:09:10 -0800 (PST)
Date:   Wed, 6 Feb 2019 14:09:09 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V12 3/5] i2c: tegra: Add DMA support
Message-ID: <20190206130909.GJ21676@ulmo>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lYetfuAxy9ic4HK3"
Content-Disposition: inline
In-Reply-To: <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lYetfuAxy9ic4HK3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 02:55:01PM +0300, Dmitry Osipenko wrote:
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
>=20
> We are not using DMA pools anywhere in the code, <linux/dmapool.h> isn't =
needed. Let's remove it.
>=20
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
>=20
> The DATA_DMA_DIR_TX/RX are not used anywhere in the code, let's remove th=
em.
>=20
> [snip]
>=20
> 		TEGRA_I2C_TIMEOUT);
> >  	tegra_i2c_mask_irq(i2c_dev, int_mask);
> > @@ -814,6 +1133,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev=
 *i2c_dev,
> >  		time_left, completion_done(&i2c_dev->msg_complete),
> >  		i2c_dev->msg_err);
> > =20
> > +	i2c_dev->is_curr_dma_xfer =3D false;
>=20
> This line could be removed because there is no need to clear "is_curr_dma=
_xfer" at this point.
>=20
> >  	if (likely(i2c_dev->msg_err =3D=3D I2C_ERR_NONE))
> >  		return 0;
> [snip]
>=20
>=20
> Sowjanya, I tried to enforce DMA transferring + setting DMA burst to a on=
e word and this combination doesn't work well while it should, if I'm not m=
issing something. Could you please take a look at the problem or explain wh=
y that happens?
>=20
> Here is the change I made:
>=20
> -----------------
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegr=
a.c
> index c538ed5f8e2c..59e245d4417d 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -6,6 +6,8 @@
>   * Author: Colin Cross <ccross@android.com>
>   */
> =20
> +#define DEBUG
> +
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dmaengine.h>
> @@ -929,12 +931,7 @@ static void tegra_i2c_config_fifo_trig(struct tegra_=
i2c_dev *i2c_dev,
>         val =3D i2c_readl(i2c_dev, reg);
> =20
>         if (i2c_dev->is_curr_dma_xfer) {
> -               if (len & 0xF)
>                         dma_burst =3D 1;
> -               else if (len & 0x10)
> -                       dma_burst =3D 4;
> -               else
> -                       dma_burst =3D 8;
> =20
>                 if (i2c_dev->msg_read) {
>                         chan =3D i2c_dev->rx_dma_chan;
> @@ -1046,8 +1043,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev =
*i2c_dev,
>                 xfer_size =3D msg->len + I2C_PACKET_HEADER_SIZE;
> =20
>         xfer_size =3D ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
> -       i2c_dev->is_curr_dma_xfer =3D (xfer_size > I2C_PIO_MODE_MAX_LEN) =
&&
> -                                   i2c_dev->dma_buf;
> +       i2c_dev->is_curr_dma_xfer =3D !!i2c_dev->dma_buf;
>         tegra_i2c_config_fifo_trig(i2c_dev, xfer_size);
>         dma =3D i2c_dev->is_curr_dma_xfer
> -----------------
>=20
> And here what happens:
>=20
> -----------------
> ...
> [    0.761144] tegra_rtc 7000e000.rtc: registered as rtc1
> [    0.761199] tegra_rtc 7000e000.rtc: Tegra internal Real Time Clock
> [    0.761406] i2c /dev entries driver
> [    0.919233] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.919246] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.919345] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.919355] tegra-i2c 7000c000.i2c: starting DMA for length: 8
> [    0.919363] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.919628] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.919641] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.919649] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.919746] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.919755] tegra-i2c 7000c000.i2c: starting DMA for length: 112
> [    0.919763] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.923140] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
> [    0.923150] atmel_mxt_ts 0-004c: Family: 160 Variant: 0 Firmware V1.0.=
AA Objects: 18
> [    0.923208] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.923217] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.923314] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.923323] tegra-i2c 7000c000.i2c: starting DMA for length: 224
> [    0.923331] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.933564] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
> [    0.933599] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.933609] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.933760] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.933770] tegra-i2c 7000c000.i2c: starting DMA for length: 12
> [    0.933779] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.934284] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.934309] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.934317] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.934500] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.934509] tegra-i2c 7000c000.i2c: starting DMA for length: 12
> [    0.934518] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.935023] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.935081] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.935091] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.935240] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.935249] tegra-i2c 7000c000.i2c: starting DMA for length: 4
> [    0.935258] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.935399] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.935416] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.935424] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.935655] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.945445] tegra-i2c 7000d000.i2c: starting DMA for length: 16
> [    0.945456] tegra-i2c 7000d000.i2c: unmasked irq: 0c
> [    0.969236] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.969245] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.969361] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.969370] tegra-i2c 7000c000.i2c: starting DMA for length: 4
> [    0.969379] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.969462] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.982587] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.982596] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.982722] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.982731] tegra-i2c 7000c000.i2c: starting DMA for length: 12
> [    0.982740] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.983071] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.983090] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.983098] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.983252] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.983261] tegra-i2c 7000c000.i2c: starting DMA for length: 136
> [    0.983269] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.987605] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
> [    0.987623] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.987631] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.987800] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.987809] tegra-i2c 7000c000.i2c: starting DMA for length: 12
> [    0.987817] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.988324] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    1.009227] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    1.009236] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    1.009374] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    1.009383] tegra-i2c 7000c000.i2c: starting DMA for length: 4
> [    1.009391] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    1.009479] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    1.009497] atmel_mxt_ts 0-004c: Warning: Info CRC error - device=3D0x=
F436DC file=3D0x000000
> [    1.009588] tegra-i2c 7000c000.i2c: starting DMA for length: 272
> [    1.009597] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    1.017483] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
> [    1.017496] tegra-i2c 7000c000.i2c: starting DMA for length: 120
> [    1.017504] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    1.020896] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
> [    1.020909] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    1.020918] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    1.021055] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    1.032230] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    1.032239] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    1.032359] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    1.032368] tegra-i2c 7000c000.i2c: starting DMA for length: 12
> [    1.032376] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    1.032704] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    1.049224] tegra-i2c 7000d000.i2c: i2c transfer timed out

That's odd because it suggests that DMA actually completed, but the
message didn't.

I'm not sure I understand how that could happen.

What's also weird above is that there doesn't seem to be a DMA that
is started for that particular message. Or is the timeout message a
response to the prior transfer (length 10)? Seems like that should
not be possible because we get the "transfer complete" message.

Thierry

--lYetfuAxy9ic4HK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxa3HIACgkQ3SOs138+
s6Gc8g//U/qOM7S+Xpl55OishRyhggX+YtSzjRlIrie57tJ0pfad5jAALEnNjU2a
K0DFalsuK6g3fIvM1GcFipC+6lNfp3r57UBbSHvnB/1TEQb49boz7arEJK14W9wD
tdG4dgcnibasSGf4tO2+UtMDaQmqHtOldNSzffPshNVSK+kO88haplqtLVa9r4to
4YiKTSBYt+m0c7RHZmnhdG6qYKY9t1FCam9zjjFdgoN8jPeBF/CpyGghl1mR0JuP
zuzvhNXeGeId0t2VfxKxrpvDFTDXuDsmnOWf7VErmgqRM1hbOg521du4fTo5dF2n
q21B5WR8PQ/YDSpvLJDX3StN/mNoG5wGReecU3HhtDlFDFpOoDshLGfXFELNps0o
PYlzXTTWdPUaZ6RCJghigSBOawcrje1rbH81r/ZUmulxHL7rC765+RGNA2t6VCiJ
QmRKpvMpIB7ChS2KSMgfAw9BYU8BHDuiW2Jg+Hu+lKgsvpjcwg6NA0wBOd+z3OOm
khNUnHSSZe4ccMH5druhBW7FLke/5v+unb1a/FFi5NfrCLUyQEjKjgXMZt2iO73B
tKmmy51ini9vJuUgsQz+iFGKe8Bp53zBNkaplx5yyaSKConc3zXyrECxUuJ3Dy7/
etrkYdDJooqGGZhmB79YhqpRnmVpaDZYoBqbIi1jWW5eig7PC3w=
=LbXM
-----END PGP SIGNATURE-----

--lYetfuAxy9ic4HK3--
