Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53917C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2306F2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547800293;
	bh=j4wJkOh8VBMuO7q7T8A8LmO1ycPaKYrAP1xJRrV6BI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uRqBNr89a3yon34+DA+0ErhpbzRZLH+gLFGXftokV5BnybTweSVaqTvyhx0lYNCOW
	 XP1Is1q40boC1k3rF8z05/emO9VcFSk+iK1oI+/P7/TEBMbbivZTTZy+hlpATro9DA
	 8qOCbImHy/6M/r0xKN4ulo7OdCXQXVT6g6VNIh24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfARIbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:31:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfARIba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:31:30 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C208220823;
        Fri, 18 Jan 2019 08:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547800290;
        bh=j4wJkOh8VBMuO7q7T8A8LmO1ycPaKYrAP1xJRrV6BI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l7e694dChsW66HRP6c7dVMlfNHym6zFg3coasB6CzNx+pXtx+nwo0NkkyGuKfZedB
         iLsYf+A5qKaL1Cb2K4AKhpx7n4u2QT8Cp6PbJv1IHwDfVvTuBWFVXrnx4QmvWigx9F
         fXoln2l/FdqaSNQcEIunaBM+jc3OTdbepd7ZCmh0=
Date:   Fri, 18 Jan 2019 09:31:16 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 6/8] mtd: rawnand: jz4780-bch: Don't set clock rate in
 driver
Message-ID: <20190118093116.5f62efa5@bbrezillon>
In-Reply-To: <20190118010634.27399-6-paul@crapouillou.net>
References: <20190118010634.27399-1-paul@crapouillou.net>
        <20190118010634.27399-6-paul@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 22:06:32 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> This should be done in devicetree. Besides, it prevents us from
> supporting other SoCs which don't use the same clock frequency for the
> BCH hardware.

As I said earlier, I disagree with this statement, plus, you're
breaking backward compat with existing DTs when doing that.

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/mtd/nand/raw/jz4780_bch.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/jz4780_bch.c b/drivers/mtd/nand/raw/jz4780_bch.c
> index 7e4e5e627603..161d3821e1c4 100644
> --- a/drivers/mtd/nand/raw/jz4780_bch.c
> +++ b/drivers/mtd/nand/raw/jz4780_bch.c
> @@ -57,8 +57,6 @@
>  #define BCH_BHINT_UNCOR			BIT(1)
>  #define BCH_BHINT_ERR			BIT(0)
>  
> -#define BCH_CLK_RATE			(200 * 1000 * 1000)
> -
>  /* Timeout for BCH calculation/correction. */
>  #define BCH_TIMEOUT_US			100000
>  
> @@ -348,8 +346,6 @@ static int jz4780_bch_probe(struct platform_device *pdev)
>  		return PTR_ERR(bch->clk);
>  	}
>  
> -	clk_set_rate(bch->clk, BCH_CLK_RATE);
> -
>  	mutex_init(&bch->lock);
>  
>  	bch->dev = dev;

