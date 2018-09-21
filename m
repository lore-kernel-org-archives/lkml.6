Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD27ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED87A2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ClTshHBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED87A2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389264AbeIUOZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:25:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37707 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUOZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:25:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so11985377wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 01:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sqoyH7q2r/O9v7qfqusOrTx9qOXnxbveVNRvJUurRvI=;
        b=ClTshHBOOd6UCliyiFL0rP3GjKAcOAD9qDQ+lv7cc9uJi76O6wKWfX5sbsj/otx5EP
         tNyLbHccI8ybWNtdd3/lBMMs8ectfkIT64lvH/BOYk+ukDAjyc2wIzZqr3RFkeyXVcpc
         Nj1K2byHrriAWJhhBzvvUXoJyYK3gqqC7y5AgwfycCIB/k6PZQl8Ui076obgf6Z+BiAX
         jP0IyrwEyFOpDImEumXLdKtH6vP3wuDbZbWgtvlerTOs+1/VLtg/0shhx1oQbopqtvk5
         iLLQOWxeB9yZVXI/dUHcFfcnmMP11n7D3/CT16qlwkPyM/8MwZBl0CeE7UilQnAgKekh
         ntmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sqoyH7q2r/O9v7qfqusOrTx9qOXnxbveVNRvJUurRvI=;
        b=IuG0uUbulKtdM9Pa6Ylqqjwk7gUy8+MziOfj3SpbbAJ10H4REYvSpfI0uz6ltauqKG
         H9TZ0f3CDP1KXDQheSL5ifAutXFz1QOlzeXiDHMnMcvLL07317wqcohznNGHAclZKNj4
         g2CxJf0uetHoN8jngyYzkjfBbWEs+B0zyywDhgjICjATQJFdZpvt7fIfejeQij8N0sWe
         PGvQkLHsXO4O5fJgw5xG+TVjJ56VzxvRUUtjoMn4t2srBlNHI8f/JJgdJJdxY1fKgWV0
         t2g1iRfH3a+nojzpsdaulShN8pe6sogxl+sVTMru5otsLMlEwZHQViPfIA8+3SqWoK8s
         htqA==
X-Gm-Message-State: ABuFfoif+XP/sAKnvQWTztNXrfhN8ITL3TeltEsxVe+vRM+vEXx4MMbt
        SSa39uIWFLjghW4q5eYQhliqfiIin1I=
X-Google-Smtp-Source: ACcGV62ANvuZbXOTAofx+CX002wBpmGztCCqWrgYjkQhoZNR+1s2BxLbDKoAVg6592hlKkg/v1Lokw==
X-Received: by 2002:adf:ce0e:: with SMTP id p14-v6mr6506045wrn.118.1537519086088;
        Fri, 21 Sep 2018 01:38:06 -0700 (PDT)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:6c78:1f23:6bb3:14f6? ([2a01:cb1d:4ce:ea00:6c78:1f23:6bb3:14f6])
        by smtp.gmail.com with ESMTPSA id k63-v6sm9971852wmd.46.2018.09.21.01.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 01:38:05 -0700 (PDT)
Subject: Re: [PATCH v5 0/2] arm64: dts: meson-g12a: Introduce new DT files for
 Meson-G12A SoC
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        linux-kernel@vger.kernel.org,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jian Hu <jian.hu@amlogic.com>, Carlo Caione <carlo@caione.org>,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
References: <1537518881-53137-1-git-send-email-jianxin.pan@amlogic.com>
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
Message-ID: <33ef5ede-63f4-c58f-4057-0841f0d2aca5@baylibre.com>
Date:   Fri, 21 Sep 2018 10:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537518881-53137-1-git-send-email-jianxin.pan@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianxin,

On 21/09/2018 10:34, Jianxin Pan wrote:
> This attempt will try to add new DT files to support Meson-G12A SoC.
> 
> 1) first, Please notice that, in this patch series, the DT node about 16M reserved
> memory for hwrom is removed, since it's not needed by G12A SoC.
> 2) second, the pclk for uart_AO need to be fixed once G12A clock_ao driver is
> merged. In this version, it rely on bootloader to enable the pclk gate which 
> belong to AO clock domain. Please add clk_ignore_unused to bootargs.
> 
> Changes since v4 [3]:
>  - add chosen and memory node
> 
> Changes since v3 [2]:
>  - collect Rob's Reviewed-by
>  - test on latest v4.20/integ
> 
> Changes since v2 [1]:
>  - reorder subnodes
>  - collect Rob's Reviewed-by
> 
> Changes since v1 [0]:
>  - fix signoff typo
>  - order subnodes by addresses when there is one and alphabetically when there is none
> 
> 
> [0] https://lore.kernel.org/lkml/1533802951-49919-2-git-send-email-jianxin.pan@amlogic.com
> [1] https://lore.kernel.org/lkml/1534160901-22889-1-git-send-email-jianxin.pan@amlogic.com
> [2] https://lore.kernel.org/lkml/1534243121-33589-1-git-send-email-jianxin.pan@amlogic.com
> [3] https://lore.kernel.org/lkml/1537427368-11104-1-git-send-email-jianxin.pan@amlogic.com
> 

For the whole serie :
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil

> Jianxin Pan (2):
>   dt-bindings: arm: amlogic: Add Meson G12A binding
>   arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support
> 
>  Documentation/devicetree/bindings/arm/amlogic.txt |   6 +
>  arch/arm64/boot/dts/amlogic/Makefile              |   1 +
>  arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts   |  29 ++++
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi       | 172 ++++++++++++++++++++++
>  4 files changed, 208 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> 

