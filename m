Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA361ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD5120856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FZ9acCvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD5120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388360AbeGXNN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:13:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44878 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388256AbeGXNN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:13:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so3862224wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=839tJS9p1S+7+9fV9J/p5XXMtKoyvRXvk4CXNEMhBZ8=;
        b=FZ9acCvNz3RWvbcM0N+bZxQm5AZOdd0tJTsbYI5NSXFOopjpAZMT2XQEupHYL/glEE
         ZdBUPGpFPVqT5rw7K5hSchcB/SxtMhS5lWJvar1sKefWmBkpafI+8QjwLLzQGy5lUL13
         pBoOKgA1AwkGEwXCyX++htjmUnV4sGJehuVCdhMJZbLDNl24358o+87X2YYD8b6QIcEl
         U+7nCNgNYIRZ9W/sco+bm7tEdfz9u5ozR8fNDcSKFLbhW8olQbR1m4iuUaIhuPHFxPWl
         bxwArwZaMwk+SGQWGuIcxXqGpz1IlyktJtDQkP1P+ZQVvxX1Tcdai17CgfXb/JcgEsAC
         3ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=839tJS9p1S+7+9fV9J/p5XXMtKoyvRXvk4CXNEMhBZ8=;
        b=bUC4xUg09l28wiiw0q4BPpPuu+2HBlgShh1UNe7YLlnbAknA7tbHx9JCcP/BVp6mdD
         /Trc+yvY+H32UzZ/RhSrbNw2uFS3BXAuvP2GMGLGzKQHP5BdZpS4KX0LV+lr5zWSrf7D
         Hd3y9wc3DyyoL3FU1y6D74407xlV0hG1geEXWOB0qdcxMy+A+5dAVDrJJb2mWhoLfg1p
         urLkk0gFmX4joZPqM9sGgiFPFVXsbw5pzRnNziIkQ2ms+rHnXaUwK335cSapPPr2Mq0i
         WmGdMXgn0gN6B3y/kmWoImiNw5GmfgU3Z2/T/9HLj9PJZGj8eackrs8/KF8GekEbLcIs
         R3Ng==
X-Gm-Message-State: AOUpUlErsQ2h6/YPOcEib9Vje+AFL9O0GiAqREgiQGf+P9wFN8Bu5cZZ
        D3V8M0IEE8yQEPuC737yuTXvzQ==
X-Google-Smtp-Source: AAOMgpf6M4pu4FA4MgeTwM8I3cylbBDa5uv+lG7bK9TUXTNUE9f+enCmwPveRop48EZ3cMKbO4ekfg==
X-Received: by 2002:adf:c4a7:: with SMTP id m36-v6mr11479753wrf.103.1532434033147;
        Tue, 24 Jul 2018 05:07:13 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r12-v6sm2006971wmc.27.2018.07.24.05.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 05:07:12 -0700 (PDT)
