Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D28DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E1B208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E1B208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeH0V4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:56:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41028 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeH0V4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:56:39 -0400
Received: from localhost (unknown [62.119.166.9])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EFC09C96;
        Mon, 27 Aug 2018 18:08:59 +0000 (UTC)
Date:   Mon, 27 Aug 2018 19:52:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arkadiusz Lis <areklis909@gmail.com>
Cc:     jfrederich@gmail.com, dsd@laptop.org, jon.nettleton@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: One Laptop Per Child: add function argument
 names
Message-ID: <20180827175213.GA27361@kroah.com>
References: <1533831839-7361-1-git-send-email-areklis909@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533831839-7361-1-git-send-email-areklis909@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:23:59PM +0200, Arkadiusz Lis wrote:
> Add function argument names to pointers to functions
> in struct dcon_platform_data: init, set_dconload and read_status
> This commit removes checkpatch.pl warning.
> 
> Signed-off-by: Arkadiusz Lis <areklis909@gmail.com>
> ---
>  drivers/staging/olpc_dcon/olpc_dcon.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/olpc_dcon/olpc_dcon.h b/drivers/staging/olpc_dcon/olpc_dcon.h
> index fa89bb9..0ce1a7a 100644
> --- a/drivers/staging/olpc_dcon/olpc_dcon.h
> +++ b/drivers/staging/olpc_dcon/olpc_dcon.h
> @@ -91,10 +91,10 @@ struct dcon_priv {
>  };
>  
>  struct dcon_platform_data {
> -	int (*init)(struct dcon_priv *);
> +	int (*init)(struct dcon_priv *dcon);
>  	void (*bus_stabilize_wiggle)(void);
> -	void (*set_dconload)(int);
> -	int (*read_status)(u8 *);
> +	void (*set_dconload)(int val);
> +	int (*read_status)(u8 *status);
>  };
>  
>  #include <linux/interrupt.h>
> -- 
> 1.9.1
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Patch did not apply to my tree at all.  Please rebase against the latest
linux-next and resend.

thanks,

greg k-h
