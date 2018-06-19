Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76161C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1500220020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Kiu8clZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1500220020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967108AbeFSRHo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:07:44 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36462 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966650AbeFSRHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:07:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id a12-v6so176302pfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=0Ulfec399kta8V5wMDOmua5VI2B7rHEqE/BNrxoarFI=;
        b=Kiu8clZWFSFXEA8NP3l2K+Z4wCKdRJzqfiCrdzXAKltiTCMge/ZZRhej/6pX5I8QaR
         I0tG/TDB8UZzo038B24+kx7qiiW4TmcMuTBB5Jdm5cpZU034yP1ZEz3z2JvjJbIXEPcj
         MGzPzNvlVRmBUkSv9OwyunrYKIWqZYNmSV9BOeWVkEm4RDRXp54Plqj0IvRWzZVguwff
         xLyess1pi9EOnkq+RghMWq7eBl7QeUi/UgeCDQ8j6OQnA2QARhNyKPYR3avF6u4rRvDA
         aUxKxH47YTZBlivYXCprTcrZLfmhiQeL3Sn3oTHXAppX2KCmOPj/1yscxLUcxGB/djAS
         ygkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=0Ulfec399kta8V5wMDOmua5VI2B7rHEqE/BNrxoarFI=;
        b=sbLcHq1s0kJSD18t09+2Lb5bof4SzOnuXzWdqTqPqs1wCQ/ywIemw7SYdBdOLZxT0o
         UwyzL+FaKanSILDDl14JL2exlvR2os3VgeA+vFrc/kg6aL+VRzerWhte6u8JjW7mGDXp
         MO5Emt+bsgbNFka8z/geGlJ8MxPr6wvR2LAYQolsRTQAzI0ceHe0dk6eGySKiARohKGz
         pI5Y4Qc8AGKXw2E+2ZvQk0OWniWYXs22YjJhtwZf86HGZQe91PtGYFX1wQBHDfDqFCl2
         4Gj+e/NY8e5H2QvNV2LQLHLGlRfED7g6ghJXMbYlkKdfE5siuFAupPVSEdM32u1aMXHE
         vWqw==
X-Gm-Message-State: APt69E1mCaZlWqbm2L65xx5CAcA2u1vNVcgVYkyLLlKvyNqLbNoTrnlD
        sU3lFMO1kcEaNhKSE3TphdaEyQ==
X-Google-Smtp-Source: ADUXVKKm7n1lJmtcP2glbvX6ZeILkmukyyH4XFWpcL6+zuJYrenbg/e+NiROkU+JhbYgLwiLZKZpEw==
X-Received: by 2002:a62:d653:: with SMTP id r80-v6mr19021538pfg.54.1529428060715;
        Tue, 19 Jun 2018 10:07:40 -0700 (PDT)
Received: from localhost ([2605:e000:151d:96f:170:3319:9294:4203])
        by smtp.gmail.com with ESMTPSA id m16-v6sm150629pgu.67.2018.06.19.10.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 10:07:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Boyd <sboyd@kernel.org>
From:   Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <20180619144141.8506-1-jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180619144141.8506-1-jbrunet@baylibre.com>
Message-ID: <20180619170737.33232.41279@harbor.lan>
User-Agent: alot/0.7
Subject: Re: [PATCH v4] clk: add duty cycle support
Date:   Tue, 19 Jun 2018 10:07:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-06-19 07:41:41)
> Add the possibility to apply and query the clock signal duty cycle ratio.
> =

> This is useful when the duty cycle of the clock signal depends on some
> other parameters controlled by the clock framework.
> =

> For example, the duty cycle of a divider may depends on the raw divider
> setting (ratio =3D N / div) , which is controlled by the CCF. In such cas=
e,
> going through the pwm framework to control the duty cycle ratio of this
> clock would be a burden.
> =

> A clock provider is not required to implement the operation to set and get
> the duty cycle. If it does not implement .get_duty_cycle(), the ratio is
> assumed to be 50%.
> =

> This change also adds a new flag, CLK_DUTY_CYCLE_PARENT. This flag should
> be used to indicate that a clock, such as gates and muxes, may inherit
> the duty cycle ratio of its parent clock. If a clock does not provide a
> get_duty_cycle() callback and has CLK_DUTY_CYCLE_PARENT, then the call
> will be directly forwarded to its parent clock, if any. For
> set_duty_cycle(), the clock should also have CLK_SET_RATE_PARENT for the
> call to be forwarded
> =

> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied to clk-core-duty-cycle.

Regards,
Mike

> ---
> =

