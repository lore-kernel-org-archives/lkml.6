Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A94C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C320F20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547793029;
	bh=33iNWEFUJBpnkcIxrThMX2VODTDZu2fOxvpZwMSwGnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TPhP7Odjz9Xla2XbzBdoHETuyEeGQB/obP48LMnWKI1LFZ+8pB6QtuyEKJ6fERBQU
	 A8xQl/pHPHFwikbZDULOjpeg74cYPqNQc98J7EPZj96fHzllS6j9vEs1cvl4d3QVla
	 AnmSDFwEpyjfpCUQ8AllcTQDaOapRljnMwyNAZow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfARGaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 01:30:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfARGaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 01:30:22 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE0A620855;
        Fri, 18 Jan 2019 06:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547793021;
        bh=33iNWEFUJBpnkcIxrThMX2VODTDZu2fOxvpZwMSwGnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AWU3sKwYtc4TJjWSu+tb8nYc1LxsmNQ/7zjIG3axF8pQPuUO2ra9RH+PP9+6dYCR2
         oq4UhPX/NL8x6kU8ORsGt3PAJcbs+9x9DlfOKMiHqws3pcW+wJlqPKFrfNk5v7nYv+
         IRJc6E4exR+q0kVX1O4bF7/EEXxsQrWzkV67AJOc=
Date:   Fri, 18 Jan 2019 14:30:17 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     ren_guo@c-sky.com, arnd@arndb.de, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: Re: [PATCH] csky/kernel/entry: Remove duplicate heade
Message-ID: <20190118063016.GA20463@guoren-Inspiron-7460>
References: <20190117143004.GA2916@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117143004.GA2916@hp-pavilion-15-notebook-pc-brajeswar>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Brajeswar,

Tested-by: Guo Ren <ren_guo@c-sky.com>
Acked-by: Guo Ren <ren_guo@c-sky.com>

On Thu, Jan 17, 2019 at 08:00:04PM +0530, Brajeswar Ghosh wrote:
> Remove duplicate headers which are included more than once
> 
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
>  arch/csky/kernel/entry.S | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
> index 79f92b8606c8..f2081ddcc398 100644
> --- a/arch/csky/kernel/entry.S
> +++ b/arch/csky/kernel/entry.S
> @@ -9,7 +9,6 @@
>  #include <asm/unistd.h>
>  #include <asm/asm-offsets.h>
>  #include <linux/threads.h>
> -#include <asm/setup.h>
>  #include <asm/page.h>
>  #include <asm/thread_info.h>
>  
> -- 
> 2.17.1
> 
