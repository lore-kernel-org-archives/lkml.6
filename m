Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1577C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6208218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="N2QHYwHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfA2O4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:56:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35543 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfA2O4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:56:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so14844279lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 06:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YtmDmx4hF7yUv9PZ4nol91PQCpWWisMGSSBsX/os2+8=;
        b=N2QHYwHjj9U1Wh04zqHIe3EW9H8HfQwmSullR+DHw7bbzKnhuK2K+0s8dzkEOUd2ma
         S7eFATRyL7g3Yau1HPrm11eF3rdnEITmYq+4Qa0ke9ygGpMF/eR2jXA4ERwHZ70DCCFv
         VWyECTjPnXoUzXELtmpE283atZP0yEG19z2tZ4kmCFs0/gzw1dCzehHi0MWd+QbGjvvV
         dgcmyHJLCntRGKyuEinerpyR9nYswRt3H9YBg/M1eEWCHJUiLc1fwISZmI3RCMGkVAaF
         tC+VOLwPtjNuEdUrdQsQxpC+keYzY/3fXRMg1SNucde/MIk6vy/CARgRBD9xSgNmWNHQ
         JDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YtmDmx4hF7yUv9PZ4nol91PQCpWWisMGSSBsX/os2+8=;
        b=WNci0xubQT6RbghQkHRTNWmlJZ2FlNXMlICuMocwe7Xf7+8CHrQuQPfqDxtDRKfg5i
         4rm+Zun30Gn/1qipAEI5dVgojL7c5nQWNBC15hzlTrGAhuiiEN100auKFxUes2yGV6aD
         ZNuI5r/IWfl38CzvgDy6fYnj+jeV01psjwIZfZkA+TTaYz2vJN+afkg5UBrO5gONICCW
         HQ50DZNFxSruD6uql9EGpTs7b/to0f/uSZb4AnPv3ZJhe/xdjVHCA1hOFGMXnvTSzl+s
         pNU60TcJWwfILVXMwXVAz8BggzxeRD7BYeMt3gqyjujmhiUd8BRaCEomReXcknEADdFD
         pVNw==
X-Gm-Message-State: AJcUukfOwQcDJSSibjby9fw9lKZDxSBI4ipv4QobL4lMkGkjqufAA6FP
        rDqKPEJtzlceglfqu0adsYQv5A==
X-Google-Smtp-Source: ALg8bN6oDCwGX67Kvm6xb9k3EUdbs+5+I74YZEN+oGHSzrNQIKdeJUC6TUDTR2Yyz+H5jaob8t5DqQ==
X-Received: by 2002:a19:41c4:: with SMTP id o187mr20236759lfa.32.1548773793484;
        Tue, 29 Jan 2019 06:56:33 -0800 (PST)
Received: from [192.168.1.169] (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id m10-v6sm3553378ljj.34.2019.01.29.06.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:56:32 -0800 (PST)
Subject: Re: [PATCH v4 2/2] spi-atmel: support inter-word delay
To:     Nicolas.Ferre@microchip.com, linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tudor.Ambarus@microchip.com
References: <20190129083844.20572-1-jonas@norrbonn.se>
 <20190129083844.20572-3-jonas@norrbonn.se>
 <995b3885-254b-7932-8d05-77271a2c070d@microchip.com>
From:   Jonas Bonn <jonas@norrbonn.se>
Message-ID: <7a6efd1a-5920-60e5-bc68-dfbe6866e522@norrbonn.se>
Date:   Tue, 29 Jan 2019 15:56:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <995b3885-254b-7932-8d05-77271a2c070d@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/01/2019 15:27, Nicolas.Ferre@microchip.com wrote:
> On 29/01/2019 at 09:38, Jonas Bonn wrote:
>> 
>> +	/* DLYBCT adds delays between words.  This is useful for slow devices
>> +	 * that need a bit of time to setup the next transfer.
>> +	 */
>> +	if (spi->word_delay_us) {
> 
> Well...
> 
>> +		csr |= SPI_BF(DLYBCT,
>> +			clamp_t(u8,
>> +				(as->spi_clk/1000000*spi->word_delay_us)>>5,
>> +				1, 255));
> 
> ... why not simplifying to:
> +				0, 255));
> and remove the test altogether, after all?

Hmm... that seemed too easy!  This started out as something else and 
looking at it now I think even the clamp_t() is unnecessary.  The value 
is already 0-255 and the way SPI_BF works any overflow is already 
truncated...  I'll rework this and resubmit once I get some feedback on 
the word_delay_us bits.

Thanks,
/Jonas
