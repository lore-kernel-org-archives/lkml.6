Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4B3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B275520894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DoxZ24AK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B275520894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388746AbeHAMor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:44:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41401 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388641AbeHAMor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:44:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so19681074wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5RE9ZeDxOXrMIn7I+ZUIAl8SHSTHu7h9dphqsYHNgHg=;
        b=DoxZ24AKxDZdXCDiTjozvO7HK/XVCFm1TLI5CBqdaWfUsFLU1bj1BXINOcCUNWyEBl
         CBIAtxav7lp0Hux4bdIkTV0axMJiqns06mH8hswvKxJaC54cLpdDoGmBhj7qMdV0NXK2
         7ZLGGTpQC41lQNTIb0/HBXaIAMyl7n0seFNEEV0ICzqbPybgchegqGb/FGSZ5EdjOZ/6
         8N9URd0GRnX7gBKyckLdISIgXM6SRJJtsyIj+aFhnIXudfQ69RBTquQkmLAnEAhWri0O
         sOJ6KaKG32duxU8Ir4oSy12h6+W1mH+XXHOhloWngZ+viQflECqOaGbq3lvBXak5t7p2
         NW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5RE9ZeDxOXrMIn7I+ZUIAl8SHSTHu7h9dphqsYHNgHg=;
        b=uAVD806eHzbrPKnKz6Eyuufp1hpb/gb79IfPmrgEa9QEf4zPFq0oTZ33vVzeXLb924
         iyAOKVfvE+dYxFSOlMY+T0v1wRvuZDWpfNrODqVmX+SnWKAtVESayoa4fEjVZQHDW4W1
         0qEHWhKtzXPhtWeaPjXBQJMOKUmHk1yVplD4TtRQXRrqMB0fqO7yqgdJ0FHgjBgNdwIN
         eIVzAeRcz5n4NQR/DTf7h4TrAYmNlsL+xrgb/3p65wPCGfLEHRLLynL7agnLWpUF5w7C
         XI4tiiVD/5sCLOLV/SPMpbK4gDd9iIG/NaOelVdjitPyi045+6Zejqhhn7BSh3Mv5X83
         /Y2g==
X-Gm-Message-State: AOUpUlEgyomJOXZGXjyMxf2HoGeycpBZpfNYc+emTfHtgRLD8oV9pwFi
        MfHsJppvqhBYRk96HbAjWyVqJ6dbSQ8=
X-Google-Smtp-Source: AAOMgpeaDmojnHovNA7N9yg898P1YaJU5Q+C/EwSFR6LtNdv/vbAr41sJ2H9ubcaydfzklHB7LKTiQ==
X-Received: by 2002:adf:9b11:: with SMTP id b17-v6mr23708857wrc.119.1533121172641;
        Wed, 01 Aug 2018 03:59:32 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s9-v6sm4417480wmc.34.2018.08.01.03.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 03:59:31 -0700 (PDT)
Subject: Re: [PATCH] pwm: meson: fix mux clock names
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180801105720.23999-1-jbrunet@baylibre.com>
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
Message-ID: <75d87aa4-68b5-8182-f67f-5704e7b1bef3@baylibre.com>
Date:   Wed, 1 Aug 2018 12:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801105720.23999-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2018 12:57, Jerome Brunet wrote:
> Current clock name looks like this:
> /soc/bus@ffd00000/pwm@1b000#mux0
> 
> This is bad because CCF uses the clock to create a directory in clk debugfs.
> With such name, the directory creation (silently) fails and the debugfs
> entry end up being created at the debugfs root.
> 
> With this change, the clock name will now be:
> ffd1b000.pwm#mux0
> 
> This matches the clock naming scheme used in the ethernet and mmc driver.
> It also fixes the problem with debugfs.
> 
> Fixes: 36af66a79056 ("pwm: Convert to using %pOF instead of full_name")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pwm/pwm-meson.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 822860b4801a..c1ed641b3e26 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -458,7 +458,6 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
>  				   struct meson_pwm_channel *channels)
>  {
>  	struct device *dev = meson->chip.dev;
> -	struct device_node *np = dev->of_node;
>  	struct clk_init_data init;
>  	unsigned int i;
>  	char name[255];
> @@ -467,7 +466,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
>  	for (i = 0; i < meson->chip.npwm; i++) {
>  		struct meson_pwm_channel *channel = &channels[i];
>  
> -		snprintf(name, sizeof(name), "%pOF#mux%u", np, i);
> +		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>  
>  		init.name = name;
>  		init.ops = &clk_mux_ops;
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
