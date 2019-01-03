Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226B7C43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20EE20815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546543163;
	bh=kS1MZVUP+cXo/4ff7pUmcGZgPt9t1L1WjV5+gQ/s+uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xm4CjzmiXuGoCpPriyE19F+HLEiCI7ar9cLRnACYMBoVhzbKO+ZiqM0/PEgaoIx1/
	 QpNxKLLnIfodwK2IwPYDigzSsxFyYuQTig29kHQ4t5647pVGMa20sSR/wzMjMMAP68
	 NA/534iuY+ZY5Q1C8SGdnGfyxBmbkQid+tQrS++Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfACTTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:19:22 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50267 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfACTTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:19:21 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so46761335iti.0;
        Thu, 03 Jan 2019 11:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TTnlFRMC/tE2y0XboP30PxCpwrUWxCmg8uvckIQqldo=;
        b=L/QPy2/Z/V3AIghSO28GSCBSLG1BbfHxuX2bRRr5KFMCWrZvgwl/TBdvSvYj3ulses
         0TrGs9O/SX/QNISVI9mdseOeSA0D47jqv2wJKYihWyv5FhzBKHuKpmoIaQrFLxaxwOjs
         a65pOpiLPokZoQxiQnWr4e2UOsKMb61yg35morf+LQA1fna3Hu4xApsVsxP+kkxlxKzc
         WgznNrDH2+hxQoopO2bKZE+nnDlsQ7Hu8cmB4d1GHdOny4bY/UOh4pipmR1mBLKxsH1b
         4Dp0cBZTN5Ay21ZbgUHqA+ijWyq/L3RqMJ9xVEJDW5cdtDkvJ63B0JbGW2LxhOj89A4d
         zxSA==
X-Gm-Message-State: AA+aEWZlBuWU+RdYKR3k6UEDvtd+fWkyHro70xTHr58eUYrKAen6Xz/M
        90ynyqgalWqv71U9DDe+Ug==
X-Google-Smtp-Source: AFSGD/UZEMhiT87aOENfaKWdNgM8dBWqIqypxNoZvZL5hB4KxZ576H7iGUkjGYuBCQHbvaAodjKt3w==
X-Received: by 2002:a02:b093:: with SMTP id v19mr34616129jah.64.1546543159424;
        Thu, 03 Jan 2019 11:19:19 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id t11sm6652270iop.88.2019.01.03.11.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 11:19:18 -0800 (PST)
Date:   Thu, 3 Jan 2019 13:19:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add document for Broadcom STB
 reset controller
Message-ID: <20190103191915.GB6613@bogus>
References: <20181221013409.14324-1-f.fainelli@gmail.com>
 <20181221013409.14324-2-f.fainelli@gmail.com>
 <20190103174117.GA6613@bogus>
 <2a54c2cf-5595-ade5-fb29-40e8b6d3133e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a54c2cf-5595-ade5-fb29-40e8b6d3133e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 10:53:25AM -0800, Florian Fainelli wrote:
> On 1/3/19 9:41 AM, Rob Herring wrote:
> > On Thu, Dec 20, 2018 at 05:34:08PM -0800, Florian Fainelli wrote:
> >> Add a binding document for the Broadcom STB reset controller, also known
> >> as SW_INIT-style reset controller.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  .../devicetree/bindings/reset/brcm,reset.txt  | 27 +++++++++++++++++++
> >>  1 file changed, 27 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,reset.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/reset/brcm,reset.txt b/Documentation/devicetree/bindings/reset/brcm,reset.txt
> >> new file mode 100644
> >> index 000000000000..6e5341b4f891
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/reset/brcm,reset.txt
> >> @@ -0,0 +1,27 @@
> >> +Broadcom STB SW_INIT-style reset controller
> >> +===========================================
> >> +
> >> +Broadcom STB SoCs have a SW_INIT-style reset controller with separate
> >> +SET/CLEAR/STATUS registers and possibly multiple banks, each of 32 bit
> >> +reset lines.
> >> +
> >> +Please also refer to reset.txt in this directory for common reset
> >> +controller binding usage.
> >> +
> >> +Required properties:
> >> +- compatible: should be brcm,brcmstb-reset
> >> +- reg: register base and length
> >> +- #reset-cells: must be set to 1
> >> +
> >> +Example:
> >> +
> >> +	reset: reset-controller@8404318 {
> >> +		compatible = "brcm,brcmstb-reset";
> >> +		reg = <0x8404318 0x30>;
> > 
> > Based on this address, should this be a sub-node of something else? Or 
> > not even a sub-node and just make the parent be a reset provider?
> 
> The reset controller is part of a larger "sundry" node which has a
> collection of functionality, from pinmux/pinctrl, reset controller,
> spare bits, chicken bits, anything the designers forgot to put somewhere
> else and decided to put there.
> 
> If there is one thing consistent though is that given a set of 32-bit
> register groups, they have a self contained functionality such that you
> can break up the larger "sundry" space into smaller sub-blocks which
> have one an only one functionality. Do you think this warrants a
> different representation in Device Tree?

With pinctrl in the mix, you're going to need sub-nodes anyways. So just 
define what this is a sub-node of.

Also, I'd prefer to have complete example for the "sundry" node and 
child nodes than partial examples spread across the tree.

Rob
