Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Cn6mMnleHlt1MQAAmS7hNA
	; Mon, 11 Jun 2018 11:35:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A13D3607E4; Mon, 11 Jun 2018 11:35:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mtyBg5KM"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 85190601C3;
	Mon, 11 Jun 2018 11:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85190601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932923AbeFKLfS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:35:18 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:41584 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932765AbeFKLfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:35:13 -0400
Received: by mail-wr0-f175.google.com with SMTP id h10-v6so20014227wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 04:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=j8JODjuSu3T3DEJArbk/vq+3qRHcUEEDIt7/WSEYQms=;
        b=mtyBg5KMO0Y+vrNUBttszjVKYZ26yUkBUSXJiv0rOzG6pO/c8m5UWZTMsDq9pUC+B7
         y7TzXaEuEebdJDNHuS/4Bj43FhK8ymrOZEyB1Rd7e2r+4IKv9j87TgCay9hH+ISkapOe
         FH3HlgscTKEMY29dqj8DfgNrwxYGLz76uQ5J0xwYxF4fhk4N7CuVg3atq5OXxMlr2j4Z
         87irZBi0Rr2oQOyFwYZEsarj5J3cXxqGxPLg+rulAZiWhN5kGAnYSoT1iYKXhX2Y2BU5
         8lcJ9GwsdCOlQKXRQZxg9BeqnZOYhnOLho3owd23m2fmThjBsGfXMSpVz34G6R2tpd8U
         qzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=j8JODjuSu3T3DEJArbk/vq+3qRHcUEEDIt7/WSEYQms=;
        b=HUImd994EUQmQcwJ4RLKyJXTD0KffxEgdInG1ZUhXrTV5MygpyHceAoiQrmSzdNQIJ
         iTFtZfwxnYsJY9uKLZkyl/WncOAh5rqm6etfNYYlvBqj7ipBpynn0QVGQcH+bF/weHTw
         xiFWMelfzEL617YZV91IyiKWkvG7WAx6ELSTyAXt+EL193tA7x2zm0bxfIuIZUrAmwiH
         TFkeBqihbJiSyWsQllqooafDNefeE3Mdgq4jPUNxVlFXxuiMKby1YW/XfsPWSIKuzpaP
         J05yzAJWyCYmxqioeMwuJy9K4rygPscOFy9iInu8/ZrbzTGSyz7gsY2D4Gtfs8xOrj5D
         Nvgw==
X-Gm-Message-State: APt69E2AXieb4uxPVRC9QRnprqWViJTsvhhLHJTZJE8y4N5JgCxOwu5i
        PAXP/UUSYMiHHy1LMlCsp3+/+vBUHqk=
X-Google-Smtp-Source: ADUXVKLJUBscj2syzMKCMq5Hiqfeb6kiAkye+6f+a6FdowB6/pJNwjQpU1oOS36pVcs7Ssz8R5h3AQ==
X-Received: by 2002:adf:c4d0:: with SMTP id o16-v6mr12687465wrf.173.1528716912385;
        Mon, 11 Jun 2018 04:35:12 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s10-v6sm12591207wmb.12.2018.06.11.04.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:35:11 -0700 (PDT)
Subject: Re: [BUG] Pinning in pinctrl-meson-gxbb.c for uart_C is wrong
To: st6589@public-files.de, linux-kernel@vger.kernel.org
Cc: linux-amlogic@lists.infradead.org
References: <trinity-5eab4708-85af-4a10-911f-86b9afc2c0cc-1528711303734@3c-app-gmx-bs27>
From: Neil Armstrong <narmstrong@baylibre.com>
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
Message-ID: <fc5c1737-fa5c-8eed-2d75-539c9e4efc64@baylibre.com>
Date: Mon, 11 Jun 2018 13:35:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <trinity-5eab4708-85af-4a10-911f-86b9afc2c0cc-1528711303734@3c-app-gmx-bs27>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, "unknown user",

On 11/06/2018 12:01, st6589@public-files.de wrote:
> 
> Hello with the actuel Pinning definition in  pinctrl-meson-gxbb.c for the uart_c
> the system crashes when activated. The seams to be a depency with mmc driver for SD cards.
>  
> according to the comment here: https://forum.odroid.com/viewtopic.php?f=137&t=25373#p177855
> the seams to be an error in the amlogic datasheets regarding uart_c
>  
> with the attached patch everything works as it should.

Thanks for reporting this ans submitting a fix,
but could you sign with your real name and send patch as inline text only ?

Thanks,
Neil

>  
> Best regards
>  
>  
> ##
> #    https://forum.odroid.com/viewtopic.php?f=137&t=25373#p177855
> #
> --- linux-next-20180608/drivers/pinctrl/meson/pinctrl-meson-gxbb.c.orig 2018-06-09 12:03:58.921540445 +0200
> +++ linux-next-20180608/drivers/pinctrl/meson/pinctrl-meson-gxbb.c      2018-06-10 18:51:52.080665271 +0200
> @@ -198,8 +198,8 @@
>  
>  static const unsigned int uart_tx_c_pins[]     = { GPIOY_13 };
>  static const unsigned int uart_rx_c_pins[]     = { GPIOY_14 };
> -static const unsigned int uart_cts_c_pins[]    = { GPIOX_11 };
> -static const unsigned int uart_rts_c_pins[]    = { GPIOX_12 };
> +static const unsigned int uart_cts_c_pins[]    = { GPIOY_11 };
> +static const unsigned int uart_rts_c_pins[]    = { GPIOY_12 };
>  
>  static const unsigned int i2c_sck_a_pins[]     = { GPIODV_25 };
>  static const unsigned int i2c_sda_a_pins[]     = { GPIODV_24 };
> @@ -443,10 +443,10 @@
>         GROUP(pwm_f_x,          3,      18),
>  
>         /* Bank Y */
> -       GROUP(uart_cts_c,       1,      19),
> -       GROUP(uart_rts_c,       1,      18),
> -       GROUP(uart_tx_c,        1,      17),
> -       GROUP(uart_rx_c,        1,      16),
> +       GROUP(uart_cts_c,       1,      17),
> +       GROUP(uart_rts_c,       1,      16),
> +       GROUP(uart_tx_c,        1,      19),
> +       GROUP(uart_rx_c,        1,      18),
>         GROUP(pwm_a_y,          1,      21),
>         GROUP(pwm_f_y,          1,      20),
>         GROUP(i2s_out_ch23_y,   1,      5),
> 
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
