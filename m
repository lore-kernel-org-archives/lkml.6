Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D56C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239E420882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239E420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbeLGCZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:25:30 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45340 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGCZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:25:30 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so2449673edb.12;
        Thu, 06 Dec 2018 18:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oom8yb8si8YUiMh5VO+md1vrfSvTWSqrwdljfkE47HE=;
        b=QhVeG/7RyKLnv/tHd94m6Xmrzz4yABD5d4OsHAzkfYwtK3JvSKAgRsdCZLEmg41mw2
         UMZg3tGUq38rcExlqVHyeKDTHY71497rtl35V3Rdry80hOovRigjrJ8N6qyB8cUS1nP0
         BrER4hr4y0tE9wJ1uQblJxF0aGfnnGqRPnUJJ57Bpy6vCzAJMrntfWgSVNZjwEWgdxhe
         klz+EmpAG4UMGehd3WndYFi9qS2zvTM+C2ligc96kd1rSLtTHF6Neql4gZiwBrxPQvz6
         dDGXXy6dKB0EgYcASpuV3i1YU1DsVYUuKjYxHIvie1+VkeWQhU0pkZSjZzozID1y8S2s
         bG4w==
X-Gm-Message-State: AA+aEWb+XVuNPNcIaT5gDLn87uRPeReibETxanaMeQNQFumO1br8dOeZ
        5/ZYvowkRondevFAuTnCcWuNmSBOHcc=
X-Google-Smtp-Source: AFSGD/XnaA3p4xlPcNhFIUaRjRI7PtaT0W2V1bKlyvDIKs15dFjzdU4G3S58q1CUHRCU7HFYhx5Leg==
X-Received: by 2002:a50:fe15:: with SMTP id f21mr584879edt.116.1544149526643;
        Thu, 06 Dec 2018 18:25:26 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id gz20-v6sm331003ejb.56.2018.12.06.18.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 18:25:26 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id a18so3033918wmj.1;
        Thu, 06 Dec 2018 18:25:26 -0800 (PST)
X-Received: by 2002:a1c:e58c:: with SMTP id c134mr562802wmh.124.1544149525598;
 Thu, 06 Dec 2018 18:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20181203145825.20511-1-wens@csie.org> <CAGb2v65GwzEHZnRJysp=qE4HjrTa+TzCeyQ_j_Q=RrwtnC617g@mail.gmail.com>
 <20181206203419.GD8952@piout.net>
In-Reply-To: <20181206203419.GD8952@piout.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 7 Dec 2018 10:25:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Fi5EhN10wWaw0kQ2YiAOBT01xgdfXv3XYc64YaE0pgA@mail.gmail.com>
Message-ID: <CAGb2v67Fi5EhN10wWaw0kQ2YiAOBT01xgdfXv3XYc64YaE0pgA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] rtc: sun6i: clock rework and pre-H6 SoC support
To:     alexandre.belloni@bootlin.com
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rtc@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 4:34 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 06/12/2018 13:49:10+0800, Chen-Yu Tsai wrote:
> > Hi,
> >
> > On Mon, Dec 3, 2018 at 10:58 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > >
> > > Hi everyone,
> > >
> > > This is v2 of my rtc-sun6i clean-up series.
> > >
> > > Changes since v1:
> > >
> > >   - Collected tags
> > >   - Dropped patch "clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC
> > >     output"; already merged
> > >   - Removed H6 compatible CLK_OF_DECLARE_DRIVER entry that wasn't
> > >     overlooked
> > >   - Only export IOSC clock for A64/H3/H5
> > >
> > > Original cover letter, with patch numbers corrected, follows:
> > >
> > > This series was started as part of enabling Bluetooth on various
> > > Allwinner SBCs. The bluetooth controller requires a precise 32.768 kHz
> > > clock fed to it to correctly detect the frequency of its main oscillator.
> > > This clock signal is provided by the RTC, either directly from a special
> > > pin on the SoC, or some clock output function from the clock controllers.
> > > I found that the clock-related properties of the RTC on later SoCs were
> > > incorrect or missing.
> > >
> > > This series reworks the compatible strings and clock parts of the device
> > > tree bindings for sun6i-rtc. Currently we assume most Allwinner SoCs use
> > > the same sun6i-rtc variant, when in fact they do not. The differences
> > > that matter with regards to clocks are a) the A31 does not have an extra
> > > external output for the RTC 32K clock, while most of the others do;
> > > b) the clock frequency of the internal RC oscillator is different on
> > > some SoCs; c) on the H6 the RTC also handles the 24 MHz DCXO, which
> > > feeds the system HOSC. The last difference, and by extension the H6, are
> > > not covered in this series.
> > >
> > > Patch 1 cleans up the clock-related section of the RTC device tree
> > > binding. This would make it easier to read and easier to add additional
> > > clocks.
> > >
> > > Patch 2 adds compatible strings for all identified variants introduced
> > > prior to the H6.
> > >
> > > Patch 3 deprecates the external clock output for the A31. The A31 does
> > > not have this output, so it's introduction and usage was an error.
> > >
> > > Patch 4 adds a clock output for the RTC's internal oscillator to the
> > > device tree binding. This feeds the PRCM in some SoCs.
> > >
> > > Patch 5 adds a default clock name for the LOSC to the RTC driver.
> > >
> > > Patch 6 adds support for different hardware variants to the RTC driver.
> > >
> > > Patch 7 adds support for all known pre-H6 variants.
> > >
> > > Patch 8 exposes the RTC's internal oscillator through the device tree.
> > >
> > > Patch 9 through 14 adds an RTC node or fixes up the RTC device node
> > > address ranges, clock properties, names of existing clocks, and adds
> > > accuracy properties for the external fixed oscillators.
> > >
> > > The clock names require fixing because the sunxi clock driver implicitly
> > > depends on the HOSC and LOSC being named "osc24M" and "osc32k". The
> > > "fixes" to the clock hierarchy introduced in this series means the names
> > > must also be shuffled around or the in kernel representation would be
> > > incorrect. This has been the case since the sunxi-ng drivers were
> > > introduced. There are plans to address this, but the code is still in its
> > > early stages.
> > >
> > > Please have a look.
> > >
> > > Thanks
> > > ChenYu
> > >
> > > Chen-Yu Tsai (14):
> > >   dt-bindings: rtc: sun6i-rtc: Rewrite clock outputs as a list
> > >   dt-bindings: rtc: sun6i-rtc: Add compatible strings for pre-H6
> > >     variants
> > >   dt-bindings: rtc: sun6i-rtc: Deprecate external clock output for A31
> > >   dt-bindings: rtc: sun6i-rtc: Export internal RC oscillator
> > >   rtc: sun6i: Add default clock name for LOSC
> > >   rtc: sun6i: Add support for different variants
> > >   rtc: sun6i: Add support for all known pre-H6 variants
> > >   rtc: sun6i: Expose internal oscillator through device tree
>
> I've applied the above patches. However, for whatever reason, patch 3
> didn't apply without some fuzz, please check.

Sorry about that. The fuzz was due to a patch that I forgot to send out.
The fixup looks good.

I applied the remaining device tree patches. I'll send out the missing
patch, which fixes the register range in the binding example, later.

Thanks!
ChenYu
