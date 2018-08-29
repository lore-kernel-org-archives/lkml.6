Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB63C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7982A2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhDZHkRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7982A2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeH2VKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:10:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41138 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeH2VKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:10:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id s15-v6so2598708pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ucRvBM4I5CsfIN8ATKvgnpUaqBKOjafap06dz2uDKZs=;
        b=ZhDZHkRdoVEHyqS/atE2WD2bmQOsmnvUuSXCmLY+8d/frg5UcMXTy7OpvYQsoab9Ty
         4OVNCsAbBOZ1a9LGF4fEIjUWnnpylX6CcmSoDiB7CuHTh7daZI6+ZxeKgU9Z9IC4PahA
         i9b/EYsN5ZXNvDnGO4F/H3KhpdSBPnUdOQpfncA8Hurnvfq/Ei74CNvCO1vcHI1p7Me3
         DjocfQLP3lGwYvZ5Y7qDD/HX5UE56/2OFTJ047HYg2rLZeH9sZ5753iszyfdRtpqHueK
         lGbYy4R/zWTH3ZAxFq90ipN4ATivXOH3WP/5fmE1ndW0s4F0AE3Vrwgj0fA0ifmsUWKj
         QwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ucRvBM4I5CsfIN8ATKvgnpUaqBKOjafap06dz2uDKZs=;
        b=L35HomXPBdKNbf4v/4GlcefW1Ks/Sjz9WddbhqDlVHKdNQe5oODfcvwuoLvfXBD/Kc
         6DeBHlN2FgOdt+BsegBZOSkS93fN1rmYhixosutazqYZrmZrNSS2qSrNoQchi0Xx9miO
         O9ljiUikDh1YQNhAqd2IWkzqo6DUI6StvKBhmZHQt9G2lNSZSaAFRYqQf9gHRKg8Mo4S
         eM2LGB97I0lp/Q/3vwjnFyeIrQrrgOz53TNGn9I8Nm5Ieflf1JWteF5p+AW/LdoMNoTB
         Q7zKSaTbS/zJEwsjb/j3+K9j6igjsxRu/4V54m01k4Pl47nKPoC5ons1sB99y+FcnS1y
         apRg==
X-Gm-Message-State: APzg51D7iIe9BKAcDlgp7wC59GW3s/OQGxwqNtDngvs6qNMFfSENZ9Yz
        l9CSfv1qOElMvX6S7FIWmLU=
X-Google-Smtp-Source: ANB0VdY1BwkFdG8UqG7sVAxzQlsS8/n1SyKu4EPyQVQPdJjU8Nri1/5VFk2GZytVziYU2nrZ3FrzEw==
X-Received: by 2002:a65:658a:: with SMTP id u10-v6mr2121182pgv.330.1535562744377;
        Wed, 29 Aug 2018 10:12:24 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id v186-v6sm8372311pgd.25.2018.08.29.10.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 10:12:23 -0700 (PDT)
Date:   Wed, 29 Aug 2018 22:42:16 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v5 1/4] staging: mt7621-mmc: Remove commented code for
 N_MSG
Message-ID: <20180829171215.GA8071@nishad>
References: <cover.1535038494.git.nishadkamdar@gmail.com>
 <21d3ce50f8bba68348c478e4a7520ee22d7b765c.1535038494.git.nishadkamdar@gmail.com>
 <20180827173340.GA827@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827173340.GA827@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 07:33:40PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 23, 2018 at 10:58:09PM +0530, Nishad Kamdar wrote:
> > This patch removes the dead code for N_MSG().
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v5:
> >   - Remove commented code for N_MSG()
> > ---
> >  drivers/staging/mt7621-mmc/dbg.h | 8 --------
> >  1 file changed, 8 deletions(-)
> > 
> > diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
> > index 2f2c56b73987..6f6b4505337f 100644
> > --- a/drivers/staging/mt7621-mmc/dbg.h
> > +++ b/drivers/staging/mt7621-mmc/dbg.h
> > @@ -103,14 +103,6 @@ do { \
> >  #endif /* end of +++ */
> >  
> >  #define N_MSG(evt, fmt, args...)
> > -/*
> > -do {    \
> > -    if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> > -        printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> > -            host->id,  ##args , __FUNCTION__, __LINE__, current->comm, current->pid);	\
> > -    } \
> > -} while(0)
> > -*/
> >  
> 
> So what are we supposed to do with a macro that defines nothing now?
> Please delete it and all users of it at the same time.
> 
> thanks,
> 
> greg k-h

Ok, I'll do that.

thanks for the review.

regards,
nishad
