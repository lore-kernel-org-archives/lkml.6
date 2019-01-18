Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943F9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504872087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547798991;
	bh=2BJqF1DGHJR574nnqg18JKjNviAzOf5qTRHinqi0yCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=d+9Wdy9ojuYHmma+YPHwCyw6Gvy3sicKQoaE/b2PfhXibsFpqOkKzf4WSDiA83r1K
	 qxQj0JXUSuh2/kOqXhwRxmMzCSYFATYG2xIscCI4hfQ8eLLEr/ecfCYqrQlaTmittX
	 ld0PovP52YYXgLnWxvS7VIFkEzVMIpGbDo4C1AdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfARIJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:09:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727226AbfARIJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:09:49 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 898F720855;
        Fri, 18 Jan 2019 08:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547798988;
        bh=2BJqF1DGHJR574nnqg18JKjNviAzOf5qTRHinqi0yCk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DgFj94KATExqGfmZ3CY1QlRWWYrEkY1IagP3wqPBzbmPaWZcM5ZVwWsu+wheZTJpp
         XuFLnq0NOWmGCoxkgaXjn5V+xjkMXAqKCRixKOkhCZ+c46XiH/oyiU1YxhsGMa26+j
         L6QPs3EXcETvdVt9GK7+ml2UDXVVJDJaDJuaI2yY=
Date:   Fri, 18 Jan 2019 09:09:38 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] memory: Kconfig: Drop dependency on MACH_JZ4780 for
 jz4780
Message-ID: <20190118090938.13fe7375@bbrezillon>
In-Reply-To: <20190117224550.18043-2-paul@crapouillou.net>
References: <20190117224550.18043-1-paul@crapouillou.net>
        <20190117224550.18043-2-paul@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 19:45:48 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> Depending on MACH_JZ4780 prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
>  drivers/memory/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 2d91b00e3591..3d411575fcb6 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -122,7 +122,7 @@ config FSL_IFC
>  config JZ4780_NEMC
>  	bool "Ingenic JZ4780 SoC NEMC driver"
>  	default y
> -	depends on MACH_JZ4780 || COMPILE_TEST
> +	depends on MIPS || COMPILE_TEST
>  	depends on HAS_IOMEM && OF
>  	help
>  	  This driver is for the NAND/External Memory Controller (NEMC) in

