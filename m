Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3300C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF3320840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="0OlS4uY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfAPTg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:36:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43553 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731396AbfAPTg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:36:26 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2-v6so6446377lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IFTscLBXEKxmuwLVxgfDjZ/toVkzWHUAokOat6F8qRI=;
        b=0OlS4uY/L5CuM1LfkY0qwYzlQxHqR5E5WuDz/EQCTZsAtYBEE5k0aoYyA2SYjNPSAQ
         DqAmwnNk6+QNGc7pk6LgJR/4/8g8M8VtpkUml/QvnFbEUJB2nDf6qwAfZc6Ncheougpa
         phmsuxpM2L/jpifUppClrtPBvHeMfHTfz+6jAJYsizDzIn2XjyIVxmA5zhwLTmlTwjc5
         axaKmfiEAwd0xPO8j+kYODgzcup1xZaS41mZHobC4Mef04bBG6nP1rvHOvqYZGKJtw+L
         WecR8p+eubkORrlLJNBdhGBBcVClN66towaEw2L3PutrIofH1YFHHRMYjBWFZ3LAk/0h
         0+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IFTscLBXEKxmuwLVxgfDjZ/toVkzWHUAokOat6F8qRI=;
        b=GtlcNS4zlv3SzPCn0Ww6irePexyajw0f6KO9JLDBow2jiymhJTJGPFlChjFh2cnRAy
         Qx+geOAYiBEFUTN2AX+Qy9zipJ7y6NSEqzHeDQpuHINYqRzsT0LYlLiJEh0MVBCGS/dd
         VpEJOK8xYM8/fZOCpW4jX1u9pH86xsRqz2uBnGFo8uX8qWpR9Dt2yPFdYrAemNmY1D0R
         iHah01D+7TWcBiC/yYn7ieQ4alYOu3SDYVg1V25JiNFavo7lyeDPsnEESAwnZ7O6GOMi
         Tf8EIWV7fxh5IRocZ8OpysX0ASE14gL86zG1q+JXA7SAC2/NfT76Wi2RZtrzki2UMjbi
         J4Mg==
X-Gm-Message-State: AJcUukeimLMm6R+pAacMUt3xMZrNNkSTKcJLTUzsY/iIVtTOzflsJkYO
        TvB8+9mGNPqNb3VoLdYdzLaALg==
X-Google-Smtp-Source: ALg8bN4W2G5y3oG7ULkpFwZP5Wg37DbgNckcv7F6NcFJWQ2aCfG+WMPqN/SQCjmorfpJSLHjP70PPw==
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr7642404ljb.126.1547667383356;
        Wed, 16 Jan 2019 11:36:23 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.80.123])
        by smtp.gmail.com with ESMTPSA id a127sm1343738lfe.73.2019.01.16.11.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 11:36:22 -0800 (PST)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v5 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     Boris Brezillon <bbrezillon@kernel.org>, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        zhengxunli@mxic.com.tw
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
 <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw>
 <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com>
 <OFBBA60D64.FFD34553-ON48258384.00315BB0-48258384.0034A5C7@mxic.com.tw>
Organization: Cogent Embedded
Message-ID: <30d678b9-2b49-1f82-3027-332d213b488e@cogentembedded.com>
Date:   Wed, 16 Jan 2019 22:36:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OFBBA60D64.FFD34553-ON48258384.00315BB0-48258384.0034A5C7@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/16/2019 12:35 PM, masonccyang@mxic.com.tw wrote:

[...]
>> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> > index 9f89cb1..81b4e04 100644
>> > --- a/drivers/spi/Kconfig
>> > +++ b/drivers/spi/Kconfig
[...]
>>
>> > +   tristate "Renesas R-Car Gen3 RPC-IF SPI controller"
>> > +   depends on ARCH_RENESAS || COMPILE_TEST
>>
>>    Judging on the compilation error reported by the 0-day bot about readq(),
>> we now need to depend on 64BIT or something...
> 
> I have patched RPC external address space read mode
> and driver don't need readq() now!

   Good work, thank you!

