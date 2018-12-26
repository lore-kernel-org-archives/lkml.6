Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69C9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F3B214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="bYgi/0Ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeLZK5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 05:57:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42232 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeLZK5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 05:57:48 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so10650722lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 02:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J8WyxtQub8yz5rR6IEwF5r6gXFibbk1Hj1/rSBxG9kM=;
        b=bYgi/0AhsfVH5YmdgHSwxMi+Ev0ZXnPszdWPnF5rHbmGXsVj9dHsq/BI6yHsB9/2vj
         /fpnb3AY7ajHZ5St/oJKNO9uFEfrdb8Orh55zy1y23ulBun4whMwf6JrjgfD/2XQX6/R
         MiKDEhf6zuQolHEOWsCvHByiLLAWQKupORPqcTnlrIPtqLxq+A65NHOVdKRkPN3UT6Jc
         Q3n+HtFyP+W3XaR+J2v2tGDuxDYEkfvc5zKrt/NRAxqw6PyjBktbLqL4V7yCQy+oeXzn
         aYCPIksVyg+4iG0GOhWhm8Z4mcBkFUomx3JQoRscvVW+nmRlRaAp656HDgx2hsoefrFs
         jgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=J8WyxtQub8yz5rR6IEwF5r6gXFibbk1Hj1/rSBxG9kM=;
        b=ABxWNIH9jUcgRYi0qy5NqZiYHRJZX4QTOWYWjvIo7+hs3Ukn3jZwMnXzb4+6v/KDb5
         9siMRmt2sgEsOwlf37h/9uzW6/u2+CUTnSp8uPwa0QJp9zWXQUJ2xb+4CeXOndyVndbG
         Kvjg0oM9E2Bq0+60SwW7ltdM4+nBH6oJQlZCXJEKgQg9xPLF88lWQmSxyOapCZLHtevh
         NCIoDZojWb6Rrdvg+7lA3gcgu1kVrxk6JJvL7Wnawp0v8N9FdX7GP9nac+pew5J8GJdy
         7qcc/DkLC8rTGOycHcv1iXYCnnnQNTsFYdS5y80642NboVbqbwJudxn8HSgtMSxnGoYf
         CEoA==
X-Gm-Message-State: AA+aEWZB42s4hgFoa8Xmjdgy3rtRkIXeiTdHIOGVgiAre6V6Ic5vDf2J
        VW4lXLK/8VR+XJeOPSGooG1LvA==
X-Google-Smtp-Source: AFSGD/VGWw7tEJT4zNJxVrtCeiE2LorY56sa4PxnuWoAbCPMOlqXeYbohzuKZpNZxHkaV6BGS4OTSQ==
X-Received: by 2002:ac2:41cb:: with SMTP id d11mr10196495lfi.3.1545821865714;
        Wed, 26 Dec 2018 02:57:45 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.83.42])
        by smtp.gmail.com with ESMTPSA id a2-v6sm7588868lji.13.2018.12.26.02.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 02:57:45 -0800 (PST)
