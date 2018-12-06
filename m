Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A42C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA14720892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC3LXmQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA14720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbeLFJIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:08:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33291 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFJIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:08:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so13640060wmh.0;
        Thu, 06 Dec 2018 01:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l191p/ttRV59okJGhscm2TYeZf28l7MGu49Xr6zZNJA=;
        b=WC3LXmQdgOKREue2zjDEMMLgQGGZn342vcJaloz4l3WHxOvrSwVINhBz1j3Ipk4Qxs
         YwsoqDZ2Jy2D3UG6NgOcnruJo92PKusf4FX5HBb8GoICzBLnSeKf95if8OT1P4fS6Rx+
         4195s/lDFEIwflFw9KXR0noUQLmUkzhe6YsCkV+WY7vckvgZ/i4qFe5ivgeXTtlh8zpO
         Nv2f5TrfmLtHzu8UYus3eLIziiM+ch/uBLkWekDSQxEWdNpuCxTC9/o0DyIqDM5Vdu4O
         q3bhEZj2cbvwMewn9WEJUjdJNXqnNETa9E135sh7YtcYBTsVnDowSO07zdiU1FDYSWob
         x9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l191p/ttRV59okJGhscm2TYeZf28l7MGu49Xr6zZNJA=;
        b=jqNXWY4Em7akzGByl6jj3ynWdvhTHLVvMtVkb0NiziIxSGhWdH6PzQgqysPQ3q9BZq
         VBEFaJjzyE8v3quTm2gojWu/7KVer9eSsv1QGMVwtCJ2fxvVlxAakUWzcVrrAKMOA5Zu
         hU6lzWAC2VBMFVe4zVDPEEFpgER3fpFsljEtJyMg2gpQS0nFuem7R0jU2fHmwspUQ4Pg
         TtNPm6uK+bJr/sLlDuTJrT5Bj1Dw+YC5E5j0i5oBECRDL84r6SrzTotktmUOTwAPzXTI
         rqD0H6ZJHleZjEZHb9107xGJtGwLiaxAoRQdnRDLbptkdgg+BXINHwvY4vdoQY6DzgpQ
         /Rdw==
X-Gm-Message-State: AA+aEWZUGnIVm/OomdFFhSE3O9ssHartqsAGv7H0wMSdZ86k8Lg3ZGrZ
        TiNEecCQy8pEe5yReNF8Q/k=
X-Google-Smtp-Source: AFSGD/UnBqzbHLFadNkYDzYqcR//Tp/cBtdynIDcxF36OFuEYvOKMzDX26v1l83Z/BXrimOEGBRWHw==
X-Received: by 2002:a1c:87cc:: with SMTP id j195mr18507784wmd.2.1544087301214;
        Thu, 06 Dec 2018 01:08:21 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id k15sm15350370wru.8.2018.12.06.01.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 01:08:20 -0800 (PST)
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, zhengxunli@mxic.com.tw
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <cebe44a3-80be-9091-e70b-acba6f3fff4f@gmail.com>
 <OF0ED3C578.141B72CA-ON4825835A.0025CA62-4825835A.002A7BDF@mxic.com.tw>
 <84e3c55b-687e-28f6-0a7c-1c48c822ef05@gmail.com>
 <OFC9FB54F8.34B3A8B7-ON4825835B.00267480-4825835B.0029455C@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <93bb36af-8bdb-c90e-3777-62fe1a48f76a@gmail.com>
Date:   Thu, 6 Dec 2018 10:02:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <OFC9FB54F8.34B3A8B7-ON4825835B.00267480-4825835B.0029455C@mxic.com.tw>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2018 08:30 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> >> Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
> driver
>> >>
>> >> On 12/03/2018 10:18 AM, Mason Yang wrote:
>> >> > Add a driver for Renesas R-Car Gen3 RPC SPI controller.
>> >> >
>> >> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> >>
>> >> What changed in this V2 ?
>> >>
>> >> [...]
>> >
>> > see some description in [PATH v2 0/2]
>>
>> I don't see any V2: list there.
>>
> 
> including
> 1) remove RPC clock enable/dis-able control,
> 2) patch run time PM,
> 3) add RPC module software reset,
> 4) add regmap,
> 5) other coding style and so on.

Please include a detailed changelog in each subsequent patch series.

