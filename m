Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAACC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94649218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="k+sQK83+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437109AbfBONRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:17:09 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:50433 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfBONRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:17:09 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 1C0B425AD7F;
        Sat, 16 Feb 2019 00:17:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1550236627; bh=85IsyTkwGg6mvYiApzTyTvV48R93/8OwUvWYQD/8/2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+sQK83+HjVC4CsJ5UFfhByaVcHu35CYUmqukhftxrfdZnLpXnB74KW5XiOPdAPrX
         2caInkraxop9gpcctXgVE+atftcwR9Poz9srCYmeWwNfJsIWab/57V39JEMBGQmG2I
         Gh30qIqseCnPXv41BUwMVCO/uykGJI0ZfZX7OYTY=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 850929402D4; Fri, 15 Feb 2019 14:17:04 +0100 (CET)
Date:   Fri, 15 Feb 2019 14:17:04 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/6] clk: renesas: r8a774c0: Add Z2 clock
Message-ID: <20190215131658.hfpwkq2lxnwdjeln@verge.net.au>
References: <20190211135858.23635-1-horms+renesas@verge.net.au>
 <20190211135858.23635-7-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211135858.23635-7-horms+renesas@verge.net.au>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:58:58PM +0100, Simon Horman wrote:
> Adds support for R-Car RZ/G2E (r8a774c0) Z2 clock.

R-Car should not appear on the line above.

> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Tested-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3: New patch
> ---
>  drivers/clk/renesas/r8a774c0-cpg-mssr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/renesas/r8a774c0-cpg-mssr.c b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
> index 10b96895d452..24634ca94f69 100644
> --- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
> @@ -79,6 +79,7 @@ static const struct cpg_core_clk r8a774c0_core_clks[] __initconst = {
>  	/* Core Clock Outputs */
>  	DEF_FIXED("za2",       R8A774C0_CLK_ZA2,   CLK_PLL0D24,    1, 1),
>  	DEF_FIXED("za8",       R8A774C0_CLK_ZA8,   CLK_PLL0D8,     1, 1),
> +	DEF_GEN3_Z("z2",       R8A774C0_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL0, 4, 8),
>  	DEF_FIXED("ztr",       R8A774C0_CLK_ZTR,   CLK_PLL1,       6, 1),
>  	DEF_FIXED("zt",        R8A774C0_CLK_ZT,    CLK_PLL1,       4, 1),
>  	DEF_FIXED("zx",        R8A774C0_CLK_ZX,    CLK_PLL1,       3, 1),
> -- 
> 2.11.0
> 
