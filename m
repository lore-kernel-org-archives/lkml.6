Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05C3C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE012086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sd3XIcFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE012086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbeIKGvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeIKGvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:51:47 -0400
Received: from dragon (unknown [45.56.155.216])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D07720645;
        Tue, 11 Sep 2018 01:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536630897;
        bh=I3cGLSW1smcZDM0Hdv3tuZFBOpPwpXiDogpzRckDYr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sd3XIcFzJ/OlmI25C0CvU61MfWE5WKr0wkf9txo8SHxkPZ3LufLbC5qIlLL1Pg8FY
         e8zc7XATrUaCa0K+NxEolZGRfHGxjvI7Y4OlIPrqaZMZwiIqAInJySzLGNgfDzOquK
         Y+t99/UwE9Z9DAJi1HUEj47KgUn/bMLiFpqWVfR8=
Date:   Tue, 11 Sep 2018 09:53:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, linux-imx@nxp.com,
        yibin.gong@nxp.com, "A.s. Dong" <aisheng.dong@nxp.com>
Subject: Re: [PATCH v9 3/6] kernel/reboot.c: export pm_power_off_prepare
Message-ID: <20180911015320.GA25790@dragon>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
 <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
 <20180802113552.GJ9117@sirena.org.uk>
 <20180827014815.GD29208@dragon>
 <20180906101516.GA5360@sirena.org.uk>
 <20180909020021.GA18838@dragon>
 <20180910151926.GA10889@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910151926.GA10889@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 04:19:26PM +0100, Mark Brown wrote:
> On Sun, Sep 09, 2018 at 10:00:23AM +0800, Shawn Guo wrote:
> > On Thu, Sep 06, 2018 at 11:15:17AM +0100, Mark Brown wrote:
> 
> > > I was expecting to get a pull request with the precursor patches in it -
> > > the regulator driver seems to get a moderate amount of development so
> > > there's a reasonable risk of conflicts.
> 
> > What about you create a stable topic branch for regulator patches and I
> > pull it into IMX tree?
> 
> Sure, I can send a pull request back but the first two patches in the
> series are ARM ones - are you OK with me just applying them and sending
> them in the pull request or do you want to apply them first?

I just took another look at the series.  It seems that there is no
build-time dependency between regulator and platform patches.  So I
think we can handle the series like:

 - You apply patch #3, #4 and #5 on regulator tree;
 - I apply the reset on IMX tree.

There shouldn't be any build or run time regression on either tree, and
the feature that the series adds will be available when both trees get
merged together on -next or Linus tree.

@Oleksij Is my understanding above correct?

Shawn
