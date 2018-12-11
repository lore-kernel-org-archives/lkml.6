Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2E2C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A85020870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="GoJbhVug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A85020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeLKQqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:46:44 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36080 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeLKQqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:46:44 -0500
Received: by mail-lf1-f65.google.com with SMTP id a16so11295562lfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 08:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mE+DOnG/N93adP3nFsgJZRT1RtWswaWjXjJJ96M2m3A=;
        b=GoJbhVugW9xV7rkpWgZ0QkiKx+yao+EF99DxTJq4gdSeRcXtlVMbU7Jxscse1OvrEt
         FqydjMRPn+Bfd0sIsKqSm5GCenlYD6UExTgMlEcl+e1nJMJWummZUXPD6+lJ2cA7k/56
         I+cOJ4bPeNg6H0Biwi6QgAf5wVVOzdyigvz71dALTFPcF53mYPnKdsgj+n+pBYeOXPlQ
         gduMlPiKiYyE7c2mw6PKEHoR9pcFadz9XPI+gN/OdKOtgTkbfYrv/f2AY+qVL5G13uoC
         f6fkEtmEFLnLjt24P/FVfWHNe7A6FCBsWmuZ5uq+jSHfCGSewjJtwTLbv8FupmPmbQbC
         UHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mE+DOnG/N93adP3nFsgJZRT1RtWswaWjXjJJ96M2m3A=;
        b=ZoObzoOXzj4zeA7xUH7m/JR4ENfPukhyQeIohqodwxm4pfiENvWIkdzDQUDSNaAK6T
         nJVLCN4QIm0/jeagqEE3POnvAeBN2Q7jClSBajorAs6k/3WeC7ckutt0w3WIZLsY/m+Z
         QUj22MNVPFiRiTiEDaKfNlXOMYnxGBR4a6WHU+RQTKbwI8UPTl5gsTGg+7eMfEl8TyKA
         LNNLOI0s8rlXmOxD8Tc62MUyvNk5WLPlwm790x/Wac/jpvcoH/oMjusdfR02j3okWzIY
         X8F8PkPeSHzvQDpRwsEAz7G55p5kDwBWVz8xiVRwaSHqmmMkfHEMPAJqSMVoIdiwR3YI
         kB9w==
X-Gm-Message-State: AA+aEWZu4zRCMFnmsO+N/NOQGidE1r8UVhjIEFl1yLhJDmwasrah4JZX
        OPsC7ksB6L2bR22aXiiiLO4+Lg==
X-Google-Smtp-Source: AFSGD/XhjPpXeKnRVC7Dv7Jnl7ecPDUCFhW8SbP6hRtoHz6ITQsq/BkFVcX0fpa52hlWf1n11U/F0Q==
X-Received: by 2002:a19:1019:: with SMTP id f25mr9562011lfi.54.1544546800763;
        Tue, 11 Dec 2018 08:46:40 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.85.248])
        by smtp.gmail.com with ESMTPSA id a62sm2748931lfa.37.2018.12.11.08.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 08:46:39 -0800 (PST)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        zhengxunli@mxic.com.tw
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <0bd07d30-1c0a-ef5b-24ae-dcae3c4721ce@cogentembedded.com>
 <OF1EDC1518.914B7F08-ON48258360.0022FD71-48258360.0033D3DE@mxic.com.tw>
Organization: Cogent Embedded
Message-ID: <c0a83699-05e1-26fa-ca74-ba6f0850cb7b@cogentembedded.com>
Date:   Tue, 11 Dec 2018 19:46:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OF1EDC1518.914B7F08-ON48258360.0022FD71-48258360.0033D3DE@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/11/2018 12:26 PM, masonccyang@mxic.com.tw wrote:

[...]
>>    I'd already started the v2 driver review before you posted v3, so
>> here goes...
>>
>> On 12/03/2018 12:18 PM, Mason Yang wrote:
>>
>>> Add a driver for Renesas R-Car Gen3 RPC SPI controller.
>>>
>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> [...]
>>> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
>>> new file mode 100644
>>> index 0000000..ac9094e
>>> --- /dev/null
>>> +++ b/drivers/spi/spi-renesas-rpc.c
>>> @@ -0,0 +1,808 @@
>> [...]
>>> +#define RPC_DRCR      0x000C   /* R/W */
>>> +#define RPC_DRCR_SSLN      BIT(24)
>>> +#define RPC_DRCR_RBURST(v)   (((v) & 0x1F) << 16)
>>
>>    More like ((v) - 1), like in another register...

   I mean you can pass the read data burst length as a # of data units,
thus just substracting 1, like you did in the other case...

>> [...]
>>> +#define RPC_DREAR      0x0014   /* R/W */
>>> +#define RPC_DREAR_EAC      BIT(0)
>>
>>    The manual says it takes bits 0 to 2...
> 
> yup, EAC[2:0]
> but as datasheet description, either 0 or 1 is OK to BIT(0),
> other than above setting is prohibited

   I'd prefer that this matches the manual. #define the values or
