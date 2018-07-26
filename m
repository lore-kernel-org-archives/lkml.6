Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E1CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC8A20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="A27c8wip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC8A20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbeGZQle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:41:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41930 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731094AbeGZQld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:41:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so2109042wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:cc:references:to:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=i0JCGGgM9Y04wbye7R8nl4VP0v0oFMsd/MLiwmnIYro=;
        b=A27c8wip2XLhQbBMFbXd4NIMfkrMd92DLHlj38rrCYFI2zo+5typ410dXZxeuIVbCa
         JrnvgixbbA7iSsAwxT06mViZYoRmc17p/NElnexykethCc1M7xi9QWtavjRhSHPAR1H7
         kIIXLYVUvxE6Cglc7V1Rkq7RfJxxBzaac4Edr0y7hNH62pAc+iY3AlymafHVwquG0T86
         49dJu+aXIKSvbKmS8d3GyOVaCgK/f/YdTz28YMH45IVbu88zwLtOzGBTUBg8dbNY09Vi
         u3UY/B3chujCv3f3cfc+imOvXC79cy7dotUzYcUmKxRtkoFLB69T2M/ipc/uyKYrGhVC
         E+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:to:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=i0JCGGgM9Y04wbye7R8nl4VP0v0oFMsd/MLiwmnIYro=;
        b=QOpQKOEdP0PfNTM4RO7Q1HSlmSbXHWsPbTSuKdIflInVJIOINh6JiGl0o6s663PA2p
         MHAwrmqvIe26tyTMeL2s6Xm/xXVEuWjQ3KSINPHp9LEwqwDSqbzejXQcLL+ukTTH50jJ
         RQCU5/HOIN+i7nLp7ZwHeNHbxQkGJ54nstZnML4wk+mNK95t7Cm3fkl2rSFTzbo8fmFd
         CQZYqV1WZ6Am54b7MyidH+KVLFUu7FYHS8dr4/DSL3bCkTqlB/93Irm6xEM8x1T0ZV3d
         ZGp6uIgXYoGeP4JeUjeUKMqNxn5pnBJet/VaoyZ4eWHXwbVyTDbQlnrU8yQtFU6W3akd
         Aydw==
X-Gm-Message-State: AOUpUlHBnXbAacBg3eFwGIWHwYCqUUucHeXNyCuIyi2vhEJRhGBAL7LI
        Ne3u3KtGtnk+AH28kyQOrny+I+YmY2M=
X-Google-Smtp-Source: AAOMgpdzYkYq9Y+zCZ8ijLw/bMcMDeGpaqFf8q+OtuCmJ1KSKnj1i7nl15fKyM1VnYNIqqv7X9OngA==
X-Received: by 2002:adf:ad45:: with SMTP id p63-v6mr1900306wrc.222.1532618651673;
        Thu, 26 Jul 2018 08:24:11 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r12-v6sm1554080wmc.27.2018.07.26.08.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 08:24:10 -0700 (PDT)
Subject: Re: [PATCH] clk: meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL
Cc:     jbrunet@baylibre.com, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1528892421-12180-1-git-send-email-narmstrong@baylibre.com>
To:     stable@vger.kernel.org
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
Message-ID: <5153040b-1f38-a17a-d78d-fec833c1c223@baylibre.com>
Date:   Thu, 26 Jul 2018 17:24:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1528892421-12180-1-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stable Team,

On 13/06/2018 14:20, Neil Armstrong wrote:
> On Amlogic Meson GXBB & GXL platforms, the SCPI Cortex-M4 Co-Processor
> seems to be dependent on the FCLK_DIV2 to be operationnal.
> 
> The issue occured since v4.17-rc1 by freezing the kernel boot when
> the 'schedutil' cpufreq governor was selected as default :
> 
>   [   12.071837] scpi_protocol scpi: SCP Protocol 0.0 Firmware 0.0.0 version
>   domain-0 init dvfs: 4
>   [   12.087757] hctosys: unable to open rtc device (rtc0)
>   [   12.087907] cfg80211: Loading compiled-in X.509 certificates for regulatory database
>   [   12.102241] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> 
> But when disabling the MMC driver, the boot finished but cpufreq failed to
> change the CPU frequency :
> 
>   [   12.153045] cpufreq: __target_index: Failed to change cpu frequency: -5
> 
> A bisect between v4.16 and v4.16-rc1 gave the 05f814402d61 commit to be
> the first bad commit.
> This commit added support for the missing clock gates before the fixed PLL
> fixed dividers (FCLK_DIVx) and the clock framework basically disabled
> all the unused fixed dividers, thus disabled a critical clock path for
> the SCPI Co-Processor.
> 
> This patch simply sets the FCLK_DIV2 gate as critical to ensure
> nobody can disable it.
> 
> Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>


This patch hit linux master with commit id c987ac6f1f088663b6dad39281071aeb31d450a8

Could this be backported to the next 4.17 stable release ?

Thanks,
Neil

> ---
>  drivers/clk/meson/gxbb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index b1e4d95..0e053c1 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -511,6 +511,7 @@ static struct clk_regmap gxbb_fclk_div2 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_names = (const char *[]){ "fclk_div2_div" },
>  		.num_parents = 1,
> +		.flags = CLK_IS_CRITICAL,
>  	},
>  };
>  
> 

