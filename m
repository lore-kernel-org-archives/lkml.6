Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8577C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A71D2064E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A71D2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbeI1WrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:47:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33988 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeI1WrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:47:08 -0400
Received: from localhost (unknown [88.128.83.59])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4F947DB8;
        Fri, 28 Sep 2018 16:22:36 +0000 (UTC)
Date:   Fri, 28 Sep 2018 14:35:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 05/13] staging:rtl8192u: Remove AdvCoding and GreenField
 - Style
Message-ID: <20180928123550.GA7089@kroah.com>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
 <20180926191704.16322-6-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926191704.16322-6-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 08:16:56PM +0100, John Whitmore wrote:
> The member variables AdvCoding and GreenField are unused in code so
> have been removed from the structure and associated initialisation
> function.
> 
> This is a coding style change which should have no impact on runtime
> code execution.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 --
>  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> index 64d5359cf7e2..83fb8f34ccbd 100644
> --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> @@ -39,10 +39,8 @@ enum ht_extension_chan_offset {
>  
>  struct ht_capability_ele {
>  	//HT capability info
> -	u8	AdvCoding:1;
>  	u8	ChlWidth:1;
>  	u8	MimoPwrSave:2;
> -	u8	GreenField:1;

Don't these fields come from the hardware itself?  By removing them
here, you just changed the memory layout of the structure.  Does the
driver still work properly after this?  If you can't test it, I can't
take this patch as it's too risky...

sorry,

greg k-h