just pass them to RPC_DREAR_EAC(v).

>> [...]
>>> +#define RPC_SMADR      0x0028   /* R/W */
>>> +#define RPC_SMOPR      0x002C   /* R/W */
>>> +#define RPC_SMOPR_OPD0(o)   (((o) & 0xFF) << 0)
>>> +#define RPC_SMOPR_OPD1(o)   (((o) & 0xFF) << 8)
>>> +#define RPC_SMOPR_OPD2(o)   (((o) & 0xFF) << 16)
>>> +#define RPC_SMOPR_OPD3(o)   (((o) & 0xFF) << 24)
>>
>>   You either go in descending or ascending order, not both. :-)
> 
> I can't get your point.

   You #define in the ascending order of the bit # (shift count) here and
in the descending order elsewhere.

[...]
>>> +static void rpc_spi_hw_init(struct rpc_spi *rpc)
>>> +{
>>> +   /*
>>> +    * NOTE: The 0x260 are undocumented bits, but they must be set.
>>> +    *   RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
>>> +    *   0x0 : the delay is biggest,
>>> +    *   0x1 : the delay is 2nd biggest,
>>> +    *   0x3 or 0x6 is a recommended value.
>>> +    */
>>> +   regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
>>> +              RPC_PHYCNT_STRTIM(0x6) | 0x260);
>>> +
>>> +   /*
>>> +    * NOTE: The 0x31511144 and 0x431 are undocumented bits,
>>> +    *    but they must be set for RPC_PHYOFFSET1 & RPC_PHYOFFSET2.
>>> +    */
>>> +   regmap_write(rpc->regmap, RPC_PHYOFFSET1, 0x31511144);
>>> +   regmap_write(rpc->regmap, RPC_PHYOFFSET2, 0x431);
>>
>>    0x400 is actually documented, bits 0..7 are read only and defaultto 0x31...

> I got these values from R-Car bare-metal code, mini-Monitor v4.01.
> 
> What should I describe these bits 0x400 and 0x31 if it is needed?

#define PHYOFFSET2_OCTTMG(v)	((v) & 0x7) << 8)

   The read-modify-write operation ios preferred in this casa, so that
0x31 doesn't appear anywhere.

[...]
>>> +
>>> +         if (nbytes > 4) {
>>> +            nbytes = 4;
>>> +            smcr = rpc->smcr |
>>> +                   RPC_SMCR_SPIE | RPC_SMCR_SSLKP;
>>> +         } else {
>>> +            smcr = rpc->smcr | RPC_SMCR_SPIE;
>>> +         }
>>
>>    Please do this repeated part outside *if*:
> 
> ?
> The procedure is different !

   Where?!

>>          smcr = rpc->smcr | RPC_SMCR_SPIE;
>>          if (nbytes > 4) {
>>             nbytes = 4;
>>             smcr |= RPC_SMCR_SSLKP;
>>          }
[...]
>>> +
>>> +         if (nbytes > 4)
>>> +            nbytes = 4;
>>> +
>>> +         regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
>>> +         regmap_write(rpc->regmap, RPC_SMCR,
>>> +                 rpc->smcr | RPC_SMCR_SPIE);
>>> +         ret = wait_msg_xfer_end(rpc);
>>> +         if (ret)
>>> +            goto out;
>>> +
>>> +         regmap_read(rpc->regmap, RPC_SMRDR0, &data);
>>> +         memcpy_fromio(rx_buf + pos, (void *)&data, nbytes);
>>
>>    What?! The 'data' variable is not in a MMIO region, you can use
>> plain memcpy().
>> Not sure about the endianness tho...
> 
> yup, the 'data' variable is not in MMIO region!
> patch it to memcpy() rather than memcpy_fromio().

   Also, pointer casts to 'void *' are automatic...

[...]
>>> +static ssize_t rpc_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
>>> +                   u64 offs, size_t len, void *buf)
>>> +{
>>> +   struct rpc_spi *rpc = spi_master_get_devdata(desc->mem->spi->master);
>>> +   int ret;
>>> +
>>> +   if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
>>> +      return -EINVAL;
>>> +
>>> +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>>> +   if (ret)
>>> +      return ret;
>>> +
>>> +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>>> +                &desc->info.op_tmpl, &offs, &len);
>>> +
>>> +   regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_SFDE |
>>> +           RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
>>> +           RPC_CMNCR_BSZ(0));
>>> +   regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RBURST(0x1f) |
>>
>>    RPC_DRCR_RBURST(32), please.
> 
> ?
> the max value is 31 = 0x1f

   See above!

[...]
>>> +   regmap_write(rpc->regmap, RPC_DRDMCR, rpc->dummy);
>>> +   regmap_write(rpc->regmap, RPC_DRDRENR, 0);
>>> +
>>> +   memcpy_fromio(buf, rpc->linear.map + desc->info.offset + offs, len);
>>
>>    What if the read direct-mapped area is less than U32_MAX in size
>> (and it will be,
>> according to your bindings)?
> 
> the max direct mapping read area is 64 KByte description in DTS.

   You don't check for this before reading (but you do for writing)!

