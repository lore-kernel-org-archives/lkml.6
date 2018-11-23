Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505FAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B15820672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B15820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633031AbeKXDda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:33:30 -0500
Received: from muru.com ([72.249.23.125]:54862 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbeKXDd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:33:29 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D1D7380D4;
        Fri, 23 Nov 2018 16:48:31 +0000 (UTC)
Date:   Fri, 23 Nov 2018 08:48:27 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Belisko Marek <marek.belisko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Message-ID: <20181123164827.GE53235@atomide.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com>
 <20181119171406.GQ53235@atomide.com>
 <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jon Hunter <jonathanh@nvidia.com> [181120 11:14]:
> On 19/11/2018 17:14, Tony Lindgren wrote:
> > Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
> > Tegra114 PMIC interrupt") states that tegra114 inverts the
> > polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.
> 
> Yes Tegra can invert the polarity of the PMIC interrupt.

So is there some IP on Tegra called "Tegra PMC" that is
inverting the interrupt? Or is the "Tegra PMC" that commit
7e9d474954f4 mentions just the palmas configuration for
inverting the interrupt?

The problem I'm having is With omap5 where I can only get the
PMIC interrupts working with IRQ_TYPE_LEVEL_HIGH if
PALMAS_POLARITY_CTRL_INT_POLARITY is not set unlike for
Tegra.

Regards,

Tony
