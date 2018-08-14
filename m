Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECB5C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C242172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kHuilqxH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XvBvuDP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C242172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbeHNPHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:07:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51158 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbeHNPHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:07:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4CD2260BE6; Tue, 14 Aug 2018 12:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534249249;
        bh=duj1eTpJO27wXMv2JUjZgmqIlaiAb+9isXrkzlrxxJs=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=kHuilqxHmr3EpM9J1gH55nHGB+ErdGEqaHxI7E4hbViOwnok/JzRx7P08DWMZSORV
         LpOOP42V0bMSaffcPLM2P72+vBBbrOauZPG0siHuQfcFV/6CI06riYPhC8lzEb8OMS
         YTB6u12lUvrlb2bfSdF7kc5X+Un9RECSqWKPdNEg=
Received: from [10.201.3.39] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64056601B4;
        Tue, 14 Aug 2018 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534249247;
        bh=duj1eTpJO27wXMv2JUjZgmqIlaiAb+9isXrkzlrxxJs=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=XvBvuDP+0VMecms2odjHDbTkx4lZ9ls8x/ocQOEI3mlYvU4a+a6Nr6Q/e9OlEJ1nO
         74JzrKORkCT+p9hEWNNZfO0/8ANJ4z3F3xxoiuoKjhpzqSgY8ZKZd/AF6Lgtw5PHnc
         ChIU1puOw1YDa129gCxTJDFXBwiizyNTT7+TAh/I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64056601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH V12 00/14] Krait clocks + Krait CPUfreq
To:     mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com,
        linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, sboyd@codeaurora.org,
        linux@armlinux.org.uk, thierry.escande@linaro.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        niklas.cassel@linaro.org
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
From:   Sricharan R <sricharan@codeaurora.org>
Message-ID: <2ae96741-94c0-ba4c-fc19-05d33179683c@codeaurora.org>
Date:   Tue, 14 Aug 2018 17:50:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Craig,

On 8/14/2018 5:42 PM, Sricharan R wrote:
> [v12]
>   * Added my signed-off that was missing in some patches.
>   * Added Bjorn's acked that i missed earlier.
> 

  Can you give this a try on your 8974 device and check if the
  pvs version reporting, scaling for higher frequencies are fine ?
  Sorry, i could not get hold of a 8974 device. So in-case if you still
  have the issues with higher frequencies, can you give a quick debug
  and report. That would be of great help.

Regards,
 Sricharan


