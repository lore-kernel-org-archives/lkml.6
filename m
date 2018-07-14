Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A98ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704842089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YC/hEl+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704842089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeGNPB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 11:01:28 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42285 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeGNPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 11:01:28 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so67268651oib.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qUuT+BKt4h7I8QQQ0dQQOsuulbvFfPdCq5bu0wxu2Y=;
        b=YC/hEl+VCLTxwQPrYE1yuUdOPoKUG2uie1/HLE/JLI3RiQTLR2g4J3HOlnf1Cd6Bl9
         uy4M7Lp+6ai9g0gHk5N93K8nGdAohR50wL2bcIq5DLZAwbomQn+Vlkh8FBSnuaRRbEXI
         k1iGm5pfFzZ/UeAPPjikIVuJmajTayQCuUU7ylpUox4JRUH+cXRSoXnxEi+53zC2f6Yk
         2iE6r5DuM6tnz4hhQxF9XpH0Ds/AxF2owjXr4yMb1CBXdBAN7NgQN7RlyWimL0QjZ8FS
         k4YTuitZtuiuMW33dJCDTuKgrmt02DRDdvcyWJ9HnDTcSD6RpRGJSF1kUMRhzeseLGJK
         Pxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qUuT+BKt4h7I8QQQ0dQQOsuulbvFfPdCq5bu0wxu2Y=;
        b=kTckIUW74RAG1OWKveEnT/27Pv6TadpFuAwRyOcwxTFatrULRTVCWR9LHuFd9ffTxX
         lUcuwGv5MxJjxjVlWOn9hsNCqcAAw4pIIDIZoyfHFBQAND/Sqj2KgKLFrYICPbVB7F3G
         qTyv8dH5it5PoDVVsPrn8vmr4HhQnrlEUCmyp3FDsyfsEme1tZIQdkaK5SleX3lJYa4O
         lZz8Jaa8IhboRJ0ISUdZHdp5stUTohz+PyTdkVpjiupfQitHt/fbK2zmT0+6K1JPqDYP
         nA4G56dLYKkgw9jYv0zScKkBkDwPI1/ZSQ+jdfFQ6omNsZXRYI7BVl4iICOtXxqFvnWV
         B7Dg==
X-Gm-Message-State: AOUpUlG3pTiWw8nJootxndyagYHMnOTzNH/X563ktvpY7Ar7x8LeUfiR
        d51F/gv3h5Pvodv521JZd5OAPMcgCKJM/wAyuME=
X-Google-Smtp-Source: AAOMgpctRx7hXoCmXcArCjjiul2LCqQJ7EpOfXa9ESwImcBeB2dySYWvrt+UAsGRr4L9ugzcOpzeNU/k/sU/HZZBeNk=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr12208953oib.116.1531579329033;
 Sat, 14 Jul 2018 07:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
 <1530624110-4687-2-git-send-email-narmstrong@baylibre.com>
 <CAFBinCDBEbVSEzhM2WOhxNX1DZLiSrkeo7GWdxGzBpOUH3PKQw@mail.gmail.com>
 <7d83a0a4-5cde-7e4f-78a8-372ae8cb03d0@baylibre.com> <CAFBinCA5B87TkfOtQd==PxDK74kJ+XWMgY-36QK2TT9p-vAEUA@mail.gmail.com>
 <7hy3eknl3l.fsf@baylibre.com> <fb73556d-cf18-266c-e638-9dd92224b939@baylibre.com>
