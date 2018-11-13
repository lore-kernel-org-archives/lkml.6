Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A653C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B81223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB+qDzvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B81223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbeKMPyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:54:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731193AbeKMPyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:54:36 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F0302245E;
        Tue, 13 Nov 2018 05:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088687;
        bh=jg6/cNcpXrThVvLCxw3xm38qU0tj4JH2EVOamCjRDwg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=XB+qDzvYVQ5d6rH5/0ELR7FSawZa/aUhhVg8RKJNTygAsoNPZXxt7qHk6XSZ6obHQ
         WlzLa80lJhP53IRTlJ4ksLsX47H+TQj/ogzavXo9ssWa+MQcBr5NQh291J4UGWcj08
         6FLY7aWDTVZOGbwg/2qI8T4ADtt8KELFrSn8RuBg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181112074553.GB31573@localhost.localdomain>
Cc:     corbet@lwn.net, mturquette@baylibre.com, linux@armlinux.org.uk,
        andrew.smirnov@gmail.com, robh@kernel.org, sre@kernel.org,
        linux@roeck-us.net, sjhuang@iluvatar.ai, mazziesaccount@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
References: <0e6f19f99a4321d37472635c9210f6c13ac53147.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
 <201808310820.GfPfChXp%fengguang.wu@intel.com>
 <20180831102123.GA2472@localhost.localdomain>
 <153582920636.19113.4389105687778850598@swboyd.mtv.corp.google.com>
 <20180903063843.GD2472@localhost.localdomain>
 <20181112074553.GB31573@localhost.localdomain>
Message-ID: <154208868668.88331.5998751050054061730@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: bd718x7: Initial support for ROHM bd71837/bd71847 PMIC
 clock
Date:   Mon, 12 Nov 2018 21:58:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-11-11 23:45:53)
> Hello Stephen & All,
> =

> On Mon, Sep 03, 2018 at 09:38:43AM +0300, Matti Vaittinen wrote:
> > =

> > On Sat, Sep 01, 2018 at 12:13:26PM -0700, Stephen Boyd wrote:
> > > Quoting Matti Vaittinen (2018-08-31 03:21:23)
> > > > Hello All,
> > > > =

> > > > Just wanted to point out for the reviewers that this patch depends =
on
> > > > not yet accepted MFD/regulator patch. (struct/defines in
> > > > include/linux/mfd/rohm-bd718x7.h were changed)
> > > > https://lore.kernel.org/lkml/cover.1535545377.git.matti.vaittinen@f=
i.rohmeurope.com/
> > > =

> > > Does anything besides the clk driver need the defines that are in the
> > > header which are used in this file?
> > =

> > The register address for clk enable and bit mask are not used by any
> > other driver. But I'd like to keep all the register addresses in one
> > enum. That eases checking changes when new chips come.
> > =

> > The private data for MFD (which contains for example the regmap and chip
> > type) are required by other drivers too.
> > =

> > > If not, then it's better to put
> > > those defines in the C file for the clk driver so we don't have to hop
> > > between files and have merge dependencies. Also, the regmap could
> > > possibly by grabbed from the dev->parent pointer instead of passing it
> > > down through an mfd structure, allowing this driver to be more generic
> > > assuming it is always a child of some mfd device that has a regmap.
> > =

> > Currently clk only uses regmap directly from the struct bd718xx. But I
> > would like to have the access to chip_type as well. And even if we forg=
et
> > the chip_type. Well, I only see two bad ways of omitting the struct
> > bd718xx:
> > =

> > 1. Always keep the regmap as first member in parent device's driver_dat=
a.
> > Then we can just get the driver data and do cast to regmap. I am not fan
> > of this as it breaks as fast as someone changes the struct bd718xx - and
> > as this is part of MFD - well, there is no guarantees the clk people are
> > even reviewing such change. Also if we need the chip type we are back
> > using the struct.
> > =

> > 2. Use some regmnap wrapper functions which would only take the parent
> > dev pointer and dig out the regmap details. This would be doable but
> > then we still have dependency to these wrappers (so dependency is not
> > solved). Additionally these wrappers are something we decided to get rid
> > of few patch versions ago.
> > =

> > I don't expect much renamings to take place after the latest patch set
> > to MFD/regulator tree has been applied. So maybe the clk patch set can
> > just wait untill MFD/regulator stuff gets integrated. I would be
> > gratefull if we could review the clk patch set already now though so I
> > could do improvements/changes to clk side while waiting for
> > MFD/regulator to get applied. Also, the devm_ functions (patch 1) are
> > not depending on MFD - so maybe we can get them reviewed/applied? If I
> > have the spare time I can look if I can clean up some of those not freed
> > clkdev lookups.
> > =

> The MFD renaming patch has now been merged to clk-next. So dependencies
> to MFD should now be in-tree. I will rebase this to clk-next and do
> resend. This patch still requires the devm variants for clkdev lookups
> an devm variant of "parent of provider"-registration. I did submit those
> as part of the cleanup series:
> https://lore.kernel.org/linux-clk/cover.1541161503.git.matti.vaittinen@fi=
.rohmeurope.com/
> =

> My question is if you prefer me to add this driver in that series and
> resend the series as v4? Or do you want me to send this in own
> individual patch with just a note about the dependency?
> =


Either way is fine. Just be explicit and we'll figure it out. Of course,
be aware that kbuild robot may complain if it can't figure out the
dependency and something fails to compile so it may be easier to resend
the whole combined series as something that compiles.

