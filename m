Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20D0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725CE208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725CE208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeH0VxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:53:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40632 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeH0VxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:53:18 -0400
Received: from localhost (unknown [62.119.166.9])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 90B1CC7B;
        Mon, 27 Aug 2018 18:05:40 +0000 (UTC)
Date:   Mon, 27 Aug 2018 19:33:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        NeilBrown <neil@brown.name>, Joe Perches <joe@perches.com>,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v5 1/4] staging: mt7621-mmc: Remove commented code for
 N_MSG
Message-ID: <20180827173340.GA827@kroah.com>
References: <cover.1535038494.git.nishadkamdar@gmail.com>
 <21d3ce50f8bba68348c478e4a7520ee22d7b765c.1535038494.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d3ce50f8bba68348c478e4a7520ee22d7b765c.1535038494.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 10:58:09PM +0530, Nishad Kamdar wrote:
> This patch removes the dead code for N_MSG().
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
> Changes in v5:
>   - Remove commented code for N_MSG()
> ---
>  drivers/staging/mt7621-mmc/dbg.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
> index 2f2c56b73987..6f6b4505337f 100644
> --- a/drivers/staging/mt7621-mmc/dbg.h
> +++ b/drivers/staging/mt7621-mmc/dbg.h
> @@ -103,14 +103,6 @@ do { \
>  #endif /* end of +++ */
>  
>  #define N_MSG(evt, fmt, args...)
> -/*
> -do {    \
> -    if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> -        printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> -            host->id,  ##args , __FUNCTION__, __LINE__, current->comm, current->pid);	\
> -    } \
> -} while(0)
> -*/
>  

So what are we supposed to do with a macro that defines nothing now?
Please delete it and all users of it at the same time.

thanks,

greg k-h
