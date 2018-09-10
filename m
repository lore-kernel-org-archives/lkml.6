Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CF0C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E0220833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E0220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeIJUED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:04:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41316 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbeIJUEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:04:02 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5B66CD57;
        Mon, 10 Sep 2018 15:09:30 +0000 (UTC)
Date:   Mon, 10 Sep 2018 17:09:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 20/20] staging:rtl8192u: Rename OWN - Style
Message-ID: <20180910150927.GC25530@kroah.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
 <20180831230250.16810-21-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831230250.16810-21-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 12:02:50AM +0100, John Whitmore wrote:
> Rename the member variable 'OWN' to 'own', this is to comply with the
> coding standard, where variables are named in lowercase.
> 
> This is a simple coding style change which should have no impact on
> runtime code execution.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U.h      | 2 +-
>  drivers/staging/rtl8192u/r8192U_core.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
> index 68e82b32a88e..f963b664e221 100644
> --- a/drivers/staging/rtl8192u/r8192U.h
> +++ b/drivers/staging/rtl8192u/r8192U.h
> @@ -165,7 +165,7 @@ struct tx_desc_819x_usb {
>  	u8	last_seg:1;
>  	u8	first_seg:1;
>  	u8	linip:1;
> -	u8	OWN:1;
> +	u8	own:1;
>  
>  	/* DWORD 1 */
>  	u8	TxFWInfoSize;
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index 911d0214b48a..4d0f70ec31ac 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -1558,7 +1558,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
>  	/* DWORD 0 */
>  	tx_desc->first_seg = 1;
>  	tx_desc->last_seg = 1;
> -	tx_desc->OWN = 1;
> +	tx_desc->own = 1;

Is this another case of a variable being set once and then never used?

If so, just delete it.

thanks,

greg k-h
