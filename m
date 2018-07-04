Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C7AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE50C23F66
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eH2uq6gs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE50C23F66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964797AbeGDInm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:43:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53396 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934390AbeGDIly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:41:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id b188-v6so4916674wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xGuQbxm17SxbiIJPYrxE+NvF9qRZl7DDt0MkuZ4XeBM=;
        b=eH2uq6gsC9B2W1PHb+FVEhmR0k4dSaz0YCGJ1C4eX+PvfCOeHfwbOinlSenjtGL0lg
         x22Td3A9zr2LWyGcWo/SrG6zdd5Pvt0o59/Sx43sssd8wEASjekiEAHZ7cyzU+m5U0ef
         pZN9lSHnnV4vNS/wHent9PkZDow2VbnPT2O3K3unwbF/orZXp9YmkEaHFDbqeLXI8I35
         Z7hKiOBwLLYf9fbSoyw5ha+HaR8Q4qgMxRxLQFnOgOsrEOEkugTI/qhBhxGYflFMXMy+
         oz2lMSZgPQx/FZgQS8y0KFLH3EG7JSAl25UDgJBGF+NLrj8M+xchr3Ykr4bOoTPmvSjK
         87rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xGuQbxm17SxbiIJPYrxE+NvF9qRZl7DDt0MkuZ4XeBM=;
        b=fAaropcGeiLPrLnDDkDpjSvLHPKzS8+WOAS3jgheiQaDuJcAjXQJn3YsKs6P4UGtFY
         Jlt4DlzrHtzw3nlWDlx7SGW3Am43jwLHM8Jla7dkt+cY+M50fgHI21rPkbNmtKUd8KkU
         BBZXejra/6RjGnOmM+gqIQAbgssjphcr1vTWvQDFX5Kwb+ZPfDINKS3cbVb5vsvihgX7
         whtKWCfP+ABiXWLp8AxAna4iowGMl3GYz+WVIAFtyyYhgAZpOTN6/vMfLK4JHINIh1xj
         Kkw2Wh5Z+mbOabAMP9/51BhoPGL4GP82+DuiJv/eV/IIhfIfpusxBP4CXub0HYtJpLs2
         M2Iw==
X-Gm-Message-State: APt69E33bIKTHqCxd9XmnSNeZYG3IPmM2phlnuQe5Ek5UWoQEnmJfd8/
        gC4ZkUZ6wChHd40EBGEO627BcA==
X-Google-Smtp-Source: AAOMgpd1uCWEDY9lR/bg/OZnkOAWvCZxytZB2NHaJPLhhFAW1vjn614qUaU8F7sWpV15g4SwLpzT2A==
X-Received: by 2002:a1c:1414:: with SMTP id 20-v6mr122518wmu.61.1530693712787;
        Wed, 04 Jul 2018 01:41:52 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b3-v6sm2677058wrn.59.2018.07.04.01.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 01:41:52 -0700 (PDT)
Subject: Re: [PATCH 1/3] soc: amlogic: Add Meson GX Clock Measure driver
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
 <1530624110-4687-2-git-send-email-narmstrong@baylibre.com>
 <CAFBinCDBEbVSEzhM2WOhxNX1DZLiSrkeo7GWdxGzBpOUH3PKQw@mail.gmail.com>
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
Message-ID: <7d83a0a4-5cde-7e4f-78a8-372ae8cb03d0@baylibre.com>
Date:   Wed, 4 Jul 2018 10:41:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDBEbVSEzhM2WOhxNX1DZLiSrkeo7GWdxGzBpOUH3PKQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 03/07/2018 21:18, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Tue, Jul 3, 2018 at 3:23 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
>> clock paths frequencies.
>> The precision is in the order of the MHz.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/soc/amlogic/Kconfig                |   8 ++
>>  drivers/soc/amlogic/Makefile               |   1 +
>>  drivers/soc/amlogic/meson-gx-clk-measure.c | 224 +++++++++++++++++++++++++++++
>>  3 files changed, 233 insertions(+)
>>  create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c
>>
>> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
>> index b04f6e4..4a3217d 100644
>> --- a/drivers/soc/amlogic/Kconfig
>> +++ b/drivers/soc/amlogic/Kconfig
>> @@ -1,5 +1,13 @@
>>  menu "Amlogic SoC drivers"
>>
>> +config MESON_GX_CLK_MEASURE
>> +       bool "Amlogic Meson GX SoC Clock Measure driver"
>> +       depends on ARCH_MESON || COMPILE_TEST
>> +       default ARCH_MESON
>> +       help
>> +         Say yes to support of Measuring a set of internal SoC clocks
>> +         from the debugfs interface.
>> +
>>  config MESON_GX_SOCINFO
>>         bool "Amlogic Meson GX SoC Information driver"
>>         depends on ARCH_MESON || COMPILE_TEST
>> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
>> index 8fa3218..a0ad966 100644
>> --- a/drivers/soc/amlogic/Makefile
>> +++ b/drivers/soc/amlogic/Makefile
>> @@ -1,3 +1,4 @@
>> +obj-$(CONFIG_MESON_GX_CLK_MEASURE) += meson-gx-clk-measure.o
>>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
>> diff --git a/drivers/soc/amlogic/meson-gx-clk-measure.c b/drivers/soc/amlogic/meson-gx-clk-measure.c
>> new file mode 100644
>> index 0000000..434d9f3
>> --- /dev/null
>> +++ b/drivers/soc/amlogic/meson-gx-clk-measure.c

[...]

>> +       CLK_MSR_ID(57, "wave420l_c"),
>> +       CLK_MSR_ID(58, "wave420l_b"),
> AFAIK the Chips&Media WAVE420L video codec is only available on GXM (S912)
> I assume reading this on GXBB or GXL simply reads 0?

