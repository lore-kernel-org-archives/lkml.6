Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D63C04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99ABD208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99ABD208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeKTTXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:23:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:57736 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbeKTTXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:23:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA9B0AE56;
        Tue, 20 Nov 2018 08:55:01 +0000 (UTC)
Message-ID: <1542703537.28362.7.camel@suse.com>
Subject: Re: [PATCH] Drivers: Added entry for Hiro (Conexant) modem in
 cdc-acm.c.
From:   Oliver Neukum <oneukum@suse.com>
To:     Maarten Jacobs <maarten256@outlook.com>,
        Maarten Jacobs <maarten256@hotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Date:   Tue, 20 Nov 2018 09:45:37 +0100
In-Reply-To: <BLUPR20MB0178A60E74E5A2929D2F6EC08DD80@BLUPR20MB0178.namprd20.prod.outlook.com>
References: <BLUPR20MB0178A60E74E5A2929D2F6EC08DD80@BLUPR20MB0178.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2018-11-19 at 23:18 +0000, Maarten Jacobs wrote:
> The cdc-acm kernel module currently does not support the Hiro (Conexant)
> H05228 USB modem. The patch below adds the device specific information:
> idVendor	0x0572
> idProduct	0x1349
> 
> I am running with this patch on my local system and am therefore
> sumbitting the patch for formal inclusion in the kernel.
> 
> Signed-off-by: Maarten Jacobs <maarten256@outlook.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/usb/class/cdc-acm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 47d75c20c211..cce5bc59c943 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -1693,6 +1693,9 @@ static const struct usb_device_id acm_ids[] = {
>  	{ USB_DEVICE(0x0572, 0x1324), /* Conexant USB MODEM RD02-D400 */
>  	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
>  	},
> +	{ USB_DEVICE(0x0572, 0x1349), /* Hiro (Conexant) USB MODEM H50228 */
> +	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
> +	},
>  	{ USB_DEVICE(0x0572, 0x1328), /* Shiro / Aztech USB MODEM UM-3100 */
>  	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
>  	},