>> >> > +static int rpc_spi_io_xfer(struct rpc_spi *rpc,
>> >> > +            const void *tx_buf, void *rx_buf)
>> >> > +{
>> >> > +   u32 smenr, smcr, data, pos = 0;
>> >> > +   int ret = 0;
>> >> > +
>> >> > +   regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD |
> RPC_CMNCR_SFDE |
>> >> > +              RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
>> >> > +              RPC_CMNCR_BSZ(0));
>> >> > +   regmap_write(rpc->regmap, RPC_SMDRENR, 0x0);
>> >> > +   regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
>> >> > +   regmap_write(rpc->regmap, RPC_SMDMCR, rpc->dummy);
>> >> > +   regmap_write(rpc->regmap, RPC_SMADR, rpc->addr);
>> >> > +
>> >> > +   if (tx_buf) {
>> >> > +      smenr = rpc->smenr;
>> >> > +
>> >> > +      while (pos < rpc->xferlen) {
>> >> > +         u32 nbytes = rpc->xferlen  - pos;
>> >> > +
>> >> > +         regmap_write(rpc->regmap, RPC_SMWDR0,
>> >> > +                 *(u32 *)(tx_buf + pos));
>> >>
>> >> *(u32 *) cast is probably not needed , fix casts globally.
>> >
>> > It must have it!
>>
>> Why ?
> 
> Get a compiler warning due to tx_bug is void *, as Geert replied.

The compiler warning is usually an indication that this is something to
check, not silence with a type cast.

> Using get_unaligned(), patched code would be
> -----------------------------------------------------
> regmap_write(rpc->regmap, RPC_SMWDR0,
>                  get_unaligned((u32 *)(tx_buf + pos)));                
> ----------------------------------------------------

Do you need the cast if you use get_unaligned() ?

>> >> > +         rpc->xferlen = *(u32 *)len;
>> >> > +         rpc->totalxferlen += *(u32 *)len;
>> >> > +      } else {
>> >> > +         rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
>> >> > +               (op->data.nbytes)) | RPC_SMENR_SPIDB
>> >> > +               (fls(op->data.buswidth >> 1));
>> >>
>> >> Drop parenthesis around fls()
>> >
>> > ?
>> > no way.
>>
>> I would really appreciate it if you could explain things instead.
>>
>> Geert already did so, by pointing out this is a confusing code
>> formatting problem and how it should be fixed, so no need to repeat
>> that. But I hope you understand how that sort of explanation is far more
>> valuable than "no way" kind of reply.
> 
> okay, understood.
> 
> 
>> >> > +
>> >> > +   xfercnt = xferpos;
>> >> > +   rpc->xferlen = xfer[--xferpos].len;
>> >> > +   rpc->cmd = RPC_SMCMR_CMD(((u8 *)xfer[0].tx_buf)[0]);
>> >>
>> >> Is the cast needed ?
>> >
>> > yes!
>>
>> Why ?
> 
> Get a compiler warning due to tx_bug is void *, as Geert replied.

> Using get_unaligned(), patched code would be
> ---------------------------------------------------------------
>  rpc->cmd = RPC_SMCMR_CMD(get_unaligned((u8 *)xfer[0].tx_buf));
> ----------------------------------------------------------------

See above

>> >> > +   rpc->smenr = RPC_SMENR_CDE | RPC_SMENR_CDB(fls(xfer[0].tx_nbits
>> >>> 1));
>> >> > +   rpc->addr = 0;
>> >> > +
>> >> > +   if (xfercnt > 2 && xfer[1].len && xfer[1].tx_buf) {
>> >> > +      rpc->smenr |= RPC_SMENR_ADB(fls(xfer[1].tx_nbits >> 1));
>> >> > +      for (i = 0; i < xfer[1].len; i++)
>> >> > +         rpc->addr |= (u32)((u8 *)xfer[1].tx_buf)[i]
>> >> > +               << (8 * (xfer[1].len - i - 1));
>> >> > +
>> >> > +      if (xfer[1].len == 4)
>> >> > +         rpc->smenr |= RPC_SMENR_ADE(0xf);
>> >> > +      else
>> >> > +         rpc->smenr |= RPC_SMENR_ADE(0x7);
>> >> > +   }
>> >> > +
>> >> > +   switch (xfercnt) {
>> >> > +   case 2:
>> >> > +      if (xfer[1].rx_buf) {
>> >> > +         rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
>> >> > +                  (xfer[1].len)) | RPC_SMENR_SPIDB(fls
>> >> > +                  (xfer[1].rx_nbits >> 1));
>> >> > +      } else if (xfer[1].tx_buf) {
>> >> > +         rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
>> >> > +                  (xfer[1].len)) | RPC_SMENR_SPIDB(fls
>> >> > +                  (xfer[1].tx_nbits >> 1));
>> >> > +      }
>> >> > +      break;
>> >> > +
>> >> > +   case 3:
>> >> > +      if (xfer[2].len && xfer[2].rx_buf && !xfer[2].tx_buf) {
>> >> > +         rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
>> >> > +                  (xfer[2].len)) | RPC_SMENR_SPIDB(fls
>> >> > +                  (xfer[2].rx_nbits >> 1));
>> >>
>> >> It seems this SMENR pattern repeats itself throughout the driver, can
>> >> this be improved / deduplicated ?
>> >
>> > It seems no way!
>>
>> Why ?
> 
> okay, I patch this with for( ) loop.