> The series has been developed to handled the sample clocks provided by
> audio clock controller of amlogic's A113 SoC. To support i2s modes, this
> clock need to have a 50% duty cycle ratio, while it should be just one
> pulse of the parent clock in dsp modes.
> =

> Changes since v3 [2]:
>  - rebased on top of v4.18-rc1
> =

> Changes since v2 [1]:
>  - Fix kbuild robot issue with the trace file (imcomplete change related
>    to clk_duty structure)
> =

> Changes since v1 [0]:
>  - Use a structure to hold the duty cycle ratio
>  - Change the way parent traversal is done, so the core framework is
>    more aware of what is going on. Pass-through ops dropped as a result
>  - Only one debugfs entry for the duty cycle ratio, instead of 2
>  - Minor fixes as pointed out by Stephen
> =

> [0]: https://lkml.kernel.org/r/20180416175743.20826-1-jbrunet@baylibre.com
> [1]: https://lkml.kernel.org/r/20180420153431.13003-1-jbrunet@baylibre.com
> [2]: https://lkml.kernel.org/r/20180420211141.28929-1-jbrunet@baylibre.com
> =

>  drivers/clk/clk.c            | 199 +++++++++++++++++++++++++++++++++++++=
++++--
>  include/linux/clk-provider.h |  26 ++++++
>  include/linux/clk.h          |  33 +++++++
>  include/trace/events/clk.h   |  36 ++++++++
>  4 files changed, 289 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 97c09243fb21..e108f591d84a 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -68,6 +68,7 @@ struct clk_core {
>         unsigned long           max_rate;
>         unsigned long           accuracy;
>         int                     phase;
> +       struct clk_duty         duty;
>         struct hlist_head       children;
>         struct hlist_node       child_node;
>         struct hlist_head       clks;
> @@ -2412,6 +2413,172 @@ int clk_get_phase(struct clk *clk)
>  }
>  EXPORT_SYMBOL_GPL(clk_get_phase);
>  =

