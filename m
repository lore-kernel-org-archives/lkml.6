Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DBCC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B6521104
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCDtnMls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B6521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeKHUzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:55:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeKHUzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:55:07 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BD2B208E3;
        Thu,  8 Nov 2018 11:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541676002;
        bh=DHEiSDA8QzbpvDw9va9WFkdTJzi1Sfy9Ot3L4/czgp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fCDtnMlsK2re14buk1egckXe7XJXAjROh/H3QOMv8gv7s+1WW823o7oLabdPFJ7PW
         hfvtv5x+RSP4Z4Br2Kw1KAC8VTjJwlObQpF+ZO336cJyEIuzixfHkcElNKGfcpb1K9
         vrUA5u59maBrB1JOFCw6HSmcV07cYAlwPHDICvTA=
Date:   Thu, 8 Nov 2018 03:20:01 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: staging: tegra-vde: print long unsigned using %lu
 format specifier
Message-ID: <20181108112001.GA7793@kroah.com>
References: <20181108110224.1916-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108110224.1916-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 11:02:24AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The frame.flags & FLAG_B_FRAME is promoted to a long unsigned because
> of the use of the BIT() macro when defining FLAG_B_FRAME and causing a
> build warning. Fix this by using the %lu format specifer.
> 
> Cleans up warning:
> drivers/staging/media/tegra-vde/tegra-vde.c:267:5: warning: format
> specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
> 
> Fixes: 42e764d05712 ("staging: tegravde: replace bit assignment with macro")
> Cc: Ioannis Valasakis <code@wizofe.uk>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/media/tegra-vde/tegra-vde.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/tegra-vde/tegra-vde.c b/drivers/staging/media/tegra-vde/tegra-vde.c
> index 6f06061a40d9..66cf14212c14 100644
> --- a/drivers/staging/media/tegra-vde/tegra-vde.c
> +++ b/drivers/staging/media/tegra-vde/tegra-vde.c
> @@ -262,7 +262,7 @@ static void tegra_vde_setup_iram_tables(struct tegra_vde *vde,
>  			value |= frame->frame_num;
>  
>  			dev_dbg(vde->miscdev.parent,
> -				"\tFrame %d: frame_num = %d B_frame = %d\n",
> +				"\tFrame %d: frame_num = %d B_frame = %lu\n",
>  				i + 1, frame->frame_num,
>  				(frame->flags & FLAG_B_FRAME));
>  		} else {
> -- 
> 2.19.1

Thanks for this, you beat me too it :)

greg k-h
