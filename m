Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4743C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E30424300
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WwQ8WjRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E30424300
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeGDO50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:57:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51843 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeGDO5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:57:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so6282144wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IAjvVXGuXgYs7VBT9aJzyTLgzE/+kC/E8HzZ0T7lzq8=;
        b=WwQ8WjRq7awvv/MC5CF299zMv7+6QmoyQHM4GEMb76Rpk8US4Z5klF8tJcOUVS0KDv
         +p+7xo0mOWqKDauZ3o2W6YaKrv9f3jTaPF/k10QOqgL4d8B2mFJkhrZuyb6jaG/DedrY
         rFSiA7q64sR1GhDqmquyNk75QJiNdOtBqfmwG+IVaDYHvTxvBgoabv0J6jOCrGZeET09
         hdJQkM+2HW5AXI3nN+Czhk/gUQA1ExxZBMs+iyaJv646m8SvxHukdw42mDln4kDYza+R
         ve9ykdttQT36gkwpTvy+4EYS1MPwa9ZT2/hWz4swGEQ8/HKPOCVUoxleAv28cBL225eh
         AKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IAjvVXGuXgYs7VBT9aJzyTLgzE/+kC/E8HzZ0T7lzq8=;
        b=Ink2xeO7Y8NPvM6sIXcRm+nOMZK2XT0zWeVAhxHmY6qE3yKNoTa7jexvgAU43fkyJu
         5PAhXxLNxbg/HzcWSd2ZT6le3H0XoSJPda61OAziWy+mIbz9K2JRCfBk7TelkdFkltjR
         lEslERldUT11kJG+PiLjdkTTnf9eMoOjqhOmM0YfaFJyksUidFrE0Cz7OBiDHALHi8q0
         M5gZC6dH8C7N7bZSPvqVLTfIni5HodjJFg3+cQSTCItF7DlLnEbz3+07/ml/VdyHyweW
         fj03BYFbnem7HVl7OLrqTECdSacpgqv2wGqjty2eup++CrFZXSwWGALXtm3F2udQdhis
         1NiA==
X-Gm-Message-State: APt69E2ItOzPYNB38Wmymq258sS4JNdLfhiMeb8rr2jTFIfM1uu7oec9
        45ZoSON+yLGahFNGCuJ6ujJx2A==
X-Google-Smtp-Source: AAOMgpcQwXvqZuZlQxKvKOjsfGd0XoO5Ex17NYkXOfelqtxeLSff+mIZ/ZvRSx6rtBtIDItlZN4LQQ==
X-Received: by 2002:adf:8f2e:: with SMTP id p43-v6mr1836203wrb.193.1530716242563;
        Wed, 04 Jul 2018 07:57:22 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8101781wmh.14.2018.07.04.07.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 07:57:21 -0700 (PDT)
Subject: Re: [PATCH 0/3] pinctrl: meson-g12a: add pinctrl driver support
To:     Yixun Lan <yixun.lan@amlogic.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20180704224511.29350-1-yixun.lan@amlogic.com>
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
Message-ID: <78da7e13-e80b-d714-86d0-7c5f6fc0d9f5@baylibre.com>
Date:   Wed, 4 Jul 2018 16:57:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704224511.29350-1-yixun.lan@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yixun,

On 05/07/2018 00:45, Yixun Lan wrote:
> This patch series try to add pinctrl driver support for
> the Meson-G12A SoC.

Thanks for submitting these patches.

Can you explicit this patchset with more details on the G12A SoC family ?
It's relationship with AXG and the differences in term of pinmuxing with the other SoC families ?

Why is there a GPIOE bank within the AO controller ?

Thanks,
Neil

> 
> Yixun Lan (3):
>   documentation: Add compatibles for Amlogic Meson G12A pin controllers
>   dt-bindings: pinctrl: meson-g12a: document pin name
>   pinctrl: meson-g12a: add pinctrl driver support
> 
>  .../bindings/pinctrl/meson,pinctrl.txt        |    2 +
>  drivers/pinctrl/meson/Kconfig                 |    6 +
>  drivers/pinctrl/meson/Makefile                |    1 +
>  drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 1432 +++++++++++++++++
>  include/dt-bindings/gpio/meson-g12a-gpio.h    |  114 ++
>  5 files changed, 1555 insertions(+)
>  create mode 100644 drivers/pinctrl/meson/pinctrl-meson-g12a.c
>  create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h
> 

