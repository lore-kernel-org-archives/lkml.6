Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9374C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183D521754
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yI8c6VNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183D521754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeH0Fdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 01:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbeH0Fdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 01:33:31 -0400
Received: from dragon (unknown [104.237.86.214])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F6B12174A;
        Mon, 27 Aug 2018 01:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535334545;
        bh=qVmvEHEttmu1FgpYWvfPTFdUVhv9iUI7knpzC3i4qTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yI8c6VNymZwS724lONgBB2Cc8KrN4kR7bDorAHPivf815FeHU/g9hss+lYaRfufFT
         aHBHkL/AhpP9O8wZGXTuUEUDeFFBC96xidkYS6FN92XHyYvnm/b+7g3LFCiR7eDm2I
         e+L/G/eQL3A3eek6QWYRxlPpHfIXfIrbe/nQ1MpU=
Date:   Mon, 27 Aug 2018 09:48:16 +0800
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
Message-ID: <20180827014815.GD29208@dragon>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
 <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
 <20180802113552.GJ9117@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802113552.GJ9117@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 12:35:52PM +0100, Mark Brown wrote:
> On Thu, Aug 02, 2018 at 12:47:27PM +0200, Oleksij Rempel wrote:
> > On 02.08.2018 12:44, Mark Brown wrote:
> 
> > > I thought we'd got an ack for this from Raphael on a previous version or
> > > am I mistaken?
> 
> > No, we got an:
> > "Anyway, I have no particular problems with exporting
> > pm_power_off_prepare via EXPORT_SYMBOL_GPL()."
> 
> > Should i see it as ACK?

Mark,

Can you ACK on those two regulator patches, so that I can queue this
series up on IMX tree?

Shawn
