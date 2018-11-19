Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E091C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A611A2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nnWFsAzE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TIB2hCy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A611A2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbeKTHLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:11:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43800 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730796AbeKTHLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:11:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1D8EB60791; Mon, 19 Nov 2018 20:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542660348;
        bh=61cGU0Rqs/2iwX1KhmhUPqehTzBBwGTIGNh1HKI/T6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnWFsAzEC8Ygc8E4LA6xUqyMrTek89Ozu7PMx8Gu+2eARGfDIdNH4y5HhT4yP9L19
         Q57dNj37p/KgBZRzRCXZh88N5vRTENsnr1R8QkE/yiDU6PMQNWLzhWY/oRSd3vzSrP
         XZE8hlPDeQYwcy9LlMwFZr8JLfleSwX9rB+Jj5Qc=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1979460B19;
        Mon, 19 Nov 2018 20:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542660347;
        bh=61cGU0Rqs/2iwX1KhmhUPqehTzBBwGTIGNh1HKI/T6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIB2hCy9kq1NMYuGVvylEFTUJo7+TjT8a30m3LBNeJQW6yD87i5+sb6lOByQL9Klm
         21X82kcMWWX2m+aLnEm21ajbX5CwjAVIrqMSVVq67PE4T/RcMoEgP1HUiqi7VmYYOa
         6eHmS9mMI5oTlI5GrbpGY+//Zbx0ndUYPJO0v8X4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1979460B19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 19 Nov 2018 13:45:43 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Amit Nischal <anischal@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Add QCOM graphics clock controller driver for
 SDM845
Message-ID: <20181119204543.GA31792@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Amit Nischal <anischal@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1534141987-29601-1-git-send-email-anischal@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534141987-29601-1-git-send-email-anischal@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 12:03:03PM +0530, Amit Nischal wrote:
> Changes in v3:
> * Modified the determine_rate() op to use the min/max rate range
>   to round the requested rate within the set_rate range. With this,
>   requested set rate will always stay within the limits.
> 
> Changes in v2:
> Addressed review comments given by Stephen: https://lkml.org/lkml/2018/6/6/294
> * Introduce clk_rcg2_gfx3d_determine_rate ops to return the best parent
>   as 'gpucc_pll0_even' and best parent rate as twice of the requested rate
>   always. This will eliminate the need of frequency table as source and
>   div-2 are fixed for gfx3d_clk_src.
>   Also modified the clk_rcg2_set_rate ops to configure the fixed source and
>   div.
> * Add support to check if requested rate falls within allowed set_rate range.
>   This will not let the source gpucc_pll0 to go out of the supported range
>   and also client can request the rate within the range.
> * Fixed comment text in probe function and added module description for GPUCC
>   driver.
> 
> The graphics clock driver depends upon the below change.
> 	https://lkml.org/lkml/2018/6/23/108
> 
> Changes in v1:
> This patch series adds support for graphics clock controller for SDM845.
> Below is the brief description for each change:
> 
> 1. For some of the GDSCs, there is requirement to enable/disable the
>    few clocks before turning on/off the gdsc power domain. This patch
>    will add support to enable/disable the clock associated with the
>    gdsc along with power domain on/off callbacks.
> 
> 2. To turn on the gpu_gx_gdsc, there is a hardware requirement to
>    turn on the root clock (GFX3D RCG) first which would be the turn
>    on signal for the gdsc along with the SW_COLLAPSE. As per the
>    current implementation of clk_rcg2_shared_ops, it clears the
>    root_enable bit in the enable() clock ops. But due to the above
>    said requirement for GFX3D shared RCG, root_enable bit would be
>    already set by gdsc driver and rcg2_shared_ops should not clear
>    the root unless the disable() is called.
> 
>    This patch add support for the same by reusing the existing
>    clk_rcg2_shared_ops and deriving "clk_rcg2_gfx3d_ops" clk_ops
>    for GFX3D clock to take care of the root set/clear requirement.
> 
> 3. Add device tree bindings for graphics clock controller for SDM845.
> 
> 4. Add graphics clock controller (GPUCC) driver for SDM845.
> 
> [v1] : https://lore.kernel.org/patchwork/project/lkml/list/?series=348697
> [v2] : https://lore.kernel.org/patchwork/project/lkml/list/?series=359012
> 
> Amit Nischal (4):
>   clk: qcom: gdsc: Add support to enable/disable the clocks with GDSC
>   clk: qcom: Add clk_rcg2_gfx3d_ops for SDM845
>   dt-bindings: clock: Introduce QCOM Graphics clock bindings
>   clk: qcom: Add graphics clock controller driver for SDM845
> 
>  .../devicetree/bindings/clock/qcom,gpucc.txt       |  18 +
>  drivers/clk/qcom/Kconfig                           |   9 +
>  drivers/clk/qcom/Makefile                          |   1 +
>  drivers/clk/qcom/clk-rcg.h                         |   1 +
>  drivers/clk/qcom/clk-rcg2.c                        |  86 +++-
>  drivers/clk/qcom/gdsc.c                            |  44 +++
>  drivers/clk/qcom/gdsc.h                            |   5 +
>  drivers/clk/qcom/gpucc-sdm845.c                    | 438 +++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gpucc-sdm845.h      |  38 ++
>  9 files changed, 638 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc.txt
>  create mode 100644 drivers/clk/qcom/gpucc-sdm845.c
>  create mode 100644 include/dt-bindings/clock/qcom,gpucc-sdm845.h

