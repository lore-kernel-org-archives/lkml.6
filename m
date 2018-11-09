Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7FDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67C8208A3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xU8Mzu5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67C8208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeKITQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:16:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33290 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeKITQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:16:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id u9-v6so1171884wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3ZbqSxdml3QTkCXwac5TqMYHQRu/3YtrFQYtPR7qULU=;
        b=xU8Mzu5B0hZpc12nJg5Q8E71N3VsGzDYE/2nOsuxsFq4VTu+PP+gRm+w34S2Lk6XQJ
         b9O5nNbyW3BTlvW/tcJ5C1S1XicRU/vvHe7PE8aCZkIEj7g9m0phlZp2AFGDRWo8d7vt
         kaKzpwfSeP2wa9O/AlBtsX0cGk01Oti8ofHjpOqUnIithIyI5R9hKxep2LJocEB7YOdR
         mkZbiy9XR7be+CVHSF+aPTS5AnS7aBl9zFpuXkw5r4dQQsw958tIRRgh/erkEndBECYn
         nfAdEvMRg5uO5oi26fvXJv+6caRKaE9UWbbt2QpeRYut3PX5TdIPLdy+5gbFj/vYksQC
         IDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3ZbqSxdml3QTkCXwac5TqMYHQRu/3YtrFQYtPR7qULU=;
        b=ThZ4RR8DmlQnkZccqYNtxq0FO0yRr4BUyruhZ0RgSEPUuaH4dY7JRTBTobm3z69g+X
         4hXY3BdpiBqQYs1g4knJ2pIDS5ILkbB4SDM/TS1ytXE+n3F0MAvzK7OjyNpYY0+0Y/vJ
         L+zGn+RJMtVF3SzZ+nSeBQO2i0MobANka9+ZVdN7fVG9rGYz3P1l8GMe2A7rCOWdCziV
         mgtRvIicmixh6T48cZrHiwsqxUsTADgHn2HdB6g7I+V6457uGzG4UuskNwMOBg/HhY43
         ioQWFpE6yzaIfiQgCB+FZHOqjCUvRYnppW9LoKoT2RIzmceeoz5H8gfwwE6608tJnlgw
         oHCg==
X-Gm-Message-State: AGRZ1gJzuf1UZf/fSSeFtcA9NcSi1L5tZX4M3DAqXyvmCUZeRgh2GUsa
        f1A0an4rzi2R5KDqYh0kLcR6bA==
X-Google-Smtp-Source: AJdET5djIlw76MbBE6NBPocfrVJCA7SgPF4yL4MhGE6A2il+sPDphJWrqHDqQDPZTZ7P7OOnU+Pqkw==
X-Received: by 2002:a5d:45c3:: with SMTP id b3-v6mr7162610wrs.296.1541756226148;
        Fri, 09 Nov 2018 01:37:06 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r1sm7840650wrx.15.2018.11.09.01.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 01:37:05 -0800 (PST)
Subject: Re: [PATCH 1/4] arm64: dts: meson-axg: fix mailbox address
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181108135352.8459-1-jbrunet@baylibre.com>
 <20181108135352.8459-2-jbrunet@baylibre.com>
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
Message-ID: <3cf7c061-64b4-bd7a-88fb-0dea0caf7e01@baylibre.com>
Date:   Fri, 9 Nov 2018 10:37:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108135352.8459-2-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2018 14:53, Jerome Brunet wrote:
> MHU mailbox address is wrong. Fixing it enables the mailboxes on the A113.
> These mailboxes are needed for SCPI
> 
> Fixes: 9d59b708500f ("arm64: dts: meson-axg: add initial A113D SoC DT support")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 3cc0044d3468..ff8b3406aff6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -1067,9 +1067,9 @@
>  			};
>  		};
>  
> -		mailbox: mailbox@ff63dc00 {
> +		mailbox: mailbox@ff63c404 {
>  			compatible = "amlogic,meson-gx-mhu", "amlogic,meson-gxbb-mhu";
> -			reg = <0 0xff63dc00 0 0x400>;
> +			reg = <0 0xff63c404 0 0x4c>;
>  			interrupts = <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
>  				     <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
>  				     <GIC_SPI 210 IRQ_TYPE_EDGE_RISING>;
> 


Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