Please do, let's see how it looks .

>> >> > +      } else if (xfer[2].len && xfer[2].tx_buf && !xfer[2].rx_buf) {
>> >> > +         rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
>> >> > +                  (xfer[2].len)) | RPC_SMENR_SPIDB(fls
>> >> > +                  (xfer[2].tx_nbits >> 1));
>> >> > +      }
>> >> > +      break;
>> >> > +
>> >> > +   case 4:
>> >> > +      if (xfer[2].len && xfer[2].tx_buf) {
>> >> > +         rpc->smenr |= RPC_SMENR_DME;
>> >> > +         rpc->dummy = RPC_SMDMCR_DMCYC(xfer[2].len);
>> >> > +      }
>> >> > +
>> >> > +      if (xfer[3].len && xfer[3].rx_buf) {
>> >> > +         rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
>> >> > +                  (xfer[3].len)) | RPC_SMENR_SPIDB(fls
>> >> > +                  (xfer[3].rx_nbits >> 1));
>> >> > +      }
>> >> > +      break;
>> >> > +
>> >> > +   default:
>> >> > +      break;
>> >> > +   }
>> >> > +}
>> >> > +
>> >> > +static int rpc_spi_xfer_message(struct rpc_spi *rpc, struct
>> >> spi_transfer *t)
>> >> > +{
>> >> > +   int ret;
>> >> > +
>> >> > +   ret = rpc_spi_set_freq(rpc, t->speed_hz);
>> >> > +   if (ret)
>> >> > +      return ret;
>> >> > +
>> >> > +   ret = rpc_spi_io_xfer(rpc,
>> >> > +               rpc->xfer_dir == SPI_MEM_DATA_OUT ?
>> >> > +               t->tx_buf : NULL,
>> >> > +               rpc->xfer_dir == SPI_MEM_DATA_IN ?
>> >> > +               t->rx_buf : NULL);
>> >> > +
>> >> > +   return ret;
>> >> > +}
>> >> > +
>> >> > +static int rpc_spi_transfer_one_message(struct spi_master *master,
>> >> > +               struct spi_message *msg)
>> >> > +{
>> >> > +   struct rpc_spi *rpc = spi_master_get_devdata(master);
>> >> > +   struct spi_transfer *t;
>> >> > +   int ret;
>> >> > +
>> >> > +   rpc_spi_transfer_setup(rpc, msg);
>> >> > +
>> >> > +   list_for_each_entry(t, &msg->transfers, transfer_list) {
>> >> > +      if (!list_is_last(&t->transfer_list, &msg->transfers))
>> >> > +         continue;
>> >> > +      ret = rpc_spi_xfer_message(rpc, t);
>> >> > +      if (ret)
>> >> > +         goto out;
>> >> > +   }
>> >> > +
>> >> > +   msg->status = 0;
>> >> > +   msg->actual_length = rpc->totalxferlen;
>> >> > +out:
>> >> > +   spi_finalize_current_message(master);
>> >> > +   return 0;
>> >> > +}
>> >> > +
>> >> > +static const struct regmap_range rpc_spi_volatile_ranges[] = {
>> >> > +   regmap_reg_range(RPC_SMRDR0, RPC_SMRDR0),
>> >> > +   regmap_reg_range(RPC_SMWDR0, RPC_SMWDR0),
>> >>
>> >> Why is SMWDR volatile ?
>> >
>> > No matter is write-back or write-through.
>>
>> Oh, do you want to assure the SMWDR value is always written directly to
>> the hardware ?
> 
> yes,
> 
>>
>> btw. I think SMRDR should be precious ?
> 
> so, you think I should drop
> regmap_reg_range(RPC_SMWDR0, RPC_SMWDR0)

No, I am asking whether SMRDR should be marked precious or not.

[...]

> CONFIDENTIALITY NOTE:
> 
> This e-mail and any attachments may contain confidential information
> and/or personal data, which is protected by applicable laws. Please be
> reminded that duplication, disclosure, distribution, or use of this
> e-mail (and/or its attachments) or any part thereof is prohibited. If
> you receive this e-mail in error, please notify us immediately and
> delete this mail as well as its attachment(s) from your system. In
> addition, please be informed that collection, processing, and/or use of
> personal data is prohibited unless expressly permitted by personal data
> protection laws. Thank you for your attention and cooperation.
> 
> Macronix International Co., Ltd.

Can you do something about this ^ please ?

-- 
Best regards,
Marek Vasut
