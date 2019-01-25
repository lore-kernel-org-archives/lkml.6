Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE30C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0271C218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="P4ClB+f/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfAYMGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:06:50 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35830 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfAYMGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:06:50 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so6764733lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 04:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3cYCIZSGggjegfB+PSL5Q51gjaN/Du7lJ0QqMsFVp6k=;
        b=P4ClB+f/FtgMQvzeA6ajGY0R4urOZRN9GM2iGGFUagonOndg3jSN/Aj3hUpywE2DnT
         An5OuMz3JAzGDQGA8g/mokyQqKfgZgYeQfBQIeFuc/33OuDr6KmnS9KK4qQZSZAMTPrX
         4eGW9npi3fyvB2bfdBqPSK9ysCN7FQbFC9xltqfAwsFSHeCCDVEboMWfXC7umA25PoIy
         6tXORAABbpznH9+an2FnGrqrhvvaCbLbevmqtH973Z6gcrHWK0cmaBEiYHlWdTtY22/x
         wFMq6s7jLBbjuLw5LRCNKt+KtGlM03mIKU1TJetuIsdu8nsZXvWUKwtCUS5v5leA3XfI
         Kb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3cYCIZSGggjegfB+PSL5Q51gjaN/Du7lJ0QqMsFVp6k=;
        b=MvWHxnCyo+Sda6zTlj9e/Ani49JbCXgqcQx8kODSOQOh6aXLEA/NH/WecRE+Qm5pus
         DJsNA0Bhg8gqxHLPl/jppqKCXgz8Y8JF+o87t2AzZBA3vH6ptw1o+kNuTrDFBnenGVbd
         nd7CyQ9cmmGdm0fNY4JDPTOluTKP2HSLS45aa8EfqhRqw9fylcXIRmfeuHjDnhGkUxQQ
         i5fyfA6FtstrrP8ixuf3zAjeT3TapGX3923ZIoa4u1o1PClPJ7lHQS6Bt3GA8XfVtmYi
         9Wt7ne3o8EjdD6hp5vF9lCY8x6ymlsu7hrxiKod+WVIo/mHrb4XG4sIUqkK+xHeSWsaH
         XQaA==
X-Gm-Message-State: AJcUukcuGIVIBddVjJp7PglUNxrRTd5l1eXDlNILEI+0ahJoTwJ8feWi
        JLQnRpCT4Xspk1cNYjwsAI0Niw==
X-Google-Smtp-Source: ALg8bN5GP4kmWHzXw28j2GVUpv0NDSwH5tqDuQa+nPXWQrfFwAS0CUolRQbYD4G0NM5WodF+Fd3+EQ==
X-Received: by 2002:a19:a302:: with SMTP id m2mr9039772lfe.108.1548418006979;
        Fri, 25 Jan 2019 04:06:46 -0800 (PST)
Received: from [192.168.1.169] (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id t81sm1446940lfe.84.2019.01.25.04.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 04:06:46 -0800 (PST)
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
References: <20190125114429.20066-1-jonas@norrbonn.se>
 <20190125114429.20066-2-jonas@norrbonn.se>
 <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
From:   Jonas Bonn <jonas@norrbonn.se>
Message-ID: <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se>
Date:   Fri, 25 Jan 2019 13:06:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/01/2019 12:53, Baolin Wang wrote:
> Hi,
> On Fri, 25 Jan 2019 at 19:44, Jonas Bonn <jonas@norrbonn.se> wrote:
>>
>> Some devices are slow and cannot keep up with the SPI bus and therefore
>> require a short delay between words of the SPI transfer.
>>
>> The example of this that I'm looking at is a SAMA5D2 with a minimum SPI
>> clock of 400kHz talking to an AVR-based SPI slave.  The AVR cannot put
>> bytes on the bus fast enough to keep up with the SoC's SPI controller
>> even at the lowest bus speed.
>>
>> This patch introduces the ability to specify a required inter-word
>> delay for SPI devices.  It is up to the controller driver to configure
>> itself accordingly in order to introduce the requested delay.
> 
> Can we configure it at runtime by the device rather than at DT time by
> the controller? If yes, we already have a patch for this, please
> check:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eeaceb8b7d1fb64b6030249ca0dd1d902ef3069e
> 

It's a characteristic of the SPI slave, in the same sense as CPOL/CPHA 
are, and therefore it makes sense to specify it in the device tree.

Having this as device property rather than a transfer property allows 
this to be configured one time in setup() rather than having to fiddle 
with the configuration register for every transfer.

The two approaches are complementary.

/Jonas

>>
>> Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
>> CC: Mark Brown <broonie@kernel.org>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Mark Rutland <mark.rutland@arm.com>
>> CC: linux-spi@vger.kernel.org
>> CC: devicetree@vger.kernel.org
>> ---
>>   Documentation/devicetree/bindings/spi/spi-bus.txt | 1 +
>>   drivers/spi/spi.c                                 | 4 ++++
>>   include/linux/spi/spi.h                           | 1 +
>>   3 files changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> index 1f6e86f787ef..a5f20060676d 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> @@ -77,6 +77,7 @@ All slave nodes can contain the following optional properties:
>>                      Defaults to 1 if not present.
>>   - spi-rx-delay-us - Microsecond delay after a read transfer.
>>   - spi-tx-delay-us - Microsecond delay after a write transfer.
>> +- spi-word-delay-us - Microsecond delay between individual words of a transfer
>>
>>   Some SPI controllers and devices support Dual and Quad SPI transfer mode.
>>   It allows data in the SPI system to be transferred using 2 wires (DUAL) or 4
>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> index 9a7def7c3237..cd4d4065eca2 100644
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -1692,6 +1692,10 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>>          }
>>          spi->max_speed_hz = value;
>>
>> +       if (!of_property_read_u32(nc, "spi-word-delay-us", &value)) {
>> +               spi->word_delay = value;
>> +       }
>> +
>>          return 0;
>>   }
>>
>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
>> index 314d922ca607..e5200dd9d750 100644
>> --- a/include/linux/spi/spi.h
>> +++ b/include/linux/spi/spi.h
>> @@ -164,6 +164,7 @@ struct spi_device {
>>          char                    modalias[SPI_NAME_SIZE];
>>          const char              *driver_override;
>>          int                     cs_gpio;        /* chip select gpio */
>> +       uint16_t                word_delay;     /* inter-word delay (us) */
>>
>>          /* the statistics */
>>          struct spi_statistics   statistics;
>> --
>> 2.19.1
>>
> 
> 
