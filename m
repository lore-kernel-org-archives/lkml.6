Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91838C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E8E2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="IrWSc5e6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbeLOPXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:23:43 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:47846 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbeLOPXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:23:43 -0500
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 385B625AD76;
        Sun, 16 Dec 2018 02:23:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544887420; bh=BnovN8daVN+ej1pibbsomJW8ikGxqB/k+4K9/jgohdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IrWSc5e6wNv2z6o5Kt+9KZzKjmmirzSKFuykS+bsFP3UBXpIxluI2oYXo4VbeJ3fz
         jMEUtw3w65eP0CuwK3h0vLIJX34MY+0FWm6btVfitNYpBZY88vsjevkaiTZH7l6gp0
         b75Cc077Vspoe5wuyJxmEaBprlW+oQBPic++aMhE=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 484EFE20E06; Sat, 15 Dec 2018 07:23:38 -0800 (PST)
Date:   Sat, 15 Dec 2018 16:23:38 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a77990: Fix IOCTRL reg state after
 s2ram on R-Car E3
Message-ID: <20181215152337.km3rr2sx36gkuc7b@verge.net.au>
References: <20181213162027.13137-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213162027.13137-1-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 05:20:27PM +0100, Geert Uytterhoeven wrote:
> Due to an interaction with commit 9f2b76a2db3c4387 ("pinctrl: sh-pfc:
> r8a77990: Add R8A774C0 PFC support"), the state of the I/O Control
> Registers is saved/restored during s2ram on RZ/G2E, but not on R-Car E3.
> Hence on R-Car E3, SDHI voltage state is lost after system resume.
> 
> Fix this by registering the I/O Control Registers on R-Car E3, too.
> 
> Fixes: 33847a71373cd6ae ("pinctrl: sh-pfc: r8a77990: Add voltage switch operations for SDHI")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> To be queued as a fix in sh-pfc-for-v4.21.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