In-Reply-To: <fb73556d-cf18-266c-e638-9dd92224b939@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 14 Jul 2018 16:41:57 +0200
Message-ID: <CAFBinCDCbOrX8BaJcDpeiR=r6eSxj=OQ1voj-Lug=P7hyvu=hA@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: amlogic: Add Meson GX Clock Measure driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Jul 11, 2018 at 10:37 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 09/07/2018 23:41, Kevin Hilman wrote:
> > Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
> >
> >> Hi Neil,
> >>
> >> On Wed, Jul 4, 2018 at 10:41 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>>
> >>> Hi Martin,
> >>>
> >>> On 03/07/2018 21:18, Martin Blumenstingl wrote:
> >>>> Hi Neil,
> >>>>
> >>>> On Tue, Jul 3, 2018 at 3:23 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>>>>
> >>>>> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> >>>>> clock paths frequencies.
> >>>>> The precision is in the order of the MHz.
> >>>>>
> >>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >>>>> ---
> >>>>>  drivers/soc/amlogic/Kconfig                |   8 ++
> >>>>>  drivers/soc/amlogic/Makefile               |   1 +
> >>>>>  drivers/soc/amlogic/meson-gx-clk-measure.c | 224 +++++++++++++++++++++++++++++
> >>>>>  3 files changed, 233 insertions(+)
> >>>>>  create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c
> >>>>>
> >>>>> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
> >>>>> index b04f6e4..4a3217d 100644
> >>>>> --- a/drivers/soc/amlogic/Kconfig
> >>>>> +++ b/drivers/soc/amlogic/Kconfig
> >>>>> @@ -1,5 +1,13 @@
> >>>>>  menu "Amlogic SoC drivers"
> >>>>>
> >>>>> +config MESON_GX_CLK_MEASURE
> >>>>> +       bool "Amlogic Meson GX SoC Clock Measure driver"
> >>>>> +       depends on ARCH_MESON || COMPILE_TEST
> >>>>> +       default ARCH_MESON
> >>>>> +       help
> >>>>> +         Say yes to support of Measuring a set of internal SoC clocks
> >>>>> +         from the debugfs interface.
> >>>>> +
> >>>>>  config MESON_GX_SOCINFO
> >>>>>         bool "Amlogic Meson GX SoC Information driver"
> >>>>>         depends on ARCH_MESON || COMPILE_TEST
> >>>>> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
> >>>>> index 8fa3218..a0ad966 100644
> >>>>> --- a/drivers/soc/amlogic/Makefile
> >>>>> +++ b/drivers/soc/amlogic/Makefile
> >>>>> @@ -1,3 +1,4 @@
> >>>>> +obj-$(CONFIG_MESON_GX_CLK_MEASURE) += meson-gx-clk-measure.o
> >>>>>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
> >>>>>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
> >>>>>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
> >>>>> diff --git a/drivers/soc/amlogic/meson-gx-clk-measure.c b/drivers/soc/amlogic/meson-gx-clk-measure.c
> >>>>> new file mode 100644
> >>>>> index 0000000..434d9f3
> >>>>> --- /dev/null
> >>>>> +++ b/drivers/soc/amlogic/meson-gx-clk-measure.c
> >>>
> >>> [...]
> >>>
> >>>>> +       CLK_MSR_ID(57, "wave420l_c"),
> >>>>> +       CLK_MSR_ID(58, "wave420l_b"),
> >>>> AFAIK the Chips&Media WAVE420L video codec is only available on GXM (S912)
> >>>> I assume reading this on GXBB or GXL simply reads 0?
> >>>
> >>> Yes
> >>>
> >>>>
> >>>>> +       CLK_MSR_ID(59, "hcodec"),
> >>>>> +       CLK_MSR_ID(60, "alt_32k"),
> >>>>> +       CLK_MSR_ID(61, "gpio_msr"),
> >>>>> +       CLK_MSR_ID(62, "hevc"),
> >>>>> +       CLK_MSR_ID(66, "vid_lock"),
> >>>>> +       CLK_MSR_ID(70, "pwm_f"),
> >>>>> +       CLK_MSR_ID(71, "pwm_e"),
> >>>>> +       CLK_MSR_ID(72, "pwm_d"),
> >>>>> +       CLK_MSR_ID(73, "pwm_C"),
> >>>> should this be pwm_c (instead of pwm_C)?
> >>>>
> >>>>> +       CLK_MSR_ID(75, "aoclkx2_int"),
> >>>>> +       CLK_MSR_ID(76, "aoclk_int"),
> >>>>> +       CLK_MSR_ID(77, "rng_ring_osc_0"),
> >>>>> +       CLK_MSR_ID(78, "rng_ring_osc_1"),
> >>>>> +       CLK_MSR_ID(79, "rng_ring_osc_2"),
> >>>>> +       CLK_MSR_ID(80, "rng_ring_osc_3"),
> >>>>> +       CLK_MSR_ID(81, "vapb"),
> >>>>> +       CLK_MSR_ID(82, "ge2d"),
> >>>>> +};
> >>>> I did a quick check whether the clock IDs are really the same for all GX SoCs:
> >>>> apart from clocks missing on older SoCs (see for example the WAVE420L
> >>>> clocks above) there were only minor renames but no conflicts!
> >>>
> >>> I did the same work ! I will add this detail to the commit log.
> >>> Thanks for checking ;-)
> >> :)
> >>
> >>>>
> >>>>> +
> >>>>> +static int meson_gx_measure_id(struct meson_gx_msr *priv, unsigned int id)
> >>>>> +{
> >>>>> +       unsigned int val;
> >>>>> +       int ret;
> >>>>> +
> >>>>> +       regmap_write(priv->regmap, MSR_CLK_REG0, 0);
> >>>>> +
> >>>>> +       /* Set measurement gate to 50uS */
> >>>>> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_DIV,
> >>>>> +                          FIELD_PREP(MSR_CLK_DIV, DIV_50US));
> >>>>> +
> >>>>> +       /* Set ID */
> >>>>> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_CLK_SRC,
> >>>>> +                          FIELD_PREP(MSR_CLK_SRC, id));
> >>>>> +
> >>>>> +       /* Enable & Start */
> >>>>> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0,
> >>>>> +                          MSR_RUN | MSR_ENABLE,
> >>>>> +                          MSR_RUN | MSR_ENABLE);
> >>>>> +
> >>>>> +       ret = regmap_read_poll_timeout(priv->regmap, MSR_CLK_REG0,
> >>>>> +                                      val, !(val & MSR_BUSY), 10, 1000);
> >>>>> +       if (ret)
> >>>>> +               return ret;
> >>>>> +
> >>>>> +       /* Disable */
> >>>>> +       regmap_update_bits(priv->regmap, MSR_CLK_REG0, MSR_ENABLE, 0);
> >>>>> +
> >>>>> +       /* Get the value in MHz*64 */
> >>>>> +       regmap_read(priv->regmap, MSR_CLK_REG2, &val);
> >>>>> +
> >>>>> +       return (((val + 31) & MSR_VAL_MASK) / 64) * 1000000;
> >>>>> +}
> >>>>> +
> >>>>> +static int clk_msr_show(struct seq_file *s, void *data)
> >>>>> +{
> >>>>> +       struct meson_gx_msr_id *clk_msr_id = s->private;
> >>>>> +       int val;
> >>>>> +
> >>>>> +       val = meson_gx_measure_id(clk_msr_id->priv, clk_msr_id->id);
> >>>>> +       if (val < 0)
> >>>>> +               return val;
> >>>>> +
> >>>>> +       seq_printf(s, "%d\n", val);
> >>>
> >>> With jerome, we managed to have a much higher precision by cycling over the divider
> >>> and checking when the counter overflows. And I will print the precision in the clock debugfs
> >>> entry.
> >> great that you could even improve the precision!
> >>
> >>>>> +
> >>>>> +       return 0;
> >>>>> +}
> >>>>> +DEFINE_SHOW_ATTRIBUTE(clk_msr);
> >>>> have you considered modelling this as clock driver instead?
> >>>
> >>> Yes, but it can wait.
> >>> Actually this clk-msr can be feed to GEN_CLK and be outputted to a pad,
> >>> but all this is only for debug, so we can stick to debugfs for now.
> >>>
> >>> Question, should I separate the clocks in a subdirectory and add a summary file like
> >>> for the clk debugfs ?
> >>>
> >>>
> >>> /sys/kernel/debug/meson-clk-msr
> >>> ------------------|--- summary
> >>> ------------------|--- clks
> >>> -----------------------|--- ring_osc_out_ee_0
> >>> ...
> >>> -----------------------|--- ge2d
> >>>
> >>> ?
> >> this is exactly why I was curious if you considered implementing this
> >> as clock driver instead
> >> based on your description above each measured clock will have the
> >> following properties:
> >> - id (passed to the clkmsr IP block)
> >> - name (human readable name)
> >> - clock rate
> >> - accuracy
> >>
> >> doesn't CCF provide everything except "id"? you'll even get the summary
> >>
> >> can you explain how you would use the clkmsr output?
> >> here's how I would use it:
> >> - assume I'm debugging something broken
> >> - I suspect that it may be due to the clock setup
> >> - grep "suspicious-clock" /sys/kernel/debug/clk/clk_summary
> >> - compare the grep output with /sys/kernel/debug/meson-clk-msr/suspicious-clock
> >>
> >> if it was a CCF driver I could simply do:
> >> grep "suspicious-clock" /sys/kernel/debug/clk/clk_summary
> >> -> this would return "suspicious-clock" (which is what the kernel can
> >> configure) and "clkmsr_suspicious-clock" (which is what clkmsr reads)
>
> I'm concerned because it will add a bunch of duplicate clock that will be measured each time you cat clk_summary...
>
> I'm alsi concerned by the "CCF clock provider" feature, meaning we could feed the CLK_GEN with the clock selected
> by the clk-msr, but this mean we won't be able to change the measured clock at will, only the CCF will select the
> clock to measure. and we will loose the ability to have a summary of all internal clocks from debugfs.
that is a good point. I think this applies to both, the pure debugfs
solution as well as any CCF based solution

> >
> > Even futther, Couldn't this measure IP be used by the current CCF code
> > (as an additonal, optional property) such the the debugfs clk_summary
> > uses it directly?
>
> It will need hacking the CCF core, but as Jerome and I said, this can be done later on !
> We can push a debugfs version and migrate it to CCF when we figure out how to integrate it
> correctly.
Jerome already raised concerns (on IRC) that measuring the clock takes
too much time and using a CCF clock provider would mean that "cat
/sys/kernel/debug/clk/clk_summary" would be slow
if that's the case then I'm happy with a debugfs solution which can be
migrated wo whatever framework suits best in the future


Regards
Martin
