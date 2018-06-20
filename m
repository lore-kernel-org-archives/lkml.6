Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97667C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9C6208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mlWOLAmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9C6208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932545AbeFTIb5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:31:57 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33634 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932465AbeFTIbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:31:48 -0400
Received: by mail-wr0-f196.google.com with SMTP id k16-v6so2350047wro.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CAikuSFndMBVuJnohw9MxpLUs/ZKXgRPecMh41wuJ+I=;
        b=mlWOLAmKiVqnChWlO+ZFawB/j0q6EFXiOcCAWK1jo/H4FLYSXNemdOHduU4iBZrfjN
         d4EqY3itDLw+07f/6ufqXhy3po+ZwTMgssn+vCTNp2AZgBOsRaz8cYw/MVhDC8RpNyaD
         YE0kIocKnYMDKtjCe6pUGqui2zYfLmdZH8nxlbeX3020KEqL/8/kQNRKEFhDILP7bhlq
         Xj+KXLxP43untrvCR5VzhdqntoIB4cfB31GouNpZH9XmuSuBaqbW02SGGqOonDFjHnxm
         5xR7xwqvhT5+hEWlxfLRzwvjIA+9kLqVi645s5VAEIRjNB/TXQ1aHwZ6UWiLkR06aFHO
         pgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CAikuSFndMBVuJnohw9MxpLUs/ZKXgRPecMh41wuJ+I=;
        b=RFgzjUkZDyVpCdgoEEqdY8ZXxf9j59z9CLVrr+5VTxhbkllcl3hbjGhwPrVkEYHABX
         fuRt+UOqCLwz4R4yswQnalo/lSZKGq2QD16Zrq5zvY5ZAB2QlTmkZawcEjd9DiGGFoPT
         95m8yNbCe2jrQN4CBk8l+2SAFHK9XwAD2OOt0fYTJNnY4RaVZ9v7UhxCMrvx+Ylo6skQ
         yT6xZa2DKH6YIJEYyTkQLiVTgB4zZNtyuAlvBJycfFGaTbz1OthrxlpPr13hShbTVAvD
         K0N7Y8LG6tc7Td0ykueDynesyK15j+ZXtolLjCSvgzVVqfNeK7i4fN63eMi5qfi+7ltu
         yiXA==
X-Gm-Message-State: APt69E2pipO2/CoaoXB8rfh4AbIIayBA6yIjnEvcMUnGhvWch6QrhP5C
        urf+obhyoI6zRRgHfXlx1ZgFEU8VM8k=
X-Google-Smtp-Source: ADUXVKIBc5aZwASQL2Q0F9xH5MM3I/OaFjFfayn+jHJAl0SJHclD8kc3HEXhDKBPDlrpP51+/5NX7g==
X-Received: by 2002:adf:ad4c:: with SMTP id p70-v6mr15592661wrc.44.1529483506862;
        Wed, 20 Jun 2018 01:31:46 -0700 (PDT)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:7411:64db:cd3a:8490? ([2a01:cb1d:4ce:ea00:7411:64db:cd3a:8490])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2491566wrm.45.2018.06.20.01.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:31:45 -0700 (PDT)
Subject: Re: [PATCH] clk: meson: audio-divider is one based
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180619154753.12788-1-jbrunet@baylibre.com>
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
Message-ID: <e8898e54-24b1-ec77-1b08-390607640747@baylibre.com>
Date:   Wed, 20 Jun 2018 10:31:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619154753.12788-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2018 17:47, Jerome Brunet wrote:
> The audio divider is one based. This offset was mistakenly dropped from
> recalc_rate() when migrating to clk_regmap.
> 
> Fixes: 88a4e1283681 ("clk: meson: migrate the audio divider clock to clk_regmap")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/clk-audio-divider.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/clk-audio-divider.c b/drivers/clk/meson/clk-audio-divider.c
> index 58f546e04807..e4cf96ba704e 100644
> --- a/drivers/clk/meson/clk-audio-divider.c
> +++ b/drivers/clk/meson/clk-audio-divider.c
> @@ -51,7 +51,7 @@ static unsigned long audio_divider_recalc_rate(struct clk_hw *hw,
>  	struct meson_clk_audio_div_data *adiv = meson_clk_audio_div_data(clk);
>  	unsigned long divider;
>  
> -	divider = meson_parm_read(clk->map, &adiv->div);
> +	divider = meson_parm_read(clk->map, &adiv->div) + 1;
>  
>  	return DIV_ROUND_UP_ULL((u64)parent_rate, divider);
>  }
> 
Acked-by: Neil Armstrong <narmstrong@baylibre.com>

