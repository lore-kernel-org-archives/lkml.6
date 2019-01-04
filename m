Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FADC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9EA217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546590767;
	bh=AGtQYRSkaRnub3crMb57SxzTd9xxq4uFT7rn3aXfVp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RZikpdDQI4DBfqfBAh75XmHdD0Bx2C8iGGps2iYS5pJTdVAU8Y+zV3nRbdHvL/l90
	 MsfoaW3Ykqf3+zE6pOLYtj+xv8eNtqfZkk/GHSfyK15YhAh0J9g4AVr0lOfT/IBbw5
	 ak+K0DzH2k4tuiJuFRwHMHTRstvPOZDAyGuiFlKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfADIcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:32:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfADIcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:32:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B40217F5;
        Fri,  4 Jan 2019 08:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546590764;
        bh=AGtQYRSkaRnub3crMb57SxzTd9xxq4uFT7rn3aXfVp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=honfxDmVYUhuZGbo7WEAr+9i5lX6FllU1Vn5WMLr7z5cB+STiuQmG3hTWUi4DEHns
         u7kzFFoAoqtscto8axQ8qJZfl0eg2mTBoKyYvACirSxCu1/TnHLP01PO6JZuE0S3rJ
         3o8UMprgF5Ehowf5v6MztB05PyD9vjCM13G3V7L4=
Date:   Fri, 4 Jan 2019 09:32:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Juan Manuel Torres Palma <j.m.torrespalma@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        ajay.kathat@microchip.com, linux-wireless@vger.kernel.org,
        adham.abozaeid@microchip.com
Subject: Re: [PATCH] staging: wilc1000: define wilc_get_stats_async as static
Message-ID: <20190104083242.GB25233@kroah.com>
References: <20190103161805.4581-1-j.m.torrespalma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103161805.4581-1-j.m.torrespalma@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 05:18:05PM +0100, Juan Manuel Torres Palma wrote:
> Declare wilc_get_stats_async as static since it's only
> used within the definition file scope.
> 
> Signed-off-by: Juan Manuel Torres Palma <j.m.torrespalma@gmail.com>
> ---
>  drivers/staging/wilc1000/host_interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wilc1000/host_interface.c b/drivers/staging/wilc1000/host_interface.c
> index 70c854d939ce..5dae6e7155d3 100644
> --- a/drivers/staging/wilc1000/host_interface.c
> +++ b/drivers/staging/wilc1000/host_interface.c
> @@ -1992,7 +1992,7 @@ int wilc_get_rssi(struct wilc_vif *vif, s8 *rssi_level)
>  	return result;
>  }
>  
> -int wilc_get_stats_async(struct wilc_vif *vif, struct rf_info *stats)
> +static int wilc_get_stats_async(struct wilc_vif *vif, struct rf_info *stats)

Someone else sent this same patch a few days before you did, sorry.

greg k-h
