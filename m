Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC226C004D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740F5206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMmm6x8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740F5206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeI1WVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeI1WVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:21:54 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 733C0206B6;
        Fri, 28 Sep 2018 15:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538150250;
        bh=m6afPo+CpJleR+tHgu49o9wbeU2CxVbmvCaT8CAaHnI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=MMmm6x8Qb6bHqk7FEcSdp4Yi1nr4yBHVTpBkDc59opEIwlXU0vS/ilPk7aAbnXbSF
         xFrcMt3i9gqjUnSx/E5CSYvGX1XpfyVWgg+YT39VUiKHHoRB4ZOdqXkzi1UxYCErv7
         ZRsl0kEWtuwj5Mzw5pXq+puLsktHJxx4Cc8SAE88=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Johan Hovold <johan@kernel.org>, Tero Kristo <t-kristo@ti.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <9a80b925-a36e-3895-f91b-4716d5524249@ti.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180822090319.29167-1-johan@kernel.org>
 <153566556601.129321.16962771053169973395@swboyd.mtv.corp.google.com>
 <9a80b925-a36e-3895-f91b-4716d5524249@ti.com>
Message-ID: <153815024975.119890.6463829001501352147@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: ti: fix OF child-node lookup
Date:   Fri, 28 Sep 2018 08:57:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tero Kristo (2018-09-20 00:11:08)
> On 31/08/18 00:46, Stephen Boyd wrote:
> > Quoting Johan Hovold (2018-08-22 02:03:19)
> >> Fix child-node lookup which by using the wrong OF helper was searching
> >> the whole tree depth-first, something which could end up matching an
> >> unrelated node.
> >>
> >> Also fix the related node-reference leaks.
> >>
> >> Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")
> >> Signed-off-by: Johan Hovold <johan@kernel.org>
> >> ---
> > =

> > Applied to clk-next
> > =

> =

> Stephen, this patch causes a merge conflict with some of the code I am =

> planning to send a pull-req against (the clkctrl work series: =

> https://patchwork.kernel.org/project/linux-clk/list/?series=3D13841)
> =

> Would it be possible to drop this from clk-next, and for me to =

> pick-it-up via my own branch? I can get this setup either today or tomorr=
ow.
> =

> Alternatively I need an immutable branch against which I can work.
> =


clk-ti-of-node is immutable. You can base on top of that and send a PR.
Does that work for you?

