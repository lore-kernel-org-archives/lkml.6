Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03022C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA452064A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rm4nKBEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA452064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbeJEX0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:26:03 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55093 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbeJEX0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=KQNvv/QjVtmklrfAfcDBdwfZIaye7B00llWXEbjNqMw=;
        b=rm4nKBEssQIs3Q74z0odUTm5h6QzXljTTnghU48fkZ2CeyUsoW97rS/IisRwjmJ6LdvbMhW3OKcoj14uuehPSLYPvlQDE1hxtt7Yyfbl1S4IoOQ+jtv9GIVQ+kwGKvMxp/0sxhm5FnewkPgGB0PAVXO+SEC68RexDXDFKJZn+IM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g8Svt-0005Xz-8s; Fri, 05 Oct 2018 18:26:29 +0200
Date:   Fri, 5 Oct 2018 18:26:29 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: orion: avoid VLA in orion_mpp_conf
Message-ID: <20181005162629.GJ4730@lunn.ch>
References: <20181005161601.875388-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005161601.875388-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 06:15:49PM +0200, Arnd Bergmann wrote:
> Testing randconfig builds found an instance of a VLA that was
> missed when determining that we have removed them all:
> 
> arch/arm/plat-orion/mpp.c: In function 'orion_mpp_conf':
> arch/arm/plat-orion/mpp.c:31:2: error: ISO C90 forbids variable length array 'mpp_ctrl' [-Werror=vla]
> 
> This one is fairly straightforward: we know what all three
> callers are, and the maximum length is not very long.
> 
> Fixes: 68664695ae57 ("Makefile: Globally enable VLA warning")
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Hi Arnd

Do you want this to go via the mvebu tree? Or you can take it direct
into arm-soc. There have not been any patches to orion5x, dove or
mv78xx0 for a long time, so there won't be any merge conflicts.

Thanks

    Andrew
