Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3514C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DC921873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="eBN1u4YG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbeLRQpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:45:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35926 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeLRQpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:45:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so14811608ljk.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 08:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bspdw49K9wkhTt7Vy+IDrD8tHJL9BGF0pICGyon1IUA=;
        b=eBN1u4YGUta7aPXvNcuSSKqHnIRYqZhoDQn9dmD+D+EaDTMrJuoatsXNt+gUmBisUL
         QYOk1rsuGxLknPqJnaBrxv+FlJazN3ln6N2xBOtMZH3nLj/jSEwrOPloPoggZsSmsc2t
         QJ1bQ0OjDBbKYYrngdmGpQEYd2jpFKwdOVvSK4dUctizN/r6zimX8lSUL1ORbd69a/ev
         YKleguZjFRJ/Wc+Ywqh/WTtiZuO7QFZz6/24jys7ucmejfsFWbMCNaSwGUCHEQ/v8qB2
         gJyQFHF+LMrEvA7bSUDKMQBuE1vXOy3hhcbPoxrq3v7btFwXGAKfHlI6/YFuPT4WiWG9
         CL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bspdw49K9wkhTt7Vy+IDrD8tHJL9BGF0pICGyon1IUA=;
        b=iC7d4o4sTC/4cWG+EtEmstErlsCjichpA9oSy27uOfOZzxjfoAbDH6J+n4tZk2rsMX
         9wh4V+sv0415crLF1x9F1qcE/HQjjXzwjrF7r+u3Sv40mCkqXfxKBhzmRn6c7IMoVrj4
         /flpBx2IzgtUwi6RERbk6lOD2qZlhw6Po9TJD0l8NqLgWZScyJepU+PZ8toO9PlVIycC
         ztzApVX7dXiED/N+iSGfC27tvINTRkEd4eHdYAnbowbEZleHYsBif4P4AvwIWA/vc7iV
         J1PSpJBXmgs6iMON4i09O6TK7yJcEJmX2oe1FUOTXL3A0O0NSta6BD5t/8wCFMcogESg
         AYQw==
X-Gm-Message-State: AA+aEWY2C9vFOLfg0dKTUffU3w4wXoPblb1/f2I45eX0FVcStxf63Dmy
        LUyYNAE/rVaHVkEzt07gh2PgJg==
X-Google-Smtp-Source: AFSGD/Vr2+pKPpnEeQI2OFXqN2YoXz+JgkXJNsHASArMLCNAa7PTRpsDuc+mta89xVPcAXGEZgSyfA==
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr1788145ljb.52.1545151505903;
        Tue, 18 Dec 2018 08:45:05 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.83.43])
        by smtp.gmail.com with ESMTPSA id r1-v6sm3164680ljb.64.2018.12.18.08.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 08:45:05 -0800 (PST)
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
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <a7ec6634-fa56-9fa1-df22-3bbf786cb95a@cogentembedded.com>
Date:   Tue, 18 Dec 2018 19:45:03 +0300
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

[...]

> what follows is my booting log, FYI.
> ------------------------------------------------------------------
> [    1.625053] m25p80 spi5.0: s25fl129p1 (16384 Kbytes)

   Looking at the spi_nor_ids[], this chip has 0x01 in both byte 0 and byte 4...

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
> 
> That is, one command + read 4 bytes data + read 4 bytes data + read 4 bytes data + ...
> will get the incorrect data.
> 
> That's why RPC in manual I/O mode, driver only could do,
> one command + read 4 bytes data; one command + read 4 bytes data and so on.

   Yes. But the problem is you can't work around by reading 4 bytes at most
for the RDID command -- it has no address phase. Every time you "restart"
reading, you get bytes 0..3 again, like me. It seems that this approach works
for you only by chance...

> thanks & best regards,
> Mason

MBR, Sergei