>> [...]
>> > diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
>> > index f296270..3f2b2f9 100644
>> > --- a/drivers/spi/Makefile
>> > +++ b/drivers/spi/Makefile
>> [...]
>> > diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
>> > new file mode 100644
>> > index 0000000..1e57eb1
>> > --- /dev/null
>> > +++ b/drivers/spi/spi-renesas-rpc.c
>> > @@ -0,0 +1,787 @@
>> [...]
>> > +#define RPC_CMNCR      0x0000   // R/W
>> > +#define RPC_CMNCR_MD      BIT(31)
>> > +#define RPC_CMNCR_SFDE      BIT(24) // undocumented bit but must be set
>> > +#define RPC_CMNCR_MOIIO3(val)   (((val) & 0x3) << 22)
>> > +#define RPC_CMNCR_MOIIO2(val)   (((val) & 0x3) << 20)
>> > +#define RPC_CMNCR_MOIIO1(val)   (((val) & 0x3) << 18)
>> > +#define RPC_CMNCR_MOIIO0(val)   (((val) & 0x3) << 16)
>> > +#define RPC_CMNCR_MOIIO_HIZ   (RPC_CMNCR_MOIIO0(3) |
>> RPC_CMNCR_MOIIO1(3) | \
>> > +             RPC_CMNCR_MOIIO2(3) | RPC_CMNCR_MOIIO3(3))
>> > +#define RPC_CMNCR_IO3FV(val)   (((val) & 0x3) << 14) // undocumented bit
>> > +#define RPC_CMNCR_IO2FV(val)   (((val) & 0x3) << 12) // undocumented bit
>>
>>    Those are not exactly bits. I'd be happy with just // undocumented...
>>
>> [...]
>> > +#define RPC_WBUF      0x8000   // Write Buffer
>> > +#define RPC_WBUF_SIZE      256   // Write Buffer size
>>
>>    I wonder if the write buffer should be in a separate "reg" prop tuple...
>> Have you considered that?
>>
> 
> I don't get your point!

   I mean that the write buffer should be a separate "reg" property address/size tuple,
so that the RPC device has 3 memory resources. Our SPI driver used this scheme, and I
like it.

>> [...]
>> > +static void rpc_spi_hw_init(struct rpc_spi *rpc)
>> > +{
>> > +   //
>> > +   // NOTE: The 0x260 are undocumented bits, but they must be set.
>> > +   //   RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
>> > +   //   0x0 : the delay is biggest,
>> > +   //   0x1 : the delay is 2nd biggest,
>> > +   //   On H3 ES1.x, the value should be 0, while on others,
>> > +   //   the value should be 6.
>> > +   //
>> > +   regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
>> > +           RPC_PHYCNT_STRTIM(6) | 0x260);
>> > +
>> > +   //
>> > +   // NOTE: The 0x1511144 are undocumented bits, but they must be set
>> > +   //       for RPC_PHYOFFSET1.
>> > +   //    The 0x31 are undocumented bits, but they must be set
>> > +   //    for RPC_PHYOFFSET2.
>> > +   //
>> > +   regmap_write(rpc->regmap, RPC_PHYOFFSET1,
>> > +           RPC_PHYOFFSET1_DDRTMG(3) | 0x1511144);
>> > +   regmap_write(rpc->regmap, RPC_PHYOFFSET2, 0x31 |
>> > +           RPC_PHYOFFSET2_OCTTMG(4));
>>
>>    I still would have preferred using regmap_update_bits() here...
>>
> 
> This is a init() function to set up an initial value to registers.

   Note that 0x31 is read only register value.

