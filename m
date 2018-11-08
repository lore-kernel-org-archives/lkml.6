Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E4EECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC902081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ooFIJ6Tw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC902081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeKHXDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:03:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41849 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKHXDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:03:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id v18-v6so1947293wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VBmJ+H/DtMNUawz/qfXA1yqEhZ+LVZ34IwBqCQkhJhY=;
        b=ooFIJ6Tw/sWYR3cFykbftDFBCh5FxyjGIivaWGeS3j0zLulT+X6DK2BW/y3SgXo0zH
         zz/Dr7dHBNBYrzpcVRT++/C5kyZw/yxDeJlgsOFHs0sfqFL3yoXTEKRImqULRdka+BA4
         Yv0Cg25IhyBAhS9NNHN2DGiu6UgARpQ3fd6bE8d95Sjef8QN3e8DMuFVrhO5fD3nmK5m
         csazwZ7cM/U7zmayrFtrMetfmcwh/1WHfGpedGYQzw789ptKjWs5COe9NOp18cvD1z1O
         D33NMaFVrG54MlsPzR9G1t3Rf0aOAVZigg0W0Gfenwl3OfJVF6uxC0hidmrrAPpiy9fd
         TgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VBmJ+H/DtMNUawz/qfXA1yqEhZ+LVZ34IwBqCQkhJhY=;
        b=WBak1q3wbdowqDQuKTb3C02QIWKymyjBNMywtD3ctPzJ96701Q4XijX+KfP37rDcrA
         B2UP8G84IGxKppumucB9bsSw6QsuQg0hFMBSeijJyS693WB5JSYwBG9hkcbQeYhrMUs6
         U6A7WgPjw2QxYKbQ+PnF9/Vy3mbmLDjyEeGjdnE9CNh8m1rXgRLW1uTgDsnzQFtIkHx0
         FXkPQ1g8nYpmRFdkfWST95PF+AJj/zk/xIGzi+c8ccnjZHzrx3MxK+ChzjijP002aKlZ
         lhAEelLmRdu6456KWA3KVcUZB4cAMdmeJb217p7bmeOOosdEx7X88JoseP1FmTSVIRb5
         AcxA==
X-Gm-Message-State: AGRZ1gJcMfbo0Wpvvp1DbRFXDdtsW+t++MZDqXtEkFe76aJruBhMHyAx
        /Mjl1/97MmjfIaXgxmj5OQGfdw==
X-Google-Smtp-Source: AJdET5fMOZ/IhWKGx1InOHLqIvLGskkeEmICQF44WiAme/ZQ4idsR58eV4PI9u42hT3sDoFMk5mjuQ==
X-Received: by 2002:a5d:5685:: with SMTP id f5-v6mr4023506wrv.113.1541683703377;
        Thu, 08 Nov 2018 05:28:23 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k66-v6sm4841601wmd.47.2018.11.08.05.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 05:28:22 -0800 (PST)
Subject: Re: [PATCH RESEND] arm64: dts: meson-axg: fix dtc warning about unit
 address
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>
References: <20181030150614.19461-1-jbrunet@baylibre.com>
 <20181108095156.26810-1-jbrunet@baylibre.com>
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
Message-ID: <1a0aa100-1d44-b2d1-178d-059e95debda1@baylibre.com>
Date:   Thu, 8 Nov 2018 14:28:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108095156.26810-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2018 10:51, Jerome Brunet wrote:
> section 2.2.1 of the DT specs says: " If the node has no reg property,
> the @unit-address must be omitted and the node-name alone differentiates
> the node from other nodes at the same level in the tree"
> 
> Simply replace the '@' with a '-' to fix this warning.
> 
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> 
> Hi Kevin,
> 
> I'm resending this change because I noticed the previous patch I sent had
> references to spdif input which has not been merged yet. This would have
> triggered a conflict in your tree.
> 
> Hopefully, this new version will apply correctly
> 
> Cheers
> Jerome
> 
>  .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 26 +++++++++----------
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  6 ++---
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> index 18778ada7bd3..ba44b0419404 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> @@ -60,7 +60,7 @@
>  		serial1 = &uart_A;
>  	};
>  

[...]

>  
> -	tdmif_c: audio-controller@2 {
> +	tdmif_c: audio-controller-2 {
>  		compatible = "amlogic,axg-tdm-iface";
>  		#sound-dai-cells = <0>;
>  		sound-name-prefix = "TDM_C";
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
