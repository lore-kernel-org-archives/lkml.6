Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D85C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4FB208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aj5Y5MAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4FB208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933342AbeGIVlG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:41:06 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32780 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933060AbeGIVlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:41:04 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so6611141plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 14:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=7Kwh/39HXaZrk4a3THBxCjrRn2zqXRADDjxmWmIduzI=;
        b=aj5Y5MAnzCMU0v0z6GvxV3ZFUWTvgxu7dw7d7C+0oG9AMviO/wUi2fWJYr8Fm/TD3Z
         rWsTAzBEUmKwBrVUjvMa2HTYbD8NRONgcJlhwnRGSmFmKxizUwMH+wVChjnqo8n3x+vm
         cUjhRDOxGN9wRP9nAO9uRObfNJA5trxIIw44dteodPW87zMvwZJIAZQKX1L6qYYUtrnG
         em33XDlaaS4k4mTr5vlKtmhOmyUFg0F2TOedN0ffTcWuBofILYqmx0xudzqLYh5laAHf
         SzOVfyH3K+fcFjFnZKP2rPsABGjntk853S8P3UUKrKbMInUFh4Z8yOJkJxHF9qvolsDt
         Umrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7Kwh/39HXaZrk4a3THBxCjrRn2zqXRADDjxmWmIduzI=;
        b=SED6FhCIBoGtgM61aU+IVtD+/7LwYD+0mbVqq23vVQMIgu8TYq/Hz+VtVLRDG7+Tgs
         qGsfe/ud5Zz46otknhnwTZDsIpk+ghtyLZryHtD811YjNJiV18lkSEF/1OHuErjp/Yos
         buIiZqHis1SVM1+9cY/yC7Qd3yQ3969Jy7IofJoFlzbC1H0YEHRBo4iuvvGWa94H4s7+
         kLfpPgocWng9NbJcCFQG52HreR1CLQ5ULi/Wlvy0StrW+58FPQQHqZKQXmeglftHUe0K
         SkBZaRAYr2V3SXNCTZBcpEcZX0AbUVRy8StHY85IPKn4N5N/Rc/OKoKi3xBGD8yCoEWL
         oGUQ==
X-Gm-Message-State: APt69E31VpIqa/6KBQh19bTpBPME45hYUxbiojQmG65bAYrxGWH/wYt8
        pVm9kzo0fY+IROCG++KIKbMCBw==
X-Google-Smtp-Source: AAOMgpdVS4XYEI0ddv/4RAloNcHsjQNp6957gR6Qz6jgsMeuk9CK2wEYeHwwNEIEvyOvFxiTzthlWQ==
X-Received: by 2002:a17:902:2924:: with SMTP id g33-v6mr22473342plb.26.1531172463444;
        Mon, 09 Jul 2018 14:41:03 -0700 (PDT)
Received: from localhost ([98.237.141.101])
        by smtp.googlemail.com with ESMTPSA id v15-v6sm32773933pfk.12.2018.07.09.14.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 14:41:02 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] soc: amlogic: Add Meson GX Clock Measure driver
Organization: BayLibre
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
        <1530624110-4687-2-git-send-email-narmstrong@baylibre.com>
        <CAFBinCDBEbVSEzhM2WOhxNX1DZLiSrkeo7GWdxGzBpOUH3PKQw@mail.gmail.com>
        <7d83a0a4-5cde-7e4f-78a8-372ae8cb03d0@baylibre.com>
        <CAFBinCA5B87TkfOtQd==PxDK74kJ+XWMgY-36QK2TT9p-vAEUA@mail.gmail.com>
