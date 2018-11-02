Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFBFC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A5620831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="wExw2RfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A5620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeKBXG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:06:28 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45342 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeKBXG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:06:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id d135so3078534qkc.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Bu+1Q9WrSOolr2QdaaXsuJYRQhCHIei9+2ATMxVv2wM=;
        b=wExw2RfWLLR2QkB+OTes1WlzhhZZDAr8HYRym8Sck7FOBvIyrcCLfS2b/6L93ONq0W
         AODXtVl5HDiC4Urh81/BsJJ0x58KDgRodVW4jMl3S84QBWnw76CWuAsNzJ8Gyw2GHDHT
         iKpl+YkVxA3FYPRnLLRQF1MBxJnlcHlorDOi+a2i3TaxP+h8JTJ5H0WdW8KEu6ScjvPL
         YxSGk2olirqTqp24VOxExVaO8+iXJ319L7oJS3+8aslUHy8qCsL3NmrxD2/jFLqSydrZ
         uKiZoeRVTjE0LjXlv/RzMs1dvHjrUkpM9+RyIs6vYRWX9r+QtliCfAu8vxQIhbgiIxGN
         RCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Bu+1Q9WrSOolr2QdaaXsuJYRQhCHIei9+2ATMxVv2wM=;
        b=f36lZw3usAoI/AOSmxQaN7J+1qBfZjgIxFnj+AyBh669UNx5p9w5EH14MTKCl0M6SV
         hQz+qHwKwuDF8kjTDEMDRWIKuwqOz6S7D6Ny714LYFy/USdYWw874ucUHYzWRyeGRdag
         z3ndLTERqnj27nUd9gnDxaz7eAKCLEjgCb9BR2zAFPi7j01yZgSNQ7PL4uvGHfIp1Q6F
         vXlcIgdCOD/z33LaEarLmZSiah8bj65MNh1wsj9cCVQpBy/A9OD/XyUJ2Bhk7kaZwXto
         Gu1iou+qp9CX++Nz8t1KWrGR3HduEZGXQT/PhPJBmOVhe7N6o8PQ1DrTcRBVZ8Y94Tg3
         FvGw==
X-Gm-Message-State: AGRZ1gLDXV1Q6CaH09bq89C+lxgZApdnAzbcEoAHSkZT42dN//+oPOWP
        j2ltYFmtn1A6lSwlCNeOTCz+Ww==
X-Google-Smtp-Source: AJdET5eCrei49gjbX/OXAy51rCTAwXkOyfUjj7mxWcn6e1kQi2TOaE1EE3skGUM2rnYfX2PV6jTqPw==
X-Received: by 2002:a37:404d:: with SMTP id n74-v6mr10936333qka.312.1541167152558;
        Fri, 02 Nov 2018 06:59:12 -0700 (PDT)
Received: from ?IPv6:2804:14c:81:942d::1? ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id 35-v6sm24226632qtu.69.2018.11.02.06.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 06:59:11 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] staging:iio:ad2s90: Make probe handle spi_setup
 failure
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
 <20181027020005.3140-3-matheus.bernardino@usp.br>
 <20181028164329.57162e06@archlinux>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Message-ID: <7e9048ff-186f-0ed3-35fc-4e8ffa595c70@usp.br>
Date:   Fri, 2 Nov 2018 10:59:06 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181028164329.57162e06@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/28/18 1:43 PM, Jonathan Cameron wrote:
> On Fri, 26 Oct 2018 23:00:01 -0300
> Matheus Tavares <matheus.bernardino@usp.br> wrote:
>
>> Previously, ad2s90_probe ignored the return code from spi_setup, not
>> handling its possible failure. This patch makes ad2s90_probe check if
>> the code is an error code and, if so, do the following:
>>
>> - Call dev_err with an appropriate error message.
>> - Return the spi_setup's error code, aborting the execution of the
>> rest of the function.
>>
>> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>> ---
>>   drivers/staging/iio/resolver/ad2s90.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
>> index 11fac9f90148..d6a42e3f1bd8 100644
>> --- a/drivers/staging/iio/resolver/ad2s90.c
>> +++ b/drivers/staging/iio/resolver/ad2s90.c
>> @@ -88,7 +88,12 @@ static int ad2s90_probe(struct spi_device *spi)
>>   	/* need 600ns between CS and the first falling edge of SCLK */
>>   	spi->max_speed_hz = 830000;
>>   	spi->mode = SPI_MODE_3;
>> -	spi_setup(spi);
>> +	ret = spi_setup(spi);
>> +
>> +	if (ret < 0) {
>> +		dev_err(&spi->dev, "spi_setup failed!\n");
>> +		return ret;
>> +	}
> I would have reordered this first to be before the iio_device_register call.
> The reason being that it would avoid this comment.
>
> Drop the return ret out of the block above and return ret unconditionally.
>
> I don't mind too much as I know this is moving later, but I only know that
> because of the earlier discussion ;)  Few reviewers read the whole patch
> set before responding to the early patches - it's just too much like hard
> work.  So if you can do things in an order that minimizes standard responses
> then that's great.
>
> Patch is fine though - could be solved by a comment in the intro that
> says the code in question will move in patch X.


Ok! As a newcomer I'm not sure about the right way to add this comment. 
Should I add it to the patch message or after the --- ? Also, how do I 
reference patch X? Just giving the number of the patch in this series?

An alternative to adding the comment would be to drop the return ret, 
and reinsert it in the next patch. Dosen't seem so good, to me, but 
would avoid the problem you presented. What would be better?


Matheus.


>
> Jonathan
>>   
>>   	return 0;
>>   }
