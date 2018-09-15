Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8942CECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193D520882
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uW6jJFbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193D520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeIOHrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:47:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40917 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725744AbeIOHrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 03:47:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17-v6so4959252plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 19:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=02lORtx30jMevNRhZpM3Wen9Mf+38XeFk1Tg0foMAH0=;
        b=uW6jJFbqPx4A+e2MY8mMLJkzfkXn4UrS+4F2GBH15u9S+RxxJCUulxnUKmGQ0OxhAg
         a/QoFQwLWeRMyMoEezZjRWNu8CQdfeirRtotMq0L8z1duV2XVIkF4NnCQz4RUf36eIeV
         7uEgF+65ER/pvsNqfJsEROyJl+yZNo/t9g56CNszXw1W/MPcW7ShKzrwp3y8SE0MghZQ
         hkdKcu0lwSZNfC2Rb5lRZOTZU+89bGGMCqwUeMhskMDNpV9MwUjw5mTFLaDnehT+NwK2
         t47RNnd0wQBQn0MqnktebAt8T6Phlk/OzYSbQzhSt4kMbd22Dz0oVZwVie3ko+G64H9c
         U3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=02lORtx30jMevNRhZpM3Wen9Mf+38XeFk1Tg0foMAH0=;
        b=WNsUNtvOf7Z+ERUaOYE+xcnjG7oLxB8GNRVkfmiyKVO82hAIYxAcyCyckeDu1QOa6a
         Ukbtx38pvf7Yehzk6esLUUDAf3KX3pTpH2eeY4DniEKuMb+NGnBrxCadHXksp1OQ64FP
         svofOFuQ0MsB4dfpXJK1Iw1xsizSFl8dhsEvUaB5Yo7pxx6qdTTFcgj+uh1TKTzThsmA
         NSqjPptpIvCfBZHH7yrhHFnOFVbPCHLuZ5yMotjqtpMKxFOY/gV1TY5pDq8VlvXlbFYb
         /DHSFdnZ6KiQwsnou/mEwQctx5PrbjrucIi9xICijs/HWYNAi4iJury9gUmNSaZiUIsC
         cLXg==
X-Gm-Message-State: APzg51B06jO5wMLkt8N1mcHi8fHIE3bVuesB8xFNEKeY2vJ6ZGlywCKY
        wDJ+s5l3gt9+ZwmQvlmDC9A=
X-Google-Smtp-Source: ANB0VdZnFDkHiE/f/Iu+KNVTBlZDA2KSkbwYGsnBElGzkAYEcRb9TgjTzyJXatLu5sTFVPObHvudHw==
X-Received: by 2002:a17:902:a987:: with SMTP id bh7-v6mr14877671plb.182.1536978599295;
        Fri, 14 Sep 2018 19:29:59 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id g5-v6sm10943091pgn.73.2018.09.14.19.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 19:29:58 -0700 (PDT)
Date:   Sat, 15 Sep 2018 07:59:51 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v6 3/3] staging: mt7621-mmc: Fix debug macro IRQ_MSG and
 its usages
Message-ID: <20180915022949.GA14300@nishad>
References: <cover.1535752537.git.nishadkamdar@gmail.com>
 <8f8cff3f1042e3fd303350baa261876cf4e3d7e7.1535752537.git.nishadkamdar@gmail.com>
 <20180910150513.GA25530@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910150513.GA25530@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 05:05:13PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Sep 01, 2018 at 03:51:10AM +0530, Nishad Kamdar wrote:
> > Replace all usages of IRQ_MSG with with dev_<level> without __func__
> > or __LINE__ or current->comm and current->pid. Remove the do {}
> > while(0) loop for the single statement macro. Drop IRQ_MSG from dbg.h.
> > Issue found by checkpatch.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v6:
> >   - No change
> > Changes in v5:
> >   - No change
> > ---
> >  drivers/staging/mt7621-mmc/dbg.h | 12 -----------
> >  drivers/staging/mt7621-mmc/sd.c  | 36 ++++++++++++++++++++++++--------
> >  2 files changed, 27 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
> > index 79914d98c573..4ab9f10dccc2 100644
> > --- a/drivers/staging/mt7621-mmc/dbg.h
> > +++ b/drivers/staging/mt7621-mmc/dbg.h
> > @@ -102,18 +102,6 @@ do { \
> >  } while (0)
> >  #endif /* end of +++ */
> >  
> > -#if 1
> > -//defined CONFIG_MTK_MMC_CD_POLL
> > -#define IRQ_MSG(fmt, args...)
> 
> So right now this define does nothing, yet:
> 
> > -#else
> > -/* PID in ISR in not corrent */
> > -#define IRQ_MSG(fmt, args...) \
> > -do { \
> > -	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d>\n",	\
> > -	       host->id,  ##args, __FUNCTION__, __LINE__);	\
> > -} while (0);
> > -#endif
> > -
> >  void msdc_debug_proc_init(void);
> >  
> >  #if 0 /* --- chhung */
> > diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> > index 7474f9ed7b5b..f3ae19fe0f76 100644
> > --- a/drivers/staging/mt7621-mmc/sd.c
> > +++ b/drivers/staging/mt7621-mmc/sd.c
> > @@ -279,7 +279,9 @@ static void msdc_tasklet_card(struct work_struct *work)
> >  		mmc_detect_change(host->mmc, msecs_to_jiffies(20));
> >  	}
> >  
> > -	IRQ_MSG("card found<%s>", inserted ? "inserted" : "removed");
> > +	dev_err(mmc_dev(host->mmc),
> > +		"%d -> card found<%s>\n",
> > +		host->id, inserted ? "inserted" : "removed");
> 
> You are now printing out lots of "errors" that really are not errors.
> 
> As these messages are not being printed at all right now, why not just
> delete these as well?
> 
> Your first 2 patches do look good, I've queued them up now.
> 
> thanks,
> 
> greg k-h

Ok, I'll do that.

Thanks for the review.

regards,
nishad
