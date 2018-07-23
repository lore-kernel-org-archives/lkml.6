Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633ADECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E4B20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpxhXGf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E4B20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbeGWMeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:34:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33032 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387910AbeGWMeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:34:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id x5-v6so658906edr.0;
        Mon, 23 Jul 2018 04:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hok9hFpn5knfL1b8A1H8BAZRW9KAcxHSpepmlduosRc=;
        b=FpxhXGf/bvICzjN/ti8wO+CwspgxN2f7oZbS+lhPt4HvMQDFytYuVm4H6bKZZdU6ip
         j1cRd8kVLjgUtCCb45LZ7wloYdygzUf0l63IczfhFXm9TdHDeM9nOWhhPuGZaM7pansJ
         Gm2fI2nTkMNNtj9l98ZyZVNdSMXu+91iCic17sb+EHkrQa8Fbg28i4KrkPZthR0RVtnq
         XBbnSuuAd1C8bOA9x7kf0FKhuP1xkpe1hPKpRuQuXLZ60UYYSxydfCMbznYtgkfhwOl1
         qfaUS1V/KtTocJdMdx/mak1iSvzKsSkcGUocmOMfOJ6XbozXhxJ2TwIfOV9RpgcnBWH5
         Kwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hok9hFpn5knfL1b8A1H8BAZRW9KAcxHSpepmlduosRc=;
        b=JjihDHlAKDBgj+o/jOCaGXal3q6C9pf5GNjhkJ93yXC07/N+xkOqLWO+REZZ552g8F
         dK3yALTHqMsC9OiqvOr14xwiPOTn9neEk6Sfs3UPWM/uWPBEOmynnUxaIrVxxX7VpARf
         l/eoIIc3k3xtZIUsFwksWCOViwtQcqdQyv/Q+OnTMDZC50MUkDw4p9WB8s/pn18zku1f
         Zv7t8MaIsgI+t9633jD2n3Yb6oimE1i7ML1ruCkkJ1oXLUgebXmnIyy2KDGIUpXUDSi4
         lsDT4jFA855o5elFOQSlyFFwtt+yMRvmKEH23kdplfGbF2Y0BfQNALMpxn0BzfkgNqko
         6HJA==
X-Gm-Message-State: AOUpUlEY/o1gTTBDlHHxMfYnLbAzieB+jDsfkFmB+TdAFINK8xGkbZK1
        Lh+H+m+SUTaXr9YlYaaCQvw=
X-Google-Smtp-Source: AAOMgpeUgrqRrSKkHS942sNV52krdKNfewCDMDJWf1Y0j6QBkpA3elhkmHoVKOBivDkC+vRPTEAlyg==
X-Received: by 2002:a50:d307:: with SMTP id g7-v6mr14397993edh.221.1532345608149;
        Mon, 23 Jul 2018 04:33:28 -0700 (PDT)
Received: from dimapc.localnet ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id y10-v6sm7143235ede.38.2018.07.23.04.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 04:33:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>, pdeschrijver@nvidia.com
Cc:     jonathanh@nvidia.co, thierry.reding@gmail.com,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, pgaikwad@nvidia.com,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH 6/8] clk: tegra30: add 2d and 3d idle clocks
Date:   Mon, 23 Jul 2018 14:33:26 +0300
Message-ID: <22870833.4JC6Is3odW@dimapc>
In-Reply-To: <ca29f065814a22f46b9b1683165548cb@codethink.co.uk>
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk> <1721645.6LMGIEI4vR@dimapc> <ca29f065814a22f46b9b1683165548cb@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23 July 2018 11:28:25 MSK Ben Dooks wrote:
> On 2018-07-22 12:55, Dmitry Osipenko wrote:
> > On Friday, 20 July 2018 16:45:30 MSK Ben Dooks wrote:
> >> The 2D and 3D clocks have an IDLE field in bits 15:8 so add these
> >> clocks by making a 2D and 3D mux, and split the divider into the
> >> standard 2D/3D ones and 2D/3D idle clocks.
> >> 
> >> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> [snip]

