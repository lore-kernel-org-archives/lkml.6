Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20149C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D843720663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D843720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389347AbeKXHYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:24:43 -0500
Received: from netrider.rowland.org ([192.131.102.5]:36717 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2387832AbeKXHYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:24:43 -0500
Received: (qmail 27928 invoked by uid 500); 23 Nov 2018 15:38:54 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Nov 2018 15:38:54 -0500
Date:   Fri, 23 Nov 2018 15:38:54 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     gregkh@linuxfoundation.org, <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: usb-storage: Add new IDs to ums-realtek
In-Reply-To: <20181123084219.30987-1-kai.heng.feng@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1811231538390.27782-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018, Kai-Heng Feng wrote:

> There are two new Realtek card readers require ums-realtek to work
> correctly.
> 
> Add the new IDs to support them.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/usb/storage/unusual_realtek.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/storage/unusual_realtek.h b/drivers/usb/storage/unusual_realtek.h
> index d17cd95b55bb..6b2140f966ef 100644
> --- a/drivers/usb/storage/unusual_realtek.h
> +++ b/drivers/usb/storage/unusual_realtek.h
> @@ -27,4 +27,14 @@ UNUSUAL_DEV(0x0bda, 0x0159, 0x0000, 0x9999,
>  		"USB Card Reader",
>  		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
>  
> +UNUSUAL_DEV(0x0bda, 0x0177, 0x0000, 0x9999,
> +		"Realtek",
> +		"USB Card Reader",
> +		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
> +
> +UNUSUAL_DEV(0x0bda, 0x0184, 0x0000, 0x9999,
> +		"Realtek",
> +		"USB Card Reader",
> +		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
> +
>  #endif  /* defined(CONFIG_USB_STORAGE_REALTEK) || ... */

Acked-by: Alan Stern <stern@rowland.harvard.edu>

