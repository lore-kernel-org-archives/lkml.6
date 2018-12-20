Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9249C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EA62186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nYCJE7o6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WRevvi+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388010AbeLTRhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:37:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49178 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387591AbeLTRhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:37:23 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B9166021A; Thu, 20 Dec 2018 17:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545327442;
        bh=1P3RNUjuvDHEARxpvDPujaDkVkb5r3coR1fEZlMwiaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nYCJE7o6W9XnSjSEccAcfXjEfMLwVJ3HVIUDUv1F0OyMEB6HkkEVtyLSPCxDZeBky
         DYdZkGOLGD2wsUknLY3HBWhTWjR9bley2iW6iYJKS+omOteq1IKUPgBDPuCLW2P4Be
         1Mx3q+U44N7xFs5Du5Z0TZXH3ZOIXMhI6nxd/iC0=
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jackp@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FA336021A;
        Thu, 20 Dec 2018 17:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545327441;
        bh=1P3RNUjuvDHEARxpvDPujaDkVkb5r3coR1fEZlMwiaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRevvi+X8vVmXyESdYS4faz6eoyM9pas51QkYoYpxsQjFsfyHVqZRH+U9kxpmjq4g
         lQldCX035JNpjgSgP6eren9+eNkglFEWMNu0hKALnkeRbUz0cKzc7lcMC2rris8Xum
         v5pEppFrGcNSbEAz00njWV75Z5zmFxzGOUsWVdSw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FA336021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date:   Thu, 20 Dec 2018 09:37:17 -0800
From:   Jack Pham <jackp@codeaurora.org>
To:     Rob Herring <robh@kernel.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, kishon@ti.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.guo@linaro.org, vkoul@kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>
Subject: Re: [PATCH 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
Message-ID: <20181220173633.GA19912@jackp-linux.qualcomm.com>
References: <1544176558-7946-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1544176558-7946-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20181220170531.GA19862@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220170531.GA19862@bogus>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Jorge,

On Thu, Dec 20, 2018 at 11:05:31AM -0600, Rob Herring wrote:
> On Fri, Dec 07, 2018 at 10:55:57AM +0100, Jorge Ramirez-Ortiz wrote:
> > Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
> > controller embedded in QCS404.
> > 
> > Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
> > definitions.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  .../devicetree/bindings/usb/qcom,usb-ssphy.txt     | 78 ++++++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> > new file mode 100644
> > index 0000000..fcf4e01
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> > @@ -0,0 +1,78 @@
> > +Qualcomm Synopsys 1.0.0 SS phy controller
> > +===========================================
> > +
> > +Synopsys 1.0.0 ss phy controller supports SS usb connectivity on Qualcomm
> > +chipsets
> > +
> > +Required properties:
> > +
> > +- compatible:
> > +    Value type: <string>
> > +    Definition: Should contain "qcom,usb-ssphy".
> 
> What is "qcom,dwc3-ss-usb-phy" which already exists then?

Uh, apparently only the bindings doc is there but the driver never
landed. I guess it fell through the cracks nearly 4 years ago.

https://lore.kernel.org/patchwork/patch/499502/

Jorge, does Andy's version of this driver at all resemble what can be
used for QCS404?

Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
