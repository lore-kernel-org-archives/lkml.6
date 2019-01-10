Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7E3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679E62173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfAJHlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:41:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:40710 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbfAJHlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:41:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD0E6AE10;
        Thu, 10 Jan 2019 07:41:13 +0000 (UTC)
Message-ID: <1547106068.7403.17.camel@suse.com>
Subject: Re: [PATCH] drivers/usb/storage/jumpshot.c: Remove duplicate header
From:   Oliver Neukum <oneukum@suse.com>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     brajeswar.linux@gmail.com, jrdr.linux@gmail.com,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Thu, 10 Jan 2019 08:41:08 +0100
In-Reply-To: <5c36f533.1c69fb81.253c8.2646@mx.google.com>
References: <5c36f533.1c69fb81.253c8.2646@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2019-01-10 at 13:03 +0530, Sabyasachi Gupta wrote:
> Remove unusual_jumpshot.h which is included more than once.
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> ---
>  drivers/usb/storage/jumpshot.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/jumpshot.c b/drivers/usb/storage/jumpshot.c
> index 917f170..06e46c6 100644
> --- a/drivers/usb/storage/jumpshot.c
> +++ b/drivers/usb/storage/jumpshot.c
> @@ -84,7 +84,6 @@ MODULE_DEVICE_TABLE(usb, jumpshot_usb_ids);
>  }
>  
>  static struct us_unusual_dev jumpshot_unusual_dev_list[] = {
> -#	include "unusual_jumpshot.h"
>  	{ }		/* Terminating entry */
>  };
>  

NACK.

It is included twice because the same device needs to be specified
and is quirky. You are breaking the driver.

	Regards
		Oliver

