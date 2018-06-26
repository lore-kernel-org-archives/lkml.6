Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F19C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3750208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YheDxS9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3750208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932262AbeFZIJG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:09:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36305 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752529AbeFZIJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:09:02 -0400
Received: by mail-wr0-f194.google.com with SMTP id f16-v6so16226471wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 01:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=e5cuWqqWRNBRsnT/kpYyCj7huv/AQ5RQelCikvf4BsE=;
        b=YheDxS9AGwgeISGgsXolQMOr6sRqEhVvGr5ACkTMR0AiLXonJ3ZpcO2D/31+vsk34w
         ou2nzpApAzH21OmzaS7EOOkEY+8sQoN2hHLBTmIsBxnpSpdd7T41VD+ytPPZIJO1Q77K
         /aTYKl5HPSRfIKhnyaezVkUkXBsifq+6KxeUbp/DtU9ig7WaO2dOZlLq37FUy13IB3bl
         V2vujsGMnqcnZwfhea2EPAPE7nkT2FQOIsyzMx70xRt6+RB7PzgunM6vAoNu2frwFM65
         WImOjAXeJzWUNElDDNK8rSbortO1/o1NC1/9RwMr2GVTWhRG0+W+0EFLipPSendGBlKF
         M+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=e5cuWqqWRNBRsnT/kpYyCj7huv/AQ5RQelCikvf4BsE=;
        b=rsUZuHVickvGE/5c+za3zfxHdcd33RFfZuxQh5F7uVDfhNVc//XLQ4kEr83lVI07JV
         pafQmjXXn1MrGjKxdu2/7Y3RQh1qt3ssANV6ENnQUs/tkdkG4G1oPZGV6u+VBCZxGmRK
         j/qWi0/WHiywT1/lbnhhVAZ3W65ebQITT7fSOJcRYdZbUcocjZC98nFnISmqMIrxZMes
         0aQ04m3tMk46XEDAx9YLI/iXbfZaWyWYuRR86P/BArpztBN7drXWOpWdYCFL4e/Wf1Lz
         LKTgJ7sr4WXJEF6CjGkTtpBycuybHqv7Cfzz9wrMcL2k1ReDlAOgfpgiLMfXxds44CIP
         pCEA==
X-Gm-Message-State: APt69E0lsK28QnSpU8/Iso8vQ/61MTOqAzqQWMst/dKEqBqfdoTTZYDq
        VSesdU6i1dt1WX+KEF7/xi+KEG3srF8=
X-Google-Smtp-Source: AAOMgpecD3vEXUnOSC5gbF7fUBaC8K7uRR2QRjOw5K/zpmI3aRKAGHUE3qwKzl1vxRcTZmEI8R018A==
X-Received: by 2002:adf:ea87:: with SMTP id s7-v6mr492484wrm.150.1530000540737;
        Tue, 26 Jun 2018 01:09:00 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o13-v6sm967749wmc.8.2018.06.26.01.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 01:08:59 -0700 (PDT)
Subject: Re: [PATCH 1/2] clk: meson: stop rate propagation for audio clocks
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180620100610.29010-1-jbrunet@baylibre.com>
 <20180620100610.29010-2-jbrunet@baylibre.com>
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
Message-ID: <76edc9c1-8fd2-de0a-ea88-ebb037a4775c@baylibre.com>
Date:   Tue, 26 Jun 2018 10:08:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620100610.29010-2-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2018 12:06, Jerome Brunet wrote:
> It is actually a lot easier to setup the PLL with carefully chosen rates
> than relying on CCF clock propagation for this audio use case.
> This way, we can make sure we will always be able to provide the common
> audio clock rates, while having the PLL in the optimal operating range.
> 
> For this, we stop the rate propagation at the mux picking the
> PLL and let it round to the closest matching PLL.
> 
> Doing so, we can use the generic divider for the i2s clock.
> clk-audio-divider is no longer required. It was a (poor) attempt
> to use CCF rate propagation while making sure the PLL rate would
> be high enough to work with audio use cases.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/gxbb.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
[...]
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
