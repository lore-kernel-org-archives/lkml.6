Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A9FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FA42083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7OVJuS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FA42083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeHaQGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:06:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38484 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaQGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:06:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so5077824wmi.3;
        Fri, 31 Aug 2018 04:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4KOS0mLx+FT5cbe+p8xosn1lWfoGzXaOhgGKXjKq2JI=;
        b=i7OVJuS9BVvQD9hRrwL07SRfO8xx0EgoelDYhwCYAQdvRpvREUg+OjzAeYYiEQDNhh
         tvkG9DcofAqI9glhAxi8VzMRB+YUfIv9PkWMvFjIkJsq8xGcMvNzRIAH6xQSSUsQO4JI
         2G7UDr4ubgTg+EESDr+qviSxTpX95tz43pAdS76WmvqcSnvvcHI6vJrvrrvXkyJY7egf
         /6mihptt8tYREpVeHnPgG8p7f/WZd87iW/VbqFW7+mN8vKtorj73eC3YbvacBZOBLpi6
         He4FM2ZblqFwRpRntVDO/7LRRffsEhpdtnKtxWvSWNdjnL5N7wldb6ot/g6OGg0RYgVr
         8ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4KOS0mLx+FT5cbe+p8xosn1lWfoGzXaOhgGKXjKq2JI=;
        b=Oy6YqF8V/GJqngSTMY8tyInGzaAT1FU6wotKhX42h1Vft628X5pXsfLCSlnxL1wmvM
         86C14h8GSplIxv6kl6EkzsOYhnJrByKhHTa0Q0XgKuET9+L/tUQkZkvT8GpedQfGd3DT
         46t8jhTeEYY1t/biq3TK/jwlPcl1RkIGQ/+EeZevcM63G+m4GQLOs/+2mthhb9WXkVKg
         mDAUx3+9vobjuDkj8fdBWqEQZqzKjx8L6XRrDVF9Mg5nhqAmBbUK7Ih5B7NsTKutH4kS
         /WHiwmm1o88TzD4ebsZViWjGwhI94DJAL2Vmqz6GeNNiGspDsfQ/ZyL4Tb5fk/DC6eIw
         lyLQ==
X-Gm-Message-State: APzg51BbSAD6SY0LhU+/ny0Fyz4m+LjPnhQs+54P/Lhy8VvMV3Nmj04/
        21p5lRfFP95FRAKPPWQCSig=
X-Google-Smtp-Source: ANB0Vdb0L0sd6zRwsOI5J4WKlQ9riVTTrxvfzua6RqpoVsn66QOVo8bymdoNF0F6YH9VvQBKIvPfqQ==
X-Received: by 2002:a7b:c017:: with SMTP id c23-v6mr4637510wmb.136.1535716734976;
        Fri, 31 Aug 2018 04:58:54 -0700 (PDT)
Received: from [134.60.170.20] (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id o33-v6sm15996952wrf.11.2018.08.31.04.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 04:58:54 -0700 (PDT)
Subject: Re: [linux-sunxi] Re: [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio: add
 support for H3 thermal sensor
To:     icenowy@aosc.io, Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     mark.rutland@arm.com, geert+renesas@glider.be,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        linux-sunxi@googlegroups.com, clabbe.montjoie@gmail.com,
        pmeerw@pmeerw.net, lee.jones@linaro.org, lars@metafoo.de,
        quentin.schulz@bootlin.com, linux@armlinux.org.uk, wens@csie.org,
        devicetree@vger.kernel.org, arnd@arndb.de, vilhelm.gray@gmail.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        rdunlap@infradead.org, arnaud.pouliquen@st.com,
        linux-kernel@vger.kernel.org, lukas@wunner.de, knaack.h@gmx.de,
        eugen.hristev@microchip.com, jic23@kernel.org
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-22-embed3d@gmail.com>
 <20180831091137.wkbbipssyd6mqfbt@flea>
 <f01ec2f202c7e2e5a7e0c822b2f9a8f0c55a9ea4.camel@aosc.io>
From:   Philipp Rossak <embed3d@gmail.com>
Message-ID: <247ac301-0f33-29d1-ead4-d76f54a226f9@gmail.com>
Date:   Fri, 31 Aug 2018 13:58:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f01ec2f202c7e2e5a7e0c822b2f9a8f0c55a9ea4.camel@aosc.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.08.2018 11:51, Icenowy Zheng wrote:
> Personally I suggest to leave out all SID or calibration related
> patches here.
> 
> Currently we seems to be wrongly converting SID to big endian, however,
> the orgnization of the THS calibration data on H6 shows that it's
> surely little endian:
> 
> It consists a temperature value in 1/10 celsuis as unit, and some
> thermal register readout values, which are the values read out at the
> given temperature, and every value here (the temperature and the
> readout) are all half word length.
> 
> Let the temperature value be AABB, the two readout values be XXYY and
> ZZWW, the oragnization is:
> BB AA YY XX WW ZZ ** ** .
> 
> When converting the SID to big endian, it becomes:
> XX YY AA BB ** ** ZZ WW ,
> which is non-sense, and not able to do sub-word cell addressing.
> 
> Maxime, should I drop the LE2BE conversion in SID driver? (I doubt
> whether it will break compatibility.)
> 
> Philipp, could you delay to send any code that uses SID?

Yes for sure! I will move the related patches to the end of the series 
and add a DO-NOT-MERGE flag in the title. So I can get those also 
ready/reviewed but not merged.

Icenowy, do you know more about the A83T SID? From the general specs it 
could be the same like on the A64 or the H3.

Thanks,
Philipp
