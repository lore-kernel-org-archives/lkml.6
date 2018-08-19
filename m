Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F0FC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 09:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F81C208B2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 09:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na4WX1YW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F81C208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeHSNKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 09:10:36 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36751 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeHSNKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 09:10:36 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so5686551plb.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/+EzZR09iH3Etyd66zwyhJSNlo+NAFknc4ZEz1BacA0=;
        b=na4WX1YWWW8T5gZhGFi34jmNlNSjw79NxXp8SY7e9KSpErABLfv1HcVeyuHT2dZJZH
         HlmRGW7jiL+HasB1ylyAooSwoGlIc3me7MFgITSBC4fYGY/Lmmeej4cGrKLtIBkfbadh
         sj3dQL1ab1DkJVZT41KtFtK2QZoeLEwY3hlBmZC+YMnqHVfa3+URSrbIEKqhWhfwnu26
         ln/YoRfK7tfh0zy18ujKCo+6XA15I/fnqOxRcnlvl3z+IAFqEDhLpHSseZ4d4nGUqBiT
         BA5TqQ9rw2zF8VepNtjAFlVqW4Oc1WRPoshihRA/MK2hbjBihYhTzzkiHko/sOnXbgqq
         pCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/+EzZR09iH3Etyd66zwyhJSNlo+NAFknc4ZEz1BacA0=;
        b=LMXV3cgeBAWx3cED4u52F0VEBDjMea+lu57ecIXvWEZSLw/4dXnlZ9dpzJYqp88o14
         MsG1dJ5e3eulkeKj0nO/B/vnvzk/hl3/7vVsENI/Ll8iW82xLjlOGMGBtGoxkLzwaTk1
         4iKNdz60oENLzpJZLDtx1uSZfvJnAwY9SMqpZ/1+V6+wXVcvvKMKmOA2BKQudZLDuUdB
         yNdbu1PB8f71As8WFbWP/91q7YnbHgZNfOvL69Eqvl5jGJ0hCuR587IUkGYcUVzLJoij
         /ZLTe4rXoUMCUH4BlGJSIGEMKfLYAvi8eMwFWuKc4yu2GNhPFUTS4wukx7tx+lVvbwgf
         XIAg==
X-Gm-Message-State: AOUpUlE2DHkEKyuRzWA4NdENBxOY7g5D8YR3UEGO8aswLy5EWLefIFeB
        QnWukxyIi/RFhv2VW0tqRP4t0VuKMPUhTA==
X-Google-Smtp-Source: AA+uWPy0vbbE2HCjnejGLuMdpoJ5s8/p5SaZ71Rw49xMOd9y3yyNSLIRrBJl//bhwniWaKfRCmnmXA==
X-Received: by 2002:a17:902:da4:: with SMTP id 33-v6mr40412686plv.193.1534672780354;
        Sun, 19 Aug 2018 02:59:40 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id w5-v6sm8601889pfn.44.2018.08.19.02.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Aug 2018 02:59:39 -0700 (PDT)
Date:   Sun, 19 Aug 2018 15:29:33 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        NeilBrown <neil@brown.name>, John Crispin <blogic@openwrt.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: mt7621-mmc: Fix debug macros in dbg.h
Message-ID: <20180819095932.GA13137@nishad>
References: <20180818114313.GA6608@nishad>
 <20180818114923.GB4137@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180818114923.GB4137@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 01:49:23PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Aug 18, 2018 at 05:13:17PM +0530, Nishad Kamdar wrote:
> > Fixed four debug macros by replacing printk with dev_<level>
> > without __func__ or __LINE__ or current->comm and current->pid.
> > Further removed the do {} while(0) loop for single statement
> > macro. Issues found by checkpatch.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v2:
> >   - Replace printk with dev_<level>.
> >   - Remove __func__, __LINE__, current->comm, current->pid from arguments.
> >   - Remove the do {} while(0) loop from these macros.
> >   - Modify commit message to include other changes.
> > ---
> >  drivers/staging/mt7621-mmc/dbg.h | 26 +++++++-------------------
> >  1 file changed, 7 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
> > index 2f2c56b73987..e8091db3c1d6 100644
> > --- a/drivers/staging/mt7621-mmc/dbg.h
> > +++ b/drivers/staging/mt7621-mmc/dbg.h
> > @@ -104,19 +104,13 @@ do { \
> >  
> >  #define N_MSG(evt, fmt, args...)
> >  /*
> > -do {    \
> > -    if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> > -        printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> > -            host->id,  ##args , __FUNCTION__, __LINE__, current->comm, current->pid);	\
> > -    } \
> > -} while(0)
> > -*/
> > + *if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> > + *    dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args) \
> > + *}
> > + */
> 
> This can just be deleted, just drop it.
> 
> >  
> >  #define ERR_MSG(fmt, args...) \
> > -do { \
> > -	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> > -	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
> > -} while (0);
> > +dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args)
> 
> No, please just replace all usages of ERR_MSG with dev_err() in the code
> itself, and then drop ERR_MSG.  No driver/subsystem should have special
> macros just for it.
> 
> >  #if 1
> >  //defined CONFIG_MTK_MMC_CD_POLL
> > @@ -124,17 +118,11 @@ do { \
> >  #define IRQ_MSG(fmt, args...)
> >  #else
> >  #define INIT_MSG(fmt, args...) \
> > -do { \
> > -	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> > -	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
> > -} while (0);
> > +dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args)
> 
> Same here.  Actually I bet all INIT_MSG can just be removed :)
> 
> >  
> >  /* PID in ISR in not corrent */
> >  #define IRQ_MSG(fmt, args...) \
> > -do { \
> > -	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d>\n",	\
> > -	       host->id,  ##args, __FUNCTION__, __LINE__);	\
> > -} while (0);
> > +dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args)
> 
> Same here, just replace the usage of these macros with the real thing.
> 
> thanks,
> 
> greg k-h

Ok, I will make the changes in the next version.

thanks for the review.

regards,
nishad
