Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968852AbeEXLZS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 07:25:18 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43147 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967855AbeEXLZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 07:25:11 -0400
X-Google-Smtp-Source: AB8JxZoMISfXYWsGTgkE+NIFG8cl6ua444S6tMFw/+qn3rEXH1Uet5fukbNa3Iqlfa5YHCePnw1oM/bvxKl3aCFwGxE=
MIME-Version: 1.0
In-Reply-To: <1527148218-16540-1-git-send-email-ilialin@codeaurora.org>
References: <1527148218-16540-1-git-send-email-ilialin@codeaurora.org>
From: Amit Kucheria <amit.kucheria@verdurent.com>
Date: Thu, 24 May 2018 14:25:10 +0300
Message-ID: <CAHLCerM-F3joG=9YgvqMiGTFvw_CAv82R91ZP7v6mxTjykz9DA@mail.gmail.com>
Subject: Re: [PATCH v12 0/8] Clock for CPU scaling support for msm8996
To: Ilia Lin <ilialin@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, will.deacon@arm.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, vireshk@kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        lakml <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 10:50 AM, Ilia Lin <ilialin@codeaurora.org> wrote:
> [v12]
>  * Addressed the kbuild fail on arm architecture
>
> [v11]
>  * Split the series into domains
>
> [v9]
>  * Addressed comments from Viresh and Russel about the error handling
>
> [v8]
>  * Reordered the patch series into 4 groups
>  * Addressed comments from Amit about the comments and commit messages
>  * Addressed comments from Amit and Viresh about the resourses deallocation
>
> [v7]
>  * Addressed comments from Viresh about resourses deallocation
>    and DT compatible
>
> [v6]
>  * Addressed comments from Viresh about:
>  ** Comments style
>  ** Kconfig bool instead of tristate
>  ** DT and documentation style
>  ** Resourses deallocation on an error
>  ** Typos
>
> [v5]
>  * Rebased
>  * Addressed comments from Bjorn about SPDX style,
>    functions and parameters naming
>  * Addressed comments from Viresh DT properties and style, comments style,
>    resourses deallocation, documentation placement
>  * Addressed comments from Sricharan about unnessesary include
>  * Addressed comments from Nicolas
>  * Addressed comments from Rob about the commit messages and acks
>  * Addressed comments from Mark
>
> [v4]
>  * Adressed all comments from Stephen
>  * Added CPU regulator support
>  * Added qcom-cpufreq-kryo driver
>
> [v3]
>  * Rebased on top of the latest PLL driver changes
>  * Addressed comment from Rob Herring for bindings
>
> [v2]
>  * Addressed comments from Rob Herring for bindings
>  * Addressed comments from Mark Rutland for memory barrier
>  * Addressed comments from Julien Thierry for clock reenabling condition
>  * Tuned the HW configuration for clock frequencies below 600MHz
>
> SOC (1/15):
> Extracts the kryo l2 accessors driver from the QCOM PMU driver
>
> Clocks (2/15-9/15):
> This series adds support for the CPU clocks on msm8996 devices.
> The driver uses the existing PLL drivers and is required to control
> the CPU frequency scaling on the MSM8996.
>
> Ilia Lin (6):
>   soc: qcom: Separate kryo l2 accessors from PMU driver
>   clk: Use devm_ in the register fixed factor clock
>   clk: qcom: Add CPU clock driver for msm8996
>   dt-bindings: clk: qcom: Add bindings for CPU clock for msm8996
>   clk: qcom: cpu-8996: Add support to switch below 600Mhz
>   clk: qcom: Add ACD path to CPU clock driver for msm8996
>
> Rajendra Nayak (2):
>   clk: qcom: Make clk_alpha_pll_configure available to modules
>   clk: qcom: cpu-8996: Add support to switch to alternate PLL
>
>  .../devicetree/bindings/clock/qcom,kryocc.txt      |  17 +
>  drivers/clk/clk-fixed-factor.c                     |   2 +-
>  drivers/clk/qcom/Kconfig                           |  10 +
>  drivers/clk/qcom/Makefile                          |   1 +
>  drivers/clk/qcom/clk-alpha-pll.c                   |   1 +
>  drivers/clk/qcom/clk-alpha-pll.h                   |   6 +
>  drivers/clk/qcom/clk-cpu-8996.c                    | 510 +++++++++++++++++++++


>  drivers/perf/Kconfig                               |   1 +
>  drivers/perf/qcom_l2_pmu.c                         |  90 +---
>  drivers/soc/qcom/Kconfig                           |   3 +
>  drivers/soc/qcom/Makefile                          |   1 +
>  drivers/soc/qcom/kryo-l2-accessors.c               |  56 +++
>  include/soc/qcom/kryo-l2-accessors.h               |  12 +

For the perf/l2-accessors part, Reviewed-by: Amit Kucheria
<amit.kucheria@linaro.org>

For the entire series, Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