This seems as good a place as any to kick off this discussion since it will
influence what these patches look like the next go around. Settle in because
this is going to get wordy...

The sdm845 GPU is comprised of two nested power domains: CX and GX. Put simply
from a CPU perspective the CX domain controls the GMU which is a microprocessor
co-located with the GPU. The GMU in turn controls the GX domain which powers the
GPU hardware. Under normal conditions the CPU powers on the CX domain and boots
the GMU and then the GMU turns on the GX and controls it under the assumption
that the GMU firmware can handle power collapse much faster than the CPU. The
GMU continues to control the GX domain up and down until we are idle for long
enough that we want to suspend the CX domain as well.

When we want to suspend the GMU we trigger a shutdown process on the GMU
which turns off GX and then the CPU turns off CX through the usual
pm_runtime_put() sequence. Under these ideal circumstances the CPU should have
no visibility into the GX at all - we should never control any headswitches or
clocks anywhere in that domain. Except....

There is one case where the CPU needs to touch the GX: due to power sequencing
requirements the GX needs to be turned off before the CX (and the CX needs to be
enabled before the GX during power up). In the very rare situation where the
GMU itself crashes and leaves the GX headswitch on the CPU needs to reach in and
turn off the GX before turning off the CX and rebooting the GMU. This is
problematic from a CPU perspective because there is no way to just go in and
hack on the register directly; we need some infrastructure set up and ready to
handle the odd use case.

We discussed this a while at LPC and Stephen had a good idea. We should keep the
GX gdsc but hack it so that the enable function does nothing (because we don't
want the GPU to turn on the headswitch ever) but leave the disable function as
is. Then we attach that genpd with dev_pm_attach_by_name() to the GMU device
and power enable/disable it at the appropriate times. Most of the time the
disable call will write to an already disabled headswitch but in that very
special situation it will actually turn off the headswitch and the world can be
right again.

So I did this and it works. At least it works for the regular case. It is
really difficult to cause the GMU to fault with the GX left on; I think I'm
going to need to hack on the firmware to test that path but I've verified that
the modified GDSC is toggling the power off before we suspend the CX so I think
thats a win.

I'll post patches against this patchset for an RFC but I mention it here because
there are a bunch of clocks defined in gpucc-sdm845.c that are not needed (
either we never call them because we don't touch GX clocks or they are parents
of uneeded clocks). It also seems like we don't need the clk_hws/clk_count
infrastructure in gdsc.c. From my testing I can safely toggle the gx gdsc off
from the CPU without 'gpu_cc_gx_gfx3d_clk_src'.

Obviously we'll need some more review and I need the actual clock experts to
weigh in but this is encouraging news because I think it lets us move ahead with
gpucc and also solve my little nagging hardware workaround issue to boot.

Look for patches shortly, in the mean time I'm going to comment to point out the
clocks I don't think we need any more so Taniya can make a new patchset.

Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
