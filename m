Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9248C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50FC208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeL0Oin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 09:38:43 -0500
Received: from hermes.aosc.io ([199.195.250.187]:59250 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbeL0Oim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 09:38:42 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id F3EDE15E503;
        Thu, 27 Dec 2018 14:38:38 +0000 (UTC)
Message-ID: <12c8418f525591cd8aad011dedd96a7c7af9ca99.camel@aosc.io>
Subject: Re: [PATCH 2/2] USB: storage: add quirk for SMI SM3350
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Date:   Thu, 27 Dec 2018 22:38:33 +0800
In-Reply-To: <20181227143437.17151-3-icenowy@aosc.io>
References: <20181227143437.17151-1-icenowy@aosc.io>
         <20181227143437.17151-3-icenowy@aosc.io>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-12-27四的 22:34 +0800，Icenowy Zheng写道：
> The SMI SM3350 USB-UFS bridge controller cannot handle long sense
> request
> correctly and will make the chip refuse to do read/write when
> requested
> long sense.
> 
> Add a bad sense quirk for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---

I forgot to:

Cc: stable@vger.kernel.org

>  drivers/usb/storage/unusual_devs.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/storage/unusual_devs.h
> b/drivers/usb/storage/unusual_devs.h
> index f7f83b21dc74..ea0d27a94afe 100644
> --- a/drivers/usb/storage/unusual_devs.h
> +++ b/drivers/usb/storage/unusual_devs.h
> @@ -1265,6 +1265,18 @@ UNUSUAL_DEV( 0x090c, 0x1132, 0x0000, 0xffff,
>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>  		US_FL_FIX_CAPACITY ),
>  
> +/*
> + * Reported by Icenowy Zheng <icenowy@aosc.io>
> + * The SMI SM3350 USB-UFS bridge controller will enter a wrong state
> + * that do not process read/write command if a long sense is
> requested,
> + * so force to use 18-byte sense.
> + */
> +UNUSUAL_DEV(  0x090c, 0x3350, 0x0000, 0xffff,
> +		"SMI",
> +		"SM3350 UFS-to-USB-Mass-Storage bridge",
> +		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> +		US_FL_BAD_SENSE ),
> +
>  /*
>   * Reported by Paul Hartman <paul.hartman+linux@gmail.com>
>   * This card reader returns "Illegal Request, Logical Block Address