Date:   Mon, 09 Jul 2018 14:41:02 -0700
In-Reply-To: <CAFBinCA5B87TkfOtQd==PxDK74kJ+XWMgY-36QK2TT9p-vAEUA@mail.gmail.com>
        (Martin Blumenstingl's message of "Wed, 4 Jul 2018 15:44:09 +0200")
Message-ID: <7hy3eknl3l.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Neil,
>
> On Wed, Jul 4, 2018 at 10:41 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi Martin,
>>
>> On 03/07/2018 21:18, Martin Blumenstingl wrote:
>> > Hi Neil,
>> >
>> > On Tue, Jul 3, 2018 at 3:23 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>> >>
>> >> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
>> >> clock paths frequencies.
>> >> The precision is in the order of the MHz.
>> >>
>> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> >> ---
>> >>  drivers/soc/amlogic/Kconfig                |   8 ++
>> >>  drivers/soc/amlogic/Makefile               |   1 +
>> >>  drivers/soc/amlogic/meson-gx-clk-measure.c | 224 +++++++++++++++++++++++++++++
>> >>  3 files changed, 233 insertions(+)
>> >>  create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c
>> >>
>> >> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
>> >> index b04f6e4..4a3217d 100644
>> >> --- a/drivers/soc/amlogic/Kconfig
>> >> +++ b/drivers/soc/amlogic/Kconfig
>> >> @@ -1,5 +1,13 @@
>> >>  menu "Amlogic SoC drivers"
>> >>
>> >> +config MESON_GX_CLK_MEASURE
>> >> +       bool "Amlogic Meson GX SoC Clock Measure driver"
>> >> +       depends on ARCH_MESON || COMPILE_TEST
>> >> +       default ARCH_MESON
>> >> +       help
>> >> +         Say yes to support of Measuring a set of internal SoC clocks
>> >> +         from the debugfs interface.
>> >> +
>> >>  config MESON_GX_SOCINFO
>> >>         bool "Amlogic Meson GX SoC Information driver"
>> >>         depends on ARCH_MESON || COMPILE_TEST
>> >> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
>> >> index 8fa3218..a0ad966 100644
>> >> --- a/drivers/soc/amlogic/Makefile
>> >> +++ b/drivers/soc/amlogic/Makefile
>> >> @@ -1,3 +1,4 @@
>> >> +obj-$(CONFIG_MESON_GX_CLK_MEASURE) += meson-gx-clk-measure.o
>> >>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>> >>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>> >>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
>> >> diff --git a/drivers/soc/amlogic/meson-gx-clk-measure.c b/drivers/soc/amlogic/meson-gx-clk-measure.c
>> >> new file mode 100644
>> >> index 0000000..434d9f3
>> >> --- /dev/null
>> >> +++ b/drivers/soc/amlogic/meson-gx-clk-measure.c
>>
>> [...]
>>
>> >> +       CLK_MSR_ID(57, "wave420l_c"),
>> >> +       CLK_MSR_ID(58, "wave420l_b"),
>> > AFAIK the Chips&Media WAVE420L video codec is only available on GXM (S912)
>> > I assume reading this on GXBB or GXL simply reads 0?
>>
>> Yes
>>
>> >
>> >> +       CLK_MSR_ID(59, "hcodec"),
>> >> +       CLK_MSR_ID(60, "alt_32k"),
>> >> +       CLK_MSR_ID(61, "gpio_msr"),
>> >> +       CLK_MSR_ID(62, "hevc"),
>> >> +       CLK_MSR_ID(66, "vid_lock"),
>> >> +       CLK_MSR_ID(70, "pwm_f"),
>> >> +       CLK_MSR_ID(71, "pwm_e"),
>> >> +       CLK_MSR_ID(72, "pwm_d"),
>> >> +       CLK_MSR_ID(73, "pwm_C"),
>> > should this be pwm_c (instead of pwm_C)?
>> >
>> >> +       CLK_MSR_ID(75, "aoclkx2_int"),
>> >> +       CLK_MSR_ID(76, "aoclk_int"),
>> >> +       CLK_MSR_ID(77, "rng_ring_osc_0"),
>> >> +       CLK_MSR_ID(78, "rng_ring_osc_1"),
>> >> +       CLK_MSR_ID(79, "rng_ring_osc_2"),
>> >> +       CLK_MSR_ID(80, "rng_ring_osc_3"),
>> >> +       CLK_MSR_ID(81, "vapb"),
>> >> +       CLK_MSR_ID(82, "ge2d"),
>> >> +};
>> > I did a quick check whether the clock IDs are really the same for all GX SoCs:
>> > apart from clocks missing on older SoCs (see for example the WAVE420L
>> > clocks above) there were only minor renames but no conflicts!
>>
>> I did the same work ! I will add this detail to the commit log.
>> Thanks for checking ;-)
> :)
>
>> >
>> >> +
>> >> +static int meson_gx_measure_id(struct meson_gx_msr *priv, unsigned int id)
>> >> +{
>> >> +       unsigned int val;
>> >> +       int ret;
>> >> +
>> >> +       regmap_write(priv->regmap, MSR_CLK_REG0, 0);
>> >> +
>> >> +       /* Set measurement gate to 50uS */
>> >> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_DIV,
>> >> +                          FIELD_PREP(MSR_CLK_DIV, DIV_50US));
>> >> +
>> >> +       /* Set ID */
>> >> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_SRC,
>> >> +                          FIELD_PREP(MSR_CLK_SRC, id));
>> >> +
>> >> +       /* Enable & Start */
>> >> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0,
>> >> +                          MSR_RUN | MSR_ENABLE,
>> >> +                          MSR_RUN | MSR_ENABLE);
>> >> +
>> >> +       ret = regmap_read_poll_timeout(priv->regmap, MSR_CLK_REG0,
>> >> +                                      val, !(val & MSR_BUSY), 10, 1000);
>> >> +       if (ret)
>> >> +               return ret;
>> >> +
>> >> +       /* Disable */
>> >> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_ENABLE, 0);
>> >> +
>> >> +       /* Get the value in MHz*64 */
>> >> +       regmap_read(priv->regmap, MSR_CLK_REG2, &val);
>> >> +
>> >> +       return (((val + 31) & MSR_VAL_MASK) / 64) * 1000000;
>> >> +}
>> >> +
>> >> +static int clk_msr_show(struct seq_file *s, void *data)
>> >> +{
>> >> +       struct meson_gx_msr_id *clk_msr_id = s->private;
>> >> +       int val;
>> >> +
>> >> +       val = meson_gx_measure_id(clk_msr_id->priv, clk_msr_id->id);
>> >> +       if (val < 0)
>> >> +               return val;
>> >> +
>> >> +       seq_printf(s, "%d\n", val);
>>
>> With jerome, we managed to have a much higher precision by cycling over the divider
>> and checking when the counter overflows. And I will print the precision in the clock debugfs
>> entry.
> great that you could even improve the precision!
>
>> >> +
>> >> +       return 0;
>> >> +}
>> >> +DEFINE_SHOW_ATTRIBUTE(clk_msr);
>> > have you considered modelling this as clock driver instead?
>>
>> Yes, but it can wait.
>> Actually this clk-msr can be feed to GEN_CLK and be outputted to a pad,
>> but all this is only for debug, so we can stick to debugfs for now.
>>
>> Question, should I separate the clocks in a subdirectory and add a summary file like
>> for the clk debugfs ?
>>
>>
>> /sys/kernel/debug/meson-clk-msr
>> ------------------|--- summary
>> ------------------|--- clks
>> -----------------------|--- ring_osc_out_ee_0
>> ...
>> -----------------------|--- ge2d
>>
>> ?
> this is exactly why I was curious if you considered implementing this
> as clock driver instead
> based on your description above each measured clock will have the
> following properties:
> - id (passed to the clkmsr IP block)
> - name (human readable name)
> - clock rate
> - accuracy
>
> doesn't CCF provide everything except "id"? you'll even get the summary
>
> can you explain how you would use the clkmsr output?
> here's how I would use it:
> - assume I'm debugging something broken
> - I suspect that it may be due to the clock setup
> - grep "suspicious-clock" /sys/kernel/debug/clk/clk_summary
> - compare the grep output with /sys/kernel/debug/meson-clk-msr/suspicious-clock
>
> if it was a CCF driver I could simply do:
> grep "suspicious-clock" /sys/kernel/debug/clk/clk_summary
> -> this would return "suspicious-clock" (which is what the kernel can
> configure) and "clkmsr_suspicious-clock" (which is what clkmsr reads)

Even futther, Couldn't this measure IP be used by the current CCF code
(as an additonal, optional property) such the the debugfs clk_summary
uses it directly?

Kevin