Subject: Re: [PATCH v4 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        zhengxunli@mxic.com.tw
References: <1545634358-17485-1-git-send-email-masonccyang@mxic.com.tw>
 <1545634358-17485-2-git-send-email-masonccyang@mxic.com.tw>
 <12cb2574-8ec9-d756-756a-d7fbbd5c7069@cogentembedded.com>
 <OFC561D699.9746ACDB-ON4825836F.000CB709-4825836F.00184155@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <0f21cd94-08ad-befa-649e-ba191b0e33bc@cogentembedded.com>
Date:   Wed, 26 Dec 2018 13:57:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OFC561D699.9746ACDB-ON4825836F.000CB709-4825836F.00184155@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/26/2018 07:24 AM, masonccyang@mxic.com.tw wrote:

>> [...]
>> > diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
>> > new file mode 100644
>> > index 0000000..6dd739a
>> > --- /dev/null
>> > +++ b/drivers/spi/spi-renesas-rpc.c
>> > @@ -0,0 +1,788 @@
[...]
>> > +#define RPC_CMNCR      0x0000   /* R/W */
>> > +#define RPC_CMNCR_MD      BIT(31)
>> > +#define RPC_CMNCR_SFDE      BIT(24) /* undocumented bit but must be set */
>> > +#define RPC_CMNCR_MOIIO3(val)   (((val) & 0x3) << 22)
>> > +#define RPC_CMNCR_MOIIO2(val)   (((val) & 0x3) << 20)
>> > +#define RPC_CMNCR_MOIIO1(val)   (((val) & 0x3) << 18)
>> > +#define RPC_CMNCR_MOIIO0(val)   (((val) & 0x3) << 16)
>> > +#define RPC_CMNCR_MOIIO_HIZ   (RPC_CMNCR_MOIIO0(3) |
>> RPC_CMNCR_MOIIO1(3) | \
>> > +             RPC_CMNCR_MOIIO2(3) | RPC_CMNCR_MOIIO3(3))
>> > +#define RPC_CMNCR_IO3FV(val)   (((val) & 0x3) << 14)
>> > +#define RPC_CMNCR_IO2FV(val)   (((val) & 0x3) << 12)
>>
>>    Like I said, the above 2 aren't documented in the manual v1.00...
> 
> okay, add a description as:
> /* RPC_CMNCR_IO3FV/IO2FV are undocumented bit, but must be set */
> #define RPC_CMNCR_IO3FV(val)    (((val) & 0x3) << 14)
> #define RPC_CMNCR_IO2FV(val)    (((val) & 0x3) << 12)
> #define RPC_CMNCR_IO0FV(val)    (((val) & 0x3) << 8)
> #define RPC_CMNCR_IOFV_HIZ      (RPC_CMNCR_IO0FV(3) | RPC_CMNCR_IO2FV(3) | \
>                                   RPC_CMNCR_IO3FV(3))
> 
> is it ok?

   Yes. But would have been enough if you just commented with // on the same line --
it seems these are legal now... 

>> [...]
>> > +static void rpc_spi_hw_init(struct rpc_spi *rpc)
>> > +{
>> > +   /*
>> > +    * NOTE: The 0x260 are undocumented bits, but they must be set.
>> > +    *   RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
>> > +    *   0x0 : the delay is biggest,
>> > +    *   0x1 : the delay is 2nd biggest,
>> > +    *   On H3 ES1.x, the value should be 0, while on others,
>> > +    *   the value should be 6.
>> > +    */
>> > +   regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
>> > +              RPC_PHYCNT_STRTIM(6) | 0x260);
>> > +
>> > +   /*
>> > +    * NOTE: The 0x31511144 are undocumented bits, but they must be set
>> > +    *       for RPC_PHYOFFSET1.
>> > +    *    The 0x31 are undocumented bits, but they must be set
>> > +    *    for RPC_PHYOFFSET2.
>> > +    */
>> > +   regmap_write(rpc->regmap, RPC_PHYOFFSET1, 0x31511144);
>>
>>   0x30000000 is documented, missed that last time...
>>
> 
> okay,patch it to:
> 
> #define RPC_PHYOFFSET1_DDRTMG(v) (((v) & 0x3) << 28)
> 
> regmap_write(rpc->regmap, RPC_PHYOFFSET1,
>                           RPC_PHYOFFSET1_DDRTMG(3) | 0x1511144);
> 

   OK, thanx.

>> [...]
>> > +static int rpc_spi_do_reset(struct rpc_spi *rpc)
>> > +{
>> > +   int ret;
>> > +
>> > +   ret = reset_control_reset(rpc->rstc);
>> > +   if (ret)
>> > +      return ret;
>> > +
>> > +   return 0;
>> > +}
>>
>>    Like I said, this function folds to a mere reset_control_reset() call...
>>
> 
> Do you mean just drop this rpc_spi_do_reset( )

   I mean we don't need this wrapper, we can call reset_contreol_reset() directly.

> because driver is never
> come here from an error path ?

   You are mixing things up -- of course we call it from the error path.

