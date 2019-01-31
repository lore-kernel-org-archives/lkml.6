Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CD2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24776218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548963522;
	bh=/orb6LlXlqwfpLqH+r5f7QWR8XolTwgXzwCXJ3B0XOc=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=ZrDk5RHJEHaoLG23CXfzYWpyksHvdMK35xhfntLUv18nwKLBMbphImkMRW9+8joXp
	 u5oftFCatvukYLiSq66SpB3H+mnVZsF3mAAZgv+Oug43huRoPo/S8MByD5IIAER7ft
	 9cu2c55FnPDN7tm6xrZKZZbtXiy4gsKsk6dX6ib0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfAaTik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:38:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfAaTik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:38:40 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8477C218AF;
        Thu, 31 Jan 2019 19:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548963518;
        bh=/orb6LlXlqwfpLqH+r5f7QWR8XolTwgXzwCXJ3B0XOc=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=QoR16dRFTs1h6vnEYujbfUUEgseLuTgENlWoxPo+O6BgITTFZZaChEpwqXomZXu0I
         AGkz7cQbWpXrMVLug2ev8AFxd89ljHJc6x8uy8c4cDP30MamuKv4/ZfTQANfWM78QG
         NqndphmyeBxor6/6gR6Z++9qPf7QFli4icacU3tY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 0/3] clk: clkdev add managed lookup registrations
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154896351763.169292.2557542540041822337@swboyd.mtv.corp.google.com>
Cc:     mazziesaccount@gmail.com, corbet@lwn.net, cw00.choi@samsung.com,
        krzk@kernel.org, b.zolnierkie@samsung.com, mturquette@baylibre.com,
        pombredanne@nexb.com, sre@kernel.org, vkoul@kernel.org,
        linux@roeck-us.net, pavel@ucw.cz, sjhuang@iluvatar.ai,
        andrew.smirnov@gmail.com, djkurtz@chromium.org,
        akshu.agrawal@amd.com, rafael.j.wysocki@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com> <20190131132452.GD23791@localhost.localdomain> <20190131152147.tzxabhyhlyy2rwhy@e5254000004ec.dyn.armlinux.org.uk>
User-Agent: alot/0.8
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
In-Reply-To: <20190131152147.tzxabhyhlyy2rwhy@e5254000004ec.dyn.armlinux.org.uk>
Date:   Thu, 31 Jan 2019 11:38:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Russell King - ARM Linux admin (2019-01-31 07:21:47)
> On Thu, Jan 31, 2019 at 03:24:52PM +0200, Matti Vaittinen wrote:
> > Hello All,
> >=20
> > On Fri, Dec 07, 2018 at 01:09:00PM +0200, Matti Vaittinen wrote:
> > > Series adds managed clkdev lookup interfaces and cleans few drivers
> > >=20
> > > Few clk drivers appear to be leaking clkdev lookup registrations at
> > > driver remove. The patch series adds devm versions of lookup
> > > registrations and cleans up few drivers. Driver clean-up patches have
> > > not been tested as I lack the HW. All testing and comments if
> > > driver/device removal is even possible for changed drivers is highly
> > > appreciated. If removal is not possible I will gladly drop the patches
> > > from series - although leaking lookups may serve as bad example for n=
ew
> > > developers =3D)
> > >=20
> > > Changed drivers are:
> > > clk-max77686 and clk-st
> > >=20
> > > Please note that the patch #2 requires this change to work correctly:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/=
?h=3Dclk-next&id=3D05502bf9eb7a7297f5fa6f1d17b169b3d5b53570
> >=20
> > I guess the dependency mentioned abowe is already in (most) of the
> > trees. (I can't say for sure as I don't know what is the correct tree
> > for clkdev - is it linux-arm.git as Russel is maintaining clkdev?
>=20
> Yes, I'm supposed to be maintaining clkdev, but I'm busy with other
> stuff (such as reorganising my network, helping people with SFP issues,
> I'm supposed to be replying to Arend over a brcmfmac issue that has been
> on-going since Christmas which I haven't yet been able to doing the next
> test...)
>=20
> > If yes, then the commit 05502bf9eb7a7297f5fa6f1d17b169b3d5b53570
> > "clk: of-provider: look at parent if registered device has no
> > provider info" seems to be sitting in maser branch).
>=20
> It's there because it's part of the mainline kernel and has been
> since v5.0-rc1.  So, if you depend on that commit, basing off
> v5.0-rc1 is probably sane, unless there's something else that
> conflicts.
>=20

I can pick up the patches in the clk tree. Clk drivers will be the users
so it's probably simplest to merge the clkdev patch in clk tree and then
consumers can be updated at the same time in a patch stack on top of
that. Otherwise, if I can get a stable branch/tag to pile the clk driver
patches on I can apply them that way and then the clkdev patch can go
via Russell.

