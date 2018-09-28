Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675E6C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18620206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu9BC3Gy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18620206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeI2E5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:57:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38343 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeI2E5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:57:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id 193-v6so2160478wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5AqEZcLYba1FmERIil4u2EZYcixsOvhK579Dn9gQV38=;
        b=Tu9BC3GywB6ARd+nk3SO9VIAeWVPc1kJZ/QPuWebBRj/oY3d9IaniVv6TGAdY2hcAj
         lartJhlF1ebQpm5PRSvHwUT9/wl2KYyVNFF9W0KZuCPRV4l3WdJIxcN3aE1WN3MjHBeW
         NWWBCrgZAIFYQlWvylR+W+xJ2+ey8jTUCISyCzMMw68jUtnnsXnAh+bP8Ah3vWOV883j
         5cg7UA4dYWbYFxGaTUBNv81xbGBfPI2txlC4LAgrJF7UiHNAiVms73xZQzCqlxrVdbe6
         wPujsvF9Ywd01romK0UzTtndJ14rzgtbFGBxeMF32Y67ZK/o+3q4MWCqzwuOytdmSdDM
         n1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5AqEZcLYba1FmERIil4u2EZYcixsOvhK579Dn9gQV38=;
        b=WEMOQQj40YVK5xRN1zftdkIEvEefV8WYQsBPoWHCyGcTO3azkrZKJWSQ0g5tQJwYLK
         vWPLqvzZ/JDYxoELqlRlQSoeihWV78+djSBWIB0rJRHRh0AWuyjzUpjL2cGifnJ2X8dS
         GppLuC2oj9CD5ItDgJSAH+SZEX4BV3U9go+4amF5dsDEo6kSSfVu/cji2Qka1H7eUAJ4
         w18gJVXZv/PEF+kPDXUgTN3fWVhqNZrYOJQLAITI361GDdtgr4lNkVUWgpMgfUV9YOrN
         +CAiyMUPC5s4V3/GH+7Z7+v6PYtPQxzw6xGoDRhFj59TdvOaQncIavTcmzulIGnh/OJ1
         jfwA==
X-Gm-Message-State: ABuFfojCUGzHf62I2V57iMNjViXHlXy85AFn0yd1wtQ+jGyK2b1zcid9
        4n/dtOSKX+4xHTkS8kj+ZZA=
X-Google-Smtp-Source: ACcGV62NZ0IMsbGBj4tCdyYoDAq/ZaR+ErZ/NzFdFdPzZnD365iWPLE37mlWBGr7WsqmyxIKRYNNtw==
X-Received: by 2002:a1c:88c6:: with SMTP id k189-v6mr2990068wmd.32.1538173909723;
        Fri, 28 Sep 2018 15:31:49 -0700 (PDT)
Received: from xux707-tw (host86-169-110-130.range86-169.btcentralplus.com. [86.169.110.130])
        by smtp.gmail.com with ESMTPSA id n4-v6sm6541895wrr.21.2018.09.28.15.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 15:31:48 -0700 (PDT)
Date:   Fri, 28 Sep 2018 23:32:14 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 05/13] staging:rtl8192u: Remove AdvCoding and GreenField
 - Style
Message-ID: <20180928223212.GA4984@xux707-tw>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
 <20180926191704.16322-6-johnfwhitmore@gmail.com>
 <20180928143140.e5fwzgdpehiw527f@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928143140.e5fwzgdpehiw527f@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 05:31:40PM +0300, Dan Carpenter wrote:
> On Wed, Sep 26, 2018 at 08:16:56PM +0100, John Whitmore wrote:
> > The member variables AdvCoding and GreenField are unused in code so
> > have been removed from the structure and associated initialisation
> > function.
> > 
> > This is a coding style change which should have no impact on runtime
> > code execution.
> > 
> > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 --
> >  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 --
> >  2 files changed, 4 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> > index 64d5359cf7e2..83fb8f34ccbd 100644
> > --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> > +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> > @@ -39,10 +39,8 @@ enum ht_extension_chan_offset {
> >  
> >  struct ht_capability_ele {
> >  	//HT capability info
> > -	u8	AdvCoding:1;
> >  	u8	ChlWidth:1;
> >  	u8	MimoPwrSave:2;
> > -	u8	GreenField:1;
> >  	u8	ShortGI20Mhz:1;
> >  	u8	ShortGI40Mhz:1;
> >  	u8	TxSTBC:1;
> 
> I feel like we discussed this before.  I'm pretty sure this comes from
> the firmware and so the format can't be changed.  When I look at
> rtllib_parse_mife_generic() then I think that "info_element" probably
> comes from the firmware.
> 
> I wouldn't want to accept this with out someone testing it.
> 
> regards,
> dan carpenter
> 

Thank you and sorry about not helping the signal to noise ratio on here.

I agree that a bit field like that and it looks like it comes from
firmware, but my question or possibly obsession was where. There are
structures inside structures, but they are all allocated from RAM.
Because of that I expected to find a memcopy from the device, or given
that the bitfield is initialised with values that it might be memcopy'd
to the device. I just couldn't find that memcopy, but that's down to
my untrained eye. I'll stumble across it in some obscure corner of the
driver.
