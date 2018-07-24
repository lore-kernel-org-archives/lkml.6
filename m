Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DA6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A565205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="etn3uFSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A565205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbeGXNC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:02:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34383 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388256AbeGXNC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:02:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so3877662wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 04:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=A9VmyrQEVlZuAcMgs8I00aGZM033snbWdMcMBsiy6fQ=;
        b=etn3uFSA5+BH5VYIqhetudGp41gMznzlScm922eAepe5LOxby3W/DzZD9goxmsaNdn
         jXackYnDuC63coiODgYbtlFBrrVTVCCD+DeqKZLbJ0SunfcTf6M4TWdl7+ou7bd2/5aA
         9FU9QOrZznECEcSpdCjh0SFClQyyoB4na+IDveNtgixEayjLPWsz/HkJ7BFMgAsLE6R5
         MzpVV+AOwIC1sXpFc+fsT9sxk3J8zq8XUni2jhB+qGmHdHNmrXg8Re4twTXT98XjBLO4
         NFVfL2O0p+l5gDKOhmnP5Q0WL1HRGxiBXsuwFSnoZj1Rr9soaotZe8sK4E0vx28Ujlto
         LgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=A9VmyrQEVlZuAcMgs8I00aGZM033snbWdMcMBsiy6fQ=;
        b=pCQ8SmkQ+SA1PXYS2LoyXNc0HAp8X6Qu5HmRaY8IuvKyiIgYb3aACu8ZRXhjjsl9ZB
         LH78L59whQigYoZTeEcxgFDRNzcWRwqxbxxydQN0zkyDDlRb29DKqsJWcZpGxPhLd40Z
         xavlASr61wsk2+pgV/PEEQB2rcjc5/0sUxroSxAAzEu9S5uo26rDwsrW48990Ul76s0z
         6LWc20DmUS6ojJ1rTmbqWx5f5w1mIHz3sS49134Q0tgZHOyQ9jVakXAIlOBtzbOW3CQZ
         gboKWdAqt5t2ED8WDpakYy5xX4NVhzwTF9wM25efJV4ycxGukis/flo7pcucpxpFdS5X
         E88w==
X-Gm-Message-State: AOUpUlGOekYnnwKRnQhBc99yupBCzom6qSJ/uC/99wTAdDqkDrRpacIz
        3YuW5jennno3Msh9FgdkSOMBzw==
X-Google-Smtp-Source: AAOMgpcZMd6DiXc2Q2CCOLtTIR6g3z5tFkodTXOZI46Q5piZyH4Xh09+G/fxc1hlYNzl5F64t4x7Ag==
X-Received: by 2002:adf:b519:: with SMTP id a25-v6mr12061717wrd.273.1532433409118;
        Tue, 24 Jul 2018 04:56:49 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e141-v6sm2758963wmd.32.2018.07.24.04.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 04:56:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] clk: meson: Add vid_pll divider driver
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1532079581-978-1-git-send-email-narmstrong@baylibre.com>
 <1532079581-978-2-git-send-email-narmstrong@baylibre.com>
 <CAFBinCCbzJ3Un3Naqc1ONq6gK3gDsAY+pSyHabaivjySFuzbZw@mail.gmail.com>
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
Message-ID: <00919c03-7950-dbe2-bca3-4d739a3a5aa3@baylibre.com>
Date:   Tue, 24 Jul 2018 13:56:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCCbzJ3Un3Naqc1ONq6gK3gDsAY+pSyHabaivjySFuzbZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2018 21:17, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Fri, Jul 20, 2018 at 11:40 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Add support the VID_PLL fully programmable divider used right after the
>> HDMI PLL clock source. It is used to achieve complex fractional division
>> with a programmble bitfield.
> I assume you have no other information that the S912 datasheet, pages
> 64 and 77 which describe the HHI_VID_PLL_CLK_DIV register?

Exact

