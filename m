Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1716C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9F920660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547455104;
	bh=Y6HpCUC3ee/ZPFFnBUUdvgPUHC7mXshMZV4u5/EBr24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=O5hGQl79hAKkdOKD7JznwKPBaDr3Jc6FJGuCc5JY756k2QtbLUqzmiCppb3vk3zS2
	 iH/ZX+xsZqhW022bh5H/wcqH/1jwG2jdBBlyl1n3AHqqOKdg5lSSSCflbTiIczEWGJ
	 tZo2D7wK7vcfsQbhZncA6qtmVwcMTWSoY25P781g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfANIiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:38:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfANIiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:38:22 -0500
Received: from bbrezillon (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA98120660;
        Mon, 14 Jan 2019 08:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547455100;
        bh=Y6HpCUC3ee/ZPFFnBUUdvgPUHC7mXshMZV4u5/EBr24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RnyVAskElM1aENLHRdUbEzLSyHAiVuWziYjX4S75m50MfvvAcEACihhm3af6OFkH1
         oVxD/bTXg2Cgce1Ehs9ofbFY7GCnWbExKYFCoZSmY1ZZJ3k0EvyyXjuMyDL9ijopvG
         ksolJ+Fx9UuMIfhInddyMrhGYHNLUXw2ge0GVeWA=
Date:   Mon, 14 Jan 2019 09:38:07 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Message-ID: <20190114093759.2ce51b55@bbrezillon>
In-Reply-To: <dbb6ddc8-5939-3d4b-7031-931afa79fccb@kontron.de>
References: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1546939346-20181-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <dbb6ddc8-5939-3d4b-7031-931afa79fccb@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 17:28:57 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> Hi Yogesh,
> 
> my comments below are mainly about things I already mentioned in my 
> review for v5 and about removing or simplifying some unnecessary or 
> complex code.
> 
> Also as I gathered from your conversation with Boris, there's still a 
> check for the length of the requested memory missing.
> 
> On 08.01.19 10:24, Yogesh Narayan Gaur wrote:
> [...]
> > +
> > +static bool nxp_fspi_supports_op(struct spi_mem *mem,
> > +				 const struct spi_mem_op *op)
> > +{
> > +	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
> > +	int ret;
> > +
> > +	ret = nxp_fspi_check_buswidth(f, op->cmd.buswidth);
> > +
> > +	if (op->addr.nbytes)
> > +		ret |= nxp_fspi_check_buswidth(f, op->addr.buswidth);
> > +
> > +	if (op->dummy.nbytes)
> > +		ret |= nxp_fspi_check_buswidth(f, op->dummy.buswidth);
> > +
> > +	if (op->data.nbytes)
> > +		ret |= nxp_fspi_check_buswidth(f, op->data.buswidth);
> > +
> > +	if (ret)
> > +		return false;
> > +
> > +	/*
> > +	 * The number of instructions needed for the op, needs
> > +	 * to fit into a single LUT entry.
> > +	 */
> > +	if (op->addr.nbytes +
> > +	   (op->dummy.nbytes ? 1:0) +
> > +	   (op->data.nbytes ? 1:0) > 6)
> > +		return false;  
> 
> Actually this check was only needed in the QSPI driver, as we were using 
>   LUT_MODE and there we needed one instruction for each address byte. 
> Here the number of instructions will always fit into one LUT entry.
> 
> Instead of this, a check for op->addr.nbytes > 4 (as already suggested 
> in my comments for v5) would make more sense. So we can make sure that 
> the address length passed in is supported (between 1 and 4 bytes).
> 
> > +
> > +	/* Max 64 dummy clock cycles supported */
> > +	if (op->dummy.buswidth &&
> > +	    (op->dummy.nbytes * 8 / op->dummy.buswidth > 64))
> > +		return false;
> > +
> > +	/* Max data length, check controller limits and alignment */
> > +	if (op->data.dir == SPI_MEM_DATA_IN &&
> > +	    (op->data.nbytes > f->devtype_data->ahb_buf_size ||
> > +	     (op->data.nbytes > f->devtype_data->rxfifo - 4 &&
> > +	      !IS_ALIGNED(op->data.nbytes, 8))))
> > +		return false;
> > +
> > +	if (op->data.dir == SPI_MEM_DATA_OUT &&
> > +	    op->data.nbytes > f->devtype_data->txfifo)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +  
> [...]
> > +static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi)
> > +{
> > +	unsigned long rate = spi->max_speed_hz;
> > +	int ret;
> > +	uint64_t size_kb;
> > +
> > +	/*
> > +	 * Return, if previously selected slave device is same as current
> > +	 * requested slave device.
> > +	 */
> > +	if (f->selected == spi->chip_select)
> > +		return;
> > +
> > +	/* Reset FLSHxxCR0 registers */
> > +	fspi_writel(f, 0, f->iobase + FSPI_FLSHA1CR0);
> > +	fspi_writel(f, 0, f->iobase + FSPI_FLSHA2CR0);
> > +	fspi_writel(f, 0, f->iobase + FSPI_FLSHB1CR0);
> > +	fspi_writel(f, 0, f->iobase + FSPI_FLSHB2CR0);
> > +
> > +	/* Assign controller memory mapped space as size, KBytes, of flash. */
> > +	size_kb = FSPI_FLSHXCR0_SZ(f->memmap_phy_size);
> > +
> > +	switch (spi->chip_select) {
> > +	case 0:
> > +		fspi_writel(f, size_kb, f->iobase + FSPI_FLSHA1CR0);
> > +		break;
> > +	case 1:
> > +		fspi_writel(f, size_kb, f->iobase + FSPI_FLSHA2CR0);
> > +		break;
> > +	case 2:
> > +		fspi_writel(f, size_kb, f->iobase + FSPI_FLSHB1CR0);
> > +		break;
> > +	case 3:
> > +		fspi_writel(f, size_kb, f->iobase + FSPI_FLSHB2CR0);
> > +		break;
> > +	}  
> 
> The switch statement above can be replaced by:
> 
> fspi_writel(f, size_kb, f->iobase + FSPI_FLSHA1CR0 +
> 	    4 * spi->chip_select);
> 
> > +
> > +	dev_dbg(f->dev, "Slave device [CS:%x] selected\n", spi->chip_select);
> > +
> > +	nxp_fspi_clk_disable_unprep(f);
> > +
> > +	ret = clk_set_rate(f->clk, rate);
> > +	if (ret)
> > +		return;
> > +
> > +	ret = nxp_fspi_clk_prep_enable(f);
> > +	if (ret)
> > +		return;
> > +
> > +	f->selected = spi->chip_select;
> > +}
> > +
> > +static void nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
> > +{
> > +	u32 len = op->data.nbytes;
> > +
> > +	/* Read out the data directly from the AHB buffer. */
> > +	memcpy_fromio(op->data.buf.in, (f->ahb_addr + op->addr.val), len);
> > +}
> > +
> > +static void nxp_fspi_fill_txfifo(struct nxp_fspi *f,
> > +				 const struct spi_mem_op *op)
> > +{
> > +	void __iomem *base = f->iobase;
> > +	int i, j, ret;
> > +	int size, tmp, wm_size;
> > +	u32 data = 0;
> > +	u32 *txbuf = (u32 *) op->data.buf.out;  
> 
> You can cast the u8 buffer to u32 and increment it by 1 in each cycle 
> below, or you can just use the u8 buffer and align and increment by 8 as 
> I did in my proposal for v5.
> I still like my version better as it seems simpler and easier to 
> understand ;)
> 
> > +
> > +	/* clear the TX FIFO. */
> > +	fspi_writel(f, FSPI_IPTXFCR_CLR, base + FSPI_IPTXFCR);
> > +
> > +	/* Default value of water mark level is 8 bytes. */
> > +	wm_size = 8;
> > +
> > +	size = op->data.nbytes / wm_size;
> > +	for (i = 0; i < size; i++) {
> > +		/* Wait for TXFIFO empty */
> > +		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> > +					   FSPI_INTR_IPTXWE, 0,
> > +					   POLL_TOUT, true);
> > +		WARN_ON(ret);
> > +
> > +		for (tmp = wm_size, j = 0; tmp > 0; tmp -= 4, j++)  
> 
> I still think the inner loop should only be added when someone 
> implements watermark levels other than 8. It is of no use at the moment 
> and makes reading the code more difficult.
> But if you insist on using it, please at least simplify the code.
> 
> What about:	for (j = 0; j < (wm_size / 4); j++)
> 
> > +			fspi_writel(f, *txbuf++, base + FSPI_TFDR + j * 4); > +
> > +		fspi_writel(f, FSPI_INTR_IPTXWE, base + FSPI_INTR);
> > +	}
> > +
> > +	size = op->data.nbytes % wm_size;
> > +	if (size) {
> > +		/* Wait for TXFIFO empty */
> > +		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> > +					   FSPI_INTR_IPTXWE, 0,
> > +					   POLL_TOUT, true);
> > +		WARN_ON(ret);
> > +
> > +		for (tmp = size, j = 0; tmp > 0; tmp -= 4, j++) {  
> 
> Same here:	for (j = 0; j < (size / 4); j++) {
> 
> > +			data = 0;
> > +			memcpy(&data, txbuf++, 4);
> > +			fspi_writel(f, data, base + FSPI_TFDR + j * 4);
> > +		}
> > +		fspi_writel(f, FSPI_INTR_IPTXWE, base + FSPI_INTR);
> > +	}
> > +}
> > +
> > +static void nxp_fspi_read_rxfifo(struct nxp_fspi *f,
> > +			  const struct spi_mem_op *op)
> > +{
> > +	void __iomem *base = f->iobase;
> > +	int i, j;
> > +	int size, tmp_size, wm_size, ret;
> > +	u32 tmp = 0;
> > +	u8 *buf = op->data.buf.in;
> > +	u32 len = op->data.nbytes;
> > +
> > +	/* Default value of water mark level is 8 bytes. */
> > +	wm_size = 8;
> > +
> > +	while (len > 0) {  
> 
> What is this outer loop good for? Below you are first reading aligned to 
> wm_size and then the remaining bytes. Why would you need to repeat that?
> It looks like the loop will always be executed only once.
> 
> > +		size = len / wm_size;
> > +		for (i = 0; i < size; i++) {
> > +			/* Wait for RXFIFO available */
> > +			ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> > +						   FSPI_INTR_IPRXWA, 0,
> > +						   POLL_TOUT, true);
> > +			WARN_ON(ret);
> > +
> > +			for (tmp_size = wm_size, j = 0; tmp_size > 0;
> > +			     tmp_size -= 4, j++, buf += 4) {  
> 
> What about:		for (j = 0; j < (wm_size / 4); j++, buf += 4) {
> 
> > +				tmp = fspi_readl(f, base + FSPI_RFDR + j * 4);
> > +				memcpy(buf, &tmp, 4);
> > +			}
> > +			/* move the FIFO pointer */
> > +			fspi_writel(f, FSPI_INTR_IPRXWA, base + FSPI_INTR);
> > +			len -= wm_size;
> > +		}
> > +
> > +		size = len % wm_size;
> > +		if (size) {
> > +			/* Wait for RXFIFO available */
> > +			ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
> > +						   FSPI_INTR_IPRXWA, 0,
> > +						   POLL_TOUT, true);
> > +			WARN_ON(ret);
> > +
> > +			for (j = 0; len > 0; len -= size, j++, buf += size) {
> > +				tmp = fspi_readl(f, base + FSPI_RFDR + j * 4);
> > +				size = len < 4 ? len : 4;  
> 
> What about:			size = min(len, 4);
> 
> > +				memcpy(buf, &tmp, size);
> > +			}
> > +		}
> > +
> > +		/* invalid the RXFIFO */
> > +		fspi_writel(f, FSPI_IPRXFCR_CLR, base + FSPI_IPRXFCR);
> > +		/* move the FIFO pointer */
> > +		fspi_writel(f, FSPI_INTR_IPRXWA, base + FSPI_INTR);
> > +	}
> > +}  
> 

Once you've addressed all of Frieder's comments you can add

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

Regards,

Boris