Subject: Re: [PATCH 2/2] clk: meson-gxbb: Add video clocks
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1532079581-978-1-git-send-email-narmstrong@baylibre.com>
 <1532079581-978-3-git-send-email-narmstrong@baylibre.com>
 <CAFBinCAsfJ+5xgFM3mDAPU18N=1VFzjQZNQc5R_Ri5=BsMAKYA@mail.gmail.com>
 <520a75d8-9c20-7ed0-f416-0bbb408075a5@baylibre.com>
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
Message-ID: <07bad32f-71ce-bd28-b0e2-dfe70667687e@baylibre.com>
Date:   Tue, 24 Jul 2018 14:07:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <520a75d8-9c20-7ed0-f416-0bbb408075a5@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2018 14:04, Neil Armstrong wrote:
> On 20/07/2018 21:00, Martin Blumenstingl wrote:
>> Hi Neil,
>>
>> On Fri, Jul 20, 2018 at 11:40 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>
>>> Add the clocks entries used in the video clock path, the clock path
>>> is doubled to permit having different synchronized clocks for different
>>> parts of the video pipeline.
>> maybe you can add the comment about CLK_GET_RATE_NOCACHE here as well
> 
> Yes
> 
>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  drivers/clk/meson/gxbb.c              | 667 ++++++++++++++++++++++++++++++++++
>>>  drivers/clk/meson/gxbb.h              |  24 +-
>>>  include/dt-bindings/clock/gxbb-clkc.h |  17 +
>>>  3 files changed, 706 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
>>> index f79ea33..5fabedf 100644
>>> --- a/drivers/clk/meson/gxbb.c
>>> +++ b/drivers/clk/meson/gxbb.c
>>> @@ -1508,6 +1508,570 @@ static struct clk_regmap gxbb_vapb = {
>>>         },
>>>  };
>>>
>>> +/* Video Clocks */
>>> +
>>> +static struct clk_regmap gxbb_vid_pll_div = {
>>> +       .data = &(struct meson_vid_pll_div_data){
>>> +               .val = {
>>> +                       .reg_off = HHI_VID_PLL_CLK_DIV,
>>> +                       .shift   = 0,
>>> +                       .width   = 15,
>>> +               },
>>> +               .sel = {
>>> +                       .reg_off = HHI_VID_PLL_CLK_DIV,
>>> +                       .shift   = 16,
>>> +                       .width   = 2,
>>> +               },
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vid_pll_div",
>>> +               .ops = &meson_vid_pll_div_ro_ops,
>>> +               .parent_names = (const char *[]){ "hdmi_pll" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
>>> +       },
>>> +};
>>> +
>>> +static u32 mux_table_vid_pll[] = { 0, 1 };
>> you can drop this mux table
> 
> Yep
> 
>>
>>> +const char *gxbb_vid_pll_parent_names[] = { "vid_pll_div", "hdmi_pll" };
>>> +
>>> +static struct clk_regmap gxbb_vid_pll_sel = {
>>> +       .data = &(struct clk_regmap_mux_data){
>>> +               .offset = HHI_VID_PLL_CLK_DIV,
>>> +               .mask = 0x1,
>>> +               .shift = 18,
>>> +               .table = mux_table_vid_pll,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "vid_pll_sel",
>>> +               .ops = &clk_regmap_mux_ops,
>>> +               /*
>>> +                * bit 18 selects from 2 possible parents:
>>> +                * vid_pll_div or hdmi_pll
>>> +                */
>>> +               .parent_names = gxbb_vid_pll_parent_names,
>>> +               .num_parents = ARRAY_SIZE(gxbb_vid_pll_parent_names),
>>> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vid_pll = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VID_PLL_CLK_DIV,
>>> +               .bit_idx = 19,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vid_pll",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "vid_pll_sel" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static u32 mux_table_vclk[] = { 0, 1, 2, 3, 4, 5, 6 };
>> you can drop this mux table
> 
> Yep
> 
>>
>>> +const char *gxbb_vclk_parent_names[] = {
>>> +       "vid_pll", "fclk_div4", "fclk_div3", "fclk_div5", "vid_pll",
>>> +       "fclk_div7", "mpll1",
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk_sel = {
>>> +       .data = &(struct clk_regmap_mux_data){
>>> +               .offset = HHI_VID_CLK_CNTL,
>>> +               .mask = 0x7,
>>> +               .shift = 16,
>>> +               .table = mux_table_vclk,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "vclk_sel",
>>> +               .ops = &clk_regmap_mux_ops,
>>> +               /*
>>> +                * bits 16:18 selects from 8 possible parents:
>>> +                * vid_pll, fclk_div4, fclk_div3, fclk_div5,
>>> +                * vid_pll, fclk_div7, mp1
>>> +                */
>>> +               .parent_names = gxbb_vclk_parent_names,
>>> +               .num_parents = ARRAY_SIZE(gxbb_vclk_parent_names),
>>> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk2_sel = {
>>> +       .data = &(struct clk_regmap_mux_data){
>>> +               .offset = HHI_VIID_CLK_CNTL,
>>> +               .mask = 0x7,
>>> +               .shift = 16,
>>> +               .table = mux_table_vclk,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "vclk2_sel",
>>> +               .ops = &clk_regmap_mux_ops,
>>> +               /*
>>> +                * bits 16:18 selects from 8 possible parents:
>>> +                * vid_pll, fclk_div4, fclk_div3, fclk_div5,
>>> +                * vid_pll, fclk_div7, mp1
>>> +                */
>>> +               .parent_names = gxbb_vclk_parent_names,
>>> +               .num_parents = ARRAY_SIZE(gxbb_vclk_parent_names),
>>> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk_input = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VID_CLK_DIV,
>>> +               .bit_idx = 16,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vclk_input",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "vclk_sel" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk2_input = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VIID_CLK_DIV,
>>> +               .bit_idx = 16,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vclk2_input",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "vclk2_sel" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk_div = {
>>> +       .data = &(struct clk_regmap_div_data){
>>> +               .offset = HHI_VID_CLK_DIV,
>>> +               .shift = 0,
>>> +               .width = 8,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "vclk_div",
>>> +               .ops = &clk_regmap_divider_ops,
>>> +               .parent_names = (const char *[]){ "vclk_input" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_GET_RATE_NOCACHE,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk2_div = {
>>> +       .data = &(struct clk_regmap_div_data){
>>> +               .offset = HHI_VIID_CLK_DIV,
>>> +               .shift = 0,
>>> +               .width = 8,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "vclk2_div",
>>> +               .ops = &clk_regmap_divider_ops,
>>> +               .parent_names = (const char *[]){ "vclk2_input" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_GET_RATE_NOCACHE,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VID_CLK_CNTL,
>>> +               .bit_idx = 19,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vclk",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "vclk_div" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk2 = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VIID_CLK_CNTL,
>>> +               .bit_idx = 19,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vclk2",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "vclk2_div" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk_div1 = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VID_CLK_CNTL,
>>> +               .bit_idx = 0,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vclk_div1",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "vclk" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk_div2_en = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VID_CLK_CNTL,
>>> +               .bit_idx = 1,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vclk_div2_en",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "vclk" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk_div4_en = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VID_CLK_CNTL,
>>> +               .bit_idx = 2,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vclk_div4_en",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "vclk" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk_div6_en = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VID_CLK_CNTL,
>>> +               .bit_idx = 3,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vclk_div6_en",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "vclk" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk_div12_en = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VID_CLK_CNTL,
>>> +               .bit_idx = 4,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vclk_div12_en",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "vclk" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk2_div1 = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VIID_CLK_CNTL,
>>> +               .bit_idx = 0,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vclk2_div1",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "vclk2" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk2_div2_en = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VIID_CLK_CNTL,
>>> +               .bit_idx = 1,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vclk2_div2_en",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "vclk2" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk2_div4_en = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VIID_CLK_CNTL,
>>> +               .bit_idx = 2,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vclk2_div4_en",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "vclk2" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk2_div6_en = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VIID_CLK_CNTL,
>>> +               .bit_idx = 3,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vclk2_div6_en",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "vclk2" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_vclk2_div12_en = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VIID_CLK_CNTL,
>>> +               .bit_idx = 4,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "vclk2_div12_en",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "vclk2" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_fixed_factor gxbb_vclk_div2 = {
>>> +       .mult = 1,
>>> +       .div = 2,
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "vclk_div2",
>>> +               .ops = &clk_fixed_factor_ops,
>>> +               .parent_names = (const char *[]){ "vclk_div2_en" },
>>> +               .num_parents = 1,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_fixed_factor gxbb_vclk_div4 = {
>>> +       .mult = 1,
>>> +       .div = 4,
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "vclk_div4",
>>> +               .ops = &clk_fixed_factor_ops,
>>> +               .parent_names = (const char *[]){ "vclk_div4_en" },
>>> +               .num_parents = 1,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_fixed_factor gxbb_vclk_div6 = {
>>> +       .mult = 1,
>>> +       .div = 6,
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "vclk_div6",
>>> +               .ops = &clk_fixed_factor_ops,
>>> +               .parent_names = (const char *[]){ "vclk_div6_en" },
>>> +               .num_parents = 1,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_fixed_factor gxbb_vclk_div12 = {
>>> +       .mult = 1,
>>> +       .div = 12,
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "vclk_div12",
>>> +               .ops = &clk_fixed_factor_ops,
>>> +               .parent_names = (const char *[]){ "vclk_div12_en" },
>>> +               .num_parents = 1,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_fixed_factor gxbb_vclk2_div2 = {
>>> +       .mult = 1,
>>> +       .div = 2,
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "vclk2_div2",
>>> +               .ops = &clk_fixed_factor_ops,
>>> +               .parent_names = (const char *[]){ "vclk2_div2_en" },
>>> +               .num_parents = 1,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_fixed_factor gxbb_vclk2_div4 = {
>>> +       .mult = 1,
>>> +       .div = 4,
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "vclk2_div4",
>>> +               .ops = &clk_fixed_factor_ops,
>>> +               .parent_names = (const char *[]){ "vclk2_div4_en" },
>>> +               .num_parents = 1,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_fixed_factor gxbb_vclk2_div6 = {
>>> +       .mult = 1,
>>> +       .div = 6,
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "vclk2_div6",
>>> +               .ops = &clk_fixed_factor_ops,
>>> +               .parent_names = (const char *[]){ "vclk2_div6_en" },
>>> +               .num_parents = 1,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_fixed_factor gxbb_vclk2_div12 = {
>>> +       .mult = 1,
>>> +       .div = 12,
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "vclk2_div12",
>>> +               .ops = &clk_fixed_factor_ops,
>>> +               .parent_names = (const char *[]){ "vclk2_div12_en" },
>>> +               .num_parents = 1,
>>> +       },
>>> +};
>>> +
>>> +static u32 mux_table_cts_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
>>> +const char *gxbb_cts_parent_names[] = {
>>> +       "vclk_div1", "vclk_div2", "vclk_div4", "vclk_div6",
>>> +       "vclk_div12", "vclk2_div1", "vclk2_div2", "vclk2_div4",
>>> +       "vclk2_div6", "vclk2_div12"
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_cts_enci_sel = {
>>> +       .data = &(struct clk_regmap_mux_data){
>>> +               .offset = HHI_VID_CLK_DIV,
>>> +               .mask = 0xf,
>>> +               .shift = 28,
>>> +               .table = mux_table_cts_sel,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "cts_enci_sel",
>>> +               .ops = &clk_regmap_mux_ops,
>>> +               .parent_names = gxbb_cts_parent_names,
>>> +               .num_parents = ARRAY_SIZE(gxbb_cts_parent_names),
>>> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_cts_encp_sel = {
>>> +       .data = &(struct clk_regmap_mux_data){
>>> +               .offset = HHI_VID_CLK_DIV,
>>> +               .mask = 0xf,
>>> +               .shift = 20,
>>> +               .table = mux_table_cts_sel,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "cts_encp_sel",
>>> +               .ops = &clk_regmap_mux_ops,
>>> +               .parent_names = gxbb_cts_parent_names,
>>> +               .num_parents = ARRAY_SIZE(gxbb_cts_parent_names),
>>> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_cts_vdac_sel = {
>>> +       .data = &(struct clk_regmap_mux_data){
>>> +               .offset = HHI_VIID_CLK_DIV,
>>> +               .mask = 0xf,
>>> +               .shift = 28,
>>> +               .table = mux_table_cts_sel,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "cts_vdac_sel",
>>> +               .ops = &clk_regmap_mux_ops,
>>> +               .parent_names = gxbb_cts_parent_names,
>>> +               .num_parents = ARRAY_SIZE(gxbb_cts_parent_names),
>>> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>>> +       },
>>> +};
>>> +
>>> +/* TOFIX: add support for cts_tcon */
>>> +static u32 mux_table_hdmi_tx_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
>>> +const char *gxbb_cts_hdmi_tx_parent_names[] = {
>>> +       "vclk_div1", "vclk_div2", "vclk_div4", "vclk_div6",
>>> +       "vclk_div12", "vclk2_div1", "vclk2_div2", "vclk2_div4",
>>> +       "vclk2_div6", "vclk2_div12"
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_hdmi_tx_sel = {
>>> +       .data = &(struct clk_regmap_mux_data){
>>> +               .offset = HHI_HDMI_CLK_CNTL,
>>> +               .mask = 0xf,
>>> +               .shift = 16,
>>> +               .table = mux_table_hdmi_tx_sel,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data){
>>> +               .name = "hdmi_tx_sel",
>>> +               .ops = &clk_regmap_mux_ops,
>>> +               /*
>>> +                * bits 31:28 selects from 12 possible parents:
>>> +                * vclk_div1, vclk_div2, vclk_div4, vclk_div6, vclk_div12
>>> +                * vclk2_div1, vclk2_div2, vclk2_div4, vclk2_div6, vclk2_div12,
>>> +                * cts_tcon
>>> +                */
>>> +               .parent_names = gxbb_cts_hdmi_tx_parent_names,
>>> +               .num_parents = ARRAY_SIZE(gxbb_cts_hdmi_tx_parent_names),
>>> +               .flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_cts_enci = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VID_CLK_CNTL2,
>>> +               .bit_idx = 0,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "cts_enci",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "cts_enci_sel" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_cts_encp = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VID_CLK_CNTL2,
>>> +               .bit_idx = 2,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "cts_encp",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "cts_encp_sel" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_cts_vdac = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VID_CLK_CNTL2,
>>> +               .bit_idx = 4,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "cts_vdac",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "cts_vdac_sel" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>> +static struct clk_regmap gxbb_hdmi_tx = {
>>> +       .data = &(struct clk_regmap_gate_data){
>>> +               .offset = HHI_VID_CLK_CNTL2,
>>> +               .bit_idx = 5,
>>> +       },
>>> +       .hw.init = &(struct clk_init_data) {
>>> +               .name = "hdmi_tx",
>>> +               .ops = &clk_regmap_gate_ops,
>>> +               .parent_names = (const char *[]){ "hdmi_tx_sel" },
>>> +               .num_parents = 1,
>>> +               .flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +       },
>>> +};
>>> +
>>>  /* VDEC clocks */
>>>
>>>  static const char * const gxbb_vdec_parent_names[] = {
>>> @@ -1919,6 +2483,43 @@ static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
>>>                 [CLKID_HDMI_PLL_OD2]        = &gxbb_hdmi_pll_od2.hw,
>>>                 [CLKID_SYS_PLL_DCO]         = &gxbb_sys_pll_dco.hw,
>>>                 [CLKID_GP0_PLL_DCO]         = &gxbb_gp0_pll_dco.hw,
>>> +               [CLKID_VID_PLL_DIV]         = &gxbb_vid_pll_div.hw,
>>> +               [CLKID_VID_PLL_SEL]         = &gxbb_vid_pll_sel.hw,
>>> +               [CLKID_VID_PLL]             = &gxbb_vid_pll.hw,
>>> +               [CLKID_VCLK_SEL]            = &gxbb_vclk_sel.hw,
>>> +               [CLKID_VCLK2_SEL]           = &gxbb_vclk2_sel.hw,
>>> +               [CLKID_VCLK_INPUT]          = &gxbb_vclk_input.hw,
>>> +               [CLKID_VCLK2_INPUT]         = &gxbb_vclk2_input.hw,
>>> +               [CLKID_VCLK_DIV]            = &gxbb_vclk_div.hw,
>>> +               [CLKID_VCLK2_DIV]           = &gxbb_vclk2_div.hw,
>>> +               [CLKID_VCLK]                = &gxbb_vclk.hw,
>>> +               [CLKID_VCLK2]               = &gxbb_vclk2.hw,
>>> +               [CLKID_VCLK_DIV1]           = &gxbb_vclk_div1.hw,
>>> +               [CLKID_VCLK_DIV2_EN]        = &gxbb_vclk_div2_en.hw,
>>> +               [CLKID_VCLK_DIV2]           = &gxbb_vclk_div2.hw,
>>> +               [CLKID_VCLK_DIV4_EN]        = &gxbb_vclk_div4_en.hw,
>>> +               [CLKID_VCLK_DIV4]           = &gxbb_vclk_div4.hw,
>>> +               [CLKID_VCLK_DIV6_EN]        = &gxbb_vclk_div6_en.hw,
>>> +               [CLKID_VCLK_DIV6]           = &gxbb_vclk_div6.hw,
>>> +               [CLKID_VCLK_DIV12_EN]       = &gxbb_vclk_div12_en.hw,
>>> +               [CLKID_VCLK_DIV12]          = &gxbb_vclk_div12.hw,
>>> +               [CLKID_VCLK2_DIV1]          = &gxbb_vclk2_div1.hw,
>>> +               [CLKID_VCLK2_DIV2_EN]       = &gxbb_vclk2_div2_en.hw,
>>> +               [CLKID_VCLK2_DIV2]          = &gxbb_vclk2_div2.hw,
>>> +               [CLKID_VCLK2_DIV4_EN]       = &gxbb_vclk2_div4_en.hw,
>>> +               [CLKID_VCLK2_DIV4]          = &gxbb_vclk2_div4.hw,
>>> +               [CLKID_VCLK2_DIV6_EN]       = &gxbb_vclk2_div6_en.hw,
>>> +               [CLKID_VCLK2_DIV6]          = &gxbb_vclk2_div6.hw,
>>> +               [CLKID_VCLK2_DIV12_EN]      = &gxbb_vclk2_div12_en.hw,
>>> +               [CLKID_VCLK2_DIV12]         = &gxbb_vclk2_div12.hw,
>>> +               [CLKID_CTS_ENCI_SEL]        = &gxbb_cts_enci_sel.hw,
>>> +               [CLKID_CTS_ENCP_SEL]        = &gxbb_cts_encp_sel.hw,
>>> +               [CLKID_CTS_VDAC_SEL]        = &gxbb_cts_vdac_sel.hw,
>>> +               [CLKID_HDMI_TX_SEL]         = &gxbb_hdmi_tx_sel.hw,
>>> +               [CLKID_CTS_ENCI]            = &gxbb_cts_enci.hw,
>>> +               [CLKID_CTS_ENCP]            = &gxbb_cts_encp.hw,
>>> +               [CLKID_CTS_VDAC]            = &gxbb_cts_vdac.hw,
>>> +               [CLKID_HDMI_TX]             = &gxbb_hdmi_tx.hw,
>>>                 [NR_CLKS]                   = NULL,
>>>         },
>>>         .num = NR_CLKS,
>>> @@ -2090,6 +2691,43 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
>>>                 [CLKID_HDMI_PLL_OD2]        = &gxl_hdmi_pll_od2.hw,
>>>                 [CLKID_SYS_PLL_DCO]         = &gxbb_sys_pll_dco.hw,
>>>                 [CLKID_GP0_PLL_DCO]         = &gxl_gp0_pll_dco.hw,
>>> +               [CLKID_VID_PLL_DIV]         = &gxbb_vid_pll_div.hw,
>>> +               [CLKID_VID_PLL_SEL]         = &gxbb_vid_pll_sel.hw,
>>> +               [CLKID_VID_PLL]             = &gxbb_vid_pll.hw,
>>> +               [CLKID_VCLK_SEL]            = &gxbb_vclk_sel.hw,
>>> +               [CLKID_VCLK2_SEL]           = &gxbb_vclk2_sel.hw,
>>> +               [CLKID_VCLK_INPUT]          = &gxbb_vclk_input.hw,
>>> +               [CLKID_VCLK2_INPUT]         = &gxbb_vclk2_input.hw,
>>> +               [CLKID_VCLK_DIV]            = &gxbb_vclk_div.hw,
>>> +               [CLKID_VCLK2_DIV]           = &gxbb_vclk2_div.hw,
>>> +               [CLKID_VCLK]                = &gxbb_vclk.hw,
>>> +               [CLKID_VCLK2]               = &gxbb_vclk2.hw,
>>> +               [CLKID_VCLK_DIV1]           = &gxbb_vclk_div1.hw,
>>> +               [CLKID_VCLK_DIV2_EN]        = &gxbb_vclk_div2_en.hw,
>>> +               [CLKID_VCLK_DIV2]           = &gxbb_vclk_div2.hw,
>>> +               [CLKID_VCLK_DIV4_EN]        = &gxbb_vclk_div4_en.hw,
>>> +               [CLKID_VCLK_DIV4]           = &gxbb_vclk_div4.hw,
>>> +               [CLKID_VCLK_DIV6_EN]        = &gxbb_vclk_div6_en.hw,
>>> +               [CLKID_VCLK_DIV6]           = &gxbb_vclk_div6.hw,
>>> +               [CLKID_VCLK_DIV12_EN]       = &gxbb_vclk_div12_en.hw,
>>> +               [CLKID_VCLK_DIV12]          = &gxbb_vclk_div12.hw,
>>> +               [CLKID_VCLK2_DIV1]          = &gxbb_vclk2_div1.hw,
>>> +               [CLKID_VCLK2_DIV2_EN]       = &gxbb_vclk2_div2_en.hw,
>>> +               [CLKID_VCLK2_DIV2]          = &gxbb_vclk2_div2.hw,
>>> +               [CLKID_VCLK2_DIV4_EN]       = &gxbb_vclk2_div4_en.hw,
>>> +               [CLKID_VCLK2_DIV4]          = &gxbb_vclk2_div4.hw,
>>> +               [CLKID_VCLK2_DIV6_EN]       = &gxbb_vclk2_div6_en.hw,
>>> +               [CLKID_VCLK2_DIV6]          = &gxbb_vclk2_div6.hw,
>>> +               [CLKID_VCLK2_DIV12_EN]      = &gxbb_vclk2_div12_en.hw,
>>> +               [CLKID_VCLK2_DIV12]         = &gxbb_vclk2_div12.hw,
>>> +               [CLKID_CTS_ENCI_SEL]        = &gxbb_cts_enci_sel.hw,
>>> +               [CLKID_CTS_ENCP_SEL]        = &gxbb_cts_encp_sel.hw,
>>> +               [CLKID_CTS_VDAC_SEL]        = &gxbb_cts_vdac_sel.hw,
>>> +               [CLKID_HDMI_TX_SEL]         = &gxbb_hdmi_tx_sel.hw,
>>> +               [CLKID_CTS_ENCI]            = &gxbb_cts_enci.hw,
>>> +               [CLKID_CTS_ENCP]            = &gxbb_cts_encp.hw,
>>> +               [CLKID_CTS_VDAC]            = &gxbb_cts_vdac.hw,
>>> +               [CLKID_HDMI_TX]             = &gxbb_hdmi_tx.hw,
>>>                 [NR_CLKS]                   = NULL,
>>>         },
>>>         .num = NR_CLKS,
>>> @@ -2265,6 +2903,35 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
>>>         &gxbb_hdmi_pll_dco,
>>>         &gxbb_sys_pll_dco,
>>>         &gxbb_gp0_pll,
>>> +       &gxbb_vid_pll,
>>> +       &gxbb_vid_pll_sel,
>>> +       &gxbb_vid_pll_div,
>>> +       &gxbb_vclk,
>>> +       &gxbb_vclk_sel,
>>> +       &gxbb_vclk_div,
>>> +       &gxbb_vclk_input,
>>> +       &gxbb_vclk_div1,
>>> +       &gxbb_vclk_div2_en,
>>> +       &gxbb_vclk_div4_en,
>>> +       &gxbb_vclk_div6_en,
>>> +       &gxbb_vclk_div12_en,
>>> +       &gxbb_vclk2,
>>> +       &gxbb_vclk2_sel,
>>> +       &gxbb_vclk2_div,
>>> +       &gxbb_vclk2_input,
>>> +       &gxbb_vclk2_div1,
>>> +       &gxbb_vclk2_div2_en,
>>> +       &gxbb_vclk2_div4_en,
>>> +       &gxbb_vclk2_div6_en,
>>> +       &gxbb_vclk2_div12_en,
>>> +       &gxbb_cts_enci,
>>> +       &gxbb_cts_enci_sel,
>>> +       &gxbb_cts_encp,
>>> +       &gxbb_cts_encp_sel,
>>> +       &gxbb_cts_vdac,
>>> +       &gxbb_cts_vdac_sel,
>>> +       &gxbb_hdmi_tx,
>>> +       &gxbb_hdmi_tx_sel,
>>>  };
>>>
>>>  struct clkc_data {
>>> diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
>>> index 72bc077..171b7d8 100644
>>> --- a/drivers/clk/meson/gxbb.h
>>> +++ b/drivers/clk/meson/gxbb.h
>>> @@ -165,8 +165,28 @@
>>>  #define CLKID_HDMI_PLL_OD2       163
>>>  #define CLKID_SYS_PLL_DCO        164
>>>  #define CLKID_GP0_PLL_DCO        165
>>> -
>>> -#define NR_CLKS                          166
>>> +#define CLKID_VID_PLL_SEL        167
>>> +#define CLKID_VID_PLL_DIV        168
>>> +#define CLKID_VCLK_SEL           169
>>> +#define CLKID_VCLK2_SEL                  170
>>> +#define CLKID_VCLK_INPUT         171
>>> +#define CLKID_VCLK2_INPUT        172
>>> +#define CLKID_VCLK_DIV           173
>>> +#define CLKID_VCLK2_DIV                  174
>>> +#define CLKID_VCLK_DIV2_EN       177
>>> +#define CLKID_VCLK_DIV4_EN       178
>>> +#define CLKID_VCLK_DIV6_EN       179
>>> +#define CLKID_VCLK_DIV12_EN      180
>>> +#define CLKID_VCLK2_DIV2_EN      181
>>> +#define CLKID_VCLK2_DIV4_EN      182
>>> +#define CLKID_VCLK2_DIV6_EN      183
>>> +#define CLKID_VCLK2_DIV12_EN     184
>>> +#define CLKID_CTS_ENCI_SEL       195
>>> +#define CLKID_CTS_ENCP_SEL       196
>>> +#define CLKID_CTS_VDAC_SEL       197
>>> +#define CLKID_HDMI_TX_SEL        198
>>> +
>>> +#define NR_CLKS                          203
>>>
>>>  /* include the CLKIDs that have been made part of the DT binding */
>>>  #include <dt-bindings/clock/gxbb-clkc.h>
>>> diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
>>> index 3979d48..9f7b99e 100644
>>> --- a/include/dt-bindings/clock/gxbb-clkc.h
>>> +++ b/include/dt-bindings/clock/gxbb-clkc.h
>> shouldn't this go into a separate patch?
>>
>>> @@ -128,5 +128,22 @@
>>>  #define CLKID_VDEC_1           153
>>>  #define CLKID_VDEC_HEVC                156
>>>  #define CLKID_GEN_CLK          159
>>> +#define CLKID_VID_PLL          166
>>> +#define CLKID_VCLK             175
>>> +#define CLKID_VCLK2            176
>>> +#define CLKID_VCLK_DIV1                185
>>> +#define CLKID_VCLK_DIV2                186
>>> +#define CLKID_VCLK_DIV4                187
>>> +#define CLKID_VCLK_DIV6                188
>>> +#define CLKID_VCLK_DIV12       189
>>> +#define CLKID_VCLK2_DIV1       190
>>> +#define CLKID_VCLK2_DIV2       191
>>> +#define CLKID_VCLK2_DIV4       192
>>> +#define CLKID_VCLK2_DIV6       193
>>> +#define CLKID_VCLK2_DIV12      194
>> at first I was confused why you need to export all the dividers,
>> instead of simply calling clk_set_rate with "parent_rate (taken vom
>> VCLK or VCLK2) divided by N"
>> then I noticed that the four muxes below can use VCLK *or* VCLK2
>> dividers as input (as far as I remember this is different on Meson8b:
>> there the muxes below take either the VCLK dividers or the VCLK2
>> dividers as input, but not both)
> 
> Ok, I need to be sure both hdmi and enci/encp takes clock from the
> same vclk tree, and in some HDMI mode you need to have a x2 clock
> to cts_enci/encp from the same 1x clock to cts_htmi.
> 
> So I will need to manually setup the parents to make sure CCF doesn't
> make a random choice.
> 
> Then I'll be able to do a set_rate on vclk to setup the proper PLL rate.
> 
>>
>>> +#define CLKID_CTS_ENCI         199
>>> +#define CLKID_CTS_ENCP         200
>>> +#define CLKID_CTS_VDAC         201
>>> +#define CLKID_HDMI_TX          202
>> is my assumption correct that you need to choose a specific input
>> clock (VCLK or VCLK2) for a specific use-case (ENCI, ENCP, VDAC,
>> HDMI_TX)?
>> let's say HDMI uses VLKC2 as input (I'm not sure if it really does):
>> could you skip the VCLK_DIV_* parents in the HDMI_TX clock definition
>> - or does the selection of a specific parent clock (VCLK or VCLK2)
>> depend on the output rate?
> 
> HDMI takes vclk2 (why ? I'll keep this path since it's always used by the
> vendor code), and CBVS takes vclk.
> I suspect they tried to make is possible to have CVBS and HDMI output
> work at the same time using the VPP2 instance. But no idea how it works.
> 
> As I sais before, you need to feed a x2 factor to hdmi and enci/encp for
> some modes, and I can't let CCF decide since they must take the same
> clock path (VCLK or VCLK2, not both).
> 
>>
>>
>> Regards
>> Martin
>>
> 
> Neil
> 

Oh and for my own reference, I forgot to add the HDMI clk feeding the HDMI controller... HHI_HDMI_CLK_CNTL
