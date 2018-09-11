Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD79C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD21D20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WPXiVj/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD21D20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeIKS0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:26:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50929 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeIKS0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:26:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so1009187wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9B56u2ld10zKwk/eyBtaYDTv7+Rg0xTskgSrHHVzWTg=;
        b=WPXiVj/kFHbHt3ouvgUCCz9k1csqfsIxFXVOHkLN4nDSqHS+D0z92PRz6b/Xk+j5Z2
         e8uizuA4RLFe0SzXlLjUmUlrQabb6WhcVVoIjVMVKK4mtUyLxHRV8/PrAoM0RRkWNzGP
         UsIuYD7l2vNEj5Jzq4TUF0uMc15dkUbK59H2gqLTzuyHaWqLATn8cOfSdxWiTBGwDkbg
         WjgBAfbDromGCwgKi0A2FDqPlNWX1p7SXEORJtI1x+e6Q/V/6gXVlU705yMiCYnZGcZO
         051wYd86Wp82pQqR/ZilLgsAA4vct7s8f8VTANy8ITOOKnZbZmsLp30HCFHjp9Px4rOk
         U2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9B56u2ld10zKwk/eyBtaYDTv7+Rg0xTskgSrHHVzWTg=;
        b=R84SKjVDHLM1/5gLox7QolhAOaZAp6vG272THY/NYNP0X9QK9gf9wbqKcA6aDMW2EH
         wPBiLBxzQckrc/+bsn6ErIpnb9LrxZMRY/8/0cm1DCPKotX7aDfVSV7pNmBBMYKQU2iT
         1eWUEsBBdHNpAJmHRLjY+gWvgx08coxw1SYIaZD1XDPKFnuQ/Zc+djkEoVvJ0RYuPDBQ
         2XKbs4mY5ovPLScavmvvFZ5YV4oLn0dPkGxXf6xH2yU8Lrnrl5WTKlpSUnkmF/plgh8W
         jxCN7X88mu4XIKk5gXOBfR/ZDzbm5NL1890rXn1MTAbe91W8UDpLFhplL6wL7OWIx2pU
         v2ng==
X-Gm-Message-State: APzg51D4hGnd/p0TTEPBIq2SgLTJ0k/qPFkuhrepwZiIY4dyVMD8oEva
        AmyWwDr/6fow5wJb0RYLLIeRDQ==
X-Google-Smtp-Source: ANB0VdaS+nYO3gJkyIYE/MNvhME/Jk3Gn6pwl0maVxaNPvRd9R51V4jFIyuFMuEnS86CecdKWVDRqw==
X-Received: by 2002:a1c:8ac4:: with SMTP id m187-v6mr1346784wmd.80.1536672443619;
        Tue, 11 Sep 2018 06:27:23 -0700 (PDT)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:10fd:4780:9fae:1ba3? ([2a01:cb1d:4ce:ea00:10fd:4780:9fae:1ba3])
        by smtp.gmail.com with ESMTPSA id 124-v6sm1709511wmk.20.2018.09.11.06.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 06:27:22 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson-axg: use the proper compatible for
 ethmac
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1536604750-32621-1-git-send-email-narmstrong@baylibre.com>
 <CAFBinCB2GAR7OKbiPM5DaiG-gdBvcOq7qo=97qK-Hi1LGnKQ8Q@mail.gmail.com>
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
Message-ID: <49e4640e-526b-0501-1909-92743bf5fa24@baylibre.com>
Date:   Tue, 11 Sep 2018 15:27:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCB2GAR7OKbiPM5DaiG-gdBvcOq7qo=97qK-Hi1LGnKQ8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2018 20:44, Martin Blumenstingl wrote:
> On Mon, Sep 10, 2018 at 8:39 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Use the correct compatible for the AXG ethernet mac node.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> I wonder if you should add a "Fixes" tag. apart from that:
> 
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 

Hi Martin,

I'm not sure when the dwmac changes has been merged, and anyway the only board upstreamed uses RGMII which has the same bits for the glue register.

Neil
