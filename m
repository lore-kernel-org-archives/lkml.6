Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C9BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C2C2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfBSR6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:58:18 -0500
Received: from muru.com ([72.249.23.125]:39706 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfBSR6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:58:18 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A56EB80B6;
        Tue, 19 Feb 2019 17:58:27 +0000 (UTC)
Date:   Tue, 19 Feb 2019 09:58:14 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Peng Hao <peng.hao2@zte.com.cn>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        wen.yang99@zte.com.cn
Subject: Re: [PATCH] arm/mach-omap2/display: fix possible object reference
 leak
Message-ID: <20190219175814.GO15711@atomide.com>
References: <1550071969-86286-1-git-send-email-peng.hao2@zte.com.cn>
 <20190219170516.GL15711@atomide.com>
 <alpine.DEB.2.20.1902191830490.27989@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1902191830490.27989@hadrien>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Julia Lawall <julia.lawall@lip6.fr> [190219 17:33]:
> On Tue, 19 Feb 2019, Tony Lindgren wrote:
> > In general, if the device tree node is never used afterwards,
> > should this be just:
> >
> > 	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
> > 	of_node_put(dev_node);
> > 	if (r) {
> > 		...
> > 	}
> >
> > If so, Julia might have a Coccinelle recpipe for it?
> 
> Unfortunately this is not really an ideal case for Coccinelle, because
> node is the result of calling a local function and Coccinelle doesn't by
> default do any interprocedural analysis.  It is possible to write a rule
> that explicitly looks for one function that returns a device node and then
> the pattern of its usage in the caller, though.

OK thanks for the information.

Regards,

Tony