>> [...]
>> > +
>> > +      while (pos < rpc->xferlen) {
>> > +         u32 nbytes = rpc->xferlen - pos;
>> > +
>> > +         if (nbytes > 4)
>> > +            nbytes = 4;
>> > +
>> > +         smcr = rpc->smcr | RPC_SMCR_SPIE;
>> > +
>> > +         if (rpc->xferlen > 4 && rpc->xferlen < 8 && pos == 0)
>> > +            smcr |= RPC_SMCR_SSLKP;
>> > +
>> > +         regmap_write(rpc->regmap, RPC_SMENR, smenr);
>> > +         regmap_write(rpc->regmap, RPC_SMCR, smcr);
>> > +         ret = wait_msg_xfer_end(rpc);
>> > +         if (ret)
>> > +            goto out;
>> > +
>> > +         regmap_read(rpc->regmap, RPC_SMRDR0, &data);
>> > +         memcpy(rx_buf + pos, &data, nbytes);
>> > +         pos += nbytes;
>> > +
>> > +         if (rpc->xferlen > 4 && rpc->xferlen < 8 && pos == 4) {
>>
>>    This looks hackish. What I think matters is whether the address
>> bits are set or not.
>> Anyway, maybe it works OK for you but not for me (on V3H), the 4th
>> byte of the JEDEC ID
>> is clobbered from 0 to 3... I've been working on a better workaround
>> using Marek's
>> approach (reading in extended memory mode) -- should port to v4 of
>> your patch yet...
> 
> Do you mean I also patch external address space read mode
> for RPC to read ID and data ?

   No, I meant using the dirmap read mode for RDID and company. I have the patch
almost ready now and I hope you'll merge it with yours... either that or add it to
your series atop of this patch.

[...]
> I also think this is kind of RPC HW bug in manual I/O mode.

   Yes.

> Renesas FAE@Taiwan has replied me that their the last bare-metal code,
> mini-monitor v5.x still use one command to read 4 bytes data each time
> and I think RPC HW designer should have known this HW bug already.

   Have they tried it on V3H?

>> > +            smenr = rpc->smenr & ~RPC_SMENR_CDE &
>> > +               ~RPC_SMENR_ADE(0xf);
>> > +         } else {
>> > +            regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
>> > +            regmap_write(rpc->regmap, RPC_SMDMCR,
>> > +                    rpc->dummy);
>>
>>    Not sure why you rewrite these regs again. Where do they change?
> 
> Make sure the value in these register are setting correctly
> before RPC starting a SPI transfer.

   The are -- ath the start of this function.

> Not sure RPC HW behavior will change these registers after a transfer.

   I doubt it.

> In RPC bare-metal code mini-monitor v4.01 also do this way.

   Well, we shouldn't blindly copy wgat they did, I think.

>> > +            regmap_write(rpc->regmap, RPC_SMADR,
>> > +                    rpc->addr + pos);
>> > +         }
>> > +      }
>> > +   } else {
>> > +      regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
>> > +      regmap_write(rpc->regmap, RPC_SMCR, rpc->smcr | RPC_SMCR_SPIE);
>> > +      ret = wait_msg_xfer_end(rpc);
>> > +      if (ret)
>> > +         goto out;
>> > +   }
>> > +
>> > +   return ret;
>>
>>    Could be *return* 0, we never get here from an error path...
> 
> see above!

   You've mixed things up. We always come here with ret == 0.

>> > +
>> > +out:
>> > +   return rpc_spi_do_reset(rpc);
>> > +}
>> > +
>> > +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
>> > +               const struct spi_mem_op *op,
>> > +               u64 *offs, size_t *len)
[...]
>> > +   if (op->data.nbytes || (offs && len)) {
>> > +      if (op->data.dir == SPI_MEM_DATA_IN) {
>> > +         rpc->smcr = RPC_SMCR_SPIRE;
>> > +         rpc->xfer_dir = SPI_MEM_DATA_IN;
>> > +      } else if (op->data.dir == SPI_MEM_DATA_OUT) {
>> > +         rpc->smcr = RPC_SMCR_SPIWE;
>> > +         rpc->xfer_dir = SPI_MEM_DATA_OUT;
>> > +      }
>>
>>    Use *switch* instead, please.
>>
> 
> why ?
> only two condition here!

   Oh, so you have some "threshold" on when to use *switch*? :-)
   I think each time we compare the same varible with a constant 2+
times, we need to use *switch*.

