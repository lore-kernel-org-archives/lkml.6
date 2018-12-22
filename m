Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAA5C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7997E21A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="XtuXCt2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392386AbeLVRA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:00:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36259 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeLVRA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:00:26 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so7388812ljk.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7019Sbz7njJH0n6N7kMpSVDrD5qCKplfIPxBW6YEnpI=;
        b=XtuXCt2tBytD4sazfHietuU+HFD86Zbl6+0msw9Y8ON3Z4ZRCwma2vtwftMFYjFme1
         QYvRtzyEzoiduPZ6EGV72yhtC+dSVuYY/81Ht1D0tReWGxcu6Zd060TWYuy13fzmKlOG
         YYUNRxLI2Hc0VKh0ioTI0WGcKb9kL1SMchpwTnBCk1wbDJ+ZA3/h2T7mUmCYsjCTQ+vq
         nTB+yRk0Zmyv3f0uizCz8RvpsIrjwHYlbaGuCyKk8n1/xMJvRQNJV1WFyy8uJk9Tw/d5
         qbu0CMCwpgb/HB1ihTFO7h14bLEPbDrxsEYrUWwKwOrPgiaW4eEwOCOFHU0k/Bzus5Gw
         2xDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7019Sbz7njJH0n6N7kMpSVDrD5qCKplfIPxBW6YEnpI=;
        b=qKWE2WGr9wgs+vNJc2CtmrrZpXuN+R9uZfMXLXvAk3JZRNi4BUJv+G7gNdUQeuc3B7
         xEUK9HxUByRSpEI2qyGp7XCQlaCW8QIUefOskqfWjTvomDR13kALfdkiXyvUPEB/3qbO
         fMiPNQF7UuBKHC3icSRKRm01QloGCMEvBVH3VpkTl9yp/9qoOtPPvMF5MjL3Pj1Q2mna
         QaN7ivnAzE0B9dm2ADBiw8afGbTIULd+yG98BLXzqHaJx1q6Dx6aXzFo35S9BWimjCR1
         g9LEt5/Lx46oZP5IR73UFoNqrIrSfro4gqO7J1heSm/MhhErUbxYL+NKFf9lD0Cgp2Hu
         tJOw==
X-Gm-Message-State: AJcUukcOqqa2k+NFQdv9zOgOHnCdHXcxwKIzE26BZsKWnHICfQcUCwhv
        jgz9IMe/zqs+D9VqMzU7raVt9A==
X-Google-Smtp-Source: ALg8bN5ycwNrcKbbl07nFBwrfj0K6TNjqDLGsGuwymWQzF2cAGoUiQFsvbN+bvgtoD2UVCduTqOEPA==
X-Received: by 2002:a2e:55d3:: with SMTP id g80-v6mr4469298lje.78.1545488419164;
        Sat, 22 Dec 2018 06:20:19 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.87.178])
        by smtp.gmail.com with ESMTPSA id m77sm5383914lfg.3.2018.12.22.06.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 06:20:17 -0800 (PST)
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
 <c0a83699-05e1-26fa-ca74-ba6f0850cb7b@cogentembedded.com>
 <OF719DFBAE.D0F9F117-ON4825836A.0039EEA3-4825836A.003B28D8@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <908cd30d-10d9-a60d-8056-84924557bfbe@cogentembedded.com>
Date:   Sat, 22 Dec 2018 17:20:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OF719DFBAE.D0F9F117-ON4825836A.0039EEA3-4825836A.003B28D8@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/21/2018 01:46 PM, masonccyang@mxic.com.tw wrote:

>> >>> +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
>> >>> +               u64 offs, size_t len, const void *buf)
>> >>> +{
>> >>> +   struct rpc_spi *rpc = spi_master_get_devdata(desc->mem->spi->master);
>> >>> +   int ret;
>> >>> +
>> >>> +   if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
>> >>> +      return -EINVAL;
>> >>> +
>> >>> +   if (WARN_ON(len > RPC_WBUF_SIZE))
>> >>> +      return -EIO;
>> >>
>> >>    Why not write 256 bytes and return w/that?
>> >
>> > in manual 62.3.13 Write Buffer Operation,
>> > transfer size to device is 256-byte unit.
>>
>>    Why not write 256 bytes max and just return 256?
>>
> 
> ?
> I don't get your point.
> 
> here writes 256 byte each time and return 256 (len).

   I mean not aborting the requests for >256 bytes right away (like you do) but
write only 256 bytes and return 256, not -EIO.

[...]
>> >>
>> >>> +      for (i = 0; i < xfer[1].len; i++)
>> >>> +         rpc->addr |= (u32)((u8 *)xfer[1].tx_buf)[i]
>> >>> +               << (8 * (xfer[1].len - i - 1));
>> >>
>> >>    Ugh, you need get_unaligned_*()...
>> >
>> > for accessing a single byte quantity, ((u8 *)xfer[1].tx_buf)[i] ?
>>
>>    Ugh, never start a new line with an operator, lease it on a 1st,

   Sorry -- leave, not lease.

>> broken up line.
> 
> okay, patch it to:
> 
> rpc->addr |= (u32)((u8 *)xfer[1].tx_buf)[i] <<
>                  (8 * (xfer[1].len - i - 1));

   OK, thanks.

[...]

>> [...]
>> >> > +err_put_master:
>> >> > +   spi_master_put(master);
>> >> > +   pm_runtime_disable(&pdev->dev);
>> >> > +
>> >> > +   return ret;
>> >> > +}
>> >> > +
>> >> > +static int rpc_spi_remove(struct platform_device *pdev)
>> >> > +{
>> >> > +   struct spi_master *master = platform_get_drvdata(pdev);
>> >> > +
>> >> > +   pm_runtime_disable(&pdev->dev);
>> >> > +   spi_unregister_master(master);
>> >>
>> >>    No spi_master_put() here?
>> >
>> > put_device() in spi_unregister_master().
>>
>>    Why call spi_master_put() in the probe() method's error path?
>>
> 
> called get_device() in spi_register_master() !

   Hm, this is somewhat asymmetric...

> thanks & best regards,
> Mason

[...]

MBR, Sergei
