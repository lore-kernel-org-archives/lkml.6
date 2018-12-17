Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BC020874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="UiRubWDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbeLQSzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:55:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43359 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbeLQSzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:55:31 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2-v6so822888lji.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mK8FxPSg3yEXlR4c/dgVe8ombh9XrqEJVxE4vCuZPZs=;
        b=UiRubWDf0bjvjXEStS5i8v9jM7u6suXB0sOQK7GgK6xLimwaSAGg55q613QbHa+yeF
         uAaF47ii+fIcS60cx0mTP1pXvg4WabAXju6s/tzQipMDqTE85CqRKnjVmijydV5XWZwC
         kk4qREGZSOWTXv/uVhv3doSXLB4nuOkW18A9LuwFcN3D2yoI/8s7UdbwVoGfUaRfDtAx
         xNvsH7kz5VgDneC2Id3slAz98GmYNnC5uNJvDcs3dVCTKh4TEjaE7ntysIk7NyslPwwi
         jk+CZfGKXUen1KgXUNClCqKKiPp6MU6AIUFEED8H/a8hAagOJcdgByUKBOEz1v9IFPv5
         jGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mK8FxPSg3yEXlR4c/dgVe8ombh9XrqEJVxE4vCuZPZs=;
        b=IZTyCyNBumjBT7YUvGnng83icwDUW5p20Oeuxvtu8ZKIzrMTqJHiJPTvFtaF9OaoBF
         YQPy2Jb1uTj5RirE8IdQyN14uTUwx2faXDtr5U0wuCv9B6bcwOSYedMLB/KtkCJ+sPsH
         6HJJnyLK+OgOUWHPmMej3STlZnVlpYbrDbGj+mTSOro0R5OLoyMQdvwcIjgN/8LhHWS6
         o7WGE2PlRerH+ZL798BunGzOrZuUSGnnwu9PUci112kJvwJSm6Q35LQ2lKH51iCm9vJ3
         z7h8STQtWhirPpLyy4BMFNRfIH8Yhtlg7O+X4E9Wn77beYbWGcrk8g0FJNwLdorS7Q9z
         Gb/Q==
X-Gm-Message-State: AA+aEWYFADHE6+FGaWEfXBE8MBg8foWfC70ZmYostz9kG1kwbjWYkRAp
        dq6/mN+D02n3IxYsF9PWFV1uhg==
X-Google-Smtp-Source: AFSGD/VL5AyEBpt7MKooj/bPc6IzjNW/DZLkzDjs0MmtImOj3jsaU5XNt0XdUEc/FGi5oyNYBADR4w==
X-Received: by 2002:a2e:681a:: with SMTP id c26-v6mr7946290lja.175.1545072928545;
        Mon, 17 Dec 2018 10:55:28 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.86.84])
        by smtp.gmail.com with ESMTPSA id r69sm2885928lfi.15.2018.12.17.10.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 10:55:26 -0800 (PST)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        zhengxunli@mxic.com.tw
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
 <1544181199-3373-2-git-send-email-masonccyang@mxic.com.tw>
 <557c8114-2819-7be3-21b8-02918aa89c04@cogentembedded.com>
 <OFAE786891.A102E46D-ON48258366.002779D7-48258366.002A5C36@mxic.com.tw>
Organization: Cogent Embedded
Message-ID: <bfda743d-4aa0-732f-e240-9435647a4856@cogentembedded.com>
Date:   Mon, 17 Dec 2018 21:55:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OFAE786891.A102E46D-ON48258366.002779D7-48258366.002A5C36@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/17/2018 10:42 AM, masonccyang@mxic.com.tw wrote:

