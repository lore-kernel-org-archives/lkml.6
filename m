Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FB7C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21A627961
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SFrOS0HW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21A627961
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753599AbeF2HOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:14:22 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35866 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeF2HOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:14:21 -0400
Received: by mail-wr0-f196.google.com with SMTP id f16-v6so7771944wrm.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 00:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=o7Koi4FjY35NcPpfGvkS5BrUvZescx1HotOe2Nv6/Qc=;
        b=SFrOS0HWY/HkWRrTa9nFNoe0OKn0USuru6G7IWvkKhGTXW0GwzXhJAdKwmHu/cJ77x
         a4dRhKlgu2AAvFGePLvY/z1Syz7SNYNDUkUQu5g6QMgmEs7wlujkNeKimNnAVvXInAjt
         wQG4BMfMOhnijnLwV4x/3A+xCyxYXykM0m7Can4V6Nh9i8McuAV2XkmnUeOa/XpW2VE9
         iT7qHrID8VcDgfNPYpud8NzZZEh6ymJoRsWtKDhtUml07XCuE1jvP6xDP3hAlb/MmO96
         VorVFAdmJpqzttvELGfXt36cO4U533i1sPFCnmvO6p3/W2gnUA4/TKHIi2qSHtdJl+AN
         88kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=o7Koi4FjY35NcPpfGvkS5BrUvZescx1HotOe2Nv6/Qc=;
        b=sVX4ajXhnyHbav+62+ORlr8UYtONltLTxriVQIFkXcq9hro8Gpt2OUZG0+so4lPgBR
         09WGtTjQ0aF++u+pi0EE5uCCHxTKsOQfnEZ0VlNVqiMFNBSFFJo+FWSxveyp3SORKKue
         gkHO7BtG8ryKttXgpvbEacWt6ilPU7DW0qNpF8IaLyeaN44vVFktTclJ6G08jIjpLdAE
         468x2nXvMKMTv1WgqeSYuJSo56PkopLwOAxAGUA3af21UPkJVpRM/c7FGX/64xmm4Pdy
         HCHH7mjTdetaNO8LMsHe8segHFMkFL2C5DP3x0zPHjbLGnmxn58cT+InyFS+IBEJ7XOz
         depw==
X-Gm-Message-State: APt69E3+s5WRPCqPRuCytN5sKyfxBn/LWE11/K5xvIpdQ0KD22xGaKG8
        bNvMjTfzjYMeO+J/VQJIwjAVARf98lo=
X-Google-Smtp-Source: AAOMgpd5+knLbyVVV5A+2LbhGnLOLvYwRif0Ak10j1dAfU7zzvBeheFPtl8bpDsVadSi0B22gAkwww==
X-Received: by 2002:adf:8ab0:: with SMTP id y45-v6mr10671356wry.98.1530256459451;
        Fri, 29 Jun 2018 00:14:19 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 17-v6sm1036480wmm.21.2018.06.29.00.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 00:14:18 -0700 (PDT)
