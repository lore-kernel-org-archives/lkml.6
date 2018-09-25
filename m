Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5619AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEFF2089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lepn/kuE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IzOmsXn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEFF2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeIZBpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:45:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54398 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeIZBpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:45:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 599C260B0D; Tue, 25 Sep 2018 19:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537904192;
        bh=mFWzynJCl5nOcWEevB7JIriwt+MzJb/KYOEtj27XaXo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lepn/kuEHiuSawV+3D7Df8EzECUJKexUyi0F88KP6PExXEXs102BM4AcXLN/z4RJH
         z2ZTYLBYVCJvrG09jOprfY10GwEsnigAV1EZxy9Edwdw1gq3lW2sE41XbzBdN6bkNV
         wnaEstYu+gL6KJuji4P/FIlR6o3aBXwT5Zi1SlN8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5E75C605FD;
        Tue, 25 Sep 2018 19:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537904190;
        bh=mFWzynJCl5nOcWEevB7JIriwt+MzJb/KYOEtj27XaXo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IzOmsXn8xv1PWkLPo7IEsf14QmZyTRlwehc3zSDRfUHROJF7iUDPebaiOXkJPpz6r
         Fqs0riFFJIPBaXzgZQryN4g26vDf+UdcTbV2ygwIveHlNtt56hpkbJ5d56kUcMS4eO
         Vr/Cmss1+osl3soNGWL8p0SyAEybot1oxhiYuWrc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Sep 2018 01:06:30 +0530
From:   dkota@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     broonie@kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        mka@chromium.org, linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>
Subject: Re: [PATCH V4 3/4] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
In-Reply-To: <153780767551.119890.9339380838620508307@swboyd.mtv.corp.google.com>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
 <1537294047-12093-4-git-send-email-dkota@codeaurora.org>
 <153780767551.119890.9339380838620508307@swboyd.mtv.corp.google.com>
