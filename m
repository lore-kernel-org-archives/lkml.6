Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CF1C4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD1021700
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD1021700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbeHND0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 23:26:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:42209 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729230AbeHND0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 23:26:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7E0fN23005644;
        Mon, 13 Aug 2018 19:41:24 -0500
Message-ID: <bcc8541923f57f534c609d7e00335baa29b00a10.camel@kernel.crashing.org>
Subject: Re: [PATCH] fsi: ast: select GENERIC_ALLOCATOR
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
Date:   Tue, 14 Aug 2018 10:41:23 +1000
In-Reply-To: <20180813223733.991653-1-arnd@arndb.de>
References: <20180813223733.991653-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 00:37 +0200, Arnd Bergmann wrote:
> In randconfig builds without CONFIG_GENERIC_ALLOCATOR, this driver
> fails to link:
> 
> ERROR: "gen_pool_alloc_algo" [drivers/fsi/fsi-master-ast-cf.ko] undefined!
> ERROR: "gen_pool_fixed_alloc" [drivers/fsi/fsi-master-ast-cf.ko] undefined!
> ERROR: "of_gen_pool_get" [drivers/fsi/fsi-master-ast-cf.ko] undefined!
> ERROR: "gen_pool_free" [drivers/fsi/fsi-master-ast-cf.ko] undefined!
> 
> Select the dependency as all other users do.
> 
> Fixes: 6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks, I'll pick it up and send to Greg with a slightly different
subject

Cheers,
Ben.

>  drivers/fsi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
> index af3a20dd5aa4..99c99a5d57fe 100644
> --- a/drivers/fsi/Kconfig
> +++ b/drivers/fsi/Kconfig
> @@ -46,6 +46,7 @@ config FSI_MASTER_AST_CF
>  	tristate "FSI master based on Aspeed ColdFire coprocessor"
>  	depends on GPIOLIB
>  	depends on GPIO_ASPEED
> +	select GENERIC_ALLOCATOR
>  	---help---
>  	This option enables a FSI master using the AST2400 and AST2500 GPIO
>  	lines driven by the internal ColdFire coprocessor. This requires