> +static void clk_core_reset_duty_cycle_nolock(struct clk_core *core)
> +{
> +       /* Assume a default value of 50% */
> +       core->duty.num =3D 1;
> +       core->duty.den =3D 2;
> +}
> +
> +static int clk_core_update_duty_cycle_parent_nolock(struct clk_core *cor=
e);
> +
> +static int clk_core_update_duty_cycle_nolock(struct clk_core *core)
> +{
> +       struct clk_duty *duty =3D &core->duty;
> +       int ret =3D 0;
> +
> +       if (!core->ops->get_duty_cycle)
> +               return clk_core_update_duty_cycle_parent_nolock(core);
> +
> +       ret =3D core->ops->get_duty_cycle(core->hw, duty);
> +       if (ret)
> +               goto reset;
> +
> +       /* Don't trust the clock provider too much */
> +       if (duty->den =3D=3D 0 || duty->num > duty->den) {
> +               ret =3D -EINVAL;
> +               goto reset;
> +       }
> +
> +       return 0;
> +
> +reset:
> +       clk_core_reset_duty_cycle_nolock(core);
> +       return ret;
> +}
> +
> +static int clk_core_update_duty_cycle_parent_nolock(struct clk_core *cor=
e)
> +{
> +       int ret =3D 0;
> +
> +       if (core->parent &&
> +           core->flags & CLK_DUTY_CYCLE_PARENT) {
> +               ret =3D clk_core_update_duty_cycle_nolock(core->parent);
> +               memcpy(&core->duty, &core->parent->duty, sizeof(core->dut=
y));
> +       } else {
> +               clk_core_reset_duty_cycle_nolock(core);
> +       }
> +
> +       return ret;
> +}
> +
> +static int clk_core_set_duty_cycle_parent_nolock(struct clk_core *core,
> +                                                struct clk_duty *duty);
> +
> +static int clk_core_set_duty_cycle_nolock(struct clk_core *core,
> +                                         struct clk_duty *duty)
> +{
> +       int ret;
> +
> +       lockdep_assert_held(&prepare_lock);
> +
> +       if (clk_core_rate_is_protected(core))
> +               return -EBUSY;
> +
> +       trace_clk_set_duty_cycle(core, duty);
> +
> +       if (!core->ops->set_duty_cycle)
> +               return clk_core_set_duty_cycle_parent_nolock(core, duty);
> +
> +       ret =3D core->ops->set_duty_cycle(core->hw, duty);
> +       if (!ret)
> +               memcpy(&core->duty, duty, sizeof(*duty));
> +
> +       trace_clk_set_duty_cycle_complete(core, duty);
> +
> +       return ret;
> +}
> +
> +static int clk_core_set_duty_cycle_parent_nolock(struct clk_core *core,
> +                                                struct clk_duty *duty)
> +{
> +       int ret =3D 0;
> +
> +       if (core->parent &&
> +           core->flags & (CLK_DUTY_CYCLE_PARENT | CLK_SET_RATE_PARENT)) {
> +               ret =3D clk_core_set_duty_cycle_nolock(core->parent, duty=
);
> +               memcpy(&core->duty, &core->parent->duty, sizeof(core->dut=
y));
> +       }
> +
> +       return ret;
> +}
> +
> +/**
> + * clk_set_duty_cycle - adjust the duty cycle ratio of a clock signal
> + * @clk: clock signal source
> + * @num: numerator of the duty cycle ratio to be applied
> + * @den: denominator of the duty cycle ratio to be applied
> + *
> + * Apply the duty cycle ratio if the ratio is valid and the clock can
> + * perform this operation
> + *
> + * Returns (0) on success, a negative errno otherwise.
> + */
> +int clk_set_duty_cycle(struct clk *clk, unsigned int num, unsigned int d=
en)
> +{
> +       int ret;
> +       struct clk_duty duty;
> +
> +       if (!clk)
> +               return 0;
> +
> +       /* sanity check the ratio */
> +       if (den =3D=3D 0 || num > den)
> +               return -EINVAL;
> +
> +       duty.num =3D num;
> +       duty.den =3D den;
> +
> +       clk_prepare_lock();
> +
> +       if (clk->exclusive_count)
> +               clk_core_rate_unprotect(clk->core);
> +
> +       ret =3D clk_core_set_duty_cycle_nolock(clk->core, &duty);
> +
> +       if (clk->exclusive_count)
> +               clk_core_rate_protect(clk->core);
> +
> +       clk_prepare_unlock();
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(clk_set_duty_cycle);
> +
> +static int clk_core_get_scaled_duty_cycle(struct clk_core *core,
> +                                         unsigned int scale)
> +{
> +       struct clk_duty *duty =3D &core->duty;
> +       int ret;
> +
> +       clk_prepare_lock();
> +
> +       ret =3D clk_core_update_duty_cycle_nolock(core);
> +       if (!ret)
> +               ret =3D mult_frac(scale, duty->num, duty->den);
> +
> +       clk_prepare_unlock();
> +
> +       return ret;
> +}
> +
> +/**
> + * clk_get_scaled_duty_cycle - return the duty cycle ratio of a clock si=
gnal
> + * @clk: clock signal source
> + * @scale: scaling factor to be applied to represent the ratio as an int=
eger
> + *
> + * Returns the duty cycle ratio of a clock node multiplied by the provid=
ed
> + * scaling factor, or negative errno on error.
> + */
> +int clk_get_scaled_duty_cycle(struct clk *clk, unsigned int scale)
> +{
> +       if (!clk)
> +               return 0;
> +
> +       return clk_core_get_scaled_duty_cycle(clk->core, scale);
> +}
> +EXPORT_SYMBOL_GPL(clk_get_scaled_duty_cycle);
> +
>  /**
>   * clk_is_match - check if two clk's point to the same hardware clock
>   * @p: clk compared against q
> @@ -2465,12 +2632,13 @@ static void clk_summary_show_one(struct seq_file =
*s, struct clk_core *c,
>         if (!c)
>                 return;
>  =

> -       seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu %-3d\n",
> +       seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu %5d %6d\n",
>                    level * 3 + 1, "",
>                    30 - level * 3, c->name,
>                    c->enable_count, c->prepare_count, c->protect_count,
>                    clk_core_get_rate(c), clk_core_get_accuracy(c),
> -                  clk_core_get_phase(c));
> +                  clk_core_get_phase(c),
> +                  clk_core_get_scaled_duty_cycle(c, 100000));
>  }
>  =

>  static void clk_summary_show_subtree(struct seq_file *s, struct clk_core=
 *c,
> @@ -2492,9 +2660,9 @@ static int clk_summary_show(struct seq_file *s, voi=
d *data)
>         struct clk_core *c;
>         struct hlist_head **lists =3D (struct hlist_head **)s->private;
>  =

> -       seq_puts(s, "                                 enable  prepare  pr=
otect                               \n");
> -       seq_puts(s, "   clock                          count    count    =
count        rate   accuracy   phase\n");
> -       seq_puts(s, "----------------------------------------------------=
------------------------------------\n");
> +       seq_puts(s, "                                 enable  prepare  pr=
otect                                duty\n");
> +       seq_puts(s, "   clock                          count    count    =
count        rate   accuracy phase  cycle\n");
> +       seq_puts(s, "----------------------------------------------------=
-----------------------------------------\n");
>  =

>         clk_prepare_lock();
>  =

> @@ -2521,6 +2689,8 @@ static void clk_dump_one(struct seq_file *s, struct=
 clk_core *c, int level)
>         seq_printf(s, "\"rate\": %lu,", clk_core_get_rate(c));
>         seq_printf(s, "\"accuracy\": %lu,", clk_core_get_accuracy(c));
>         seq_printf(s, "\"phase\": %d", clk_core_get_phase(c));
> +       seq_printf(s, "\"duty_cycle\": %u",
> +                  clk_core_get_scaled_duty_cycle(c, 100000));
>  }
>  =

>  static void clk_dump_subtree(struct seq_file *s, struct clk_core *c, int=
 level)
> @@ -2582,6 +2752,7 @@ static const struct {
>         ENTRY(CLK_SET_RATE_UNGATE),
>         ENTRY(CLK_IS_CRITICAL),
>         ENTRY(CLK_OPS_PARENT_ENABLE),
> +       ENTRY(CLK_DUTY_CYCLE_PARENT),
>  #undef ENTRY
>  };
>  =

> @@ -2620,6 +2791,17 @@ static int possible_parents_show(struct seq_file *=
s, void *data)
>  }
>  DEFINE_SHOW_ATTRIBUTE(possible_parents);
>  =

> +static int clk_duty_cycle_show(struct seq_file *s, void *data)
> +{
> +       struct clk_core *core =3D s->private;
> +       struct clk_duty *duty =3D &core->duty;
> +
> +       seq_printf(s, "%u/%u\n", duty->num, duty->den);
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(clk_duty_cycle);
> +
>  static void clk_debug_create_one(struct clk_core *core, struct dentry *p=
dentry)
>  {
>         struct dentry *root;
> @@ -2638,6 +2820,8 @@ static void clk_debug_create_one(struct clk_core *c=
ore, struct dentry *pdentry)
>         debugfs_create_u32("clk_enable_count", 0444, root, &core->enable_=
count);
>         debugfs_create_u32("clk_protect_count", 0444, root, &core->protec=
t_count);
>         debugfs_create_u32("clk_notifier_count", 0444, root, &core->notif=
ier_count);
> +       debugfs_create_file("clk_duty_cycle", 0444, root, core,
> +                           &clk_duty_cycle_fops);
>  =

>         if (core->num_parents > 1)
>                 debugfs_create_file("clk_possible_parents", 0444, root, c=
ore,
> @@ -2855,6 +3039,11 @@ static int __clk_core_init(struct clk_core *core)
>         else
>                 core->phase =3D 0;
>  =

> +       /*
> +        * Set clk's duty cycle.
> +        */
> +       clk_core_update_duty_cycle_nolock(core);
> +
>         /*
>          * Set clk's rate.  The preferred method is to use .recalc_rate. =
 For
>          * simple clocks and lazy developers the default fallback is to u=
se the
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index b7cfa037e593..08b1aa70a38d 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -38,6 +38,8 @@
>  #define CLK_IS_CRITICAL                BIT(11) /* do not gate, ever */
>  /* parents need enable during gate/ungate, set rate and re-parent */
>  #define CLK_OPS_PARENT_ENABLE  BIT(12)
> +/* duty cycle call may be forwarded to the parent clock */
> +#define CLK_DUTY_CYCLE_PARENT  BIT(13)
>  =

>  struct clk;
>  struct clk_hw;
> @@ -66,6 +68,17 @@ struct clk_rate_request {
>         struct clk_hw *best_parent_hw;
>  };
>  =

> +/**
> + * struct clk_duty - Struture encoding the duty cycle ratio of a clock
> + *
> + * @num:       Numerator of the duty cycle ratio
> + * @den:       Denominator of the duty cycle ratio
> + */
> +struct clk_duty {
> +       unsigned int num;
> +       unsigned int den;
> +};
> +
>  /**
>   * struct clk_ops -  Callback operations for hardware clocks; these are =
to
>   * be provided by the clock implementation, and will be called by drivers
> @@ -169,6 +182,15 @@ struct clk_rate_request {
>   *             by the second argument. Valid values for degrees are
>   *             0-359. Return 0 on success, otherwise -EERROR.
>   *
> + * @get_duty_cycle: Queries the hardware to get the current duty cycle r=
atio
> + *              of a clock. Returned values denominator cannot be 0 and =
must be
> + *              superior or equal to the numerator.
> + *
> + * @set_duty_cycle: Apply the duty cycle ratio to this clock signal spec=
ified by
> + *              the numerator (2nd argurment) and denominator (3rd  argu=
ment).
> + *              Argument must be a valid ratio (denominator > 0
> + *              and >=3D numerator) Return 0 on success, otherwise -EERR=
OR.
> + *
>   * @init:      Perform platform-specific initialization magic.
>   *             This is not not used by any of the basic clock types.
>   *             Please consider other ways of solving initialization prob=
lems
> @@ -218,6 +240,10 @@ struct clk_ops {
>                                            unsigned long parent_accuracy);
>         int             (*get_phase)(struct clk_hw *hw);
>         int             (*set_phase)(struct clk_hw *hw, int degrees);
> +       int             (*get_duty_cycle)(struct clk_hw *hw,
> +                                         struct clk_duty *duty);
> +       int             (*set_duty_cycle)(struct clk_hw *hw,
> +                                         struct clk_duty *duty);
>         void            (*init)(struct clk_hw *hw);
>         void            (*debug_init)(struct clk_hw *hw, struct dentry *d=
entry);
>  };
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 0dbd0885b2c2..4f750c481b82 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -141,6 +141,27 @@ int clk_set_phase(struct clk *clk, int degrees);
>   */
>  int clk_get_phase(struct clk *clk);
>  =

> +/**
> + * clk_set_duty_cycle - adjust the duty cycle ratio of a clock signal
> + * @clk: clock signal source
> + * @num: numerator of the duty cycle ratio to be applied
> + * @den: denominator of the duty cycle ratio to be applied
> + *
> + * Adjust the duty cycle of a clock signal by the specified ratio. Retur=
ns 0 on
> + * success, -EERROR otherwise.
> + */
> +int clk_set_duty_cycle(struct clk *clk, unsigned int num, unsigned int d=
en);
> +
> +/**
> + * clk_get_duty_cycle - return the duty cycle ratio of a clock signal
> + * @clk: clock signal source
> + * @scale: scaling factor to be applied to represent the ratio as an int=
eger
> + *
> + * Returns the duty cycle ratio multiplied by the scale provided, otherw=
ise
> + * returns -EERROR.
> + */
> +int clk_get_scaled_duty_cycle(struct clk *clk, unsigned int scale);
> +
>  /**
>   * clk_is_match - check if two clk's point to the same hardware clock
>   * @p: clk compared against q
> @@ -183,6 +204,18 @@ static inline long clk_get_phase(struct clk *clk)
>         return -ENOTSUPP;
>  }
>  =

> +static inline int clk_set_duty_cycle(struct clk *clk, unsigned int num,
> +                                    unsigned int den)
> +{
> +       return -ENOTSUPP;
> +}
> +
> +static inline unsigned int clk_get_scaled_duty_cycle(struct clk *clk,
> +                                                    unsigned int scale)
> +{
> +       return 0;
> +}
> +
>  static inline bool clk_is_match(const struct clk *p, const struct clk *q)
>  {
>         return p =3D=3D q;
> diff --git a/include/trace/events/clk.h b/include/trace/events/clk.h
> index 2cd449328aee..9004ffff7f32 100644
> --- a/include/trace/events/clk.h
> +++ b/include/trace/events/clk.h
> @@ -192,6 +192,42 @@ DEFINE_EVENT(clk_phase, clk_set_phase_complete,
>         TP_ARGS(core, phase)
>  );
>  =

> +DECLARE_EVENT_CLASS(clk_duty_cycle,
> +
> +       TP_PROTO(struct clk_core *core, struct clk_duty *duty),
> +
> +       TP_ARGS(core, duty),
> +
> +       TP_STRUCT__entry(
> +               __string(        name,           core->name              )
> +               __field( unsigned int,           num                     )
> +               __field( unsigned int,           den                     )
> +       ),
> +
> +       TP_fast_assign(
> +               __assign_str(name, core->name);
> +               __entry->num =3D duty->num;
> +               __entry->den =3D duty->den;
> +       ),
> +
> +       TP_printk("%s %u/%u", __get_str(name), (unsigned int)__entry->num,
> +                 (unsigned int)__entry->den)
> +);
> +
> +DEFINE_EVENT(clk_duty_cycle, clk_set_duty_cycle,
> +
> +       TP_PROTO(struct clk_core *core, struct clk_duty *duty),
> +
> +       TP_ARGS(core, duty)
> +);
> +
> +DEFINE_EVENT(clk_duty_cycle, clk_set_duty_cycle_complete,
> +
> +       TP_PROTO(struct clk_core *core, struct clk_duty *duty),
> +
> +       TP_ARGS(core, duty)
> +);
> +
>  #endif /* _TRACE_CLK_H */
>  =

>  /* This part must be outside protection */
> -- =

> 2.14.3
>=20