>> > +static int rpc_spi_io_xfer(struct rpc_spi *rpc,
>> > +            const void *tx_buf, void *rx_buf)
>> > +{
>> > +   u32 smenr, smcr, data, pos = 0;
>> > +   int ret = 0;
>> > +
>> > +   regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
>> > +              RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
>> > +              RPC_CMNCR_BSZ(0));
>> > +   regmap_write(rpc->regmap, RPC_SMDRENR, 0x0);
>> > +   regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
>> > +   regmap_write(rpc->regmap, RPC_SMDMCR, rpc->dummy);
>> > +   regmap_write(rpc->regmap, RPC_SMADR, rpc->addr);
>> > +
>> > +   if (tx_buf) {
>> > +      smenr = rpc->smenr;
>> > +
>> > +      while (pos < rpc->xferlen) {
>> > +         u32 nbytes = rpc->xferlen  - pos;
>> > +
>> > +         regmap_write(rpc->regmap, RPC_SMWDR0,
>> > +                 get_unaligned((u32 *)(tx_buf + pos)));
>> > +
>> > +         if (nbytes > 4) {
>> > +            nbytes = 4;
>> > +            smcr = rpc->smcr |
>> > +                   RPC_SMCR_SPIE | RPC_SMCR_SSLKP;
>> > +         } else {
>> > +            smcr = rpc->smcr | RPC_SMCR_SPIE;
>> > +         }
>> > +
>> > +         regmap_write(rpc->regmap, RPC_SMENR, smenr);
>> > +         regmap_write(rpc->regmap, RPC_SMCR, smcr);
>> > +         ret = wait_msg_xfer_end(rpc);
>> > +         if (ret)
>> > +            goto out;
>> > +
>> > +         pos += nbytes;
>> > +         smenr = rpc->smenr & ~RPC_SMENR_CDE &
>> > +                    ~RPC_SMENR_ADE(0xf);
>> > +      }
>> > +   } else if (rx_buf) {
>> > +      while (pos < rpc->xferlen) {
>> > +         u32 nbytes = rpc->xferlen  - pos;
>> > +
>> > +         if (nbytes > 4)
>> > +            nbytes = 4;
>> > +
>> > +         regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
>> > +         regmap_write(rpc->regmap, RPC_SMCR,
>> > +                 rpc->smcr | RPC_SMCR_SPIE);
>>
>>    Hm... our flash chip (Spansion S25FS512S) doesn't get detected; it sends
>> JEDEC ID bytes 0..3 repeatedly, unless I copy the SSLKP logic from the writing
>> branch above...
> 
> Do you switch the SW1, SW2, SW3, SW13, SW31 and SW10 to on-board QSPI mode ?
> Because R-Car D3 Draak board default is booting from HyperFlsah.

   I was testing your patch on the V3H-based Condor and Starter Kit boards --
it should have worked without much ado...
   It works with *our* driver, living under drivers/mtd/spi-nor/ (which makes
it outdated, AFAIU) and I was going to push it upstream before I learned about
your driver. :-)

> what follows is my booting log, FYI.
> ------------------------------------------------------------------
> [    1.625053] m25p80 spi5.0: s25fl129p1 (16384 Kbytes)

   So another Spansion flash?

> [    1.634391] 12 fixed-partitions partitions found on MTD device spi5.0
> [    1.642198] Creating 12 MTD partitions on "spi5.0":
> [    1.647598] 0x000000000000-0x000000040000 : "Bank 1 - Boot parameter"
> [    1.660893] 0x000000040000-0x000000180000 : "Bank 1 - Loader-BL2"
> [    1.671287] 0x000000180000-0x0000001c0000 : "Bank 1 - Certification"
> -----------------------------------------------------------------------
> 
>>
>> > +         ret = wait_msg_xfer_end(rpc);
>> > +         if (ret)
>> > +            goto out;
>> > +
>> > +         regmap_read(rpc->regmap, RPC_SMRDR0, &data);
>> > +         memcpy_fromio(rx_buf + pos, (void *)&data, nbytes);
>> > +         pos += nbytes;
>>
>>    ... and it skips byte 4 unless I copy the code from the end of the writing
>> branch, clearing CDE/ADE. But even then the byte 4 reads as 0x03 instead of 0.
> 
> yup, I think this is some kind of RPC HW limitation,
> in RPC manual I/O mode, it only could read 4 bytes data w/ one command.

   Thank for the info -- seems worth a comment though...

> That is, one command + read 4 bytes data + read 4 bytes data + read 4 bytes data + ...
> will get the incorrect data.

   What if we want to read less than 4 bytes (the ID read requests SPI_NOR_MAX_ID_LEN
(6) bytes, i.e. 4 + 2)? You seem to always expect 4 bytes...

> That's why RPC in manual I/O mode, driver only could do,
> one command + read 4 bytes data; one command + read 4 bytes data and so on.

   The question is why it just duplicates the ID bytes 0..3 on the 2nd iteration
in our case...

> But RPC in external address space read mode(here we call it direct mapping read mode)
> is ok for one command + read 4 bytes data + read 4 bytes data + ....

   Sounds promising... if only we could make the probing work. :-)

> thanks & best regards,
> Mason

MBR, Sergei
