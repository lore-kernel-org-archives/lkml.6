Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8D6C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C4321877
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvEDsNfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C4321877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeHROhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:37:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36888 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:37:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so4686527pgq.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 04:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BAksXcuQ/kGTeH24LqDoJI5JpPCoj/eg7V/zcW5P91o=;
        b=ZvEDsNfgJUzQ52uZQEnOtIBZT5EP151HHAfDdqwbxEdj2X800q/E97kfAzwYUvIzvO
         qrp5PaAVU0FcO9mpsCEIuwOsPYJ4lOUbe2ZhS+/9hotYnR6f9Q8vJbkWryLcXZeROs1d
         Vk+W9k8VQCqOxQDT4ABROm5GnnZcQbjZtQMjSmql8OXdvB7MxlWmhQeIAr/ZQaWxhiSO
         lNAcLE2Z8ESQFLOH8dmiD/WyhXtp5Oc2i5pctJ1LuYnla0px71HZWnPwa+nHMDjyKOQU
         1RY5aVsqBsXdXKOBAfCH7+7IBXmOj/DEeuUEVHMeR1lCdw9g2gzR9/DZ1scvD+nOFkzR
         utFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BAksXcuQ/kGTeH24LqDoJI5JpPCoj/eg7V/zcW5P91o=;
        b=kIapmPrQF4MPgMdNbTjXoDji1KIezxpb3DAfOnGXmz2BEHPNfj+pUqpUZJxQ1N6rrf
         WdmiwuFKKK9X9O2vYercSUY27D5xOn1XwwrloJr/bOotzSKdKit11KHdHS/2ig+VPDRA
         RUwSpp3dmopQ6/FRLTJHBbB6TKXuptbZkt76YoyfnVPhWSlH9knNJWd3U0QmrYtkehUa
         P4ppJuYyEnKznnj+eOw7Mlfinq4WXPDp/9R4pdi7gPt9YFrN5YFeJB+ZctSCCbu3hIfY
         7nHsZ/0eIPk4czhxZAfYA1UUfGOeaebxcThA5opsnCpnnZuNNIUax6ApQohZy+rT8Y4F
         +pRw==
X-Gm-Message-State: AOUpUlF1Wqaja/XKhltRwBi56iw/7SDvZvOkfoTAbiTny5M2xIwUoo7H
        5XWFCkmNJfdRY+C7lc3XJMg=
X-Google-Smtp-Source: AA+uWPyDVZlvdm23StST0RgPaA4OBSOjKbZ/1axj+OdD0W9wZrcPtKlS49CYuriHRq+1Dc09qgSC/Q==
X-Received: by 2002:a62:bd4:: with SMTP id 81-v6mr40424610pfl.67.1534591792663;
        Sat, 18 Aug 2018 04:29:52 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id p19-v6sm5718265pgk.28.2018.08.18.04.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 04:29:51 -0700 (PDT)
Date:   Sat, 18 Aug 2018 16:59:45 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        NeilBrown <neil@brown.name>, John Crispin <blogic@openwrt.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mt7621-mmc: Use __func__ instead of
 __FUNCTION__ in dbg.h
Message-ID: <20180818112943.GA560@nishad>
References: <20180816194943.GA25895@nishad>
 <60b91f3fc3dce48e2da0c9f2a7896d84829e1d25.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60b91f3fc3dce48e2da0c9f2a7896d84829e1d25.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 01:07:41PM -0700, Joe Perches wrote:
> On Fri, 2018-08-17 at 01:19 +0530, Nishad Kamdar wrote:
> > Use the identifier __func__ instead of gcc specific __FUNCTION__
> > in dbg.h. Limit these lines to 80 characters. Issues found by
> > checkpatch.
> 
> It looks like there are 4 uses in -next
> 
> drivers/staging/mt7621-mmc/dbg.h:110:            host->id,  ##args , __FUNCTION__, __LINE__, current->comm, current->pid);      \
> drivers/staging/mt7621-mmc/dbg.h:118:          host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
> drivers/staging/mt7621-mmc/dbg.h:129:          host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
> drivers/staging/mt7621-mmc/dbg.h:136:          host->id,  ##args, __FUNCTION__, __LINE__);      \
> 
> If you are going to fix this by substitution,
> please fix all of them, even if commented out.
> 
> And likely, all these uses should all be converted
> to dev_<level> instead without __func__ or __LINE__
> or current->comm and current->pid.
> 
> And relatedly, these are single statement macros and
> don't need do while (0);
> 
> And the ; after while (0) is unnecessary.
> 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/mt7621-mmc/dbg.h | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
> > index 2f2c56b73987..5da275239d7c 100644
> > --- a/drivers/staging/mt7621-mmc/dbg.h
> > +++ b/drivers/staging/mt7621-mmc/dbg.h
> > @@ -115,7 +115,8 @@ do {    \
> >  #define ERR_MSG(fmt, args...) \
> >  do { \
> >  	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> > -	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
> > +	       host->id,  ##args, __func__, __LINE__, current->comm, \
> > +	       current->pid); \
> >  } while (0);
> >  
> >  #if 1
> > @@ -126,14 +127,15 @@ do { \
> >  #define INIT_MSG(fmt, args...) \
> >  do { \
> >  	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> > -	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
> > +	       host->id,  ##args, __func__, __LINE__, current->comm, \
> > +	       current->pid); \
> >  } while (0);
> >  
> >  /* PID in ISR in not corrent */
> >  #define IRQ_MSG(fmt, args...) \
> >  do { \
> >  	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d>\n",	\
> > -	       host->id,  ##args, __FUNCTION__, __LINE__);	\
> > +	       host->id,  ##args, __func__, __LINE__);	\
> >  } while (0);
> >  #endif
> >  

Ok, I'll include the changes in the next version.

Thanks for the review.

regards,
nishad