> [...]
>> > +static int rpc_spi_io_xfer(struct rpc_spi *rpc,
>> > +            const void *tx_buf, void *rx_buf)
>> > +{
>> [...]
>> > +   } else if (rx_buf) {
>> > +      //
>> > +      // RPC-IF spoils the data for the commands without an address
>> > +      // phase (like RDID) in the manual mode, so we'll have to work
>> > +      // around this issue by using the external address space read
>> > +      // mode instead; we seem to be able to read 8 bytes at most in
>> > +      // this mode though...
>> > +      //
>> > +      if (!(smenr & RPC_SMENR_ADE(0xf))) {
>> > +         u32 nbytes = rpc->xferlen - pos;
>> > +         u64 tmp;
>> > +
>> > +         if (nbytes > 8)
>> > +            nbytes = 8;
>> > +
>> > +         regmap_update_bits(rpc->regmap, RPC_CMNCR,
>> > +                  RPC_CMNCR_MD, 0);
>> > +         regmap_write(rpc->regmap, RPC_DRCR, 0);
>> > +         regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
>> > +         regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
>> > +         regmap_write(rpc->regmap, RPC_DRDMCR, rpc->dummy);
>> > +         regmap_write(rpc->regmap, RPC_DROPR, 0);
>> > +         regmap_write(rpc->regmap, RPC_DRENR, rpc->smenr &
>> > +                 ~RPC_SMENR_SPIDE(0xf));
>>
>>    The 'smenr' filed needs a more universal name -- it's written to
>> both SMENR and DRENR?
> 
> I think it's ok because their bits are compatible.

   Not quite, the LSBs are not compatible, as you can see from the code above.
I'd suggest smth like 'enr' or 'enable'...

> I patch external address space read mode as follows and don't
> need u64, readq().
> ----------------------------------------------------------------
> //
> // RPC-IF spoils the data for the commands without an address
> // phase (like RDID) in the manual mode, so we'll have to work
> // around this issue by using the external address space read
> // mode instead.
> //
> if (!(smenr & RPC_SMENR_ADE(0xf))) {
>         regmap_update_bits(rpc->regmap, RPC_CMNCR,
>                            RPC_CMNCR_MD, 0);
>         regmap_write(rpc->regmap, RPC_DRCR,
>                      RPC_DRCR_RBURST(32) | RPC_DRCR_RBE);

   So the burst mode was the key?

>         regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
>         regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
>         regmap_write(rpc->regmap, RPC_DRDMCR, rpc->dummy);
>         regmap_write(rpc->regmap, RPC_DROPR, 0);
>         regmap_write(rpc->regmap, RPC_DRENR, smenr);
>         memcpy_fromio(rx_buf, rpc->dirmap, rpc->xferlen);
>         regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RCF);
> } else {
> ---------------------------------------------------------------
> 
> you may test it on your side.

   It works!

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
>>    We always return 0 here...
> 
> you mean driver just
> return 0;
> rather than
> return ret;

  Yep.

[...]
>> > +   return reset_control_reset(rpc->rstc);
>> > +}
>> > +
>> > +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
>> > +               const struct spi_mem_op *op,
>> > +               u64 *offs, size_t *len)
>> > +{
>> [...]
>> > +   if (op->data.nbytes || (offs && len)) {
>> > +      if (op->data.dir == SPI_MEM_DATA_IN) {
>> > +         rpc->smcr = RPC_SMCR_SPIRE;
>> > +         rpc->xfer_dir = SPI_MEM_DATA_IN;
>> > +      } else if (op->data.dir == SPI_MEM_DATA_OUT) {
>> > +         rpc->smcr = RPC_SMCR_SPIWE;
>> > +         rpc->xfer_dir = SPI_MEM_DATA_OUT;
>> > +      }
>>
>>    I asked for *switch* above...
>>
> 
> okay, patch it to:
> ------------------------------
> switch (op->data.dir) {
> case SPI_MEM_DATA_IN:
>         rpc->smcr = RPC_SMCR_SPIRE;
>         rpc->xfer_dir = SPI_MEM_DATA_IN;
>         break;
> case SPI_MEM_DATA_OUT:
>         rpc->smcr = RPC_SMCR_SPIWE;
>         rpc->xfer_dir = SPI_MEM_DATA_OUT;
>         break;
> default:
>         break;
> }
> -------------------------------

   Thanks.

> 
>> [...]
>> > +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
>> > +               u64 offs, size_t len, const void *buf)
>> > +{
>> [...]
>> > +   regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, RPC_CMNCR_MD);
>> > +
>> > +   regmap_write(rpc->regmap, RPC_SMDRENR, 0);
>> > +   regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL | 0x260 |
>> > +              RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF);
>>
>>    regmap_update_bits()?
> 
> if so, call regmap_update_bots() twice!!
> 
> regmap_update_bits(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_STRTIM(7), 0);
> regmap_update_bits(rpc->regmap, RPC_PHYCNT,
>                    RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF,
>                    RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF);

   Duplicate line here? And you can do both in 1 go, I think.

> 
> performance and code size!
> is it better ?
> 
> best regards,
> Mason

MBR, Sergei
