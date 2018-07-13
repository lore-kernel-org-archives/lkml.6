Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73242ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277FD208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277FD208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbeGMUki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:40:38 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57299 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731500AbeGMUkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:40:37 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jul 2018 16:40:37 EDT
Received: (qmail 14772 invoked by uid 500); 13 Jul 2018 16:17:46 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Jul 2018 16:17:46 -0400
Date:   Fri, 13 Jul 2018 16:17:46 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Colin King <colin.king@canonical.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: host: ehci-sched: remove redundant pointer dev
In-Reply-To: <20180713092956.13247-1-colin.king@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1807131617360.10216-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer dev is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'dev' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/usb/host/ehci-sched.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
> index 1d87295682b8..da7b00a6110b 100644
> --- a/drivers/usb/host/ehci-sched.c
> +++ b/drivers/usb/host/ehci-sched.c
> @@ -1835,7 +1835,6 @@ static bool itd_complete(struct ehci_hcd *ehci, struct ehci_itd *itd)
>  	unsigned				uframe;
>  	int					urb_index = -1;
>  	struct ehci_iso_stream			*stream = itd->stream;
> -	struct usb_device			*dev;
>  	bool					retval = false;
>  
>  	/* for each uframe with a packet */
> @@ -1886,7 +1885,6 @@ static bool itd_complete(struct ehci_hcd *ehci, struct ehci_itd *itd)
>  	 */
>  
>  	/* give urb back to the driver; completion often (re)submits */
> -	dev = urb->dev;
>  	ehci_urb_done(ehci, urb, 0);
>  	retval = true;
>  	urb = NULL;
> @@ -2230,7 +2228,6 @@ static bool sitd_complete(struct ehci_hcd *ehci, struct ehci_sitd *sitd)
>  	u32					t;
>  	int					urb_index;
>  	struct ehci_iso_stream			*stream = sitd->stream;
> -	struct usb_device			*dev;
>  	bool					retval = false;
>  
>  	urb_index = sitd->index;
> @@ -2268,7 +2265,6 @@ static bool sitd_complete(struct ehci_hcd *ehci, struct ehci_sitd *sitd)
>  	 */
>  
>  	/* give urb back to the driver; completion often (re)submits */
> -	dev = urb->dev;
>  	ehci_urb_done(ehci, urb, 0);
>  	retval = true;
>  	urb = NULL;

Acked-by: Alan Stern <stern@rowland.harvard.edu>

