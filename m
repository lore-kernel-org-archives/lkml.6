Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFD6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BB520660
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BB520660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbeK1FCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:02:04 -0500
Received: from muru.com ([72.249.23.125]:55364 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbeK1FCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:02:03 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BEC6D8030;
        Tue, 27 Nov 2018 18:03:23 +0000 (UTC)
Date:   Tue, 27 Nov 2018 10:03:18 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Belisko Marek <marek.belisko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Message-ID: <20181127180318.GT53235@atomide.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com>
 <20181119171406.GQ53235@atomide.com>
 <20181126101434.GB10878@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126101434.GB10878@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Thierry Reding <treding@nvidia.com> [181126 10:14]:
> I'm not sure we need to go to those lengths. As far as I'm concerned, if
> it turns out that we've inverted the logic for Tegra114, that's a bug in
> the DTS and we should fix it along with the driver to remove the double
> negation. I don't think this would be causing any problems with existing
> DTBs since, as far as I can tell, the TPS65913 is only used on Dalmore
> (which was never publicly available) or Roth and TN7, neither of which I
> think anyone ever ran upstream Linux on other than maybe Alex who added
> the support. In all of the above cases, there is no problem updating the
> DTB since it's all loaded either from eMMC or from an Android boot image
> as far as I understand.

As Jon explained, Tegra PMC inverts the Palmas interrupt twice, so it
gets inverted total three times. So no need to do anything right now,
I'll just change the omap5 PMIC interrupt to use a GPIO instead like
dra7 is already doing.

Thanks everybody for checking the use on Tegra.

Regards,

Tony
