Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF6C04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B3F20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="q1bEPuk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B3F20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388763AbeKXAvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:51:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53548 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbeKXAvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:51:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so8780815wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 06:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LLnyaHVW8COYgd0/8u6dpwIxIqSqz7iUPZozQJatSyI=;
        b=q1bEPuk3wwUl1E8u/nErOCdMUqGI2Wmz1R/kg7dqwZrsvh7sJKkL1gyIB3TE8XNjMJ
         N1Zefb+vpwP6h5uy+5riK980whzqNcsCWoO7Nqk7HTR+oZSK+f97lxMpFPhaJMaFNfEI
         2m3fH969b/tdaoaGxlE7xVroJKSinv9HVwqwbbL95DGqB0ZxIn+OkWN6byHRI36Ste8g
         1OHAExDFRH7yNbxEwe9HCRNTWPx4iXiCIx/QSZ7ySDQBQd7zEQnqkncAY7iAzTriZ8kr
         BbvKS9Fw+YDSkbdTH3VR5rl06/2BaqGCWWUDj/73eNF6KfQIWQsliUqhdfXuLoEWGBDr
         sYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LLnyaHVW8COYgd0/8u6dpwIxIqSqz7iUPZozQJatSyI=;
        b=A7txFWuvemKkq4pWTk1Gz6g/177Xh2qUp6fFoLto40sMYwBt6JL3OoI6s7A7tYcRvS
         AVDQfR7PCokLd11DrLvRA44Gx5QQexpxmhJJOKCIV6ZItBd/ZCi5N/PRCs9CUGrrJcHE
         JeIyemkQaw/6e+MVeZIFQhISBY2dctDiOFFoHdehZnabxiBW5QajC6REE3oFgKLJsT9k
         McnCGGkE8rJG5TL6nAyDMSYZTfqILlFzi8yioFE4idleE688LAhwvUAHloKoEX3pYu/v
         kOG/8272atTb4XAeju2CvRURd5UAgi8PjhpNfvenIAwoWyexogI1iUS00dW1RR8FXAPc
         TPgw==
X-Gm-Message-State: AA+aEWYdVL/FnFZZ7I36ehyf0mGdrmVL4pu/yYkhXnXSu8FIvW3CHZgm
        6TwXflR+j8CIA4NdVwO8D4UHwGwI1VdBJw==
X-Google-Smtp-Source: AFSGD/V6B+r8wHV1gvV3eleG/jkaTyIM3B4NxhiR9pfjya+S5M+WWBPpY1R+0CEMhU5ck0JDcQ94fA==
X-Received: by 2002:a1c:48c1:: with SMTP id v184-v6mr3399768wma.26.1542982015457;
        Fri, 23 Nov 2018 06:06:55 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n5sm25185648wrr.94.2018.11.23.06.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 06:06:54 -0800 (PST)
Subject: Re: [PATCH v2 2/4] clk: meson: clk-regmap: add read-only gate ops
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
 <20181122214017.25643-3-martin.blumenstingl@googlemail.com>
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
Message-ID: <46911a32-43bc-4fd8-b4bd-92fe934cecf8@baylibre.com>
Date:   Fri, 23 Nov 2018 15:06:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181122214017.25643-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2018 22:40, Martin Blumenstingl wrote:
> Some of the gate clocks are described as "just in case" bits in the
> datasheet. Examples are the ABP, PERIPH, AXI and L2 DRAM clocks on
> Meson8b.
> The datasheet suggests that these bits are not touched. The full
> explanation is:
> "Set to 1 to manually disable the [...] clock when changing the mux
> selection. Typically this bit is set to 0 since the clock muxes can
> switch without glitches.".
> 
> This adds new read-only ops for gate clocks so we can describe these
> clocks in our clock controller drivers while ensuring that we can't
> accidentally modify the registers.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/clk-regmap.c | 5 +++++
>  drivers/clk/meson/clk-regmap.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
> index 305ee307c003..c515f67322a3 100644
> --- a/drivers/clk/meson/clk-regmap.c
> +++ b/drivers/clk/meson/clk-regmap.c
> @@ -50,6 +50,11 @@ const struct clk_ops clk_regmap_gate_ops = {
>  };
>  EXPORT_SYMBOL_GPL(clk_regmap_gate_ops);
>  
> +const struct clk_ops clk_regmap_gate_ro_ops = {
> +	.is_enabled = clk_regmap_gate_is_enabled,
> +};
> +EXPORT_SYMBOL_GPL(clk_regmap_gate_ro_ops);
> +
>  static unsigned long clk_regmap_div_recalc_rate(struct clk_hw *hw,
>  						unsigned long prate)
>  {
> diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
> index ed2d4348dbe2..e9c5728d40eb 100644
> --- a/drivers/clk/meson/clk-regmap.h
> +++ b/drivers/clk/meson/clk-regmap.h
> @@ -51,6 +51,7 @@ clk_get_regmap_gate_data(struct clk_regmap *clk)
>  }
>  
>  extern const struct clk_ops clk_regmap_gate_ops;
> +extern const struct clk_ops clk_regmap_gate_ro_ops;
>  
>  /**
>   * struct clk_regmap_div_data - regmap backed adjustable divider specific data
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
