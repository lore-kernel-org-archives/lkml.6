Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932233AbeEWJcs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:32:48 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41393 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932187AbeEWJcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:32:39 -0400
X-Google-Smtp-Source: AB8JxZpm+owMcno6p5vqXNaYEh08BNn/AoN47sjRjDaBTrsfxSLC8h5vMr18nbdpItsKaGHycM48oA==
Date: Wed, 23 May 2018 15:02:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: rjw@rjwysocki.net, sudeep.holla@arm.com, linux@armlinux.org.uk,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180523093235.k7xugnd7pfisazdx@vireshk-i7>
References: <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
 <1527066324-24726-1-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527066324-24726-1-git-send-email-ilialin@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18, 12:05, Ilia Lin wrote:
> In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO processors,
> the CPU frequency subset and voltage value of each OPP varies
> based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
> defines the voltage and frequency value based on the msm-id in SMEM
> and speedbin blown in the efuse combination.
> The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> to provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each OPP of
> operating-points-v2 table when it is parsed by the OPP framework.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm          |  10 +++
>  drivers/cpufreq/Makefile             |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |   3 +
>  drivers/cpufreq/qcom-cpufreq-kryo.c  | 163 +++++++++++++++++++++++++++++++++++
>  4 files changed, 177 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c

Hi Ilia,

So the patch looks good now. But I don't see how this series is going
to get merged. You are touching all parts of the kernel and no single
maintainer would be able to get these merged easily.

What I would suggest is that you divided the series in at least 3
parts.

- Patch 10 and 11, just the cpufreq stuff. So that Rafael can apply
  those independently. Also mention the dependency on my OPP patches
  in the cover letter for those two patches.

- All clk patches in another series, so that Stephen can apply them.

- And finally everything else to go via ARM-Soc.

Maybe things wouldn't be that simple, but that's what you would need
to do to get things merged. And please add all Acked by tags you got
to the patches.

For this patch:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

--
viresh
