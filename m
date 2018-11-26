Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE484C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92A820664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92A820664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeK0GJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:09:13 -0500
Received: from muru.com ([72.249.23.125]:55234 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeK0GJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:09:12 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E0C548068;
        Mon, 26 Nov 2018 19:14:09 +0000 (UTC)
Date:   Mon, 26 Nov 2018 11:14:05 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Belisko Marek <marek.belisko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Message-ID: <20181126191405.GM53235@atomide.com>
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
> On Mon, Nov 19, 2018 at 09:14:06AM -0800, Tony Lindgren wrote:
> > Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
> > Tegra114 PMIC interrupt") states that tegra114 inverts the
> > polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.
> > 
> > So it seems that commit df545d1cd01a ("mfd: palmas: Provide
> > irq flags through DT/platform data") wrongly sets the
> > PALMAS_POLARITY_CTRL_INT_POLARITY on IRQ_TYPE_LEVEL_HIGH
> > while it should set it on IRQ_TYPE_LEVEL_LOW.
> 
> Oops, sorry, you seem to have come to pretty much the same conclusion as
> I did. I think what we need to do is find a copy of the TRM and see what
> exactly the right behaviour is. Or we need to find someone that can take
> measurements of the PMIC interrupt pin.

Yeah so either tegra inverts the PMIC interrupt twice now,
or we have also omap5 wkupgen also inverting the PMIC interrupt
once.. Santosh, do you remember if omap5 wkupgen might be
inverting the palmas interrupt?

Regards,

Tony
