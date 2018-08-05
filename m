Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFDCC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F372217D1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F372217D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeHEQ11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 12:27:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36682 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeHEQ11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 12:27:27 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8EBA440B;
        Sun,  5 Aug 2018 14:22:41 +0000 (UTC)
Date:   Sun, 5 Aug 2018 16:22:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 6/7] staging:rtl8192u: Remove unused member variable -
 Style
Message-ID: <20180805142239.GA17309@kroah.com>
References: <20180804091859.6729-1-johnfwhitmore@gmail.com>
 <20180804091859.6729-7-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804091859.6729-7-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 10:18:58AM +0100, John Whitmore wrote:
> Remove name of 'reserved' bitfield member which is simply used to pad
> the bitfield to a byte boundary. The actual bit has been left in place
> so alignment should not change. The name, which is not required has
> been removed.
> 
> This is a coding style change which should have no impact on runtime
> code execution.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/ieee80211.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> index 3cfeac0d7214..fc449806dab8 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> @@ -114,7 +114,7 @@ struct cb_desc {
>  	u8 bBroadcast:1;
>  	//u8 reserved2:2;
>  	u8 drv_agg_enable:1;
> -	u8 reserved2:1;
> +	u8:1;

No, this is ok, and a common thing to do.  Anonymous bit fields is not a
normal thing.

thanks,

greg k-h
