Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2329AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44FC2152F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2UocVOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44FC2152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbeHVOfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:35:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43400 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbeHVOfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:35:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id v66-v6so770580pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 04:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gMmthSmECt/1QcGfwdGFFAZS/3AEempWhc1c4XQcFfo=;
        b=n2UocVOZJ6S3lPV/DgaqVk+ma7KshFGebbieSTT8+9kIg2j4g2ZTaokeSvlC0PyrnY
         inD6Z6GC+9REuX3atIbr/wIrhKuHrStXV3yvEMJFk85tinKRC/idef1ribhYPWDhehfC
         kgViDgUkZm0q3nJtj0lIz0zm6nbkAr9i/PFMDDuGCglQZ7WM1c1fIzpWiU7t1fwabkNF
         Is1ysQzc0wB0J5mz5tKot323u9jNI+jiuAMbt7Gtnv9MBdaSqprDTLT0iDlZAe0C32UU
         lIpaPNj09FYE6Vb02QPeo5XmbdRFKUDyrNy9s3KAIY6MmWFMc5+mN/HX/qWOkZx4AcJg
         DQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gMmthSmECt/1QcGfwdGFFAZS/3AEempWhc1c4XQcFfo=;
        b=pi4CveDlbSSCt0QkRPkXc9JESwggIN4pDCgf+egT7gP3bElE04f9yrP3Sie1q50pah
         AjA2hzou+vAbPcwl1/5MuHCxkGoSBQhb2xZciSN9K8gzF1zd9tjpAmyJARVExsgz3QeT
         ndKyyamXI4hYx+QAG/2oRESNMPUGofTpzQqyPkfsU3fy14Dvc94hCfUK7O8OCVOxBI4Q
         S+cJUTuU5+qw5ugDVfxOANFaEgzPZ1CrDgmUgHP7dDMrmAzRb0WK5Ql4j5jJDf3UngIo
         ZYvFuIGDJ72AattFUJK60sj5KgpnR8+aEJ/xTsMve2p/ipKj95gWkoh7c7OfmFAb7NDz
         pkxQ==
X-Gm-Message-State: AOUpUlEWHFDcFIpE1jdmsA8m+OIDOVuRF2iCDXmrRwtUtfNi8Kox1TCI
        XhkAVpmvEYP/OwIxxjgjq6g=
X-Google-Smtp-Source: AA+uWPySfw+gv9BbBDLUUax3HnJtbzOwfj/ZLpDIB0dzi9AzOOPvhDlCeVUhbzqI8XbuWAR8OLrvGA==
X-Received: by 2002:a63:9712:: with SMTP id n18-v6mr9859095pge.292.1534936262629;
        Wed, 22 Aug 2018 04:11:02 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id a15-v6sm2642448pfe.32.2018.08.22.04.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 04:11:02 -0700 (PDT)
Date:   Wed, 22 Aug 2018 16:40:56 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        NeilBrown <neil@brown.name>, Joe Perches <joe@perches.com>,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v4 1/4] staging: mt7621-mmc: Fix debug macro N_MSG
Message-ID: <20180822111052.GA2675@nishad>
References: <cover.1534923403.git.nishadkamdar@gmail.com>
 <2313d873f9a940fcdd4f608ffe3c37ec6a5b6e35.1534923403.git.nishadkamdar@gmail.com>
 <20180822090935.eod5oyodo3xchaxw@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822090935.eod5oyodo3xchaxw@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 12:09:36PM +0300, Dan Carpenter wrote:
> On Wed, Aug 22, 2018 at 02:04:55PM +0530, Nishad Kamdar wrote:
> > This patch fixes the debug macro N_MSG. Replaces printk with
> > dev_<level> without __func__ or __LINE__ or current->comm and
> > current->pid. Removes the do {} while(0) loop for the single
> > statement macro. Issue found by checkpatch.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/mt7621-mmc/dbg.h | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
> > index 2f2c56b73987..c56fb896617a 100644
> > --- a/drivers/staging/mt7621-mmc/dbg.h
> > +++ b/drivers/staging/mt7621-mmc/dbg.h
> > @@ -104,13 +104,10 @@ do { \
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
> I don't understand what you're trying to do here.  You just commented
> out the macro and turned it into a no-op.  That's not what the patch
> description says.
> 
> To me the original code seems fine.
> 
> regards,
> dan carpenter
>

Ok. But the macro definition was already commented.
I just changed printk to dev_err and gave it a better
block comment format.
Should I leave the older version as it is ?

Thanks for the review.

regards,
nishad
