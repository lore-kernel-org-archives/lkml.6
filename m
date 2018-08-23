Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D74C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F3C2154E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk8jaoY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F3C2154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeHWUoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:44:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40860 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeHWUoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:44:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id z25-v6so2927865pgu.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A6PvVEhN1QeijDG56FuA0RiJe/C/as95j/IMo/h3ijU=;
        b=Uk8jaoY4qiVh3p9nuJAQPH/5R/JDEsslKJWpv2sRJZcfVIdjPeDqfg8Cw9Dong4oUZ
         U/pju+KuL7xpjcxIBwb/z4g78YBZmmN5ZO+ODX1eU4nNpJHL25NFPPiMnhDgzBwM5pkQ
         /q0YG+GW1+jDGx2jV7q/TDvutoM319wahLMvT6EcU2v5Dbop4IwUmR2e3s3/6pvtAOSk
         /9XCrisUir3Xmh575wgtc0qevcbHsC4hAbVKTmfOu848b7Rk1CTj1JAsR3ijrMU5WMgL
         hkqK+nwLTV1KUx4FnbiY1Efx7qI7vGho5WrQnCkrwh5S+INPIlyT9LR7cf7Pdgb2tFTP
         yyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A6PvVEhN1QeijDG56FuA0RiJe/C/as95j/IMo/h3ijU=;
        b=BcBUN0eLpWPGEViykPtoGnshUuHHu++0190uiz8elkqeOsEfBqaF3eI7+HHLuKVf8N
         8vb3lLLZ7WoER84XLlvZUaLscmze8zPOLIat/mYRoPG463nDouQSc0Hq4DyePegBKyBh
         z70VP1IQZ77ZnZyBAqYmmobJynWs5xmHaBfR+zH/CBgppbj8pp+8NcwANl1DlmdNuAkx
         mdW5rgiglnHEgo9Z9cNxql0J9hywz5NiGlAbjaDRy3J5LtaRl7LAe+UpHCDVoR+PADdg
         6/oB3cbj2qWQdiY5TfjWBi4vcRU045kW7RRxPTag+PvLbWcZOy3SqGHxPf8cGDu/Zou5
         c7bA==
X-Gm-Message-State: AOUpUlGUdXq4EQ3xMJeonR74QTFD3lvdGoCb3DWMnCb3NAxOSt2XFLpc
        EbYeHC6hq2HEeOkQJF9IR9nthk5r4NnA6g==
X-Google-Smtp-Source: AA+uWPw192nO5ckT3oKcHgi6KEZD1grVt6nZTTjtO6syNOmKnVTf0ZpTs5Jp9p7GVYaISnM25Q69Ag==
X-Received: by 2002:a63:cd4c:: with SMTP id a12-v6mr57164915pgj.15.1535044424685;
        Thu, 23 Aug 2018 10:13:44 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id f6-v6sm9668147pff.29.2018.08.23.10.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 10:13:44 -0700 (PDT)
Date:   Thu, 23 Aug 2018 22:43:38 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v4 1/4] staging: mt7621-mmc: Fix debug macro N_MSG
Message-ID: <20180823171336.GA18185@nishad>
References: <cover.1534923403.git.nishadkamdar@gmail.com>
 <2313d873f9a940fcdd4f608ffe3c37ec6a5b6e35.1534923403.git.nishadkamdar@gmail.com>
 <20180822090935.eod5oyodo3xchaxw@mwanda>
 <20180822111052.GA2675@nishad>
 <20180822112641.GA21716@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822112641.GA21716@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 01:26:41PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 22, 2018 at 04:40:56PM +0530, Nishad Kamdar wrote:
> > On Wed, Aug 22, 2018 at 12:09:36PM +0300, Dan Carpenter wrote:
> > > On Wed, Aug 22, 2018 at 02:04:55PM +0530, Nishad Kamdar wrote:
> > > > This patch fixes the debug macro N_MSG. Replaces printk with
> > > > dev_<level> without __func__ or __LINE__ or current->comm and
> > > > current->pid. Removes the do {} while(0) loop for the single
> > > > statement macro. Issue found by checkpatch.
> > > > 
> > > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > > > ---
> > > >  drivers/staging/mt7621-mmc/dbg.h | 11 ++++-------
> > > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
> > > > index 2f2c56b73987..c56fb896617a 100644
> > > > --- a/drivers/staging/mt7621-mmc/dbg.h
> > > > +++ b/drivers/staging/mt7621-mmc/dbg.h
> > > > @@ -104,13 +104,10 @@ do { \
> > > >  
> > > >  #define N_MSG(evt, fmt, args...)
> > > >  /*
> > > > -do {    \
> > > > -    if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> > > > -        printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> > > > -            host->id,  ##args , __FUNCTION__, __LINE__, current->comm, current->pid);	\
> > > > -    } \
> > > > -} while(0)
> > > > -*/
> > > > + *if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> > > > + *    dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args) \
> > > > + *}
> > > > + */
> > > 
> > > I don't understand what you're trying to do here.  You just commented
> > > out the macro and turned it into a no-op.  That's not what the patch
> > > description says.
> > > 
> > > To me the original code seems fine.
> > > 
> > > regards,
> > > dan carpenter
> > >
> > 
> > Ok. But the macro definition was already commented.
> > I just changed printk to dev_err and gave it a better
> > block comment format.
> > Should I leave the older version as it is ?
> 
> No, delete the whole thing if it is not being used, don't "convert" code
> that is commented out.
> 
> thanks,
> 
> greg k-h

Ok, I'll do that.

Thanks for the review.

regards,
nishad
