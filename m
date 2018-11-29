Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D73BC64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B2A2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gU7gbtjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B2A2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeK3Kot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbeK3Kot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:44:49 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEBA120863;
        Thu, 29 Nov 2018 23:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543534654;
        bh=xAypaLrh/aJumtX2Ta2GrzMwv2NIrxoInFLOX84hZsA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=gU7gbtjHX+SSAcNGsJ35X0ABf61Sql5gkUW8TxBKKDAwDSgq9AwCBHLR83UcXF67Z
         1faHn4I1uWBWaVZhmagRbXvI+Qa8qaLbT0YzGQvq0YRX9Th/8BztHt7BqCd0aZwEKs
         iesPKYr3PKM8k7ELNM67GTxNRj8Gdz1trr7/WPdo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mesih Kilinc <mesihkilinc@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181129063952.623svjr7pti7apah@ThinkPad>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
 <cc1357c9272628b4d89af007cead83117d9ba6e9.1543443475.git.mesihkilinc@gmail.com>
 <154345243603.88331.17915868280143383591@swboyd.mtv.corp.google.com>
 <20181129063952.623svjr7pti7apah@ThinkPad>
Message-ID: <154353465409.88331.8677593357765162802@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 13/17] clk: sunxi-ng: add support for suniv F1C100s SoC
Date:   Thu, 29 Nov 2018 15:37:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mesih Kilinc (2018-11-28 22:39:52)
> On 18/11/28 04:47, Stephen Boyd wrote:
> > Quoting Mesih Kilinc (2018-11-28 14:33:23)
> > > diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/s=
unxi-ng/ccu-suniv-f1c100s.c
> > > new file mode 100644
> > > index 0000000..d4bc1b8
> > > --- /dev/null
> > > +++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> > > @@ -0,0 +1,541 @@
> > > +/*
> > > + * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.io>
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0
> > =

> > Please fix this location.
> =

> I am very sorry, I should have been more carefull. Should I resend whole
> patchset or just resending this patch is enough? =

> =


Just this one? Who do you intend to pick up these patches?

