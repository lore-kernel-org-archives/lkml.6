Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A88FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0967D20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0967D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeIJUEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:04:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41500 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbeIJUEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:04:38 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 70C6AD1F;
        Mon, 10 Sep 2018 15:10:06 +0000 (UTC)
Date:   Mon, 10 Sep 2018 17:10:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 18/20] staging:rtl8192u: Rename FirstSeg - Style
Message-ID: <20180910151002.GE25530@kroah.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
 <20180831230250.16810-19-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831230250.16810-19-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 12:02:48AM +0100, John Whitmore wrote:
> Rename the member variable 'FirstSeg' to 'first_seg', this change
> clears the checkpatch issue with CamelCase naming.
> 
> This is a simple coding style change and as such should not impact
> runtime code execution.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U.h      | 2 +-
>  drivers/staging/rtl8192u/r8192U_core.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
> index 672cbfa688f7..66efa59eabf0 100644
> --- a/drivers/staging/rtl8192u/r8192U.h
> +++ b/drivers/staging/rtl8192u/r8192U.h
> @@ -163,7 +163,7 @@ struct tx_desc_819x_usb {
>  	u8	reserved0:3;
>  	u8	cmd_init:1;
>  	u8	last_seg:1;
> -	u8	FirstSeg:1;
> +	u8	first_seg:1;
>  	u8	LINIP:1;
>  	u8	OWN:1;
>  
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index dfbba1177470..a4d1b55a1117 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -1556,7 +1556,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
>  	 * all of the descriptors
>  	 */
>  	/* DWORD 0 */
> -	tx_desc->FirstSeg = 1;
> +	tx_desc->first_seg = 1;

Same for all of these, I'll let you respin this patch series...

thanks,

greg k-h
