Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5F7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02FA206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="inFalKH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02FA206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeGQVC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:02:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44752 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730052AbeGQVC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:02:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so2449774wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sri9jvkr4KDnCPLSnmkHTRzP5cXSp3bapXF/dnGKv8k=;
        b=inFalKH/UDqoqtbOJS8lBLHD2RRU9OWnFQ86QZ6mA/q4IaHW29OLVmwRHC75LRX+/z
         jWfWmMwsIjDtvYgLtY2hdawAJqxWhZQik46RHcRx6k35mgKImY58SB+Rqe3DUoFj0PRj
         lTBPmmFjZauZDemYIxryVi334RaibfJktTZV/kUmLTIXrNMlT8+oE0yvLld+mg5Jx4PD
         BzebwMcZjILQCw2nTQcTrCJ6PVH4pWCgf3N07wkyZVtpFP1PYDxqZ7bg2qNDGkzpaPY2
         iTzz3Y1ARMVhVmF17+p2W1um9Bo46lgya05DoX2j4pvEfuMk1cIi5UDAdcP9hfDSCRb2
         q7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sri9jvkr4KDnCPLSnmkHTRzP5cXSp3bapXF/dnGKv8k=;
        b=jutAT0BZqRdnWxjMYcv/DrV8HghkWNdGupEkd26wdhMIG3rrHKx6CZr0sy+jc2W3hl
         KOaY5zsu5c2cwBtKuJ9/UWkHpkk888FX7mCGDhERdQu2KbF80ysMYWx91qUD5WtI3Ctd
         x3owFM00/GBj1M1ppQvBzDel9aHANv3CsP0TNqSEEr0eWNjCwJB5pPSjeEVY/3PJ2tao
         qA0bm3O0oHROtXt1QGYxSKZOuCLSA2FO5XE1Aj1cJPQb6I8TgSHvMDHCUmJdwGKU2Vlz
         nYsRAZX7KMpJiHoJTvxvpdHK1dPIrLVL1EEUMe5u5mCqdLeqEOrIQ7aMe1UWpLG/iV1d
         meAw==
X-Gm-Message-State: AOUpUlEchHJS91JLYyC0qHb35LAvqX1tvKAINho8eVdprkds8o/dqkoi
        B1SYbd4LuyAgi1cewXhwM7YixA==
X-Google-Smtp-Source: AAOMgpchAvUjJni6+xajA9PYXT8oqpF7lp1GR+MFZpq/V/8T95rQdPKX8t9iaXOdVngog1cyBQmGwQ==
X-Received: by 2002:adf:e78d:: with SMTP id n13-v6mr2435367wrm.136.1531859287699;
        Tue, 17 Jul 2018 13:28:07 -0700 (PDT)
Received: from [192.168.1.24] (LFbn-MAR-1-570-38.w90-118.abo.wanadoo.fr. [90.118.15.38])
        by smtp.gmail.com with ESMTPSA id r17-v6sm2694758wrt.44.2018.07.17.13.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 13:28:07 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] ARM: dts: am33xx: Add all fck timer clocks
To:     Tony Lindgren <tony@atomide.com>
Cc:     daniel.lezcano@linaro.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, aford173@gmail.com,
        drivshin@awxrd.com
References: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
 <1531773542-15736-2-git-send-email-narmstrong@baylibre.com>
 <20180717055547.GV99251@atomide.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwE0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAcLAXwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8g
Organization: Baylibre
Message-ID: <70f28466-fd13-58cd-cb5b-9857d7670d69@baylibre.com>
Date:   Tue, 17 Jul 2018 22:28:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717055547.GV99251@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 17/07/2018 07:55, Tony Lindgren wrote:
> Hi,
> 
> * Neil Armstrong <narmstrong@baylibre.com> [180716 20:42]:
>> Add the missing fck clock to all timer nodes of the AM33XX dtsi.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  arch/arm/boot/dts/am33xx.dtsi | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>> index 9cd62bc2..e8e665d 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> @@ -541,6 +541,8 @@
>>  			reg = <0x48042000 0x400>;
>>  			interrupts = <69>;
>>  			ti,hwmods = "timer3";
>> +			clocks = <&timer3_fck>;
>> +			clock-names = "fck";
>>  		};
> 
> These should all use the clkctrl clock nodes, see:

Even the already configured timer1 & timer2 ?

> 
> $ git grep CLKCTRL include/dt-bindings/clock/ | grep TIMER
> 
> The module clock is bit 0, and on some SoCs bit 24 is the
> timer fck. But I don't think these SoS use separate bit 24
> clock.
> 
> Regards,
> 
> Tony
> 

