Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C78DC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6962133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDWWZi0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732804AbeLQNXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:23:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55823 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732643AbeLQNXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:23:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so12265257wmc.5;
        Mon, 17 Dec 2018 05:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o3RKV7a8GfhZBO/bLHPEQHHeePg/FOEC7DCrDXnsRi4=;
        b=sDWWZi0O2B6Ch+l6acCNEUSIr0xHea6aGXQ7W5gHnID/eGHbByNkFu9KncGa5A9SKo
         jRzpT8sBt+xGBanO9V6hfMmenrpycwd82adP42rrqUQZ0630TeUhlXcyAHzph/F29NzT
         2Z2o8Ang6TSwHMRLYQRb5enfY+LMkS0IN9KnUN/X7ZEaOw4nQ4zM+PRlf+OY8a+2wUYx
         lzC5tARN63kd2w67S5dwRsSnmbcjnMPLefHF7tR9zVNDBt/USBxPRscWDelJSct1mHm6
         JpSF3QNnhXciU0e7ZvlFHaKl9D1DlHhVJPnwlVKiMHrjfDQG7NQDzQq+79qx8vuLpy3B
         q7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o3RKV7a8GfhZBO/bLHPEQHHeePg/FOEC7DCrDXnsRi4=;
        b=TW1eahWlH28RMBU+LHLLX9L0IKFARXPPK+8XuZAY70r+w+a5jwi+RqAf85ZykQYIjs
         ILKcIK10/IWrTUsEYQFVsmjIOGw6HlGAMx7SfX2JaCSPQIoSwOx3BdVx7XQKgea0PqY0
         UcheEuAioL9MuWAWz9huEa/r9N0ZBY9vZJRtmPlgFElOiB6odX/PRJBaicurMGHCqUpe
         OdvR72/KfPP2TkebHckAP1NA3FBp5CICjvyR4E3k9yPXc6Ybxd+uSXv1fI62GdPZq+M8
         vVPoky4G73e8yrq9eQMFAIMffuz2tHTPrbu/CL3CycFcUEnuGwz5xWRUnom8Cj9Uagyt
         zItw==
X-Gm-Message-State: AA+aEWaZRMVnY7tkn8ToguBHCAK9g1Tl3EIuVX8exw/0hrY7jfVBzrYZ
        YO9F3LUqT2FYqRaBIjKX++k=
X-Google-Smtp-Source: AFSGD/XpYLCpZqCdu/rJbiqlAIIo0XqyDblAkAVlhKuUHTFDy1lDYPveNFc54jS3Eo9TTo0a5MWT6Q==
X-Received: by 2002:a1c:8d49:: with SMTP id p70mr12403337wmd.68.1545053011631;
        Mon, 17 Dec 2018 05:23:31 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id z17sm332895wrv.2.2018.12.17.05.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 05:23:30 -0800 (PST)
