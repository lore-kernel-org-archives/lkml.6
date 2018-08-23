Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A1BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF2D20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPqZ5MUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF2D20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeHWUuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:50:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39482 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbeHWUuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:50:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id m3-v6so2028455pgp.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=it7iWgRkhEA+Ct9r5cfYOaQhxWhSkpgjPeR035x+Ia8=;
        b=MPqZ5MUxDnTh0RRzFrj1fh15U8J6qb4mDpSOxiE02k3JKPhSWxzOkcWXjpESeeyMSL
         qPfZ7DA7wsmCHhniAq6YsavQpP8ofCKwLb8IEJmp/5i7awmYo8dOg+uklr27Builnn0k
         qBYXWQhUgJrmhVjLHirfxOlVL4VGHbLDDxGgLGRPfqZVHwnbb5Rw/9ymd/tVwEiqUAtr
         TyoJtTtWB9/PSpv0QvPLwtw+RLC3C6AYpzWQ2eki6Bij80ITUOd6H4mnZp5X7KujtZiJ
         xE3dgtzV+UR036zX8yUhhBsTh7T7+mrZJ3unqnCtAug+2TG7qwMRwh1pdgPsJ5kGDDV8
         il2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=it7iWgRkhEA+Ct9r5cfYOaQhxWhSkpgjPeR035x+Ia8=;
        b=Ob9ykIT77uWtUtaO5x2DFViEZkNIwzDnHx+tmnKbv6wnKey54h9l6sO5D0j9Qx5RPP
         dHkF28l104dvBfDWHjmb/5nNEmU06RCe5aQoXq3ACt0FUoMs15HSOJHfZ9vS9u6I3Qd/
         wTPmZ/PLeVouiYTsW/X2tigCYjNxXl6KIHQuyuFPp1Ot/uhipvHaGzFG85eVBH6XXuU4
         zO1WDkhLD5u6sOjhKIzk8q6iFo33dNZ+qD/ZT57/dIoKmJ2N3AY8wyNL1F4AmjzGamYz
         yVi10rlT6xhoqYHvrSTHMscCRzo4Y4+103mdwHrpaLXiRv1XIExRNOcSS3v8UWE01oB5
         5ltQ==
X-Gm-Message-State: AOUpUlEKxcPA1tGSfH1JM2H9UuBDUgalGghh4iOIFNV8O90G780uyfP7
        Ytw+zoq5v8QsBz0YPjWMUL4=
X-Google-Smtp-Source: AA+uWPzlr58wGLZpWuPip5neWlra8kgq5udK+jU02VCD4/pmMVD0XVgy/kTbbQo7M2Uu8pmNfNtorQ==
X-Received: by 2002:a17:902:1121:: with SMTP id d30-v6mr47708523pla.250.1535044778460;
        Thu, 23 Aug 2018 10:19:38 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id b126-v6sm5365973pga.49.2018.08.23.10.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 10:19:37 -0700 (PDT)
Date:   Thu, 23 Aug 2018 22:49:31 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v4 1/4] staging: mt7621-mmc: Fix debug macro N_MSG
Message-ID: <20180823171930.GC18185@nishad>
References: <cover.1534923403.git.nishadkamdar@gmail.com>
 <2313d873f9a940fcdd4f608ffe3c37ec6a5b6e35.1534923403.git.nishadkamdar@gmail.com>
 <20180822090935.eod5oyodo3xchaxw@mwanda>
 <20180822111052.GA2675@nishad>
 <20180822113844.h5ramq5muiyfwnju@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822113844.h5ramq5muiyfwnju@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 02:38:44PM +0300, Dan Carpenter wrote:
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
> Oh...  Yeah.  You're right.  Sorry about that.
> 
> We normally just delete dead code without even thinking hard about it.
> It turns out that if we delete all the N_MSG() code, it's actually quite
> a bit.  But probably it's the right thing to do, instead of hanging on
> to it like a hoarder.
> 
> regards,
> dan carpenter
> 

Ok. I get it.

Thanks for the review.

regards,
nishad
