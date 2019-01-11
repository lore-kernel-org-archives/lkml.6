Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC816C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3CC20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547197854;
	bh=sEBkCOFBTUqmIVZtHDUDGPDuBC8ITkz2vDyk/u99Uhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LsxNcveXb/DTpmP4mAnRLoSc/nzfWrFr7WAykQpOzCNPEFndoT5daYBT1H5PvpIh1
	 5V2lykfBtka1DAJUEaVQyeTlkZ3EbOVVe9MeLMDt6GwPXJ6bO7EwD50ibBpZ6atW4C
	 T7CkHU402VPWN/+WDXmNX0CnpntsL3L8q4RyJbxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfAKJKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:10:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfAKJKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:10:53 -0500
Received: from localhost (unknown [178.228.36.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E64C220870;
        Fri, 11 Jan 2019 09:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547197852;
        bh=sEBkCOFBTUqmIVZtHDUDGPDuBC8ITkz2vDyk/u99Uhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qnueqeEWkwfUKp8AzFwbe27vNw9sOQ2NQEBfLvV2tEO0Xsv5D11wx3oaBJwDAkmpP
         HB81VYc4aWaQK4qXkmE8w1va6rVbJnbB+qY7AeRD5w7TvIMhAm+/0QvGzgXZ/Jx8vh
         xEvI6XIYnR6uKG8i52iFUvfKbaUVihDld1fmO6OQ=
Date:   Fri, 11 Jan 2019 10:10:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     stern@rowland.harvard.edu, jrdr.linux@gmail.com,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: Re: [PATCH] drivers/usb/storage: Remove duplicate headers
Message-ID: <20190111091049.GC15610@kroah.com>
References: <5c36efd5.1c69fb81.4964.9e80@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c36efd5.1c69fb81.4964.9e80@mx.google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:40:07PM +0530, Sabyasachi Gupta wrote:
> Remove duplicate headers which are included more than once.
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> ---
>  drivers/usb/storage/datafab.c    | 1 -
>  drivers/usb/storage/ene_ub6250.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/datafab.c b/drivers/usb/storage/datafab.c
> index 09353be..4b1bd56 100644
> --- a/drivers/usb/storage/datafab.c
> +++ b/drivers/usb/storage/datafab.c
> @@ -102,7 +102,6 @@ MODULE_DEVICE_TABLE(usb, datafab_usb_ids);
>  }
>  
>  static struct us_unusual_dev datafab_unusual_dev_list[] = {
> -#	include "unusual_datafab.h"
>  	{ }		/* Terminating entry */
>  };

Nope, this breaks things :(