Subject: Re: [PATCH 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     Kevin Hilman <khilman@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        linux-mtd@lists.infradead.org, Liang Yang <liang.yang@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Jian Hu <jian.hu@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180613161314.14894-1-yixun.lan@amlogic.com>
 <20180613161314.14894-3-yixun.lan@amlogic.com>
 <20180624213844.2207ca6f@bbrezillon> <7ha7rfiz3c.fsf@baylibre.com>
 <20180628090034.0637a062@xps13> <7hr2kqfpam.fsf@baylibre.com>
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
Message-ID: <b39c87d0-6563-ee9d-51f0-aae6df462359@baylibre.com>
Date:   Fri, 29 Jun 2018 09:14:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7hr2kqfpam.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2018 01:45, Kevin Hilman wrote:
> Hi Miquel,
> 
> Miquel Raynal <miquel.raynal@bootlin.com> writes:
> 
>> On Wed, 27 Jun 2018 16:33:43 -0700, Kevin Hilman <khilman@baylibre.com>
>> wrote:
>>
>>> Hi Boris,
>>>
>>> Boris Brezillon <boris.brezillon@bootlin.com> writes:
>>>
>>>> Hi Yixun,
>>>>
>>>> On Wed, 13 Jun 2018 16:13:14 +0000
>>>> Yixun Lan <yixun.lan@amlogic.com> wrote:
>>>>  
>>>>> From: Liang Yang <liang.yang@amlogic.com>
>>>>>
>>>>> Add initial support for the Amlogic NAND flash controller which found
>>>>> in the Meson-GXBB/GXL/AXG SoCs.
>>>>>
>>>>> Singed-off-by: Liang Yang <liang.yang@amlogic.com>
>>>>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>>>>> ---
>>>>>  drivers/mtd/nand/raw/Kconfig      |    8 +
>>>>>  drivers/mtd/nand/raw/Makefile     |    3 +
>>>>>  drivers/mtd/nand/raw/meson_nand.c | 1422 +++++++++++++++++++++++++++++
>>>>>  3 files changed, 1433 insertions(+)
>>>>>  create mode 100644 drivers/mtd/nand/raw/meson_nand.c  
>>>>
>>>> Can you run checkpatch.pl --strict and fix the coding style issues?
>>>>  
>>>>>
>>>>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>>>>> index 19a2b283fbbe..b3c17a3ca8f4 100644
>>>>> --- a/drivers/mtd/nand/raw/Kconfig
>>>>> +++ b/drivers/mtd/nand/raw/Kconfig
>>>>> @@ -534,4 +534,12 @@ config MTD_NAND_MTK
>>>>>  	  Enables support for NAND controller on MTK SoCs.
>>>>>  	  This controller is found on mt27xx, mt81xx, mt65xx SoCs.
>>>>>  
>>>>> +config MTD_NAND_MESON
>>>>> +	tristate "Support for NAND flash controller on Amlogic's Meson SoCs"
>>>>> +	depends on ARCH_MESON || COMPILE_TEST
>>>>> +	select COMMON_CLK_REGMAP_MESON
>>>>> +	select MFD_SYSCON
>>>>> +	help
>>>>> +	  Enables support for NAND controller on Amlogic's Meson SoCs.
>>>>> +
>>>>>  endif # MTD_NAND
>>>>> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
>>>>> index 165b7ef9e9a1..cdf6162f38c3 100644
>>>>> --- a/drivers/mtd/nand/raw/Makefile
>>>>> +++ b/drivers/mtd/nand/raw/Makefile
>>>>> @@ -1,5 +1,7 @@
>>>>>  # SPDX-License-Identifier: GPL-2.0
>>>>>  
>>>>> +ccflags-$(CONFIG_MTD_NAND_MESON) += -I$(srctree)/drivers/clk/meson  
>>>>
>>>> Please don't do that. If you need to expose common regs, put them
>>>> in include/linux/soc/meson/. I'm also not sure why you need to access
>>>> the clk regs directly. Why can't you expose the MMC/NAND clk as a clk
>>>> provider whose driver would be placed in drivers/clk and which would use
>>>> the mmc syscon. This way the same clk driver could be used for both
>>>> MMC and NAND clk indifferently, and the NAND driver would be much
>>>> simpler.  
>>>
>>> [...]
>>>
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static const char * sd_emmc_ext_clk0_parent_names[MUX_CLK_NUM_PARENTS];
>>>>> +
>>>>> +static struct clk_regmap sd_emmc_c_ext_clk0_sel = {
>>>>> +	.data = &(struct clk_regmap_mux_data){
>>>>> +		.offset = SD_EMMC_CLOCK,
>>>>> +		.mask = 0x3,
>>>>> +		.shift = 6,
>>>>> +	},
>>>>> +	.hw.init = &(struct clk_init_data) {
>>>>> +		.name = "sd_emmc_c_nand_clk_mux",
>>>>> +		.ops = &clk_regmap_mux_ops,
>>>>> +		.parent_names = sd_emmc_ext_clk0_parent_names,
>>>>> +		.num_parents = ARRAY_SIZE(sd_emmc_ext_clk0_parent_names),
>>>>> +		.flags = CLK_SET_RATE_PARENT,
>>>>> +	},
>>>>> +};
>>>>> +
>>>>> +static struct clk_regmap sd_emmc_c_ext_clk0_div = {
>>>>> +	.data = &(struct clk_regmap_div_data){
>>>>> +		.offset = SD_EMMC_CLOCK,
>>>>> +		.shift = 0,
>>>>> +		.width = 6,
>>>>> +		.flags = CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,
>>>>> +	},
>>>>> +	.hw.init = &(struct clk_init_data) {
>>>>> +		.name = "sd_emmc_c_nand_clk_div",
>>>>> +		.ops = &clk_regmap_divider_ops,
>>>>> +		.parent_names = (const char *[]){ "sd_emmc_c_nand_clk_mux" },
>>>>> +		.num_parents = 1,
>>>>> +		.flags = CLK_SET_RATE_PARENT,
>>>>> +	},
>>>>> +};
>>>>> +
>>>>> +static int meson_nfc_clk_init(struct meson_nfc *nfc)
>>>>> +{
>>>>> +	struct clk_regmap *mux = &sd_emmc_c_ext_clk0_sel;
>>>>> +	struct clk_regmap *div = &sd_emmc_c_ext_clk0_div;
>>>>> +	struct clk *clk;
>>>>> +	int i, ret;
>>>>> +
>>>>> +	/* request core clock */
>>>>> +	nfc->core_clk = devm_clk_get(nfc->dev, "core");
>>>>> +	if (IS_ERR(nfc->core_clk)) {
>>>>> +		dev_err(nfc->dev, "failed to get core clk\n");
>>>>> +		return PTR_ERR(nfc->core_clk);
>>>>> +	}
>>>>> +
>>>>> +	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
>>>>> +	regmap_update_bits(nfc->reg_clk, 0,
>>>>> +			CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK,
>>>>> +			CLK_SELECT_NAND | CLK_ALWAYS_ON | CLK_DIV_MASK);
>>>>> +
>>>>> +	/* get the mux parents */
>>>>> +	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
>>>>> +		char name[16];
>>>>> +
>>>>> +		snprintf(name, sizeof(name), "clkin%d", i);
>>>>> +		clk = devm_clk_get(nfc->dev, name);
>>>>> +		if (IS_ERR(clk)) {
>>>>> +			if (clk != ERR_PTR(-EPROBE_DEFER))
>>>>> +				dev_err(nfc->dev, "Missing clock %s\n", name);
>>>>> +			return PTR_ERR(clk);
>>>>> +		}
>>>>> +
>>>>> +		sd_emmc_ext_clk0_parent_names[i] = __clk_get_name(clk);
>>>>> +	}
>>>>> +
>>>>> +	mux->map = nfc->reg_clk;
>>>>> +	clk = devm_clk_register(nfc->dev, &mux->hw);
>>>>> +	if (WARN_ON(IS_ERR(clk)))
>>>>> +		return PTR_ERR(clk);
>>>>> +
>>>>> +	div->map = nfc->reg_clk;
>>>>> +	nfc->device_clk = devm_clk_register(nfc->dev, &div->hw);
>>>>> +	if (WARN_ON(IS_ERR(nfc->device_clk)))
>>>>> +		return PTR_ERR(nfc->device_clk);
>>>>> +
>>>>> +	ret = clk_prepare_enable(nfc->core_clk);
>>>>> +	if (ret) {
>>>>> +		dev_err(nfc->dev, "failed to enable core clk\n");
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	ret = clk_prepare_enable(nfc->device_clk);
>>>>> +	if (ret) {
>>>>> +		dev_err(nfc->dev, "failed to enable device clk\n");
>>>>> +		clk_disable_unprepare(nfc->core_clk);
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}  
>>>>
>>>>
>>>> As said above, I don't like having a clk driver here, especially since
>>>> the registers you're accessing are not part of the NAND controller
>>>> registers. Please try to create a driver in drivers/clk/ for that.  
>>>
>>> We went back and forth on this one on some off-list reviews.
>>>
>>> Had we known that the NAND controller was (re)using the clock registers
>>> internal to the MMC IP block from the beginning, we would have written a
>>> clock provider in drivers/clk for this, and shared it.
>>>
>>> However, when I wrote the MMC driver[1] (already upstream) along with
>>> the bindings[2], we did not fathom that the internal mux and divider
>>> would be "borrowed" by another device. :(
>>>
>>> We only recently found out that the NAND controller "borrows" one of the
>>> MMC clocks, whose registers are inside the MMC range.  Taking the clock
>>> out of the MMC driver and into its own clock-provider implies redoing
>>> the MMC driver, as well as its bindings, which we wanted to avoid
>>> (especially the binding changes.)
>>>
>>> We (I can take the blame) decided that since the MMC and NAND are
>>> mutually exclusive (they also share pins), that allowing NAND to reuse
>>> the MMC range would be a good compromise.  The DT still accurately
>>> describes the hardware, but we don't have to throw a large wrench into
>>> the DT bindings just for a newly discovered shared clock.
>>>
>>> I agree, it's not the prettiest thing, but when we cannot know the full
>>> details of the hardware when we start, sometimes we end up in a bit of a
>>> mess that requires some compromise.
>>
>> I totally understand your situation but as MMC and NAND are mutually
>> exclusive, how is this a problem to have a dedicated clock driver used
>> only by the NAND controller (as maybe a first step)? I mean, if you
>> don't change the MMC bindings, then the MMC driver will still use its
>> own 'local' clock driver, right?
> 
> Yeah, I think you're right.  That would work too.
> 
>> I don't know if you can have two nodes reserving the same address
>> range though.

The idea was to override the mmc node by "syscon" when the board is in the
NAND case, since the eMMC controller won't be usable in this case anyway.

Neil

> 
> You can, but it's a race who gets to claim the region.
> 
> You'd have to have the new clock-controler disabled by default, and have
> any boards that use the NAND disable the MMC and enable the clock
> controller node.
> 
> But I think that should work.
> 
> Yixun, can you give this approach a try?
> 
> Kevin
> 