>> [...]
>> > +static bool rpc_spi_mem_supports_op(struct spi_mem *mem,
>> > +                const struct spi_mem_op *op)
>> > +{
>> > +   if (op->data.buswidth > 4 || op->addr.buswidth > 4 ||
>> > +       op->dummy.buswidth > 4 || op->cmd.buswidth > 4 ||
>> > +       op->addr.nbytes > 4)
>> > +      return false;
>>
>>    So we support the dual mode, even though the manual doesn't say we do?
> 
> I think driver would never go to dual mode by setting SPI master->mode_bits.

   Maybe. BTW, when I test the driver in the renesas.git devel branch, I get:

spi spi0.0: setup: ignoring unsupported mode bits 800

[...]
>> > +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>> > +   if (ret)
>> > +      return ret;
>> > +
>> > +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>> > +                &desc->info.op_tmpl, &offs, &len);
>> > +
>> > +   regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_SFDE |
>> > +           RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
>> > +           RPC_CMNCR_BSZ(0));
>>
>>    Why not set this in the probing time and only set/clear the MD bit?
>>
> 
> same above!
> Make sure the value in these register are setting correctly
> before RPC starting a SPI transfer.

   You can set it once and only change the bits you need to change afterwards.
What's wrong with it?

>> [...]
>> > +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
>> > +               u64 offs, size_t len, const void *buf)
>> > +{
>> > +   struct rpc_spi *rpc = spi_master_get_devdata(desc->mem->spi->master);
>> > +   int ret;
>> > +
>> > +   if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
>> > +      return -EINVAL;
>> > +
>> > +   if (WARN_ON(len > RPC_WBUF_SIZE))
>> > +      len = RPC_WBUF_SIZE;
>> > +
>> > +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>> > +   if (ret)
>> > +      return ret;
>> > +
>> > +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>> > +                &desc->info.op_tmpl, &offs, &len);
>> > +
>> > +   regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
>> > +              RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
>> > +              RPC_CMNCR_BSZ(0));
>> > +   regmap_write(rpc->regmap, RPC_SMDRENR, 0);
>> > +   regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL | 0x260 |
>> > +              RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF);
>> > +
>> > +   memcpy_toio(rpc->base + RPC_WBUF, buf, len);
>> > +
>> > +   regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
>> > +   regmap_write(rpc->regmap, RPC_SMADR, offs);
>> > +   regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
>> > +   regmap_write(rpc->regmap, RPC_SMCR, rpc->smcr | RPC_SMCR_SPIE);
>> > +   ret = wait_msg_xfer_end(rpc);
>> > +   if (ret)
>> > +      goto out;
>> > +
>> > +   regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RCF);
>> > +   regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
>> > +              RPC_PHYCNT_STRTIM(6) | 0x260);
>>
>>    Whe not do read-modify-write here and above?
> 
> same above!
> Make sure the value in these register are setting correctly
> before RPC starting a SPI transfer.

   Nobody can spoil the register values with yours being a single driver controlling
it, no?

>> [...]
>> > +static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
>> > +               struct spi_message *msg)
>> > +{
>> [...]
>> > +   for (i = xfercnt - 1; i < xfercnt && xfercnt > 1; i++) {
>> > +      if (xfer[i].rx_buf) {
>> > +         rpc->smenr |=
>> > +            RPC_SMENR_SPIDE(rpc_bits_set(xfer[i].len)) |
>> > +            RPC_SMENR_SPIDB
>> > +            (ilog2((unsigned int)xfer[i].rx_nbits));
>>
>>    Mhm, I would indent this contination line by 1 extra tab...
>>
>> > +      } else if (xfer[i].tx_buf) {
>> > +         rpc->smenr |=
>> > +            RPC_SMENR_SPIDE(rpc_bits_set(xfer[i].len)) |
>> > +            RPC_SMENR_SPIDB
>> > +            (ilog2((unsigned int)xfer[i].tx_nbits));
>>
>>    And this one...
> 
> like this ?
> --------------------------------------------------------------------
>          for (i = xfercnt - 1; i < xfercnt && xfercnt > 1; i++) {
>                  if (xfer[i].rx_buf) {
>                          rpc->smenr |=
>                                  RPC_SMENR_SPIDE(rpc_bits_set(xfer[i].len)) |
>                                  RPC_SMENR_SPIDB(
>                                          ilog2((unsigned int)xfer[i].rx_nbits));
>                  } else if (xfer[i].tx_buf) {
>                          rpc->smenr |=
>                                  RPC_SMENR_SPIDE(rpc_bits_set(xfer[i].len)) |
>                                  RPC_SMENR_SPIDB(
>                                          ilog2((unsigned int)xfer[i].tx_nbits));

   I didn't mean you need to leave ( on the first line, can be left on the  new
line, as before.

>> [...]

> thanks for your review.
> best regards,
> Mason
[...]

MBR, Sergei
