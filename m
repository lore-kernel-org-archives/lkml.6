Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B43BC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDD62146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDD62146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbeLFFt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:49:27 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40506 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbeLFFt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:49:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id d3so19032322edx.7;
        Wed, 05 Dec 2018 21:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6PNw/h9KlBN0w0kHSPz8pJtvfB9D034KTZ05omJ/0U=;
        b=TdJkfrxIynfslAJsKme4PvF3hTfJFKvHFpG2VcrkKusUNxXVxvGxXJi2Mc/3wCmEdu
         OCc36aZpf6aZesfSc6sV/+l55KoKnOW5p0TpyTXsYfrViMbpDv6uetvj+QVKrLgqxRwu
         DF053TkSgZ7VzosFgT9nwR5fUimknJcxOGyJjSLUWj2iVM4ipmi3giDieA2iaW/LpGAW
         IC0TNF3kSpdHUMKhTm5hh80lIiCDeHej2f4ie6sM/IOTi6HRFSaEyb6KcVgjDipfqHTr
         +JSAYHxKMFEMWXctbluIKV+1FGj58bzti7t9uDwWWeuNAYBwdgZjA79cxBYe3YbfbW5d
         mJWw==
X-Gm-Message-State: AA+aEWaiAn/IyxhGzDuGHS5tde8Jk9IB3Zv1UyIpzi4qpkCUfNSISDx6
        6gfM2CRKy4geOBO28nRv/Ghy3Fo0iak=
X-Google-Smtp-Source: AFSGD/VpDQ7oA8Cr2gFP8nQZyQsZ2mQBH5S3GZ9CicZJKq7Swxd+J45So8GlgpDjGy9SeyomRHbOmg==
X-Received: by 2002:a50:b487:: with SMTP id w7mr9482464edd.72.1544075363879;
        Wed, 05 Dec 2018 21:49:23 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id f35sm6329455edd.80.2018.12.05.21.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 21:49:23 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id f81so12675883wmd.4;
        Wed, 05 Dec 2018 21:49:23 -0800 (PST)
X-Received: by 2002:a1c:c008:: with SMTP id q8mr16583620wmf.99.1544075363170;
 Wed, 05 Dec 2018 21:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20181203145825.20511-1-wens@csie.org>
In-Reply-To: <20181203145825.20511-1-wens@csie.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 6 Dec 2018 13:49:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v65GwzEHZnRJysp=qE4HjrTa+TzCeyQ_j_Q=RrwtnC617g@mail.gmail.com>
Message-ID: <CAGb2v65GwzEHZnRJysp=qE4HjrTa+TzCeyQ_j_Q=RrwtnC617g@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] rtc: sun6i: clock rework and pre-H6 SoC support
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        alexandre.belloni@bootlin.com,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
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

Hi,

On Mon, Dec 3, 2018 at 10:58 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi everyone,
>
> This is v2 of my rtc-sun6i clean-up series.
>
> Changes since v1:
>
>   - Collected tags
>   - Dropped patch "clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC
>     output"; already merged
>   - Removed H6 compatible CLK_OF_DECLARE_DRIVER entry that wasn't
>     overlooked
>   - Only export IOSC clock for A64/H3/H5
>
> Original cover letter, with patch numbers corrected, follows:
>
> This series was started as part of enabling Bluetooth on various
> Allwinner SBCs. The bluetooth controller requires a precise 32.768 kHz
> clock fed to it to correctly detect the frequency of its main oscillator.
> This clock signal is provided by the RTC, either directly from a special
> pin on the SoC, or some clock output function from the clock controllers.
> I found that the clock-related properties of the RTC on later SoCs were
> incorrect or missing.
>
> This series reworks the compatible strings and clock parts of the device
> tree bindings for sun6i-rtc. Currently we assume most Allwinner SoCs use
> the same sun6i-rtc variant, when in fact they do not. The differences
> that matter with regards to clocks are a) the A31 does not have an extra
> external output for the RTC 32K clock, while most of the others do;
> b) the clock frequency of the internal RC oscillator is different on
> some SoCs; c) on the H6 the RTC also handles the 24 MHz DCXO, which
> feeds the system HOSC. The last difference, and by extension the H6, are
> not covered in this series.
>
> Patch 1 cleans up the clock-related section of the RTC device tree
> binding. This would make it easier to read and easier to add additional
> clocks.
>
> Patch 2 adds compatible strings for all identified variants introduced
> prior to the H6.
>
> Patch 3 deprecates the external clock output for the A31. The A31 does
> not have this output, so it's introduction and usage was an error.
>
> Patch 4 adds a clock output for the RTC's internal oscillator to the
> device tree binding. This feeds the PRCM in some SoCs.
>
> Patch 5 adds a default clock name for the LOSC to the RTC driver.
>
> Patch 6 adds support for different hardware variants to the RTC driver.
>
> Patch 7 adds support for all known pre-H6 variants.
>
> Patch 8 exposes the RTC's internal oscillator through the device tree.
>
> Patch 9 through 14 adds an RTC node or fixes up the RTC device node
> address ranges, clock properties, names of existing clocks, and adds
> accuracy properties for the external fixed oscillators.
>
> The clock names require fixing because the sunxi clock driver implicitly
> depends on the HOSC and LOSC being named "osc24M" and "osc32k". The
> "fixes" to the clock hierarchy introduced in this series means the names
> must also be shuffled around or the in kernel representation would be
> incorrect. This has been the case since the sunxi-ng drivers were
> introduced. There are plans to address this, but the code is still in its
> early stages.
>
> Please have a look.
>
> Thanks
> ChenYu
>
> Chen-Yu Tsai (14):
>   dt-bindings: rtc: sun6i-rtc: Rewrite clock outputs as a list
>   dt-bindings: rtc: sun6i-rtc: Add compatible strings for pre-H6
>     variants
>   dt-bindings: rtc: sun6i-rtc: Deprecate external clock output for A31
>   dt-bindings: rtc: sun6i-rtc: Export internal RC oscillator
>   rtc: sun6i: Add default clock name for LOSC
>   rtc: sun6i: Add support for different variants
>   rtc: sun6i: Add support for all known pre-H6 variants
>   rtc: sun6i: Expose internal oscillator through device tree
>   ARM: dts: sun8i: a23/a33: Fix up RTC device node
>   ARM: dts: sunxi: h3/h5: Add clock accuracy for external oscillators
>   ARM: dts: sunxi: h3/h5: Fix up RTC device node and clock references
>   ARM: dts: sun8i: r40: Add clock accuracy for external oscillators
>   ARM: dts: sun8i: r40: Add RTC device node
>   arm64: dts: allwinner: a64: Fix up RTC device node and clock
>     references

I merged patches 10 and 12 for now. These don't depend on any driver changes.

If Alex manages to get the driver bits merged for 4.21, I suppose we could do
a late PR for the dts bits? It would be nice to have both in the same release,
though I don't think anything would break if the dts bits are delayed.

ChenYu
