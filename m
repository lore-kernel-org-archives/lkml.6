Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74771C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3552621992
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1J+zy9BE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3552621992
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934129AbeGFRtO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932895AbeGFRtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:49:12 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A24DC215EB;
        Fri,  6 Jul 2018 17:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530899351;
        bh=ITEpZWyrB8Gp1pX6oYkmEO2VjYQp+NLi4KyRhxnPI38=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=1J+zy9BEAU6Ak0Eb+tT7O1N0Ajhu7eQZgX/x7HwyLyNjBDugoKNLTuq7BEmA99ex0
         MZ3XznRUFxKFW65e/all6QvrE5CtYJUo8g/13a6aXV1q8S08oZDguX5J8EfuNKswSZ
         8IePzJvAWjhWbmlfTIaaX0N8Tet8bvolfDEgYVBU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Heiko Stuebner <heiko@sntech.de>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <5208192.saTfdjLqfi@phil>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com
References: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com>
 <1529029011-15021-4-git-send-email-zhangqing@rock-chips.com>
 <153089585197.143105.10633953093490493144@swboyd.mtv.corp.google.com>
 <5208192.saTfdjLqfi@phil>
Message-ID: <153089935104.143105.9532329321820731513@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/4] clk: rockchip: add support for half divider
Date:   Fri, 06 Jul 2018 10:49:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heiko Stuebner (2018-07-06 10:19:11)
> Am Freitag, 6. Juli 2018, 18:50:51 CEST schrieb Stephen Boyd:
> > Quoting Elaine Zhang (2018-06-14 19:16:50)
> > > =

> > > diff --git a/drivers/clk/rockchip/clk-half-divider.c b/drivers/clk/ro=
ckchip/clk-half-divider.c
> > > new file mode 100644
> > > index 000000000000..fb7a6501e0c1
> > > --- /dev/null
> > > +++ b/drivers/clk/rockchip/clk-half-divider.c
> > > @@ -0,0 +1,230 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd
> > > + */
> > > +
> > > +#include <linux/slab.h>
> > > +#include <linux/bitops.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/clk.h>
> > =

> > Is this include used?
> =

> nope, and so are bitops and regmap as well.
> I've amended the commit patch accordingly.
> =

> =


Cool. Thanks!
