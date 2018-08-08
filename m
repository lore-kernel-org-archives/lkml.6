Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4745AC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9815E21AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nr9cdzBj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nr9cdzBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9815E21AA8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeHHX7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:59:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHHX7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:59:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EB99660710; Wed,  8 Aug 2018 21:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533764247;
        bh=OzCV/tODh9CfukPkcaCEHvkbc3S3lLHU99G5Dk1cALs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nr9cdzBjk4gcir3jc1jWeEr092IfsgWwYHRY/uXrNUc3I6eMcZrg76y6dlMXHeccI
         C0jKVuocYOtZIkBsRElqYQ6oHBIanPeYMOtQOYAj6vOmyiO5ulVx9ECTx0KmdrN4ab
         68qmNTgBedLqaHNZHOCnCB+fShmxacSrZQheHnj8=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12F9760AD8;
        Wed,  8 Aug 2018 21:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533764247;
        bh=OzCV/tODh9CfukPkcaCEHvkbc3S3lLHU99G5Dk1cALs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nr9cdzBjk4gcir3jc1jWeEr092IfsgWwYHRY/uXrNUc3I6eMcZrg76y6dlMXHeccI
         C0jKVuocYOtZIkBsRElqYQ6oHBIanPeYMOtQOYAj6vOmyiO5ulVx9ECTx0KmdrN4ab
         68qmNTgBedLqaHNZHOCnCB+fShmxacSrZQheHnj8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12F9760AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Wed, 8 Aug 2018 15:37:24 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ohad@wizery.com, mark.rutland@arm.com, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, ilina@codeaurora.org
Subject: Re: [PATCH 1/4] dt-bindings: reset: Add PDC reset binding for SDM845
 SoCs
Message-ID: <20180808213723.GA26960@jcrouse-lnx.qualcomm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca959e6f-b1b0-8fdf-2c40-0b49a4cf06e6@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 09:14:05PM +0530, Sibi Sankar wrote:
> Hi Rob,
> Thanks for the review
> 
> On 08/07/2018 11:46 PM, Rob Herring wrote:
> >On Tue, Jul 31, 2018 at 06:27:24PM +0530, Sibi S wrote:
> >>Hi Philipp,
> >>Thanks for the review!
> >>
> >>On 07/31/2018 02:12 PM, Philipp Zabel wrote:
> >>>Hi Sibi,
> >>>
> >>>On Fri, 2018-07-27 at 20:58 +0530, Sibi Sankar wrote:
> >>>>Add SDM845 PDC (Power Domain Controller) reset controller binding
> >>>>
> >>>>Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> >>>>---
> >>>>   .../bindings/reset/qcom,pdc-reset.txt         | 52 +++++++++++++++++++
> >>>>   include/dt-bindings/reset/qcom,sdm845-pdc.h   | 20 +++++++
> >>>>   2 files changed, 72 insertions(+)
> >>>>   create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
> >>>>   create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
> >>>>
> >>>>diff --git a/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
> >>>>new file mode 100644
> >>>>index 000000000000..85e159962e08
> >>>>--- /dev/null
> >>>>+++ b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
> >>>>@@ -0,0 +1,52 @@
> >>>>+PDC Reset Controller
> >>>>+======================================
> >>>>+
> >>>>+This binding describes a reset-controller found on PDC-Global(Power Domain
> >>>>+Controller) block for Qualcomm Technologies Inc SDM845 SoCs.
> >>>>+
> >>>>+Required properties:
> >>>>+- compatible:
> >>>>+	Usage: required
> >>>>+	Value type: <string>
> >>>>+	Definition: must be:
> >>>>+		    "qcom,sdm845-pdc-global"
> >>>>+
> >>>>+- reg:
> >>>>+	Usage: required
> >>>>+	Value type: <prop-encoded-array>
> >>>>+	Definition: must specify the base address and size of the register
> >>>>+	            space.
> >>>>+
> >>>>+- #reset-cells:
> >>>>+	Usage: required
> >>>>+	Value type: <uint>
> >>>>+	Definition: must be 1; cell entry represents the reset index.
> >>>>+
> >>>>+Example:
> >>>>+
> >>>>+pdc_reset: reset-controller@b2e0000 {
> >>>
> >>>Is this really just a reset controller?
> >>>
> >>>The name makes it sound like a driver binding to this should also
> >>>provide pm_genpd and the binding should probably call this a power-
> >>>controller: Documentation/devicetree/bindings/power/power_domain.txt.
> >>>
> >>
> >>The PDC-global reg space which is a part of PDC-wrapper reg space seems
> >>to be only used for the reset lines.
> >>
> >>Couple of other drivers use other parts of the PDC-wrapper reg space:
> >>https://patchwork.kernel.org/patch/10223701/ (PDC-Interrupt controller)
> >>https://patchwork.kernel.org/patch/10255767/ (GMU-PDC incorrectly tries
> >>to occupy the entire pdc-wrapper reg space)
> >>
> >>since it couldn't be logically mapped into pdc-interrupt driver, it had
> >>to be included as a separate reset driver.
> >
> >You can't have overlapping regions in DT (well, you can because we have
> >to work-around existing DTs that do, but you shouldn't).
> >
> >A single node can be multiple providers such as interrupt controller and
> >reset controller. It's an OS problem to split that into multiple
> >drivers.
> 
> There will be no overlaps. Jordan will be changing the dt binding of
> gmu_pdc so that there is no overlap I guess. What I meant to say is that
> pdc-global is a separate reg-space and currently has no other
> functionality other than exposing the reset lines.

Correct - the updated GPU DT will be:

  reg = <0x506a000 0x30000>,
     <0xb280000 0x10000>,
     <0xb480000, 0x10000>;
  reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
