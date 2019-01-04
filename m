Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DCAC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81C42070C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="ndIul5is"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfADNmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:42:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33119 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfADNmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 08:42:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so32515633ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 05:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hz4FKSyyeMcPuzMsC3YkEaRIby7eDVYARr1FlIUtrWA=;
        b=ndIul5isXBTWzcIaDOjyFRpZOadpG5jN41cEUHeQjvX/fJ/AcCkxAaGKLzxIGKIRGL
         d5QoRblzOiwClU3FMw/qOC4wGVsEOe7hXCLVyGKkFVjHmAcoXz6jKAbp3j7vI6Du3ZHZ
         aEjnRSC/ROKpuYjUuOtDc3H/TNNqnC6um/Lir+WNMWJF5aQe6+rcP6tG3kSOthPdDHJq
         VvbkHRgUV0KE6/d5gtmJmt+OKN5IpWq0qJ4+S1F6kndZh1wBuRnA8KbnoSd5aky6CyDd
         0JQ0OonfypsGFHkcVRT8rmUGIzmIT2UbmAROHeS9d5FGuabKfU12xnBQ5qDUrXru8Ffk
         UK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Hz4FKSyyeMcPuzMsC3YkEaRIby7eDVYARr1FlIUtrWA=;
        b=J+AOio8zQ31VAOte0sy7zTcl6C3wQJXZ/tqIZhJexXmneJo1Z0SqT74MO2vrsRk7te
         v9q7sJbzEqhyaMkZQw85YO1N8gFv73Mq/3Pu9HElKepECejqN3GFFIdCfHAD8Zzcm4fT
         lBpNQWMQoTVKPKdSsgxHUAbAyg+qltll/Qr3B9/mUk+UurM/vkc1ltRI/PUIngTQTZq1
         a5nt8uWaY+3Pg0kxF5GQ7+Fa441s1IRhcu5YZdXEvfpzqW24aSsNyX5YejGBMsgIgYWl
         uuC//+rj2W3+adwD7kbMIQqepZIM07jUZJfg9VQSDjkbEU3szakhCXH71cdc691mQLcq
         30Kw==
X-Gm-Message-State: AJcUukcXgF9smgw1q7TBR2nx6bTIiS2PfXfeL0f9bMtoDCeBTYxi7YYO
        B0h//wYL5x4JU6FqmOI36rxO/PWgjXA=
X-Google-Smtp-Source: ALg8bN4qEs5gcRkGaDk4cEBTxCrtetL2dCOVDhmA38Kp6VeDybgNPxlrLOqbzdp51D1a5Pc1e5BFPQ==
X-Received: by 2002:a2e:9957:: with SMTP id r23-v6mr27523040ljj.98.1546609364025;
        Fri, 04 Jan 2019 05:42:44 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.86.82])
        by smtp.gmail.com with ESMTPSA id p10-v6sm12461684ljg.19.2019.01.04.05.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 05:42:43 -0800 (PST)
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
 <0f21cd94-08ad-befa-649e-ba191b0e33bc@cogentembedded.com>
 <OFE79BC6CE.BE217C13-ON48258377.001FBC09-48258377.00243859@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <710badb0-c4db-a44b-dba1-01faf2f51a9d@cogentembedded.com>
Date:   Fri, 4 Jan 2019 16:42:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OFE79BC6CE.BE217C13-ON48258377.001FBC09-48258377.00243859@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 01/03/2019 09:35 AM, masonccyang@mxic.com.tw wrote:

[...]
>> >> > +#define RPC_CMNCR_MOIIO3(val)   (((val) & 0x3) << 22)
>> >> > +#define RPC_CMNCR_MOIIO2(val)   (((val) & 0x3) << 20)
>> >> > +#define RPC_CMNCR_MOIIO1(val)   (((val) & 0x3) << 18)
>> >> > +#define RPC_CMNCR_MOIIO0(val)   (((val) & 0x3) << 16)
>> >> > +#define RPC_CMNCR_MOIIO_HIZ   (RPC_CMNCR_MOIIO0(3) |
>> >> RPC_CMNCR_MOIIO1(3) | \
>> >> > +             RPC_CMNCR_MOIIO2(3) | RPC_CMNCR_MOIIO3(3))
>> >> > +#define RPC_CMNCR_IO3FV(val)   (((val) & 0x3) << 14)
>> >> > +#define RPC_CMNCR_IO2FV(val)   (((val) & 0x3) << 12)
>> >>
>> >>    Like I said, the above 2 aren't documented in the manual v1.00...
>> >
>> > okay, add a description as:
>> > /* RPC_CMNCR_IO3FV/IO2FV are undocumented bit, but must be set */
>> > #define RPC_CMNCR_IO3FV(val)    (((val) & 0x3) << 14)
>> > #define RPC_CMNCR_IO2FV(val)    (((val) & 0x3) << 12)
>> > #define RPC_CMNCR_IO0FV(val)    (((val) & 0x3) << 8)
>> > #define RPC_CMNCR_IOFV_HIZ      (RPC_CMNCR_IO0FV(3) | RPC_CMNCR_IO2FV(3) | \
>> >                                   RPC_CMNCR_IO3FV(3))
>> >
>> > is it ok?
>>
>>    Yes. But would have been enough if you just commented with // on
>> the same line --
>> it seems these are legal now...
> 
> on the same line is over 80 char,
> #define RPC_CMNCR_IO3FV(val)    (((val) & 0x3) << 14) // undocumented bit, but must be set
> #define RPC_CMNCR_IO2FV(val)    (((val) & 0x3) << 12) // undocumented bit, but must be set
> 
> or just
> #define RPC_CMNCR_IO3FV(val)    (((val) & 0x3) << 14) // undocumented bit
> #define RPC_CMNCR_IO2FV(val)    (((val) & 0x3) << 12) // undocumented bit
> is it ok ?

   The second variant would be enough.

