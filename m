Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06146C65BD1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73FE214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73FE214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeJJDtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:49:03 -0400
Received: from muru.com ([72.249.23.125]:51852 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbeJJDtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:49:03 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7899E80C3;
        Tue,  9 Oct 2018 20:30:18 +0000 (UTC)
Date:   Tue, 9 Oct 2018 13:30:17 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] dt-bindings: phy: add cpsw port interface mode
 selection phy bindings
Message-ID: <20181009203017.GM5662@atomide.com>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-3-grygorii.strashko@ti.com>
 <20181009144000.GL5662@atomide.com>
 <3fa09831-0f70-dfcc-3fd9-f877215a4631@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa09831-0f70-dfcc-3fd9-f877215a4631@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [181009 20:10]:
> 
> 
> On 10/09/2018 09:40 AM, Tony Lindgren wrote:
> > * Grygorii Strashko <grygorii.strashko@ti.com> [181008 23:54]:
> >> +Examples:
> >> +	phy_gmii_sel: phy-gmii-sel {
> >> +		compatible = "ti,am3352-phy-gmii-sel";
> >> +		syscon-scm = <&scm_conf>;
> >> +		#phy-cells = <2>;
> >> +	};
> > 
> > Now that this driver can live in it's proper place in the
> 
> right
> 
> > dts, you may want to consider just using standard reg
> > property for it instead of the syscon-scm. And also get
> > rid of the syscon reads and writes.
> 
> Could you help clarify how to get syscon in this case?
> syscon_node_to_regmap(dev->parent->of_node)?

Hmm I don't think you need syscon at all now. You can just
ioremap the register(s) and use readl/writel and that's it.
Or use regmap without syscon if you prefer that.

The ioremap in this case should be hitting cached ranges
anyways, so no extra overhead there.

> Also, there are could be more then one gmii_sel registers in SCM in the future,
> so I hidden offsets in of_match data. 
> As result, "reg" not needed at all now.

But then you have to patch driver for various SoCs
instead of just configuring the standard reg property
in the dts file :)

Regards,

Tony