Message-ID: <8866de0e7a687cea1d800d6b3dcfb60b@codeaurora.org>
X-Sender: dkota@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
>> +#define TIMESTAMP_BEFORE       BIT(1)
>> +#define FRAGMENTATION          BIT(2)
>> +#define TIMESTAMP_AFTER                BIT(3)
>> +#define POST_CMD_DELAY         BIT(4)
>> +
>> +static irqreturn_t geni_spi_isr(int irq, void *data);
> 
> Does this need to be forward declared?
Not required, will remove it.
> 
>> +
>> +struct spi_geni_master {
>> +       struct geni_se se;
>> +       struct device *dev;
>> +       u32 rx_fifo_depth;
> 
> Is this used?
It can be removed.
> 
>> +       u32 tx_fifo_depth;
>> +       u32 fifo_width_bits;
>> +       u32 tx_wm;
>> +       unsigned int cur_speed_hz;
> 
> unsigned long for Hz? The clk framework uses that type.

cur_speed_hz stores the speed value requested as part of transfer (not 
the resultant or rounded off frequency got from clk framework. It is u32 
type, i will change cur_speed_hz to u32 type instead of unsigned long.
Code snippet:
         mas->cur_speed_hz = xfer->speed_hz;

> 
>> +       unsigned int cur_bits_per_word;
>> +       unsigned int tx_rem_bytes;
>> +       unsigned int rx_rem_bytes;
>> +       struct spi_transfer *cur_xfer;
> 
> const?
Yes can be marked as const, will update it.
> 
>> +       struct completion xfer_done;
>> +       unsigned int oversampling;
>> +       spinlock_t lock;
>> +};
>> +
> [...]
>> +
>> +static int spi_geni_prepare_message(struct spi_master *spi,
>> +                                       struct spi_message *spi_msg)
>> +{
>> +       int ret;
>> +       struct spi_geni_master *mas = spi_master_get_devdata(spi);
>> +       struct geni_se *se = &mas->se;
>> +
>> +       geni_se_select_mode(se, GENI_SE_FIFO);
>> +       reinit_completion(&mas->xfer_done);
>> +       ret = setup_fifo_params(spi_msg->spi, spi);
>> +       if (ret)
>> +               dev_err(mas->dev, "Couldn't select mode %d", ret);
> 
> Missing newline on error print.
> 
Will add it.
>> +       return ret;
>> +}
>> +
> [...]
>> +
>> +static void setup_fifo_xfer(struct spi_transfer *xfer,
>> +                               struct spi_geni_master *mas,
>> +                               u16 mode, struct spi_master *spi)
>> +{
>> +       u32 m_cmd = 0, m_param = 0;
>> +       u32 spi_tx_cfg, trans_len;
>> +       struct geni_se *se = &mas->se;
>> +
>> +       spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
>> +       if (xfer->bits_per_word != mas->cur_bits_per_word) {
>> +               spi_setup_word_len(mas, mode, xfer->bits_per_word);
>> +               mas->cur_bits_per_word = xfer->bits_per_word;
>> +       }
>> +
>> +       /* Speed and bits per word can be overridden per transfer */
>> +       if (xfer->speed_hz != mas->cur_speed_hz) {
>> +               int ret;
>> +               u32 clk_sel, m_clk_cfg;
>> +               unsigned int idx, div;
>> +
>> +               ret = get_spi_clk_cfg(xfer->speed_hz, mas, &idx, 
>> &div);
>> +               if (ret) {
>> +                       dev_err(mas->dev, "Err setting clks:%d\n", 
>> ret);
>> +                       return;
>> +               }
>> +               /*
>> +                * SPI core clock gets configured with the requested 
>> frequency
>> +                * or the frequency closer to the requested frequency.
>> +                * For that reason requested frequency is stored in 
>> the
>> +                * cur_speed_hz and referred in the consicutive 
>> transfer instead
> 
> s/consicutive/consecutive/
will correct it.
> 
>> +                * of calling clk_get_rate() API.
>> +                */
>> +               mas->cur_speed_hz = xfer->speed_hz;
>> +               clk_sel = idx & CLK_SEL_MSK;
>> +               m_clk_cfg = (div << CLK_DIV_SHFT) | SER_CLK_EN;
>> +               writel(clk_sel, se->base + SE_GENI_CLK_SEL);
>> +               writel(m_clk_cfg, se->base + GENI_SER_M_CLK_CFG);
>> +       }
>> +
>> +       mas->tx_rem_bytes = 0;
>> +       mas->rx_rem_bytes = 0;
>> +       if (xfer->tx_buf && xfer->rx_buf)
>> +               m_cmd = SPI_FULL_DUPLEX;
>> +       else if (xfer->tx_buf)
>> +               m_cmd = SPI_TX_ONLY;
>> +       else if (xfer->rx_buf)
>> +               m_cmd = SPI_RX_ONLY;
>> +
>> +       spi_tx_cfg &= ~CS_TOGGLE;
>> +       if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
>> +               trans_len =
>> +                       (xfer->len * BITS_PER_BYTE /
>> +                                       mas->cur_bits_per_word) & 
>> TRANS_LEN_MSK;
>> +       } else {
>> +               unsigned int bytes_per_word =
>> +                       mas->cur_bits_per_word / BITS_PER_BYTE + 1;
>> +
>> +               trans_len = (xfer->len / bytes_per_word) & 
>> TRANS_LEN_MSK;
>> +       }
> 
> Rename 'trans_len' to 'len' and shorten some lines by taking out the
> mask to get:
> 
>        if (!(mas->cur_bits_per_word % MIN_WORD_LEN))
>                len = xfer->len * BITS_PER_BYTE / mas->cur_bits_per_word
>        else
>                len = xfer->len / (mas->cur_bits_per_word / 
> BITS_PER_BYTE + 1);
>        len &= TRANS_LEN_MSK;
> 
OK
>> +
>> +       /*
>> +        * If CS change flag is set, then toggle the CS line in 
>> between
>> +        * transfers and keep CS asserted after the last transfer.
>> +        * Else if keep CS flag asserted in between transfers and 
>> de-assert
>> +        * CS after the last message.
>> +        */
>> +       if (xfer->cs_change) {
>> +               if (list_is_last(&xfer->transfer_list,
>> +                               &spi->cur_msg->transfers))
>> +                       m_param = FRAGMENTATION;
>> +       } else {
>> +               if (!list_is_last(&xfer->transfer_list,
>> +                               &spi->cur_msg->transfers))
>> +                       m_param = FRAGMENTATION;
>> +       }
>> +
>> +       mas->cur_xfer = xfer;
>> +       if (m_cmd & SPI_TX_ONLY) {
>> +               mas->tx_rem_bytes = xfer->len;
>> +               writel(trans_len, se->base + SE_SPI_TX_TRANS_LEN);
>> +       }
>> +
>> +       if (m_cmd & SPI_RX_ONLY) {
>> +               writel(trans_len, se->base + SE_SPI_RX_TRANS_LEN);
>> +               mas->rx_rem_bytes = xfer->len;
>> +       }
>> +       writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
>> +       geni_se_setup_m_cmd(se, m_cmd, m_param);
>> +
>> +       /*
>> +        * TX_WATERMARK_REG should be set after SPI configuration and
>> +        * setting up GENI SE engine, as driver starts data transfer
>> +        * for the watermark interrupt.
>> +        */
>> +       if (m_cmd & SPI_TX_ONLY)
>> +               writel(mas->tx_wm, se->base + 
>> SE_GENI_TX_WATERMARK_REG);
>> +}
>> +
>> +static void handle_fifo_timeout(struct spi_master *spi,
>> +                               struct spi_message *msg)
>> +{
>> +       struct spi_geni_master *mas = spi_master_get_devdata(spi);
>> +       unsigned long timeout, flags;
>> +       struct geni_se *se = &mas->se;
>> +
>> +       spin_lock_irqsave(&mas->lock, flags);
>> +       reinit_completion(&mas->xfer_done);
>> +       geni_se_cancel_m_cmd(se);
>> +       writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
>> +       spin_unlock_irqrestore(&mas->lock, flags);
>> +       timeout = wait_for_completion_timeout(&mas->xfer_done, HZ);
> 
> Can you rename this time_left or completed? Then the if condition reads
> properly as "if not time left" or "if not completed". And then invert
> that logic so things aren't so indented?
> 
> 	time_left = wait_for_completion_timeout(..)
> 	if (time_left)
> 		return;
> 
> 	spin_lock_irqsave(&mas->lock, flags);
> 	reinit_completion(..)
> 	...
> 
Ok
>> +       if (!timeout) {
>> +               spin_lock_irqsave(&mas->lock, flags);
>> +               reinit_completion(&mas->xfer_done);
>> +               geni_se_abort_m_cmd(se);
>> +               spin_unlock_irqrestore(&mas->lock, flags);
>> +               timeout = wait_for_completion_timeout(&mas->xfer_done,
>> +                                                               HZ);
>> +               if (!timeout)
>> +                       dev_err(mas->dev,
>> +                               "Failed to cancel/abort m_cmd\n");
>> +       }
>> +}
>> +
>> +static int spi_geni_transfer_one(struct spi_master *spi,
>> +                               struct spi_device *slv,
>> +                               struct spi_transfer *xfer)
>> +{
>> +       struct spi_geni_master *mas = spi_master_get_devdata(spi);
>> +
>> +       setup_fifo_xfer(xfer, mas, slv->mode, spi);
>> +       return 1;
>> +}
>> +
>> +static unsigned int geni_byte_per_fifo_word(struct spi_geni_master 
>> *mas)
>> +{
>> +       /*
>> +        * Calculate how many bytes we'll put in each FIFO word.  If 
>> the
>> +        * transfer words don't pack cleanly into a FIFO word we'll 
>> just put
>> +        * one transfer word in each FIFO word.  If they do pack we'll 
>> pack 'em.
>> +        */
>> +       if (mas->fifo_width_bits % mas->cur_bits_per_word)
>> +               return 
>> roundup_pow_of_two(DIV_ROUND_UP(mas->cur_bits_per_word,
>> +                                                      
>> BITS_PER_BYTE));
>> +       else
>> +               return mas->fifo_width_bits / BITS_PER_BYTE;
> 
> Just do a return. No else please.
> 
Ok
>> +}
>> +
>> +static irqreturn_t geni_spi_handle_tx(struct spi_geni_master *mas)
>> +{
>> +       struct geni_se *se = &mas->se;
>> +       unsigned int max_bytes;
>> +       const u8 *tx_buf;
>> +       unsigned int bytes_per_fifo_word = 
>> geni_byte_per_fifo_word(mas);
>> +       unsigned int i = 0;
>> +
>> +       if (!mas->cur_xfer)
>> +               return IRQ_NONE;
>> +
>> +       max_bytes = (mas->tx_fifo_depth - mas->tx_wm) * 
>> bytes_per_fifo_word;
>> +       if (mas->tx_rem_bytes < max_bytes)
>> +               max_bytes = mas->tx_rem_bytes;
>> +
>> +       tx_buf = mas->cur_xfer->tx_buf + mas->cur_xfer->len - 
>> mas->tx_rem_bytes;
>> +       while (i < max_bytes) {
>> +               unsigned int j;
>> +               unsigned int bytes_to_write;
>> +               u32 fifo_word = 0;
>> +               u8 *fifo_byte = (u8 *)&fifo_word;
>> +
>> +               bytes_to_write = min(bytes_per_fifo_word, max_bytes - 
>> i);
>> +               for (j = 0; j < bytes_to_write; j++)
>> +                       fifo_byte[j] = tx_buf[i++];
>> +               iowrite32_rep(se->base + SE_GENI_TX_FIFOn, &fifo_word, 
>> 1);
>> +       }
>> +       mas->tx_rem_bytes -= max_bytes;
>> +       if (!mas->tx_rem_bytes)
>> +               writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t geni_spi_handle_rx(struct spi_geni_master *mas)
>> +{
>> +       struct geni_se *se = &mas->se;
>> +       u32 rx_fifo_status;
>> +       unsigned int rx_bytes;
>> +       u8 *rx_buf;
>> +       unsigned int bytes_per_fifo_word = 
>> geni_byte_per_fifo_word(mas);
>> +       unsigned int i = 0;
>> +
>> +       if (!mas->cur_xfer)
>> +               return IRQ_NONE;
>> +
>> +       rx_fifo_status = readl(se->base + SE_GENI_RX_FIFO_STATUS);
> 
> Rename to 'status'? rx_fifo is implicit in the register macro.
Declared as "rx_fifo_status" for code readability.

> 
>> +       rx_bytes = (rx_fifo_status & RX_FIFO_WC_MSK) * 
>> bytes_per_fifo_word;
>> +       if (rx_fifo_status & RX_LAST) {
>> +               unsigned int rx_last_byte_valid =
>> +                       (rx_fifo_status & RX_LAST_BYTE_VALID_MSK)
>> +                               >> RX_LAST_BYTE_VALID_SHFT;
> 
> Hoist this variable into function scope? So then the line is:
> 
> 		last_valid = status & RX_LAST_BYTE_VALID_MSK;
> 		last_valid >>= RX_LAST_BYTE_VALID_SHFT;
> 
Ok
>> +               if (rx_last_byte_valid && (rx_last_byte_valid < 4))
> 
> Drop useless parenthesis please.
> 
Ok
>> +                       rx_bytes -= bytes_per_fifo_word - 
>> rx_last_byte_valid;
>> +       }
>> +       if (mas->rx_rem_bytes < rx_bytes)
>> +               rx_bytes = mas->rx_rem_bytes;
>> +
>> +       rx_buf = mas->cur_xfer->rx_buf + mas->cur_xfer->len - 
>> mas->rx_rem_bytes;
>> +       while (i < rx_bytes) {
>> +               u32 fifo_word = 0;
>> +               u8 *fifo_byte = (u8 *)&fifo_word;
>> +               unsigned int bytes_to_read;
>> +               unsigned int j;
>> +
>> +               bytes_to_read = min(bytes_per_fifo_word, rx_bytes - 
>> i);
>> +               ioread32_rep(se->base + SE_GENI_RX_FIFOn, &fifo_word, 
>> 1);
>> +               for (j = 0; j < bytes_to_read; j++)
>> +                       rx_buf[i++] = fifo_byte[j];
>> +       }
>> +       mas->rx_rem_bytes -= rx_bytes;
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t geni_spi_isr(int irq, void *data)
>> +{
>> +       struct spi_master *spi = data;
>> +       struct spi_geni_master *mas = spi_master_get_devdata(spi);
>> +       struct geni_se *se = &mas->se;
>> +       u32 m_irq;
>> +       unsigned long flags;
>> +       irqreturn_t ret = IRQ_HANDLED;
>> +
>> +       if (pm_runtime_status_suspended(mas->dev))
>> +               return IRQ_NONE;
>> +
>> +       spin_lock_irqsave(&mas->lock, flags);
>> +       m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
>> +       if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & 
>> M_RX_FIFO_LAST_EN))
>> +               ret = geni_spi_handle_rx(mas);
>> +
>> +       if (m_irq & M_TX_FIFO_WATERMARK_EN)
>> +               ret = geni_spi_handle_tx(mas);
> 
> Is it possible for all three conditions above to happen in one
> interrupt? I ask because 'ret' is overwritten and so what may have been
> IRQ_HANDLED may become IRQ_NONE which will lead to confusion in the irq
> layer. Maybe the handle tx/rx functions can return a bool, that gets
> orred together each time so that we know if something handled an
> interrupt?
> 
Will check it again by running fullduplex transfer and update.
>> +
>> +       if (m_irq & M_CMD_DONE_EN) {
>> +               spi_finalize_current_transfer(spi);
>> +               /*
>> +                * If this happens, then a CMD_DONE came before all 
>> the Tx
>> +                * buffer bytes were sent out. This is unusual, log 
>> this
>> +                * condition and disable the WM interrupt to prevent 
>> the
>> +                * system from stalling due an interrupt storm.
>> +                * If this happens when all Rx bytes haven't been 
>> received, log
>> +                * the condition.
>> +                * The only known time this can happen is if 
>> bits_per_word != 8
>> +                * and some registers that expect xfer lengths in num 
>> spi_words
>> +                * weren't written correctly.
>> +                */
>> +               if (mas->tx_rem_bytes) {
>> +                       writel(0, se->base + 
>> SE_GENI_TX_WATERMARK_REG);
>> +                       dev_err(mas->dev, "Premature Done.tx_rem%d 
>> bpw%d\n",
> 
> Why isn't there a space after "Done."? And why is 'done' capitalized?
> Should 'tx_rem' be 'tx_rem='?
Yes, will update.
> 
>> +                               mas->tx_rem_bytes, 
>> mas->cur_bits_per_word);
>> +               }
>> +               if (mas->rx_rem_bytes)
>> +                       dev_err(mas->dev, "Premature Done.rx_rem%d 
>> bpw%d\n",
>> +                               mas->rx_rem_bytes, 
>> mas->cur_bits_per_word);
>> +       }
>> +
>> +       if ((m_irq & M_CMD_CANCEL_EN) || (m_irq & M_CMD_ABORT_EN))
>> +               complete(&mas->xfer_done);
>> +
>> +       writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
>> +       spin_unlock_irqrestore(&mas->lock, flags);
>> +       return ret;
>> +}
>> +
>> +static int spi_geni_probe(struct platform_device *pdev)
>> +{
>> +       int ret;
>> +       struct spi_master *spi;
>> +       struct spi_geni_master *mas;
>> +       struct resource *res;
>> +       struct geni_se *se;
>> +
>> +       spi = spi_alloc_master(&pdev->dev, sizeof(struct 
>> spi_geni_master));
> 
> sizeof(*mas) for code clarity?
> 
Ok
>> +       if (!spi)
>> +               return -ENOMEM;
>> +
>> +       platform_set_drvdata(pdev, spi);
>> +       mas = spi_master_get_devdata(spi);
>> +       mas->dev = &pdev->dev;
>> +       mas->se.dev = &pdev->dev;
>> +       mas->se.wrapper = dev_get_drvdata(pdev->dev.parent);
>> +       se = &mas->se;
>> +
>> +       spi->bus_num = -1;
>> +       spi->dev.of_node = pdev->dev.of_node;
>> +       mas->se.clk = devm_clk_get(&pdev->dev, "se");
>> +       if (IS_ERR(mas->se.clk)) {
>> +               ret = PTR_ERR(mas->se.clk);
>> +               dev_err(&pdev->dev, "Err getting SE Core clk %d\n", 
>> ret);
>> +               goto spi_geni_probe_err;
>> +       }
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       se->base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(se->base)) {
>> +               ret = -ENOMEM;
> 
> 		ret = PTR_ERR(se->base);
> 
> so we don't lose the error value.
> 
Ok
>> +               goto spi_geni_probe_err;
>> +       }
>> +
>> +       ret = platform_get_irq(pdev, 0);
>> +       if (ret < 0) {
>> +               dev_err(&pdev->dev, "Err getting IRQ %d\n", ret);
>> +               goto spi_geni_probe_err;
>> +       }
>> +       ret = devm_request_irq(&pdev->dev, ret, geni_spi_isr,
>> +                               IRQF_TRIGGER_HIGH, "spi_geni", spi);
>> +       if (ret)
>> +               goto spi_geni_probe_err;
> 
> Can you request this irq as late as possible in the probe function? I
> worry there may be some pending irq line set and then this will cause 
> an
> interrupt storm with IRQ_NONE returned because the device is runtime
> suspended.
> 
Ok; will call it after spi_register_master()
>> +
>> +       spi->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
>> +       spi->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
>> +       spi->num_chipselect = 4;
>> +       spi->max_speed_hz = 50000000;
>> +       spi->prepare_message = spi_geni_prepare_message;
>> +       spi->transfer_one = spi_geni_transfer_one;
>> +       spi->auto_runtime_pm = true;
>> +       spi->handle_err = handle_fifo_timeout;
>> +
>> +       init_completion(&mas->xfer_done);
>> +       spin_lock_init(&mas->lock);
>> +       pm_runtime_enable(&pdev->dev);
>> +
>> +       ret = spi_geni_init(mas);
>> +       if (ret)
>> +               goto spi_geni_probe_runtime_disable;
>> +
>> +       ret = spi_register_master(spi);
>> +       if (ret)
>> +               goto spi_geni_probe_runtime_disable;
>> +
>> +       return 0;
>> +spi_geni_probe_runtime_disable:
>> +       pm_runtime_disable(&pdev->dev);
>> +spi_geni_probe_err:
>> +       spi_master_put(spi);
>> +       return ret;
>> +}
>> +
>> +static int spi_geni_remove(struct platform_device *pdev)
>> +{
>> +       struct spi_master *spi = platform_get_drvdata(pdev);
>> +
>> +       /* Unregister _before_ disabling pm_runtime() so we stop 
>> transfers */
>> +       spi_unregister_master(spi);
>> +
>> +       pm_runtime_disable(&pdev->dev);
>> +       return 0;
>> +}
>> +
>> +static int __maybe_unused spi_geni_runtime_suspend(struct device 
>> *dev)
>> +{
>> +       struct spi_master *spi = dev_get_drvdata(dev);
>> +       struct spi_geni_master *mas = spi_master_get_devdata(spi);
>> +
>> +       return geni_se_resources_off(&mas->se);
>> +}
>> +
>> +static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
>> +{
>> +       struct spi_master *spi = dev_get_drvdata(dev);
>> +       struct spi_geni_master *mas = spi_master_get_devdata(spi);
>> +
>> +       return geni_se_resources_on(&mas->se);
>> +}
>> +
>> +static int __maybe_unused spi_geni_suspend(struct device *dev)
>> +{
>> +       if (!pm_runtime_status_suspended(dev))
>> +               return -EBUSY;
>> +       return 0;
>> +}
>> +
>> +static const struct dev_pm_ops spi_geni_pm_ops = {
>> +       SET_RUNTIME_PM_OPS(spi_geni_runtime_suspend,
>> +                                       spi_geni_runtime_resume, NULL)
>> +       SET_SYSTEM_SLEEP_PM_OPS(spi_geni_suspend, NULL)
>> +};
>> +
>> +static const struct of_device_id spi_geni_dt_match[] = {
>> +       { .compatible = "qcom,geni-spi" },
>> +       {}
>> +};
> 
> Please add a MODULE_DEVICE_TABLE(of, spi_geni_dt_match) here.
> 
Ok
>> +
>> +static struct platform_driver spi_geni_driver = {
>> +       .probe  = spi_geni_probe,
>> +       .remove = spi_geni_remove,
>> +       .driver = {
>> +               .name = "geni_spi",
>> +               .pm = &spi_geni_pm_ops,
>> +               .of_match_table = spi_geni_dt_match,
>> +       },
>> +};
>> +module_platform_driver(spi_geni_driver);
>> +
>> +MODULE_DESCRIPTION("SPI driver for GENI based QUP cores");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/spi/spi-geni-qcom.h 
>> b/include/linux/spi/spi-geni-qcom.h
>> new file mode 100644
>> index 0000000..dc95764
>> --- /dev/null
>> +++ b/include/linux/spi/spi-geni-qcom.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Copyright (c) 2017-2018, The Linux Foundation. All rights 
>> reserved.
>> + */
>> +
>> +#ifndef __SPI_GENI_QCOM_HEADER___
>> +#define __SPI_GENI_QCOM_HEADER___
>> +
>> +struct spi_geni_qcom_ctrl_data {
>> +       u32 spi_cs_clk_delay;
>> +       u32 spi_inter_words_delay;
> 
> It was decided we still needed this? I don't see it in v3 so please
> remove this file unless it's needed.
Its not required; I will remove it.

Along with these changes, i will submit the fixes of loopback issue and 
suspend/resume issue.

--Dilip