[...]

>> >> > +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>> >> > +   if (ret)
>> >> > +      return ret;
>> >> > +
>> >> > +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>> >> > +                &desc->info.op_tmpl, &offs, &len);
>> >> > +
>> >> > +   regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_SFDE |
>> >> > +           RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
>> >> > +           RPC_CMNCR_BSZ(0));
>> >>
>> >>    Why not set this in the probing time and only set/clear the MD bit?
>> >>
>> >
>> > same above!
>> > Make sure the value in these register are setting correctly
>> > before RPC starting a SPI transfer.
>>
>>    You can set it once and only change the bits you need to change afterwards.
>> What's wrong with it?
>>
> 
> if so, it will patch to:
> ------------------------------------------------------
> regmap_read(rpc->regmap, RPC_CMNCR, &data);
> data &= ~RPC_CMNCR_MD;
> regmap_write(rpc->regmap, RPC_CMNCR, data);
> ------------------------------------------------------
> Do you think this way is better ?

    No, this one is better:

	regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, 0);

> maybe this is better,
> write(read(rpc->regs + RPC_CMNCR) & ~RPC_CMNCR_MD,
>         rpc->regs + RPC_CMNCR);

   It's effectively the same code as your 1st variant...
 
[...]
>> >> > +static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
>> >> > +               struct spi_message *msg)
>> >> > +{
>> >> [...]
>> >> > +   for (i = xfercnt - 1; i < xfercnt && xfercnt > 1; i++) {
>> >> > +      if (xfer[i].rx_buf) {
>> >> > +         rpc->smenr |=
>> >> > +            RPC_SMENR_SPIDE(rpc_bits_set(xfer[i].len)) |
>> >> > +            RPC_SMENR_SPIDB
>> >> > +            (ilog2((unsigned int)xfer[i].rx_nbits));
>> >>
>> >>    Mhm, I would indent this contination line by 1 extra tab...
>> >>
>> >> > +      } else if (xfer[i].tx_buf) {
>> >> > +         rpc->smenr |=
>> >> > +            RPC_SMENR_SPIDE(rpc_bits_set(xfer[i].len)) |
>> >> > +            RPC_SMENR_SPIDB
>> >> > +            (ilog2((unsigned int)xfer[i].tx_nbits));
>> >>
>> >>    And this one...
>> >
>> > like this ?
>> > --------------------------------------------------------------------
>> >          for (i = xfercnt - 1; i < xfercnt && xfercnt > 1; i++) {
>> >                  if (xfer[i].rx_buf) {
>> >                          rpc->smenr |=
>> >                                  RPC_SMENR_SPIDE(rpc_bits_set(xfer
>> [i].len)) |
>> >                                  RPC_SMENR_SPIDB(
>> >                                          ilog2((unsigned int)xfer
>> [i].rx_nbits));
>> >                  } else if (xfer[i].tx_buf) {
>> >                          rpc->smenr |=
>> >                                  RPC_SMENR_SPIDE(rpc_bits_set(xfer
>> [i].len)) |
>> >                                  RPC_SMENR_SPIDB(
>> >                                          ilog2((unsigned int)xfer
>> [i].tx_nbits));
>>
>>    I didn't mean you need to leave ( on the first line, can be left
>> on the  new
>> line, as before.
>>
> 
> how about this style ?
> -------------------------------------------------------------------------------------
>          for (i = xfercnt - 1; i < xfercnt && xfercnt > 1; i++) {
>                  if (xfer[i].rx_buf) {
>                          rpc->smenr |= RPC_SMENR_SPIDE(
>                                          rpc_bits_set(xfer[i].len)) |
>                                        RPC_SMENR_SPIDB(
>                                          ilog2((unsigned int)xfer[i].rx_nbits));
>                  } else if (xfer[i].tx_buf) {
>                          rpc->smenr |= RPC_SMENR_SPIDE(
>                                          rpc_bits_set(xfer[i].len)) |
>                                        RPC_SMENR_SPIDB(
>                                          ilog2((unsigned int)xfer[i].tx_nbits));
>                  }
>          }

   Looks even worse...

> ------------------------------------------------------------------------------------------
> 
> best regards,
> Mason

[...]

MBR, Sergei
