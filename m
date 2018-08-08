Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E385FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4FB21A86
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QVxid3dV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bQ1ih7Zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4FB21A86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbeHIBKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:10:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44476 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHIBKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:10:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0598860B12; Wed,  8 Aug 2018 22:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533768539;
        bh=1wGsFkc1RaNOcg/iSuLLOSmXDip4Gjk73nuxqcu/Y3Q=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=QVxid3dVrLIVpV/h2tTXiO2p6sNkE/7NRzRCgL14nxidu2YWBN3hK5v/78Bb2fQ2o
         VmMcoIzPL/T9NhSS2540n24AzYz0ha4MmthmoYUV3Mk1W7BRrEWwcGJqA4rob8lwQI
         cruVrBdylXaoP/grYQ0dS812wzOy+UW8tuPIeBM0=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EE6E60807;
        Wed,  8 Aug 2018 22:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533768538;
        bh=1wGsFkc1RaNOcg/iSuLLOSmXDip4Gjk73nuxqcu/Y3Q=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=bQ1ih7ZmSuSf2zx9f96+yphoZ/V4FWwSyfs87Nz/NGTZItEWVjd8a8FS0xS8cEr2K
         zpWwgSl4dmxFjJv5yikQXGX0/Xmy/p+rei3d28WRNjU49zzPHoALEl7OdfbFrI6nz8
         xcvIsE2zvBSBwOwLuUs2X/oCOOD0kgRGN+zejaMg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EE6E60807
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Wed, 8 Aug 2018 16:48:55 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>, Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ohad@wizery.com, mark.rutland@arm.com, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, ilina@codeaurora.org
Subject: Re: [PATCH 1/4] dt-bindings: reset: Add PDC reset binding for SDM845
 SoCs
Message-ID: <20180808224854.GB26960@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        ilina@codeaurora.org
References: <20180727152811.15258-1-sibis@codeaurora.org>
 <1533026547.3444.4.camel@pengutronix.de>
 <28f34ddf-03b2-0baa-c04f-15e546ef3f75@codeaurora.org>
 <20180807181659.GA20659@rob-hp-laptop>
 <ca959e6f-b1b0-8fdf-2c40-0b49a4cf06e6@codeaurora.org>
 <20180808213723.GA26960@jcrouse-lnx.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808213723.GA26960@jcrouse-lnx.qualcomm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 03:37:24PM -0600, Jordan Crouse wrote:
> On Wed, Aug 08, 2018 at 09:14:05PM +0530, Sibi Sankar wrote:
> > Hi Rob,
> > Thanks for the review
> > 
> > On 08/07/2018 11:46 PM, Rob Herring wrote:
> > >On Tue, Jul 31, 2018 at 06:27:24PM +0530, Sibi S wrote:
> > >>Hi Philipp,
> > >>Thanks for the review!
> > >>
> > >>On 07/31/2018 02:12 PM, Philipp Zabel wrote:
> > >>>Hi Sibi,
> > >>>
> > >>>On Fri, 2018-07-27 at 20:58 +0530, Sibi Sankar wrote:
> > >>>>Add SDM845 PDC (Power Domain Controller) reset controller binding
> > >>>>
> > >>>>Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > >>>>---
> > >>>>   .../bindings/reset/qcom,pdc-reset.txt         | 52 +++++++++++++++++++
> > >>>>   include/dt-bindings/reset/qcom,sdm845-pdc.h   | 20 +++++++
> > >>>>   2 files changed, 72 insertions(+)
> > >>>>   create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
> > >>>>   create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
> > >>>>
> > >>>>diff --git a/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
> > >>>>new file mode 100644
> > >>>>index 000000000000..85e159962e08
> > >>>>--- /dev/null
> > >>>>+++ b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
> > >>>>@@ -0,0 +1,52 @@
> > >>>>+PDC Reset Controller
> > >>>>+======================================
> > >>>>+
> > >>>>+This binding describes a reset-controller found on PDC-Global(Power Domain
> > >>>>+Controller) block for Qualcomm Technologies Inc SDM845 SoCs.
> > >>>>+
> > >>>>+Required properties:
> > >>>>+- compatible:
> > >>>>+	Usage: required
> > >>>>+	Value type: <string>
> > >>>>+	Definition: must be:
> > >>>>+		    "qcom,sdm845-pdc-global"
> > >>>>+
> > >>>>+- reg:
> > >>>>+	Usage: required
> > >>>>+	Value type: <prop-encoded-array>
> > >>>>+	Definition: must specify the base address and size of the register
> > >>>>+	            space.
> > >>>>+
> > >>>>+- #reset-cells:
> > >>>>+	Usage: required
> > >>>>+	Value type: <uint>
> > >>>>+	Definition: must be 1; cell entry represents the reset index.
> > >>>>+
> > >>>>+Example:
> > >>>>+
> > >>>>+pdc_reset: reset-controller@b2e0000 {
> > >>>
> > >>>Is this really just a reset controller?
> > >>>
> > >>>The name makes it sound like a driver binding to this should also
> > >>>provide pm_genpd and the binding should probably call this a power-
> > >>>controller: Documentation/devicetree/bindings/power/power_domain.txt.
> > >>>
> > >>
> > >>The PDC-global reg space which is a part of PDC-wrapper reg space seems
> > >>to be only used for the reset lines.
> > >>
> > >>Couple of other drivers use other parts of the PDC-wrapper reg space:
> > >>https://patchwork.kernel.org/patch/10223701/ (PDC-Interrupt controller)
> > >>https://patchwork.kernel.org/patch/10255767/ (GMU-PDC incorrectly tries
> > >>to occupy the entire pdc-wrapper reg space)
> > >>
> > >>since it couldn't be logically mapped into pdc-interrupt driver, it had
> > >>to be included as a separate reset driver.
> > >
> > >You can't have overlapping regions in DT (well, you can because we have
> > >to work-around existing DTs that do, but you shouldn't).
> > >
> > >A single node can be multiple providers such as interrupt controller and
> > >reset controller. It's an OS problem to split that into multiple
> > >drivers.
> > 
> > There will be no overlaps. Jordan will be changing the dt binding of
> > gmu_pdc so that there is no overlap I guess. What I meant to say is that
> > pdc-global is a separate reg-space and currently has no other
> > functionality other than exposing the reset lines.
> 
> Correct - the updated GPU DT will be:
> 
>   reg = <0x506a000 0x30000>,
>      <0xb280000 0x10000>,
>      <0xb480000, 0x10000>;
>   reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
> 
> Jordan

Code change:  https://patchwork.freedesktop.org/patch/243513/
DT change: https://patchwork.freedesktop.org/patch/243539/

Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
