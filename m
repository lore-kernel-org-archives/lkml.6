Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7E6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5EC208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUVyAUph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5EC208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeH1AME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeH1AME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:12:04 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7429D208B2;
        Mon, 27 Aug 2018 20:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535401435;
        bh=TYDQIv5SpCQE4INsm75P2cHYrxhFtMvrobbdrKMceig=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=CUVyAUphdy+N3hlb1eaFzIKYn+hy7/VPJOZel057ctvoEmVujJwFBSuEW0+W8TDD4
         N1Hoz+Y2IEsL814gzyRWuvlfhFp3duttCU3lBdvVHj4e4gd/xVV/B0Tl8mTUWKdSJH
         mwKTgzTQbov9KG7ORZQFbJRJyPnJOl1QVQYlO/oA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180820134013.16527-1-icenowy@aosc.io>
Cc:     linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180820134013.16527-1-icenowy@aosc.io>
Message-ID: <153540143478.129321.8502068006504989469@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: sunxi-ng: sun50i: h6: Add 2x fixed post-divider to MMC
 module clocks
Date:   Mon, 27 Aug 2018 13:23:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Icenowy Zheng (2018-08-20 06:40:13)
> On the H6, the MMC module clocks are fixed in the new timing mode,
> i.e. they do not have a bit to select the mode. These clocks have
> a 2x divider somewhere between the clock and the MMC module.
> =

> To be consistent with other SoCs supporting the new timing mode,
> we model the 2x divider as a fixed post-divider on the MMC module
> clocks.
> =

> This patch adds the post-dividers to the MMC clocks, following the
> approach on A64.
> =

> Fixes: 542353ea ("clk: sunxi-ng: add support for the Allwinner H6 CCU")

This commit doesn't exist. Did you mean:

524353ea48

instead?
