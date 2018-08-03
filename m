Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66664C46467
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EFA217AE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RE6SnWg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EFA217AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbeHCVjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:39:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40661 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbeHCVjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:39:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19-v6so5822798ljc.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/G65AGOrfvruMssFYK33zUqOVJsOA+jofF11Fgshf54=;
        b=RE6SnWg7/v4ZO01dgh0VRejcJJpuk6cj7zr0nkHc0Td9+W96srLB6m7v5R+88h4dgH
         Z+gG/SodWM/6K4hmqpbCZEZHinarxr/LjJkghYNl5vtn22NjQsF+uch13fxO5IyCoa5J
         Vb0AEuregqdZos004Yh/T5zzWNH6xNwTg0I3OjR2QN3R1IYVjoWMha8gv+wPMl2Le9Pk
         8h18kMJuDGmBL7t26tOJTj+LhzSX1lbCbrai2nhPsrACbNUaApPWpWm68YSOn2TEhyj4
         sQ50P9EL7eMz0oAOjd5cfxEyBXnBI6tobIH5WiBZhdqNE/0BY1byXOH4zDvPXW52RUk/
         mXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/G65AGOrfvruMssFYK33zUqOVJsOA+jofF11Fgshf54=;
        b=GaqtWJCKjysxfCw2Tel01MEaXjNnsJKCF/XB1GAc/SvYZ3QdXm2APgt8dc+67YIkIq
         /IRRXjW709Yn9kWQEohM4T+jwaRC2Jv1nvbJe+4MAnj6lB9Aw3rTEMDnnwaxc+K02m8L
         wJiDunYGJYzIrPI2En6VxSoiOqr38O3pyYGSWu09WqmiMwHEl9V8TIqbkXZ9Sw7FQMMU
         VyP8FKc3lypraxHGuIP1U6LPJ4H2UFukYWWePc2jRPOBRes1nHRR0aDQyP3/wH7hmp2g
         9ouQyyWghJnSscCHarVlJ6FBH93O2O9bF6YZjaXKXsUCDE75PxBH9VW/Z1FGNAmePtFN
         wBtQ==
X-Gm-Message-State: AOUpUlELsBOqrWkUB2ulg5vujLHaozNpk8l1gtcyg3vZzD6c7qU9b5/g
        dB2qRTkDDUDC2IpO8y2Ki/H9b58CklCNYDR1aW5SGg==
X-Google-Smtp-Source: AAOMgpfTi9Pz8/Hy6tJbS5dyElNYFd0IK/zMm5ZnNsaJ22x45OUqcj8z5zViH8qcgOX4pXSgQfLlU/Me3eLAU9iSdGk=
X-Received: by 2002:a2e:1207:: with SMTP id t7-v6mr6079472lje.129.1533325277883;
 Fri, 03 Aug 2018 12:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org> <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
From:   Evan Green <evgreen@google.com>
Date:   Fri, 3 Aug 2018 12:40:41 -0700
Message-ID: <CAE=gft7_5SZKpU0i9Jbi6UV-eqW8=6Fm7rw4oKVXG6J9Q7_E+g@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
To:     tdas@codeaurora.org
Cc:     rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        anischal@codeaurora.org, devicetree@vger.kernel.org,
        robh@kernel.org, Saravana Kannan <skannan@codeaurora.org>,
        amit.kucheria@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

On Tue, Jul 24, 2018 at 3:44 AM Taniya Das <tdas@codeaurora.org> wrote:
>
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |  11 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-hw.c | 348 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 360 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
>
...
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> new file mode 100644
> index 0000000..ea8f7d1
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
...
> +static int qcom_cpufreq_hw_read_lut(struct platform_device *pdev,
> +                                   struct cpufreq_qcom *c)
> +{
> +       struct device *dev = &pdev->dev;
> +       void __iomem *base;
> +       u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
> +
> +       c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> +                               sizeof(*c->table), GFP_KERNEL);
> +       if (!c->table)
> +               return -ENOMEM;
> +
> +       base = c->reg_bases[REG_LUT_TABLE];
> +
> +       for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +               data = readl_relaxed(base + i * LUT_ROW_SIZE);
> +               src = (data & GENMASK(31, 30)) >> 30;
> +               lval = data & GENMASK(7, 0);
> +               core_count = CORE_COUNT_VAL(data);
> +
> +               if (src)
> +                       c->table[i].frequency = c->xo_rate * lval / 1000;
> +               else
> +                       c->table[i].frequency = INIT_RATE / 1000;

I don't know much about how this hardware works, but based on the
mask, src has 4 possible values. So does 0 mean INIT_RATE, and 1, 2,
and 3 all mean xo_rate?

Also, is INIT_RATE really constant? It sounds like gpll0 (or
gpll0_out_even?). You're already getting the xo clock, why not get
gpll0's real rate as well?
