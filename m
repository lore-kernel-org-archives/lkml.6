Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF634C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613152087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UM+7YASw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613152087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeIYN7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:59:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52053 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeIYN7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:59:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id y25-v6so4826256wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 00:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sLuaezUboyFzNp7Ux8TJPBCHYuBC00sAWQ3BpNii2hs=;
        b=UM+7YASw7XBL80vA3iXM5viyf13/cgmGcCURC+ML5LuMz7wqrMRlFO9XSBjI1fzuoD
         aV2P+hsv/tKiMeeU264hQqkFOjMn8JWUdcWqdSeNFgVRvNwkLWP3nuXE11L5CgQmveC3
         C6WUvCX9tFigMDVEy1v/zI7MwImQEZytzsYnQrRczEge2L2BBBeuKuPzUVXfJuBi7CgQ
         C/8CuyCKezrEioLircozgWwKMqxAXgsZUaKvp+m6NQ+nNyOmBFlLNL0uMUkXrG3fXNAQ
         Yinda/mpdrX8gm9R9Ojrm6nk0G+drap5XbeqxXmt+2T5KlMRyTccPHbyjH5iDSAC5RZ7
         iePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sLuaezUboyFzNp7Ux8TJPBCHYuBC00sAWQ3BpNii2hs=;
        b=m0U87hZ1tjB1mD5lopMm8Tm5JjjfLHH//kR0WQv4VHWOR/Hm649KVQo7cSLbHcaCvF
         k1K5xR1NjLazOxeS0PlgN+mwTQe0AKQhy3ejaYYMaGy2vYdyLCzmd21PhkVEad19r+gr
         rJOkOE3gc/KUrPhZgjXYByR0ZhtfpnTN4IcrsA7gPwD64DzynZ6UmNug1W2MLqN2V7xR
         eNUEZ9rkIPXa+bOYNTLyTwtqUGJgH4pOWc16ttXWxxoHtQ4p0m8aHct4bDy4o09V9j5b
         14dnhBmegEnQYC+OEyTGyTKuPbIffe+7G09tNKuHwzgqIBJRf56ZIP06L7Wh17s8tWti
         QswQ==
X-Gm-Message-State: ABuFfoiqOFkY+P8oC9pH3Uh0XEav0q6gsw6OtTlDwQur+vHKovOqmj4n
        PvQE3J9xLKQPCbXzEWiIiS5QLg==
X-Google-Smtp-Source: ACcGV62NHvckmV8zgp94bPMya9xTaUTY5ZCJUaGxdfI3IXa8ybi3WbTZwKyjuDquW2fKOqw19PYW3w==
X-Received: by 2002:a1c:3314:: with SMTP id z20-v6mr1247604wmz.95.1537862004992;
        Tue, 25 Sep 2018 00:53:24 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z8-v6sm1028336wmf.19.2018.09.25.00.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 00:53:24 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] net: stmmac: dwmac-meson8b: use xxxsetbits32
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr,
        Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie,
        alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, nicolas.palix@imag.fr,
        oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com,
        tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
 <a8d06d0a-b13b-384c-ade6-b0a3b0ee61f6@gmail.com>
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
Message-ID: <6af26377-e2b8-3a1c-ca17-4932f636e01d@baylibre.com>
Date:   Tue, 25 Sep 2018 09:53:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a8d06d0a-b13b-384c-ade6-b0a3b0ee61f6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On 24/09/2018 21:17, Florian Fainelli wrote:
> On 09/24/2018 12:04 PM, Corentin Labbe wrote:
>> This patch convert meson stmmac glue driver to use all xxxsetbits32 functions.
>>
>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>> ---
>>  .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 56 +++++++++-------------
>>  1 file changed, 22 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
>> index c5979569fd60..abcf65588576 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/mfd/syscon.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/stmmac.h>
>> +#include <linux/setbits.h>
>>  
>>  #include "stmmac_platform.h"
>>  
>> @@ -75,18 +76,6 @@ struct meson8b_dwmac_clk_configs {
>>  	struct clk_gate		rgmii_tx_en;
>>  };
>>  
>> -static void meson8b_dwmac_mask_bits(struct meson8b_dwmac *dwmac, u32 reg,
>> -				    u32 mask, u32 value)
>> -{
>> -	u32 data;
>> -
>> -	data = readl(dwmac->regs + reg);
>> -	data &= ~mask;
>> -	data |= (value & mask);
>> -
>> -	writel(data, dwmac->regs + reg);
>> -}
> 
> Why not make mseon8b_dwmac_mask_bits() a wrapper around
> clrsetbits_le32() whose purpose is only to dereference dwmac->regs and
> pass it to clrsetbits_le32()? That would be far less changes to review
> and audit for correctness, same goes with every other patch in this
> series touching the meson drivers.
> 

Personally, I'll prefer dropping my custom writel_bits_relaxed() with something
more future proof (I also use it in spi-meson-spicc and ao-cec),
and I think the same for dwmac-meson8b.c

Neil