> [v11]
>   * Dropped patch 13 and 14 from v10 and
>     merged the qcom-cpufreq-krait driver to the existing qcom-cpufreq-kryo.c
>   * Rebased on top of clk-next
>   * Fixed a bug while populating the pvs version for krait.
> 
> [v10]
>   * Addressed Stephen's comments to add clocks bindings properties
>     to the newly introduced nodes.
>   * Added a change to include opp-supported-hw to qcom-cpufreq.c
>   * Rebased on top of clk-next
>   * Although there were minor changes to bindings and the driver
>     retained the acked-by tags from Rob and Viresh respectively.    
> 
> [v9]
>   * Fixed a rebase issue in Makefile and added Tag from Robh.
> 
> [v8]
>   * Fixed a bug in path#14 pointed out by Viresh and also added tags.
>     No change in any other patch.
> 
> [v7]
>   * Fixed comments from Viresh for cleaning up the error handling
>     in qcom-cpufreq.c. Also changed the init function to lateinit
>     call. This is required because nvmem which gets initialised with
>     module_init needs to go first.
>   * Fixed Rob's comments for bindings documentation
>   * Fixed kbuild build issue in clk-lpc32xx.c
>   * Rebased on top of clk-next
> 
> [v6]
>   * Adrressed comments from Viresh for patch #14 in v5 [5]
>   * Introduced a new binding operating-points-v2-krait-cpu
>     as per discussion with Rob
>   * Added Review tags
> 
> [v5]
>   * Addressed comments from Rob for bindings
>   * Addressed comments from Viresh to use dev_pm_opp_set_prop_name, accordingly
>     dropped patch #12 and corrected patch #11 from previous patch set in [4]
>   * Converted to use #spdx tags for newly introduced files
> 
> Mostly a resend of the v3 posted by Stephen quite some time back [1]
> except for few changes.
>   Based on reading some feedback from list,
>   * Dropped the patch "clk: Add safe switch hook" from v3 [2].
>     Now this is taken care by patch#10 in this series only for Krait.
>   * Dropped the path "clk: Avoid sending high rates to downstream
> 		      clocks during set_rate" from v3 [3].
>   * Rebased on top of clk-next.
>   * Dropped the DT update from the series. Will send separately
>   * Now with cpufreq-dt+opp supporting voltage scaling, registering the
>     krait cpu supplies in DT should be sufficient. But one issue is,
>     the qcom-cpufreq drivers reads the efuse and based on that registers
>     the opp data and then registers the cpufreq-dt device. So when
>     cpufreq-dt driver probes and registers the regulator to the OPP framework,
>     it expects that the opp data for the device should not be registered before
>     the regulator. Will send a RFC patch removing that check, to find out the
>     right way of doing it.
> 
> These patches provide cpufreq scaling on devices with Krait CPUs.
> In Krait CPU designs there's one PLL and two muxes per CPU, allowing
> us to switch CPU frequencies independently.
> 
> 				 secondary
> 	 +-----+                    +
> 	 | QSB |-------+------------|\
> 	 +-----+       |            | |-+
> 		       |    +-------|/  |
> 		       |    |       +   |
> 	 +-----+       |    |           |
> 	 | PLL |----+-------+           |   primary
> 	 +-----+    |  |                |     +
> 		    |  |                +-----|\       +------+
> 	 +-------+  |  |                      | \      |      |
> 	 | HFPLL |----------+-----------------|  |-----| CPU0 |
> 	 +-------+  |  |    |                 |  |     |      |
> 		    |  |    | +-----+         | /      +------+
> 		    |  |    +-| / 2 |---------|/
> 		    |  |      +-----+         +
> 		    |  |         secondary
> 		    |  |            +
> 		    |  +------------|\
> 		    |               | |-+
> 		    +---------------|/  |   primary
> 				    +   |     +
> 					+-----|\       +------+
> 	 +-------+                            | \      |      |
> 	 | HFPLL |----------------------------|  |-----| CPU1 |
> 	 +-------+          |                 |  |     |      |
> 			    | +-----+         | /      +------+
> 			    +-| / 2 |---------|/
> 			      +-----+         +
> 
> To support this in the common clock framework we model the muxes,
> dividers, and PLLs as different clocks. CPUfreq only interacts
> with the primary mux (farthest right in the diagram). When CPUfreq
> sets a rate, the mux code finds the best parent that can provide the rate.
> Due to the design, QSB and the top PLL are always a fixed rate and thus
> only support one frequency each. These sources provide the lowest
> frequencies for the CPUs. The HFPLLs are where we can make the CPU go
> faster (GHz range). Sometimes we need to run the HFPLL twice as
> fast and divide it by two to get a particular frequency.
> 
> When switching rates we can't leave the CPU clocked by the HFPLL because
> we need to turn off the output of the PLL when changing its frequency.
> This means we have to switch over to the secondary mux and use one of the
> fixed sources. This is why we need something like the safe parent patch.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/332607.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/332615.html
> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/332608.html
> [4] https://lwn.net/Articles/740994/ 
> [5] https://lkml.org/lkml/2017/12/19/537
> 
> 
> Sricharan R (3):
>   clk: qcom: Add safe switch hook for krait mux clocks
>   cpufreq: qcom: Re-organise kryo cpufreq to use it for other nvmem
>     based qcom socs
>   cpufreq: qcom: Add support for krait based socs
> 
> Stephen Boyd (11):
>   ARM: Add Krait L2 register accessor functions
>   clk: qcom: Add support for High-Frequency PLLs (HFPLLs)
>   clk: qcom: Add HFPLL driver
>   dt-bindings: clock: Document qcom,hfpll
>   clk: qcom: Add MSM8960/APQ8064's HFPLLs
>   clk: qcom: Add IPQ806X's HFPLLs
>   clk: qcom: Add support for Krait clocks
>   clk: qcom: Add KPSS ACC/GCC driver
>   dt-bindings: arm: Document qcom,kpss-gcc
>   clk: qcom: Add Krait clock controller driver
>   dt-bindings: clock: Document qcom,krait-cc
> 
>  .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt  |  19 +
>  .../devicetree/bindings/arm/msm/qcom,kpss-gcc.txt  |  44 +++
>  .../devicetree/bindings/clock/qcom,hfpll.txt       |  60 ++++
>  .../devicetree/bindings/clock/qcom,krait-cc.txt    |  34 ++
>  .../{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt}   |   7 +-
>  arch/arm/common/Kconfig                            |   3 +
>  arch/arm/common/Makefile                           |   1 +
>  arch/arm/common/krait-l2-accessors.c               |  48 +++
>  arch/arm/include/asm/krait-l2-accessors.h          |   9 +
>  drivers/clk/qcom/Kconfig                           |  28 ++
>  drivers/clk/qcom/Makefile                          |   5 +
>  drivers/clk/qcom/clk-hfpll.c                       | 244 +++++++++++++
>  drivers/clk/qcom/clk-hfpll.h                       |  44 +++
>  drivers/clk/qcom/clk-krait.c                       | 126 +++++++
>  drivers/clk/qcom/clk-krait.h                       |  40 +++
>  drivers/clk/qcom/gcc-ipq806x.c                     |  82 +++++
>  drivers/clk/qcom/gcc-msm8960.c                     | 172 +++++++++
>  drivers/clk/qcom/hfpll.c                           |  96 +++++
>  drivers/clk/qcom/kpss-xcc.c                        |  87 +++++
>  drivers/clk/qcom/krait-cc.c                        | 397 +++++++++++++++++++++
>  drivers/cpufreq/Kconfig.arm                        |   6 +-
>  drivers/cpufreq/Makefile                           |   2 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c               |   5 +
>  drivers/cpufreq/qcom-cpufreq-kryo.c                | 232 ------------
>  drivers/cpufreq/qcom-cpufreq-nvmem.c               | 387 ++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-msm8960.h       |   2 +
>  26 files changed, 1941 insertions(+), 239 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,hfpll.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
>  rename Documentation/devicetree/bindings/opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} (98%)
>  create mode 100644 arch/arm/common/krait-l2-accessors.c
>  create mode 100644 arch/arm/include/asm/krait-l2-accessors.h
>  create mode 100644 drivers/clk/qcom/clk-hfpll.c
>  create mode 100644 drivers/clk/qcom/clk-hfpll.h
>  create mode 100644 drivers/clk/qcom/clk-krait.c
>  create mode 100644 drivers/clk/qcom/clk-krait.h
>  create mode 100644 drivers/clk/qcom/hfpll.c
>  create mode 100644 drivers/clk/qcom/kpss-xcc.c
>  create mode 100644 drivers/clk/qcom/krait-cc.c
>  delete mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-nvmem.c
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
