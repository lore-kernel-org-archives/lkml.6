Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E95C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F222085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RjpWsrU5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l8v0ylGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfAGU0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:26:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48922 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfAGU0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:26:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 303FD60866; Mon,  7 Jan 2019 20:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546892770;
        bh=k0IIBy1VXa8k+eoCFRBVYWHZ/OvHHkj0kyXCfayV9qU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjpWsrU5/8/ySCEGnkywuq/8ujmfCAp1ujcauIAS+VlIg0KnyiGxZOH0ylRF64r0G
         AoE02q2xhjoIg367HiEyTtVm/GE5fL7aEWmJONn93uQh+4Cn0Y05f/f7WhtQqkD2vp
         u3bq2IfXG9aIUN7c4UyWn6Kj4SjPbACZocyWnu64=
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jackp@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A9B860303;
        Mon,  7 Jan 2019 20:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546892768;
        bh=k0IIBy1VXa8k+eoCFRBVYWHZ/OvHHkj0kyXCfayV9qU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l8v0ylGzo2QB7c8e2BJAkpW4eUukmhGuVLlStz0msxeSrF5xXIxJNKXkkZ/DqZaAz
         En1X6fWhHR1wrhsPWnFnGGBr+MYYB2O3UwsmHgRovoZsK8iW0wPIz102ShYyklTwbw
         +MZFvu+0DdLdGcts2jWb+UjwDGOrmh4tMaGFxEJg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A9B860303
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date:   Mon, 7 Jan 2019 12:26:06 -0800
From:   Jack Pham <jackp@codeaurora.org>
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.guo@linaro.org,
        vkoul@kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>
Subject: Re: [PATCH 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
Message-ID: <20190107202606.GC23243@jackp-linux.qualcomm.com>
References: <1544176558-7946-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1544176558-7946-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20181220170531.GA19862@bogus>
 <20181220173633.GA19912@jackp-linux.qualcomm.com>
 <2a007a91-e709-c9f1-f634-ddcf707e954d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a007a91-e709-c9f1-f634-ddcf707e954d@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

Sorry for the late reply as I was out during the holiday break.

On Fri, Dec 28, 2018 at 01:38:59PM +0100, Jorge Ramirez wrote:
> On 12/20/18 18:37, Jack Pham wrote:
> >Hi Rob, Jorge,
> >
> >On Thu, Dec 20, 2018 at 11:05:31AM -0600, Rob Herring wrote:
> >>On Fri, Dec 07, 2018 at 10:55:57AM +0100, Jorge Ramirez-Ortiz wrote:
> >>>Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
> >>>controller embedded in QCS404.
> >>>
> >>>Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
> >>>definitions.
> >>>
> >>>Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> >>>Reviewed-by: Vinod Koul <vkoul@kernel.org>
> >>>---
> >>>  .../devicetree/bindings/usb/qcom,usb-ssphy.txt     | 78 ++++++++++++++++++++++
> >>>  1 file changed, 78 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> >>>
> >>>diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> >>>new file mode 100644
> >>>index 0000000..fcf4e01
> >>>--- /dev/null
> >>>+++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> >>>@@ -0,0 +1,78 @@
> >>>+Qualcomm Synopsys 1.0.0 SS phy controller
> >>>+===========================================
> >>>+
> >>>+Synopsys 1.0.0 ss phy controller supports SS usb connectivity on Qualcomm
> >>>+chipsets
> >>>+
> >>>+Required properties:
> >>>+
> >>>+- compatible:
> >>>+    Value type: <string>
> >>>+    Definition: Should contain "qcom,usb-ssphy".
> >>
> >>What is "qcom,dwc3-ss-usb-phy" which already exists then?
> >
> >Uh, apparently only the bindings doc is there but the driver never
> >landed. I guess it fell through the cracks nearly 4 years ago.
> >
> >https://lore.kernel.org/patchwork/patch/499502/
> >
> >Jorge, does Andy's version of this driver at all resemble what can be
> >used for QCS404?
> 
> on close inspection I cant see any similitudes between the drivers.
> Unfortunately I don't have access to documentation yet but the
> control register offsets and the control bits in the drivers do not
> match.
> 
> because of the above I'd like to go ahead with our separate drivers
> -already tested and validated- for HS (Shawn's) and SS (mine).
> 
> if that is acceptable, should we reuse the upstream bindings for
> our implementation? or perhaps Shawn Guo will do for his HS version
> of the driver and I go ahead and create a new one? what would you
> suggest?

I'm not really sure. My understanding of the driver Andy submitted
were for some of the older MSM and IPQ SoCs that implemented the PHY
controls as part of the DWC3 controller's "QScratch" registers, which is
why the bindings doc and the compatible string reference "dwc3" in both
the compatible and the docs filename. Is the SNPS PHY on QCS404
architected similarly in this regard? Either way, the existing bindings
doc for the non-existent driver looks incomplete for QCS404, so you'd
have to update it anyway. My feeling is that there should just be one
document describing all variants of SNPS PHYs on Qualcomm chips.

Maybe we should also just delete the "qcom,dwc3-ss-usb-phy" binding
unless there is a plan to resurrect Andy's driver.

Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