> 
> more comments inline
> 
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> ---
>>  drivers/clk/meson/Makefile      |  2 +-
>>  drivers/clk/meson/clkc.h        |  6 +++
>>  drivers/clk/meson/vid-pll-div.c | 90 +++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 97 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/clk/meson/vid-pll-div.c
>>
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 72ec8c4..0234767 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -2,7 +2,7 @@
>>  # Makefile for Meson specific clk
>>  #
>>
>> -obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o
>> +obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o vid-pll-div.o
>>  obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO) += clk-triphase.o sclk-div.o
>>  obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
>>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
>> index 6b96d55..9166605 100644
>> --- a/drivers/clk/meson/clkc.h
>> +++ b/drivers/clk/meson/clkc.h
>> @@ -90,6 +90,11 @@ struct meson_clk_phase_data {
>>  int meson_clk_degrees_from_val(unsigned int val, unsigned int width);
>>  unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width);
>>
>> +struct meson_vid_pll_div_data {
>> +       struct parm val;
>> +       struct parm sel;
>> +};
>> +
>>  #define MESON_GATE(_name, _reg, _bit)                                  \
>>  struct clk_regmap _name = {                                            \
>>         .data = &(struct clk_regmap_gate_data){                         \
>> @@ -112,5 +117,6 @@ extern const struct clk_ops meson_clk_cpu_ops;
>>  extern const struct clk_ops meson_clk_mpll_ro_ops;
>>  extern const struct clk_ops meson_clk_mpll_ops;
>>  extern const struct clk_ops meson_clk_phase_ops;
>> +extern const struct clk_ops meson_vid_pll_div_ro_ops;
>>
>>  #endif /* __CLKC_H */
>> diff --git a/drivers/clk/meson/vid-pll-div.c b/drivers/clk/meson/vid-pll-div.c
>> new file mode 100644
>> index 0000000..5f267be
>> --- /dev/null
>> +++ b/drivers/clk/meson/vid-pll-div.c
>> @@ -0,0 +1,90 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018 BayLibre, SAS.
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include "clkc.h"
>> +
>> +static inline struct meson_vid_pll_div_data *
>> +meson_vid_pll_div_data(struct clk_regmap *clk)
>> +{
>> +       return (struct meson_vid_pll_div_data *)clk->data;
>> +}
>> +
>> +/*
>> + * This vid_pll divided is a fully programmable fractionnal divider to
>> + * achieve complex video clock rates.
>> + *
>> + * Here are provided the commonly used fraction values provided by Amlogic.
>> + */
>> +
>> +struct vid_pll_div {
>> +       unsigned int shift_val;
>> +       unsigned int shift_sel;
>> +       unsigned int frac_top;
> maybe call it divider?

Yep, seems simpler !

> 
>> +       unsigned int frac_bot;
> maybe call it multiplier?

Thanks, I was in my code and forgot it was simpler...

> 
>> +};
>> +
>> +#define VID_PLL_DIV(_val, _sel, _ft, _fb)                              \
>> +       {                                                               \
>> +               .shift_val = (_val),                                    \
>> +               .shift_sel = (_sel),                                    \
>> +               .frac_top = (_ft),                                      \
>> +               .frac_bot = (_fb),                                      \
>> +       }
>> +
>> +static const struct vid_pll_div vid_pll_div_table[] = {
>> +       VID_PLL_DIV(0x0aaa, 0, 2, 1),   /* 2/1  => /2 */
>> +       VID_PLL_DIV(0x5294, 2, 5, 2),   /* 5/2  => /2.5 */
>> +       VID_PLL_DIV(0x0db6, 0, 3, 1),   /* 3/1  => /3 */
>> +       VID_PLL_DIV(0x36cc, 1, 7, 2),   /* 7/2  => /3.5 */
>> +       VID_PLL_DIV(0x6666, 2, 15, 4),  /* 15/4 => /3.75 */
>> +       VID_PLL_DIV(0x0ccc, 4, 4, 1),   /* 4/1  => /4 */
> is the shift_sel (second parameter) correct here? the public S912
> datasheet, page 77 states that CLK_SEL is only 2 bit wide (and "4"
> exceeds that)

It's a typo, it should be 0. Thanks.

> 
>> +       VID_PLL_DIV(0x739c, 2, 5, 1),   /* 5/1  => /5 */
>> +       VID_PLL_DIV(0x0e38, 0, 6, 1),   /* 6/1  => /6 */
>> +       VID_PLL_DIV(0x0000, 3, 25, 4),  /* 25/4 => /6.25 */
>> +       VID_PLL_DIV(0x3c78, 1, 7, 1),   /* 7/1  => /7 */
>> +       VID_PLL_DIV(0x78f0, 2, 15, 2),  /* 15/2 => /7.5 */
>> +       VID_PLL_DIV(0x0fc0, 0, 12, 1),  /* 12/1 => /12 */
>> +       VID_PLL_DIV(0x3f80, 1, 14, 1),  /* 14/1 => /14 */
>> +       VID_PLL_DIV(0x7f80, 2, 15, 1),  /* 15/1 => /15 */
>> +};
>> +
>> +#define to_meson_vid_pll_div(_hw) container_of(_hw, struct meson_vid_pll_div, hw)
>> +
>> +const struct vid_pll_div *_get_table_val(unsigned int shift_val,
>> +                                        unsigned int shift_sel)
>> +{
>> +       int i;
>> +
>> +       for (i = 0 ; i < ARRAY_SIZE(vid_pll_div_table) ; ++i) {
>> +               if (vid_pll_div_table[i].shift_val == shift_val &&
>> +                   vid_pll_div_table[i].shift_sel == shift_sel)
>> +                       return &vid_pll_div_table[i];
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +static unsigned long meson_vid_pll_div_recalc_rate(struct clk_hw *hw,
>> +                                                  unsigned long parent_rate)
>> +{
>> +       struct clk_regmap *clk = to_clk_regmap(hw);
>> +       struct meson_vid_pll_div_data *pll_div = meson_vid_pll_div_data(clk);
>> +       const struct vid_pll_div *div;
>> +
>> +       div = _get_table_val(meson_parm_read(clk->map, &pll_div->val),
>> +                            meson_parm_read(clk->map, &pll_div->sel));
>> +       if (!div || !div->frac_top) {
>> +               pr_info("%s: Invalid config value for vid_pll_div\n", __func__);
>> +               return parent_rate;
>> +       }
>> +
>> +       return DIV_ROUND_UP_ULL(parent_rate * div->frac_bot, div->frac_top);
> with the rename above this would read:
> return DIV_ROUND_UP_ULL(parent_rate * div->multiplier, div->divider);

Yep, this looks much better !

> 
> 
> Regards
> Martin
> 

