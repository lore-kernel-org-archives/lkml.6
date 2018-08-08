Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC466C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8D221708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8D221708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeHHLlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:41:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbeHHLlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:41:49 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 822FEC7F;
        Wed,  8 Aug 2018 09:22:59 +0000 (UTC)
Date:   Wed, 8 Aug 2018 11:22:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Frank Werner-Krippendorf <mail@kripp.ch>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net
Subject: Re: [PATCH] Staging:rtl8712: Style - Removed inline block comment to
 fix "Statements should start on a tapstop"
Message-ID: <20180808092257.GA4097@kroah.com>
References: <1533498066-31466-1-git-send-email-mail@kripp.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533498066-31466-1-git-send-email-mail@kripp.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 09:41:06PM +0200, Frank Werner-Krippendorf wrote:
> Removed 5 inline comments "/*volatile*/" rtl87x_event.h, to fix
> a coding style issue "Statements should start on a tabstop"
> detected by checkpatch.pl script.
> 
> Signed-off-by: Frank Werner-Krippendorf <mail@kripp.ch>
> ---
>  drivers/staging/rtl8712/rtl871x_event.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_event.h b/drivers/staging/rtl8712/rtl871x_event.h
> index 5171379..2e59e8e 100644
> --- a/drivers/staging/rtl8712/rtl871x_event.h
> +++ b/drivers/staging/rtl8712/rtl871x_event.h
> @@ -90,13 +90,13 @@ struct event_node {
>  	unsigned char *node;
>  	unsigned char evt_code;
>  	unsigned short evt_sz;
> -	/*volatile*/ int *caller_ff_tail;
> +	int *caller_ff_tail;
>  	int	caller_ff_sz;
>  };
>  
>  struct c2hevent_queue {
> -	/*volatile*/ int	head;
> -	/*volatile*/ int	tail;

Those "volatile" seem to imply that something is needed for these
variables.  Please check to ensure that these are ok to remove in that
there is the proper locking for these types of things.

thanks,

greg k-h
