Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B5BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6A120833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6A120833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbeIJUC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:02:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40102 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIJUC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:02:57 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1D48DD0D;
        Mon, 10 Sep 2018 15:08:24 +0000 (UTC)
Date:   Mon, 10 Sep 2018 17:08:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 01/21] staging:rtl8192u: Rename AdvCoding - Style
Message-ID: <20180910150822.GB25530@kroah.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
 <20180829203547.15650-2-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829203547.15650-2-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 09:35:27PM +0100, John Whitmore wrote:
> Rename the bit field element AdvCoding, as it causes a checkpatch issue
> with CamelCase naming. As the element is not actually used in code it
> has been renamed to 'not_used_adv_coding'.
> 
> The single line of code which initialises the bit has been removed,
> as the  field is unused.
> 
> This is a purely coding style change which should have no impact
> on runtime code execution.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
>  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> index 64d5359cf7e2..66a0274077d3 100644
> --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> @@ -39,7 +39,7 @@ enum ht_extension_chan_offset {
>  
>  struct ht_capability_ele {
>  	//HT capability info
> -	u8	AdvCoding:1;
> +	u8	not_used_adv_coding:1;
>  	u8	ChlWidth:1;
>  	u8	MimoPwrSave:2;
>  	u8	GreenField:1;
> diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> index 9bf52cebe4cd..d7f73a5831da 100644
> --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> @@ -550,7 +550,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
>  	}
>  
>  	//HT capability info
> -	pCapELE->AdvCoding		= 0; // This feature is not supported now!!
>  	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
>  		pCapELE->ChlWidth = 0;
>  	else

If a structure like this, which is not read/written to hardware
directly, has fields that are not really used at all, just delete them.
That's much easier than having to apply this patch, and a later patch
which deletes the usage.

thanks,

greg k-h