Subject: Re: [PATCH v3 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
To:     masonccyang@mxic.com.tw,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, zhengxunli@mxic.com.tw
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
 <1544181199-3373-2-git-send-email-masonccyang@mxic.com.tw>
 <557c8114-2819-7be3-21b8-02918aa89c04@cogentembedded.com>
 <OFAE786891.A102E46D-ON48258366.002779D7-48258366.002A5C36@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <a4c18176-783b-70db-4668-31cc332705a7@gmail.com>
Date:   Mon, 17 Dec 2018 14:23:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <OFAE786891.A102E46D-ON48258366.002779D7-48258366.002A5C36@mxic.com.tw>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/2018 08:42 AM, masonccyang@mxic.com.tw wrote:
> Hi Sergei,
> 
> 
>> > +static int rpc_spi_io_xfer(struct rpc_spi *rpc,
>> > +            const void *tx_buf, void *rx_buf)
>> > +{
>> > +   u32 smenr, smcr, data, pos = 0;
>> > +   int ret = 0;
>> > +
>> > +   regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
>> > +              RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
>> > +              RPC_CMNCR_BSZ(0));
>> > +   regmap_write(rpc->regmap, RPC_SMDRENR, 0x0);
>> > +   regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
>> > +   regmap_write(rpc->regmap, RPC_SMDMCR, rpc->dummy);
>> > +   regmap_write(rpc->regmap, RPC_SMADR, rpc->addr);
>> > +
>> > +   if (tx_buf) {
>> > +      smenr = rpc->smenr;
>> > +
>> > +      while (pos < rpc->xferlen) {
>> > +         u32 nbytes = rpc->xferlen  - pos;
>> > +
>> > +         regmap_write(rpc->regmap, RPC_SMWDR0,
>> > +                 get_unaligned((u32 *)(tx_buf + pos)));
>> > +
>> > +         if (nbytes > 4) {
>> > +            nbytes = 4;
>> > +            smcr = rpc->smcr |
>> > +                   RPC_SMCR_SPIE | RPC_SMCR_SSLKP;
>> > +         } else {
>> > +            smcr = rpc->smcr | RPC_SMCR_SPIE;
>> > +         }
>> > +
>> > +         regmap_write(rpc->regmap, RPC_SMENR, smenr);
>> > +         regmap_write(rpc->regmap, RPC_SMCR, smcr);
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
>> > +         regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
>> > +         regmap_write(rpc->regmap, RPC_SMCR,
>> > +                 rpc->smcr | RPC_SMCR_SPIE);
>>
>>    Hm... our flash chip (Spansion S25FS512S) doesn't get detected; it
> sends
>> JEDEC ID bytes 0..3 repeatedly, unless I copy the SSLKP logic from the
> writing
>> branch above...
> 
> Do you switch the SW1, SW2, SW3, SW13, SW31 and SW10 to on-board QSPI
> mode ?
> Because R-Car D3 Draak board default is booting from HyperFlsah.

So this puts us back to the original discussion -- the driver should
support HF mode as well IMO.

> what follows is my booting log, FYI.
> ------------------------------------------------------------------
> [    1.625053] m25p80 spi5.0: s25fl129p1 (16384 Kbytes)
> [    1.634391] 12 fixed-partitions partitions found on MTD device spi5.0
> [    1.642198] Creating 12 MTD partitions on "spi5.0":
> [    1.647598] 0x000000000000-0x000000040000 : "Bank 1 - Boot parameter"
> [    1.660893] 0x000000040000-0x000000180000 : "Bank 1 - Loader-BL2"
> [    1.671287] 0x000000180000-0x0000001c0000 : "Bank 1 - Certification"
> -----------------------------------------------------------------------
> 
>>
>> > +         ret = wait_msg_xfer_end(rpc);
>> > +         if (ret)
>> > +            goto out;
>> > +
>> > +         regmap_read(rpc->regmap, RPC_SMRDR0, &data);
>> > +         memcpy_fromio(rx_buf + pos, (void *)&data, nbytes);
>> > +         pos += nbytes;
>>
>>    ... and it skips byte 4 unless I copy the code from the end of the
> writing
>> branch, clearing CDE/ADE. But even then the byte 4 reads as 0x03
> instead of 0.
> 
> yup, I think this is some kind of RPC HW limitation,
> in RPC manual I/O mode, it only could read 4 bytes data w/ one command.
> 
> That is, one command + read 4 bytes data + read 4 bytes data + read 4
> bytes data + ...
> will get the incorrect data.
> 
> That's why RPC in manual I/O mode, driver only could do,
> one command + read 4 bytes data; one command + read 4 bytes data and so on.
> 
> But RPC in external address space read mode(here we call it direct
> mapping read mode)
> is ok for one command + read 4 bytes data + read 4 bytes data + ....

I think the U-Boot driver solves those problems, since it works in both
RPC and HF mode on all of Gen3 boards , not just D3 in non-standard SPI
boot configuration. Please take a look.

-- 
Best regards,
Marek Vasut
