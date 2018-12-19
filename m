Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1683DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC66F21873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545212793;
	bh=A/tI+oe/H+DTe9OahBv69ilWbrcL+UQg1xEDJ4Cca1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zTrHM6L6ndtKUYcxZ9i8WYHT9xLpbazDKZfG8/0HO2BSGNDUPoBPFleeBhQJAR88D
	 gbRgqGytZqankNVf2J/v04NmQk2WQB2ZNKa5BFXK1fk0CuBq/UpCpUEVEGKsSsRUgL
	 CjinRB4+Zx9AMbfAXxWr3U9M3jte1eAWp+efrEcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbeLSJqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:46:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeLSJqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:46:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9627520873;
        Wed, 19 Dec 2018 09:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545212790;
        bh=A/tI+oe/H+DTe9OahBv69ilWbrcL+UQg1xEDJ4Cca1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nu6zKqQvM6ny2Bn3ndP0vs+43gRVHcqCfVt8Vu4mjY15vbW8PdSXGeVqonwJN9oy9
         uGGT2V6bBQRFz3cFVx326XII8vOAZ9Ilr2qHx0UNYAwxOI3Ap1FzyKDsKcTqu+bCJk
         UGvKlF7LOSmC98ChRdONfhfTWC8Bwq+gsPVnwvJI=
Date:   Wed, 19 Dec 2018 10:46:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Buland Singh <bsingh@redhat.com>
Cc:     clemens@ladisch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        trivial@kernel.org, prarit@redhat.com
Subject: Re: [PATCH] hpet: Fix missing '=' character in the __setup() code of
 hpet_mmap_enable.
Message-ID: <20181219094627.GC11441@kroah.com>
References: <20181219092502.3079-1-bsingh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219092502.3079-1-bsingh@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 02:55:02PM +0530, Buland Singh wrote:
> The kernel command parameter 'hpet_mmap' never takes effect due to missing
> '=' character in the __setup() code of hpet_mmap_enable and the memory map
> of the HPET registers never get expose to userspace.
> 
> Signed-off-by: Buland Singh <bsingh@redhat.com>
> ---
>  drivers/char/hpet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index 4a22b4b41aef..9bffcd37cc7b 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -377,7 +377,7 @@ static __init int hpet_mmap_enable(char *str)
>  	pr_info("HPET mmap %s\n", hpet_mmap_enabled ? "enabled" : "disabled");
>  	return 1;
>  }
> -__setup("hpet_mmap", hpet_mmap_enable);
> +__setup("hpet_mmap=", hpet_mmap_enable);

What commit caused this bug?  Should this go to the stable kernel trees?

thanks,

greg k-h
