Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B430CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE8820874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547197843;
	bh=jTjlddFdEX8+wSyxvMw5rWa+yLP+9HxLGcrwLWq6pa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=scHRD0VK4hWr6HoBmwEJB9UuUgmcHFjtm0oHorvYUt8T7FGkhPw6qCXjivCZvbQP1
	 8PaY+Dw0eWky7oNAZsWUr5CeKbzA/uejWABnhuPligyt6rDUX1mf8kT0amEE/raXkV
	 6qHib6768RlsHwHTs/D+iirobNnah2SvzvlBIGOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfAKJKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:10:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfAKJKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:10:42 -0500
Received: from localhost (unknown [178.228.36.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D59BB20870;
        Fri, 11 Jan 2019 09:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547197841;
        bh=jTjlddFdEX8+wSyxvMw5rWa+yLP+9HxLGcrwLWq6pa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z03tzwUqdJBSokDPJrcHAqsRsIIr8+bUadU2bhsqMlTBvK1T1JSPD3sveyUUV8ZNH
         yIOQdqKHvNxwBuQGhCCQcV3CcMwsvGOl3GPcfuRBFTSX0/TI8eRNqsfeUuLanS3+qI
         BA8Ix4vvl41CzH2FzJmPoVhkkpQ/JcVfHdBj9P9c=
Date:   Fri, 11 Jan 2019 10:10:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     stern@rowland.harvard.edu, jrdr.linux@gmail.com,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: Re: [PATCH] drivers/usb/storage/sddr55.c: Remove duplicate header
Message-ID: <20190111091037.GB15610@kroah.com>
References: <5c36f6ef.1c69fb81.9d82d.5592@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c36f6ef.1c69fb81.9d82d.5592@mx.google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 01:10:25PM +0530, Sabyasachi Gupta wrote:
> Remove unusual_sddr55.h which is included more than once
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> ---
>  drivers/usb/storage/sddr55.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
> index b8527c5..96bf7ee 100644
> --- a/drivers/usb/storage/sddr55.c
> +++ b/drivers/usb/storage/sddr55.c
> @@ -62,7 +62,6 @@ MODULE_DEVICE_TABLE(usb, sddr55_usb_ids);
>  }
>  
>  static struct us_unusual_dev sddr55_unusual_dev_list[] = {
> -#	include "unusual_sddr55.h"
>  	{ }		/* Terminating entry */
>  };

As Oliver said on the other patch, this breaks the code.  Please do not
blindly make changes without understanding what the code does.

thanks,

greg k-h
