Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B6BC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06F12075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06F12075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJHVkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:40:45 -0400
Received: from mailoutvs9.siol.net ([185.57.226.200]:33022 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbeJHVkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:40:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 25269520C5A;
        Mon,  8 Oct 2018 16:28:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YcDYi2KmUKeT; Mon,  8 Oct 2018 16:28:42 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id B83D1520D17;
        Mon,  8 Oct 2018 16:28:42 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 3F4F6520D0D;
        Mon,  8 Oct 2018 16:28:42 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     wens@csie.org, robh+dt@kernel.org, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 10/29] drm/sun4i: Rename DE2 registers related macros
Date:   Mon, 08 Oct 2018 16:28:41 +0200
Message-ID: <11072788.dZi9MDiihb@jernej-laptop>
In-Reply-To: <20181008101828.hb4xtppbexwalbkk@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net> <20181007093905.11253-11-jernej.skrabec@siol.net> <20181008101828.hb4xtppbexwalbkk@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 08. oktober 2018 ob 12:18:28 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> On Sun, Oct 07, 2018 at 11:38:46AM +0200, Jernej Skrabec wrote:
> > In preparation to introduce DE3 support, change prefix from "SUN8I_" to
> > "DE2_". Current prefix suggest that it's valid only for one family,
> > whereas in reality, DE2 unit is used also on sun50i family.
> > Additionally, it will be easier to distinguish DE3 specific macros by
> > using "DE3_" prefix.
> > 
> > No functional change in this commit.
> 
> I'm not too sure about this one. There's basically two ways to look at
> this: you described the first one, and the second one would be to
> treat it as we do for the compatibles: the IP was introduced on one
> SoC family, and then got used on some other ones.
> 
> Trying to always match the one you have however have a quite big
> maintainance cost, as can be shown by your patch: you always have to
> adapt comments, function names, defines, etc. This creates a lot of
> useless churns (ie, non-functional changes) in the drivers, that need
> to be written in the first place, and then reviewed.
> 
> It's just not worth it.

Well, using family neutral way would mean that there is no need anymore for 
adaptation in the future, but as you wish.

What prefix should I use for DE3 specific registers?

Best regards,
Jernej