> @@ -658,8 +658,12 @@ static struct tegra_devclk devclks[] __initdata = {
>  	{ .dev_id = "mpe", .dt_id = TEGRA30_CLK_MPE },
>  	{ .dev_id = "host1x", .dt_id = TEGRA30_CLK_HOST1X },
>  	{ .dev_id = "3d", .dt_id = TEGRA30_CLK_GR3D },
> +	{ .dev_id = "3d", .con_id = "mux", .dt_id = TEGRA30_CLK_GR3D_MUX },
> +	{ .dev_id = "3d", .con_id = "idle", .dt_id = TEGRA30_CLK_GR3D_IDLE },
>  	{ .dev_id = "3d2", .dt_id = TEGRA30_CLK_GR3D2 },

The  "3d2" also has the "idle" divisor, why have you skipped it?

>  	{ .dev_id = "2d", .dt_id = TEGRA30_CLK_GR2D },
> +	{ .dev_id = "2d", .con_id = "mux", .dt_id = TEGRA30_CLK_GR2D_MUX },
> +	{ .dev_id = "2d", .con_id = "idle", .dt_id = TEGRA30_CLK_GR2D_IDLE },
>  	{ .dev_id = "se", .dt_id = TEGRA30_CLK_SE },
>  	{ .dev_id = "mselect", .dt_id = TEGRA30_CLK_MSELECT },
>  	{ .dev_id = "tegra-nor", .dt_id = TEGRA30_CLK_NOR },

[snip]

> 
> > According to TRM, Tegra20 and Tegra114 have these "idle-mode" clock
> > dividers
> > as well. Why only T30 should have them?
> 
> I've got a separate series to sort t20 bits out, i've not used the
> tegra114
> 

This makes this series to look a bit inconsistent, please send out all the 
patches to give a consistent view.

I don't see anything that could really stop you from adding the clocks for 
T114, its 2d/3d clocks definition pretty matches to T20/30.

> >> a/include/dt-bindings/clock/tegra30-car.h
> >> b/include/dt-bindings/clock/tegra30-car.h index
> >> 3c90f1535551..eda4ca60351e
> >> 100644
> >> --- a/include/dt-bindings/clock/tegra30-car.h
> >> +++ b/include/dt-bindings/clock/tegra30-car.h
> >> @@ -269,6 +269,11 @@
> >> 
> >>  #define TEGRA30_CLK_AUDIO3_MUX 306
> >>  #define TEGRA30_CLK_AUDIO4_MUX 307
> >>  #define TEGRA30_CLK_SPDIF_MUX 308
> >> 
> >> -#define TEGRA30_CLK_CLK_MAX 309
> >> +
> >> +#define TEGRA30_CLK_GR2D_MUX	309
> >> +#define TEGRA30_CLK_GR3D_MUX	310
> >> +#define TEGRA30_CLK_GR2D_IDLE	311
> >> +#define TEGRA30_CLK_GR3D_IDLE	312
> >> +#define TEGRA30_CLK_CLK_MAX 313
> >> 
> >>  #endif	/* _DT_BINDINGS_CLOCK_TEGRA30_CAR_H */
> > 
> > IIUC, that "idle-mode" divisor is just some kind of power-safe feature,
> > is
> > there any real use-case for these clocks? Why not to just pre-configure
> > the
> > "idle-mode" bits during the clocks initialization?
> 
> It is is nice to have it available after to check,

Please initialize the "idle" clock rate via the tegra_clk_init_table in the 
patch that adds the clock or in a followup patch within the same patchset.

> other than that we're
> not
> using any drivers that currently dynamically change the values of this.

All changes made to upstream kernel must be justified, the only acceptable 
justification is that a change is required for the upstream driver.