[...]
>>> +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
>>> +               u64 offs, size_t len, const void *buf)
>>> +{
>>> +   struct rpc_spi *rpc = spi_master_get_devdata(desc->mem->spi->master);
>>> +   int ret;
>>> +
>>> +   if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
>>> +      return -EINVAL;
>>> +
>>> +   if (WARN_ON(len > RPC_WBUF_SIZE))
>>> +      return -EIO;
>>
>>    Why not write 256 bytes and return w/that?
> 
> in manual 62.3.13 Write Buffer Operation,
> transfer size to device is 256-byte unit.

   Why not write 256 bytes max and just return 256? 

[...]
>> [...]

>>> +static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
>>> +               struct spi_message *msg)
>>> +{
>>> +   struct spi_transfer *t, xfer[4] = { };
>>> +   u32 i, xfercnt, xferpos = 0;
>>> +
>>> +   rpc->totalxferlen = 0;
>>> +   rpc->xfer_dir = SPI_MEM_NO_DATA;
>>> +
>>> +   list_for_each_entry(t, &msg->transfers, transfer_list) {
>>> +      if (t->tx_buf) {
>>> +         xfer[xferpos].tx_buf = t->tx_buf;
>>> +         xfer[xferpos].tx_nbits = t->tx_nbits;
>>> +      }
>>> +
>>> +      if (t->rx_buf) {
>>> +         xfer[xferpos].rx_buf = t->rx_buf;
>>> +         xfer[xferpos].rx_nbits = t->rx_nbits;
>>> +      }
>>> +
>>> +      if (t->len) {
>>> +         xfer[xferpos++].len = t->len;
>>> +         rpc->totalxferlen += t->len;
>>> +      }
>>> +
>>> +      if (list_is_last(&t->transfer_list, &msg->transfers)) {
>>> +         if (xferpos > 1 && t->rx_buf) {
>>> +            rpc->xfer_dir = SPI_MEM_DATA_IN;
>>> +            rpc->smcr = RPC_SMCR_SPIRE;
>>> +         } else if (xferpos > 1 && t->tx_buf) {
>>
>>    Why check 'xferpos' twice?
>>
>>> +            rpc->xfer_dir = SPI_MEM_DATA_OUT;
>>> +            rpc->smcr = RPC_SMCR_SPIWE;
>>> +         }
>>> +      }
>>> +   }
> 
> patch it to check 'xferpos' only one time.
> -------------------------------------------------------------
>                  if (list_is_last(&t->transfer_list, &msg->transfers)) {
>                          if (xferpos > 1) {
>                                         if (tx->rx_buf) {                                                
>                                  rpc->xfer_dir = SPI_MEM_DATA_IN;
>                                  rpc->smcr = RPC_SMCR_SPIRE;
>                                  } else if (t->tx_buf) {
>                                  rpc->xfer_dir = SPI_MEM_DATA_OUT;
>                                  rpc->smcr = RPC_SMCR_SPIWE;
>                                  }
>                                 }
>                  }
> ----------------------------------------------------------

   You got the idea but please reformat this properly..

[...]
>>
>>> +      for (i = 0; i < xfer[1].len; i++)
>>> +         rpc->addr |= (u32)((u8 *)xfer[1].tx_buf)[i]
>>> +               << (8 * (xfer[1].len - i - 1));
>>
>>    Ugh, you need get_unaligned_*()...
> 
> for accessing a single byte quantity, ((u8 *)xfer[1].tx_buf)[i] ?

   Ugh, never start a new line with an operator, lease it on a 1st, broken up line.

[...]
>>> +static const struct regmap_config rpc_spi_regmap_config = {
>>> +   .reg_bits = 32,
>>> +   .val_bits = 32,
>>> +   .reg_stride = 4,
>>> +   .fast_io = true,
>>> +   .max_register = RPC_WBUF + RPC_WBUF_SIZE,
>>
>>    Ugh... 0x8100/4 regs, of which the majority isn't used... :-/

   Seriously, you don't use regmap for the write buffer anyway...

[...]
>> > +err_put_master:
>> > +   spi_master_put(master);
>> > +   pm_runtime_disable(&pdev->dev);
>> > +
>> > +   return ret;
>> > +}
>> > +
>> > +static int rpc_spi_remove(struct platform_device *pdev)
>> > +{
>> > +   struct spi_master *master = platform_get_drvdata(pdev);
>> > +
>> > +   pm_runtime_disable(&pdev->dev);
>> > +   spi_unregister_master(master);
>>
>>    No spi_master_put() here?
> 
> put_device() in spi_unregister_master().

   Why call spi_master_put() in the probe() method's error path?

> best regards,
> Mason

> CONFIDENTIALITY NOTE:
> 
> This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.
> 
> Macronix International Co., Ltd.
> 
> =====================================================================

   Please consider sending patches from e.g. your GMail account to avoid this legelese
crap.

MBR, Sergei
