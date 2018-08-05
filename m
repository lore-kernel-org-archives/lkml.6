Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B282C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D505821885
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D505821885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbeHEQb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 12:31:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38108 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeHEQb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 12:31:59 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8C96C40B;
        Sun,  5 Aug 2018 14:27:12 +0000 (UTC)
Date:   Sun, 5 Aug 2018 16:27:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Salil Kapur <salilkapur93@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: Removing NULL check for pool since dma_pool_destroy
 is safe
Message-ID: <20180805142709.GA11958@kroah.com>
References: <b5db9a6d-6194-ae7c-235d-dce772cb9a4c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5db9a6d-6194-ae7c-235d-dce772cb9a4c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 12:10:22AM -0700, Salil Kapur wrote:
> Removing NULL check for pool since dma_pool_destroy is safe
> 
> Signed-off-by: Salil Kapur <salilkapur93@gmail.com>
> ---
>  drivers/usb/core/buffer.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
> index 77eef8acff94..f641342cdec0 100644
> --- a/drivers/usb/core/buffer.c
> +++ b/drivers/usb/core/buffer.c
> @@ -101,12 +101,8 @@ void hcd_buffer_destroy(struct usb_hcd *hcd)
>          return;
>  
>      for (i = 0; i < HCD_BUFFER_POOLS; i++) {
> -        struct dma_pool *pool = hcd->pool[i];
> -
> -        if (pool) {
> -            dma_pool_destroy(pool);
> -            hcd->pool[i] = NULL;
> -        }
> +        dma_pool_destroy(hcd->pool[i]);
> +        hcd->pool[i] = NULL;
>      }
>  }
>  
> -- 
> 2.14.4

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
