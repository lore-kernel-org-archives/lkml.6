Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC4EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55E621738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="nP2/frc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbfA1V2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:28:19 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39126 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfA1V2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:28:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so13008335lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 13:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sk4mAG1lHzNPlw59ceH9oPvLrkFmu3Kgpap5eZvVfeQ=;
        b=nP2/frc4pVreSzmRMUHZHfXzsNbmUrsFm69jx24YSDSfwfb7E+LMU0CAkBDFHMe0w0
         i5D3XlUQiScTWrtrO5ZromBDTqR0aM8h8R4/y+krblj8LY4hzrJ1bzrb9pNwpp1sTsbJ
         9AkR+pqOcDPwVAbNvfR/UgYCKmVGZgMZ48LSj7uNdQkeVxIIkrZIlEirlSAZFiJNRIYR
         EJ9kHF2vRjsQLp35OJMjzP+IM5oEVsf7tPCfZJ3C/6eT1LjIXfndpvu4wyGq+wsSv5is
         aJ7lwVf69knovM7uaWdbjmmMqc6BwdZkfrSjtRufO+hk4ZMwIUv2B8wRlWr4kbWru/H9
         j1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sk4mAG1lHzNPlw59ceH9oPvLrkFmu3Kgpap5eZvVfeQ=;
        b=E9yVWdfk0D98rvRoOD4p4jJWF0/YJnnGsTMw+WEQa2eaOYTrUVKU1bSf6Rad8exi+9
         Kwp3jJIIqhpPRWP2Yq9X2Celgp4SqSBtDhl1vo0zl9NKyEqmjCOD5PaB4QHz+X4VPo9p
         hcC9VPM9zlGbBft0HX187aG9WxJDSTst2iowBZIfFklkc259OPXDMWY9HbA0cXJjNggd
         21BOsQIlOPhVwoDcTrVHiQ8qgM7p6PuxT8KezFl38DxuLyr+qho1Box9aS2Ge3OVqVT0
         +6nLDcPzwigOI6NOtEGOQA/C3Yh9/9RZ48lXXQUbaGy1b8M72OqJLZL1F2irF2+joVeB
         LnuA==
X-Gm-Message-State: AJcUukdZEMzsUn2lpv0obdBYOz0hQoXTkkmtYwAyczfwLShDWjwsHm7/
        CdP0YXxARAS0A0kpgmjFoD7jAg==
X-Google-Smtp-Source: ALg8bN7in5jFaqDPkARrexfOWpmGzn4XK6rLKfYmCwSd8p+000Ifo8nqFekej0MthJsXtD5AfEAr7Q==
X-Received: by 2002:a19:cd50:: with SMTP id d77mr17800982lfg.125.1548710896678;
        Mon, 28 Jan 2019 13:28:16 -0800 (PST)
Received: from [192.168.1.169] (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id d2sm3214750lfg.16.2019.01.28.13.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:28:15 -0800 (PST)
Subject: Re: [PATCH v3 1/2] spi: support inter-word delay requirement for
 devices
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        lanqing.liu@spreadtrum.com
References: <20190126163220.26421-1-jonas@norrbonn.se>
 <20190126163220.26421-2-jonas@norrbonn.se>
 <20190128181038.GF11699@sirena.org.uk>
From:   Jonas Bonn <jonas@norrbonn.se>
Message-ID: <1b9807aa-3e6e-16f2-a2c2-ebe5e186d904@norrbonn.se>
Date:   Mon, 28 Jan 2019 22:28:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128181038.GF11699@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/01/2019 19:10, Mark Brown wrote:
> On Sat, Jan 26, 2019 at 05:32:19PM +0100, Jonas Bonn wrote:
> 
>> @@ -164,6 +166,7 @@ struct spi_device {
>>   	char			modalias[SPI_NAME_SIZE];
>>   	const char		*driver_override;
>>   	int			cs_gpio;	/* chip select gpio */
>> +	uint16_t		word_delay;	/* inter-word delay (us) */
> 
> This needs some code in the core joining it up with the per-transfer
> word delay similar to what we have for speed_hz and bits_per_word in
> __spi_validate().  Then the controller drivers can just look at the
> per-transfer value and support both without having to duplicate logic.
> 

So spi_transfer already has a field word_delay and it's defined as 
_clock cycles_ to delay between words.  I defined word_delay in 
spi_device as _microseconds_ to delay along the lines of delay_usecs.

Given that the inter-word delay is a function of the slave device speed 
and not of the SPI bus speed, I'm inclined to say that a time-based 
delay is what we want (to be independent of bus speed).  As such, I want 
to know if I should add word_delay_usecs to _both_ spi_transfer and 
spi_device?

There's only one user of word_delay from spi_transfer.  Just looking at 
it quickly, it looks like it wants the word_delay in 
SPI-controller-clock cycles and not SCK cycles which seems pretty broken 
to me.  Adding Baolin and Lanqing to CC: for comment.  Could we rework 
that to be microseconds and do the calculation in the driver?

Thanks,
Jonas
