Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ED5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E1C20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547197862;
	bh=IjYV6UIIjeOrkpKHlgqRJYcjawf6bcwSYjMQYknXWx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pQdrZhpnDczWcGQnaGJZvJM99hsQSmYM5kxp7TXfHv4Ld9xZKqQ8aQkKX1C7m1ijQ
	 8J9+EdN64YfVwJjPXf55GGMvPYj7t3gxVUibfnZyg7t0ufPUc+Q4+k/c2woz4mK1xI
	 0NSn5rZQ2X45twtcbHxg4C1fT8uYjwmB2pCshBpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfAKJLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:11:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbfAKJLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:11:00 -0500
Received: from localhost (unknown [178.228.36.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F10720870;
        Fri, 11 Jan 2019 09:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547197860;
        bh=IjYV6UIIjeOrkpKHlgqRJYcjawf6bcwSYjMQYknXWx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7s1yGwyLkXexVfEcXbf3qRBhyDFSPlbrvLG3sCt1TQLty9POs7yIu/pv25dd0685
         b87nM49n9x3UV/soT8gFZlAILAd6EdhpoM86MIEXifEZnKvb+VvxRDjsCmOOVgCWDK
         0JHkRSjS94TqpvDU9iqyzV3GPOyvfPbvswQ6GiYs=
Date:   Fri, 11 Jan 2019 10:10:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        jrdr.linux@gmail.com, brajeswar.linux@gmail.com
Subject: Re: [PATCH] drivers/usb/storage/cypress_atacb.c: Remove duplicate
 header
Message-ID: <20190111091056.GD15610@kroah.com>
References: <5c36eb05.1c69fb81.c3ab9.8a59@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c36eb05.1c69fb81.c3ab9.8a59@mx.google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:19:36PM +0530, Sabyasachi Gupta wrote:
> Remove unusual_cypress.h which is included more than once.
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> ---
>  drivers/usb/storage/cypress_atacb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/cypress_atacb.c b/drivers/usb/storage/cypress_atacb.c
> index 4825902..be2e346 100644
> --- a/drivers/usb/storage/cypress_atacb.c
> +++ b/drivers/usb/storage/cypress_atacb.c
> @@ -55,7 +55,6 @@ MODULE_DEVICE_TABLE(usb, cypress_usb_ids);
>  }
>  
>  static struct us_unusual_dev cypress_unusual_dev_list[] = {
> -#	include "unusual_cypress.h"
>  	{ }		/* Terminating entry */
>  };
>  
> -- 
> 2.7.4
> 

Again, no.