Yes

> 
>> +       CLK_MSR_ID(59, "hcodec"),
>> +       CLK_MSR_ID(60, "alt_32k"),
>> +       CLK_MSR_ID(61, "gpio_msr"),
>> +       CLK_MSR_ID(62, "hevc"),
>> +       CLK_MSR_ID(66, "vid_lock"),
>> +       CLK_MSR_ID(70, "pwm_f"),
>> +       CLK_MSR_ID(71, "pwm_e"),
>> +       CLK_MSR_ID(72, "pwm_d"),
>> +       CLK_MSR_ID(73, "pwm_C"),
> should this be pwm_c (instead of pwm_C)?
> 
>> +       CLK_MSR_ID(75, "aoclkx2_int"),
>> +       CLK_MSR_ID(76, "aoclk_int"),
>> +       CLK_MSR_ID(77, "rng_ring_osc_0"),
>> +       CLK_MSR_ID(78, "rng_ring_osc_1"),
>> +       CLK_MSR_ID(79, "rng_ring_osc_2"),
>> +       CLK_MSR_ID(80, "rng_ring_osc_3"),
>> +       CLK_MSR_ID(81, "vapb"),
>> +       CLK_MSR_ID(82, "ge2d"),
>> +};
> I did a quick check whether the clock IDs are really the same for all GX SoCs:
> apart from clocks missing on older SoCs (see for example the WAVE420L
> clocks above) there were only minor renames but no conflicts!

I did the same work ! I will add this detail to the commit log.
Thanks for checking ;-)

> 
>> +
>> +static int meson_gx_measure_id(struct meson_gx_msr *priv, unsigned int id)
>> +{
>> +       unsigned int val;
>> +       int ret;
>> +
>> +       regmap_write(priv->regmap, MSR_CLK_REG0, 0);
>> +
>> +       /* Set measurement gate to 50uS */
>> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_DIV,
>> +                          FIELD_PREP(MSR_CLK_DIV, DIV_50US));
>> +
>> +       /* Set ID */
>> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_SRC,
>> +                          FIELD_PREP(MSR_CLK_SRC, id));
>> +
>> +       /* Enable & Start */
>> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0,
>> +                          MSR_RUN | MSR_ENABLE,
>> +                          MSR_RUN | MSR_ENABLE);
>> +
>> +       ret = regmap_read_poll_timeout(priv->regmap, MSR_CLK_REG0,
>> +                                      val, !(val & MSR_BUSY), 10, 1000);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Disable */
>> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_ENABLE, 0);
>> +
>> +       /* Get the value in MHz*64 */
>> +       regmap_read(priv->regmap, MSR_CLK_REG2, &val);
>> +
>> +       return (((val + 31) & MSR_VAL_MASK) / 64) * 1000000;
>> +}
>> +
>> +static int clk_msr_show(struct seq_file *s, void *data)
>> +{
>> +       struct meson_gx_msr_id *clk_msr_id = s->private;
>> +       int val;
>> +
>> +       val = meson_gx_measure_id(clk_msr_id->priv, clk_msr_id->id);
>> +       if (val < 0)
>> +               return val;
>> +
>> +       seq_printf(s, "%d\n", val);

With jerome, we managed to have a much higher precision by cycling over the divider
and checking when the counter overflows. And I will print the precision in the clock debugfs
entry.

>> +
>> +       return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(clk_msr);
> have you considered modelling this as clock driver instead?

Yes, but it can wait.
Actually this clk-msr can be feed to GEN_CLK and be outputted to a pad,
but all this is only for debug, so we can stick to debugfs for now.

Question, should I separate the clocks in a subdirectory and add a summary file like
for the clk debugfs ?


/sys/kernel/debug/meson-clk-msr
------------------|--- summary
------------------|--- clks
-----------------------|--- ring_osc_out_ee_0
...
-----------------------|--- ge2d

?

> 
>> +
>> +static const struct regmap_config clk_msr_regmap_config = {
>> +       .reg_bits = 32,
>> +       .val_bits = 32,
>> +       .reg_stride = 4,
>> +       .max_register = MSR_CLK_REG2,
>> +};
>> +
>> +static int meson_gx_msr_probe(struct platform_device *pdev)
>> +{
>> +       struct meson_gx_msr *priv;
>> +       struct resource *res;
>> +       struct dentry *root;
>> +       void __iomem *base;
>> +       int i;
>> +
>> +       priv = devm_kzalloc(&pdev->dev, sizeof(struct meson_gx_msr),
>> +                           GFP_KERNEL);
>> +       if (!priv)
>> +               return -ENOMEM;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(base)) {
>> +               dev_err(&pdev->dev, "io resource mapping failed\n");
>> +               return PTR_ERR(base);
>> +       }
>> +
>> +       priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
>> +                                             &clk_msr_regmap_config);
>> +       if (IS_ERR(priv->regmap))
>> +               return PTR_ERR(priv->regmap);
>> +
>> +       root = debugfs_create_dir("meson-clk-msr", NULL);
>> +
>> +       for (i = 0 ; i < CLK_MSR_MAX ; ++i) {
>> +               if (!clk_msr[i].name)
>> +                       continue;
>> +
>> +               clk_msr[i].priv = priv;
>> +
>> +               debugfs_create_file(clk_msr[i].name, 0444, root,
>> +                                   &clk_msr[i], &clk_msr_fops);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id meson_gx_msr_match_table[] = {
>> +       { .compatible = "amlogic,meson-gx-clk-measure" },
> maybe pass the meson_gx_msr_id table here because it seems easy to add
> support for AXG and Meson8/Meson8b/Meson8m2 later on

Yes, I will rename the driver to be generic and pass the table as match data.

> 
> 
> Regards
> Martin
> 

Thanks for reviewing !

Neil
