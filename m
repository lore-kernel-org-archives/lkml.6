Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D1EECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740AA20862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740AA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbeGQIRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:17:53 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41216 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbeGQIRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:17:52 -0400
Received: by mail-ua0-f195.google.com with SMTP id t14-v6so96586uao.8;
        Tue, 17 Jul 2018 00:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUyQSYwIbCNTTYjfgNFmcgaHiExu4bRxvYaPnD6j1JU=;
        b=POY6a7HNf+NLuZaCqoyq80P2rcKMGqFOIZzQbYA9G4qE8NxVzDyOwEPKWplB/l+ibg
         +JEf+SPZCwAvpkcfq5rfADoPKGYAH70P6lmYi5trJ4Rkg1JFvwwbb10YyE7tDyQ5VlVj
         m8t6UkOBn/gp/tBHOKZdCeG1WrjT1FfhOmhj3CfGHzMFrzNSx0zrWHLySQG4Fe/UX8bt
         O7Y1J4gQ4QccY+RYpT6pnZQHlebJ/tD4b1jxKOF4Ilk9jFvyBRTaike5vqYJLmFjpUS1
         CzzgdhVFzk6r6KNM9bIjk6+iEoJKvxVe/DVn4MfxDMPs1G4g5UjH0z5CUlLzAEtEjixr
         COfw==
X-Gm-Message-State: AOUpUlE3bk3+R0Xy3MBTsrgXx080pjVA6X7rpffkeFAEAnxXdaPmYjYk
        ngJfOhQHNHl59Tp4USHLhaEa/xxOVLFU2gR5HDA=
X-Google-Smtp-Source: AAOMgpcGGgfKy0xNAQMrVAUZR862/vMv7TzD6w9DNqcp31wVAJvMgmRyryKF5v6MO0vxn3UXY8PGnVMrO3ePdLSopDA=
X-Received: by 2002:ab0:80e:: with SMTP id a14-v6mr349970uaf.114.1531813595508;
 Tue, 17 Jul 2018 00:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1454992186.git.viresh.kumar@linaro.org> <ad55cd1a03e712e2c0c49701e87a37199cb8376e.1454992187.git.viresh.kumar@linaro.org>
In-Reply-To: <ad55cd1a03e712e2c0c49701e87a37199cb8376e.1454992187.git.viresh.kumar@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Jul 2018 09:46:23 +0200
Message-ID: <CAMuHMdXgE3oOVdYFy3kzmOv4FXvjU4rC39gUDUtMNJCdB__2AA@mail.gmail.com>
Subject: Re: [PATCH V3 11/16] cpufreq: dt: Pass regulator name to the OPP core
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linaro-kernel <linaro-kernel@lists.linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Nishanth Menon <nm@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

CC device-tree folks

Replying to an old email, because that's the most accurate reference I
could find.

On Tue, Feb 9, 2016 at 6:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> OPP core can handle the regulators by itself, and but it needs to know
> the name of the regulator to fetch. Add support for that.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 4c9f8a828f6f..2af75f8088bb 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c

> @@ -119,6 +120,30 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
>         return ret;
>  }
>
> +/*
> + * An earlier version of opp-v1 bindings used to name the regulator
> + * "cpu0-supply", we still need to handle that for backwards compatibility.
> + */
> +static const char *find_supply_name(struct device *dev, struct device_node *np)
> +{
> +       struct property *pp;
> +       int cpu = dev->id;
> +
> +       /* Try "cpu0" for older DTs */
> +       if (!cpu) {
> +               pp = of_find_property(np, "cpu0-supply", NULL);
> +               if (pp)
> +                       return "cpu0";
> +       }
> +
> +       pp = of_find_property(np, "cpu-supply", NULL);
> +       if (pp)
> +               return "cpu";

Despite the existence of lots of users of these properties, I couldn't find
both the "earlier version" and the "current version" of the opp-v1 bindings
documenting the "cpu0-supply" and "cpu-supply" properties?

Even for opp-v2, they are not documented in
Documentation/devicetree/bindings/opp/opp.txt, but cpu-supply is used in
the examples?
For v2, I did find "[PATCH 01/16] PM / OPP: Add 'supply-names' binding"
https://lore.kernel.org/lkml/2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org/
but presumably that's an even further evolution?

Can you please document these properties?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
