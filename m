Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9E0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F102146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfBTVBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:01:31 -0500
Received: from muru.com ([72.249.23.125]:39948 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbfBTVBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:01:31 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BF71C80E1;
        Wed, 20 Feb 2019 21:01:40 +0000 (UTC)
Date:   Wed, 20 Feb 2019 13:01:27 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     David Miller <davem@davemloft.net>
Cc:     grygorii.strashko@ti.com, kishon@ti.com, robh+dt@kernel.org,
        netdev@vger.kernel.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel
 driver
Message-ID: <20190220210127.GU15711@atomide.com>
References: <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
 <20190220.112244.1206973642383679896.davem@davemloft.net>
 <20190220203326.GT15711@atomide.com>
 <20190220.124155.2226787912266109280.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220.124155.2226787912266109280.davem@davemloft.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Miller <davem@davemloft.net> [190220 20:42]:
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 20 Feb 2019 12:33:26 -0800
> 
> > * David Miller <davem@davemloft.net> [190220 19:23]:
> >> From: Grygorii Strashko <grygorii.strashko@ti.com>
> >> Date: Wed, 20 Feb 2019 17:25:19 +0200
> >> 
> >> > Deprecate cpsw-phy-sel driver as it's been replaced with new
> >> > TI phy-gmii-sel PHY driver.
> >> > 
> >> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >> 
> >> Acked-by: David S. Miller <davem@davemloft.net>
> > 
> > Thanks for the ack, but actually I'd prefer you to pick
> > this patch at some future date. I suggest Grygorii just
> > repost this one after v5.1-rc1.
> 
> It's so much easier if you group this with those DT changes, they
> logically belong together as well and it helps someone reading
> the changes in the tree also if they are side by side.

I agree that a group of patches should go together in
most cases.

> Why don't you want to integrate this with them?

Because the arm-soc tree wants dts changes separately in
general. The dts changes are considered firmware describing
hardware. And it makes it possible to split the arm-soc pile
of patches into multiple pull requests. In theory there
should be no dependency between dts changes and driver
changes, but in reality that's not always the case :)

What I can do is set up a separate branch with just this
patch on top of the dts changes that the arm-soc guys can
then merge towards the end of the merge cycle. If that
works for you, let me know and I'll do it.

Regards,

Tony
