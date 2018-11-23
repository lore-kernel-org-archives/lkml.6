Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D906C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF9620672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBJy1U7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF9620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439813AbeKXAUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:20:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39268 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394868AbeKXAUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:20:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so4419078wra.6;
        Fri, 23 Nov 2018 05:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DHyl/xvHJeBmB7zNcOR0SFgj3Cyjc0HjVsJfUJR1Kis=;
        b=qBJy1U7euv9Kpq2WAArhoeDljBIZqVniPecLmTAZDX3joBcwtbVYQBbIxfPuRTUPMS
         M+a1MIURM5vLdGIDKLFfVnebcHOR+aB07vc5V0gXQADOeaEnRS0sZ09BLCJZjPBoQit7
         xGF9b5PJfW0MLl8oSp6OvgQiMXw3uuebrxMvuj9xTvVRKnxwHhM7qtdGWHK2m+Vj1U6v
         leVPv3R8X6A34ylMzEJ2gmEMDBToMKxENtLExqLlTz8aAijSuQ5B6o17F9kt6FCK/406
         QZX/rk9Df9WGy/xILcsQYRjqleQRszNWtFk2IG+Nc7G6zGVia9sEt7szt3BotSfSnUgp
         ReWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DHyl/xvHJeBmB7zNcOR0SFgj3Cyjc0HjVsJfUJR1Kis=;
        b=GDABKyrW4n3RLVsTifwRgtY68JdFDyecbyJWKSONF0GrkrtpBFWjpN7DTdvWyZ2MW1
         7EQ6t7oPSXAztYGPp6eyGetbK3gJ8RUOh3B8XgG8nNJapi3qvfdTTDUgs51gyGsZUgKb
         ONtdInEpJKF0HHx5wWl+4XLb4hA9vjefyefhh0fF3aIht887yO5HU5MRMCLrySin7TfM
         BOBmQ4LpW+27yOlNVHUCH6mgYD8a8Mgfa8QsPjAFACqWZgci0XhT+IFIRUinpPnSq5nu
         WucaUjE8aKrwhIBAbVor2Et0g/Lb+TzfzJkjdzNTEzKcp9/BZdKyGZO0+lJXvE6gQ3Lw
         VxCQ==
X-Gm-Message-State: AA+aEWa1v/XSU4AafME+xJCtMw4cF2wzSzB6Dnsu1oX/0hDhS/IKLE6p
        QutmWwytEW34ku+ShUt63wg=
X-Google-Smtp-Source: AFSGD/VL4HfFYL6N5pG37qPJKCzVPvVYXZo4GHcd328w0W4PoFH6SqFj7aZWDBiM2gYrVQ+0qt6h1g==
X-Received: by 2002:adf:83e7:: with SMTP id 94mr14127956wre.278.1542980147286;
        Fri, 23 Nov 2018 05:35:47 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id a18sm25535268wrp.13.2018.11.23.05.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 05:35:46 -0800 (PST)
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
To:     masonccyang@mxic.com.tw
Cc:     boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, tpiepho@impinj.com,
        zhengxunli@mxic.com.tw
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
 <0223f43b-c6a6-eade-49af-4e7b7ef7f022@gmail.com>
 <OF5B1A3AE4.2DEECF37-ON4825834E.00031E97-4825834E.00042D72@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <3b639470-2351-5fff-6121-e400eb0a1493@gmail.com>
