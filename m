Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE57C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB6120883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZjoZVV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB6120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeKIUrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:47:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727596AbeKIUrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:47:05 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ACB420827;
        Fri,  9 Nov 2018 11:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541761617;
        bh=Kitz769gPbnJhLc9D/ZmSfAHOok4EaZS3NVdyICaVkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iZjoZVV2QXTqm54UtRwgyFTXaQUQ1PUYJw8vNAi5r7RRKoAEOJN0kUTYXBRjlpmIb
         zLjxWKowuvi6QcVEYk+8/X/TEHx/7BoGwbqBPHnyusU0SekkhtdywuprWGJyrwf58H
         mylldG/UdEfXoEwUp8UEiMZYOl2d6sKwajDSTdzU=
Date:   Fri, 9 Nov 2018 16:36:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Qualcomm Synopsys High-Speed
 USB PHY binding
Message-ID: <20181109110647.GS12092@vkoul-mobl>
References: <20181108070449.23572-1-shawn.guo@linaro.org>
 <20181108070449.23572-2-shawn.guo@linaro.org>
 <20181109050819.GK12092@vkoul-mobl>
 <20181109063134.GA20049@tiger>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109063134.GA20049@tiger>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-11-18, 14:31, Shawn Guo wrote:
> On Fri, Nov 09, 2018 at 10:38:19AM +0530, Vinod Koul wrote:
> > On 08-11-18, 15:04, Shawn Guo wrote:
> > > +
> > > +- #phy-cells:
> > > +    Value type: <u32>
> > > +    Definition: Should be 0.
> > 
> > I dont quite understand the definition that it should be 0, maybe you
> > mean allowed value is 0, if so why have this property?
> 
> The property is defined by generic phy bindings phy/phy-bindings.txt.
> I can add a pointer to it if you think that's necessary.  The property
> should be 0 for our device, because there is zero number cell in phy
> specifier from dwc3 node as shown in the example.

That makes sense, also does it make sense it mention the properties in
phy/phy-bindings.txt, why not refer that here for the properties we use
and vlaues.

> 
> 	dwc3@78c0000 {
> 		...
> 		phys = <&usb2_phy_prim>;
> 		phy-names = "usb2-phy";
> 	}
> 
> And for that reason, we can use the generic .of_xlate implementation
> of_phy_simple_xlate() provided by phy core.  There are some comments
> in kernel doc of of_phy_simple_xlate() which might be helpful.
> 
> Shawn

-- 
~Vinod