Date:   Fri, 23 Nov 2018 14:34:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <OF5B1A3AE4.2DEECF37-ON4825834E.00031E97-4825834E.00042D72@mxic.com.tw>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/2018 01:45 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> > +
>> > +struct rpc_spi {
>> > +   struct clk *clk_rpc;
>> > +   void __iomem *regs;
>> > +   struct {
>> > +      void __iomem *map;
>> > +      dma_addr_t dma;
>> > +      size_t size;
>> > +   } linear;
>>
>> Does this need it's own struct ?
>>
> 
> yup, I think it's better.
> In case no "dirmap" in dtb and no direct mapping mode implemented.
> 
> 
>> > +   u32 cur_speed_hz;
>> > +   u32 cmd;
>> > +   u32 addr;
>> > +   u32 dummy;
>> > +   u32 smcr;
>> > +   u32 smenr;
>> > +   u32 xferlen;
>> > +   u32 totalxferlen;
>>
>> This register cache might be a good candidate for regmap ?
> 
> I don't know what does it mean ?
> Could you give me more information!

See include/linux/regmap.h and git grep regmap drivers/ for examples.

>> > +   enum spi_mem_data_dir xfer_dir;
>> > +};
>> > +
>> > +static int rpc_spi_set_freq(struct rpc_spi *rpc, unsigned long freq)
>> > +{
>> > +   int ret;
>> > +
>> > +   if (rpc->cur_speed_hz == freq)
>> > +      return 0;
>> > +
>> > +   clk_disable_unprepare(rpc->clk_rpc);
>> > +   ret = clk_set_rate(rpc->clk_rpc, freq);
>> > +   if (ret)
>> > +      return ret;
>> > +
>> > +   ret = clk_prepare_enable(rpc->clk_rpc);
>> > +   if (ret)
>> > +      return ret;
>>
>> Is this clock disable/update/enable really needed ? I'd think that
>> clk_set_rate() would handle the rate update correctly.
> 
> As Gerrt mentioned, I will remove them.
> 
> 
>> > +static int wait_msg_xfer_end(struct rpc_spi *rpc)
>> > +{
>> > +   u32 sts;
>> > +
>> > +   return readl_poll_timeout(rpc->regs + RPC_CMNSR, sts,
>> > +              sts & RPC_CMNSR_TEND, 0, USEC_PER_SEC);
>> > +}
>> > +
>> > +static u8 rpc_bits_xfer(u32 nbytes)
>> > +{
>> > +   u8 databyte;
>> > +
>> > +   switch (nbytes) {
>>
>> Did you ever test unaligned writes and reads ? There are some nasty edge
>> cases in those.
>>
>> Also, I think you can calculate the number of set bits using a simple
>> function, so the switch-case might not even be needed.
>>
> 
> Any example function ?

Nope, you'd have to think of one. You need to fill $nbytes bits from top
down. I think you can somehow use GENMASK() .

>> > +   case 1:
>> > +      databyte = 0x8;
>> > +      break;
>> > +   case 2:
>> > +      databyte = 0xc;
>> > +      break;
>> > +   default:
>> > +      databyte = 0xf;
>> > +      break;
>> > +   }
>> > +
>> > +   return databyte;
>> > +}
>> > +
>> > +static int rpc_spi_io_xfer(struct rpc_spi *rpc,
>> > +            const void *tx_buf, void *rx_buf)
>> > +{
>> > +   u32 smenr, smcr, data, pos = 0;
>> > +   int ret = 0;
>> > +
>> > +   writel(RPC_CMNCR_MD | RPC_CMNCR_SFDE | RPC_CMNCR_MOIIO_HIZ |
>> > +          RPC_CMNCR_IOFV_HIZ | RPC_CMNCR_BSZ(0), rpc->regs +
> RPC_CMNCR);
>> > +   writel(0x0, rpc->regs + RPC_SMDRENR);
>> > +
>> > +   if (tx_buf) {
>> > +      writel(rpc->cmd, rpc->regs + RPC_SMCMR);
>> > +      writel(rpc->dummy, rpc->regs + RPC_SMDMCR);
>> > +      writel(rpc->addr, rpc->regs + RPC_SMADR);
>> > +      smenr = rpc->smenr;
>> > +
>> > +      while (pos < rpc->xferlen) {
>> > +         u32 nbytes = rpc->xferlen  - pos;
>> > +
>> > +         writel(*(u32 *)(tx_buf + pos), rpc->regs + RPC_SMWDR0);
>> > +
>> > +         if (nbytes > 4) {
>> > +            nbytes = 4;
>> > +            smcr = rpc->smcr |
>> > +                   RPC_SMCR_SPIE | RPC_SMCR_SSLKP;
>> > +         } else {
>> > +            smcr = rpc->smcr | RPC_SMCR_SPIE;
>> > +         }
>> > +
>> > +         writel(smenr, rpc->regs + RPC_SMENR);
>> > +         writel(smcr, rpc->regs + RPC_SMCR);
>> > +         ret = wait_msg_xfer_end(rpc);
>> > +         if (ret)
>> > +            goto out;
>> > +
>> > +         pos += nbytes;
>> > +         smenr = rpc->smenr & ~RPC_SMENR_CDE &
>> > +                    ~RPC_SMENR_ADE(0xf);
>> > +      }
>> > +   } else if (rx_buf) {
>> > +      while (pos < rpc->xferlen) {
>> > +         u32 nbytes = rpc->xferlen  - pos;
>> > +
>> > +         if (nbytes > 4)
>> > +            nbytes = 4;
>> > +
>> > +         writel(rpc->cmd, rpc->regs + RPC_SMCMR);
>> > +         writel(rpc->dummy, rpc->regs + RPC_SMDMCR);
>> > +         writel(rpc->addr + pos, rpc->regs + RPC_SMADR);
>> > +         writel(rpc->smenr, rpc->regs + RPC_SMENR);
>> > +         writel(rpc->smcr | RPC_SMCR_SPIE, rpc->regs + RPC_SMCR);
>> > +         ret = wait_msg_xfer_end(rpc);
>> > +         if (ret)
>> > +            goto out;
>> > +
>> > +         data = readl(rpc->regs + RPC_SMRDR0);
>> > +         memcpy_fromio(rx_buf + pos, (void *)&data, nbytes);
>> > +         pos += nbytes;
>> > +      }
>> > +   } else {
>> > +      writel(rpc->cmd, rpc->regs + RPC_SMCMR);
>> > +      writel(rpc->dummy, rpc->regs + RPC_SMDMCR);
>> > +      writel(rpc->addr + pos, rpc->regs + RPC_SMADR);
>> > +      writel(rpc->smenr, rpc->regs + RPC_SMENR);
>> > +      writel(rpc->smcr | RPC_SMCR_SPIE, rpc->regs + RPC_SMCR);
>> > +      ret = wait_msg_xfer_end(rpc);
>> > +   }
>> > +out:
>>
>> Dont you need to stop the RPC somehow in case the transmission fails ?
>>
> 
> I can't find any RPC registers can do this !
> 
> Do you know how to do this ?

It should be in the RPC datasheet ? It's likely going to involve SMCR,
possibly clear SPIE bit and maybe some more.

>> > +   writel(rpc->cmd, rpc->regs + RPC_SMCMR);
>> > +   writel(offs, rpc->regs + RPC_SMADR);
>> > +   writel(rpc->smenr, rpc->regs + RPC_SMENR);
>> > +   writel(rpc->smcr | RPC_SMCR_SPIE, rpc->regs + RPC_SMCR);
>> > +   ret = wait_msg_xfer_end(rpc);
>> > +   if (ret)
>> > +      goto out;
>> > +
>> > +   writel(RPC_DRCR_RCF, rpc->regs + RPC_DRCR);
>> > +   writel(RPC_PHYCNT_CAL | RPC_PHYCNT_STRTIM(0) | 0x260,
>> > +          rpc->regs + RPC_PHYCNT);
>> > +
>> > +   return len;
>> > +out:
>>
>> Shouldn't you shut the controller down if the xfer fails ?
> 
> Any registers can shut down RPC controller ?
> SW reset ?

Possibly, can you research it ?

>> > +   return ret;
>> > +}
>> > +
>> > +static int rpc_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
>> > +{
>> > +   struct rpc_spi *rpc =
> spi_master_get_devdata(desc->mem->spi->master);
>> > +
>> > +   if (desc->info.offset + desc->info.length > U32_MAX)
>> > +      return -ENOTSUPP;
>> > +
>> > +   if (!rpc_spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
>> > +      return -ENOTSUPP;
>> > +
>> > +   if (!rpc->linear.map &&
>> > +       desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN)
>> > +      return -ENOTSUPP;
>> > +
>> > +   return 0;
>> > +}
>> > +
>> > +static int rpc_spi_mem_exec_op(struct spi_mem *mem,
>> > +                const struct spi_mem_op *op)
>> > +{
>> > +   struct rpc_spi *rpc = spi_master_get_devdata(mem->spi->master);
>> > +   int ret;
>> > +
>> > +   ret = rpc_spi_set_freq(rpc, mem->spi->max_speed_hz);
>> > +   if (ret)
>> > +      return ret;
>> > +
>> > +   rpc_spi_mem_set_prep_op_cfg(mem->spi, op, NULL, NULL);
>> > +
>> > +   ret = rpc_spi_io_xfer(rpc,
>> > +               op->data.dir == SPI_MEM_DATA_OUT ?
>> > +               op->data.buf.out : NULL,
>> > +               op->data.dir == SPI_MEM_DATA_IN ?
>> > +               op->data.buf.in : NULL);
>> > +
>> > +   return ret;
>> > +}
>> > +
>> > +static const struct spi_controller_mem_ops rpc_spi_mem_ops = {
>> > +   .supports_op = rpc_spi_mem_supports_op,
>> > +   .exec_op = rpc_spi_mem_exec_op,
>> > +   .dirmap_create = rpc_spi_mem_dirmap_create,
>> > +   .dirmap_read = rpc_spi_mem_dirmap_read,
>> > +   .dirmap_write = rpc_spi_mem_dirmap_write,
>> > +};
>> > +
>> > +static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
>> > +               struct spi_message *msg)
>> > +{
>> > +   struct spi_transfer *t, xfer[4] = { };
>> > +   u32 i, xfercnt, xferpos = 0;
>> > +
>> > +   rpc->totalxferlen = 0;
>> > +   list_for_each_entry(t, &msg->transfers, transfer_list) {
>> > +      if (t->tx_buf) {
>> > +         xfer[xferpos].tx_buf = t->tx_buf;
>> > +         xfer[xferpos].tx_nbits = t->tx_nbits;
>> > +      }
>> > +
>> > +      if (t->rx_buf) {
>> > +         xfer[xferpos].rx_buf = t->rx_buf;
>> > +         xfer[xferpos].rx_nbits = t->rx_nbits;
>> > +      }
>> > +
>> > +      if (t->len) {
>> > +         xfer[xferpos++].len = t->len;
>> > +         rpc->totalxferlen += t->len;
>> > +      }
>> > +   }
>> > +
>> > +   xfercnt = xferpos;
>> > +   rpc->xferlen = xfer[--xferpos].len;
>> > +   rpc->cmd = RPC_SMCMR_CMD(((u8 *)xfer[0].tx_buf)[0]);
>>
>> Is the cast needed ?
> 
> ?

Sorry, I don't understand your question.
To rephrase my original question, is the (u8 *) cast needed ?

>> > +   rpc->smenr = RPC_SMENR_CDE | RPC_SMENR_CDB(fls(xfer[0].tx_nbits
>>> 1));
>> > +   rpc->addr = 0;
>> > +
>> > +   if (xfercnt > 2 && xfer[1].len && xfer[1].tx_buf) {
>> > +      rpc->smenr |= RPC_SMENR_ADB(fls(xfer[1].tx_nbits >> 1));
>> > +      for (i = 0; i < xfer[1].len; i++)
>> > +         rpc->addr |= (u32)((u8 *)xfer[1].tx_buf)[i]
>> > +               << (8 * (xfer[1].len - i - 1));
>> > +
>> > +      if (xfer[1].len == 4)
>> > +         rpc->smenr |= RPC_SMENR_ADE(0xf);
>> > +      else
>> > +         rpc->smenr |= RPC_SMENR_ADE(0x7);
>> > +   }
>> > +
>> > +   switch (xfercnt) {
>> > +   case 2:
>> > +      if (xfer[1].rx_buf) {
>> > +         rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
>> > +                  (xfer[1].len)) | RPC_SMENR_SPIDB(fls
>> > +                  (xfer[1].rx_nbits >> 1));
>>
>> How much of this register value calculation could be somehow
>> deduplicated ? It seems to be almost the same thing copied thrice here.
> 
> I don't get your point!
> 
> The 2'nd transfer may be
> 1) spi-address
> 2) tx_buf[] for write registers.
> 3) rx_buf[] for read status.
> 
> parse them and write to rpc->addr and so on.
> Or you have a better way to do this ?

Each of the case statement options has almost the same stuff in it. Can
this be somehow reworked so that it wouldn't be three copies of almost
the same ?

[...]

-- 
Best regards,
Marek Vasut
