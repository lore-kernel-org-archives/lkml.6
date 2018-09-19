Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00124C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7249E2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS7MsTc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7249E2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbeISWs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:48:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37051 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeISWs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:48:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id 2-v6so3051843pgo.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ya+gI92VGoFyDBq8ToYeLrdoEHOt/l5l4io8f8V20fc=;
        b=ZS7MsTc4yGqczNcV5C7PSGzBiP7bzQeNGTjX3KJmraL8C/ZXkoWi+h4/FP0qseyS/N
         ddrkCZJuxK3/pMrdAckCL6XjL3siR6/3NPB/CwADY5fiiIXuUS3QDZluFcDZpFtQHgZM
         TRwGv5aj44rPjo3l0UbYmYYkSwfF85J3UFMLH1sbUJ9ryFIgBept6DyG3O5Dwjf68e8Q
         EnuptxGBwl1PddmuYz2U+jBH9S8hm2ztfDGSHJRuQd0Q5MJq1Dhz+I2N3GwVHbwjQ0wW
         A2p8WvU0EU+PWX80s3UbNYLhcvTvSD1AEfdtF59ijk7jan0kdhwGYXjf+bubQCIyySYW
         mKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ya+gI92VGoFyDBq8ToYeLrdoEHOt/l5l4io8f8V20fc=;
        b=e8P4ePzXEkLXF3ip7/D6WUfiWpjqxOAYR5wKSARgNkLuRX2c8zIPWSJnjbF//wRbme
         9uxuSLc68MfWJKkSH1XoxRQOPd1xhr4FxeAtjT+wu+eTVQbUWfNZSTKMS0RDDWufzgFK
         BwMuSOlf7gqqm5GC5JAlae+4EUWTCtYT3N4LxUe9aUFLGSVT1oy/OLUkR3VDEzWGKn2U
         geBK5cX9w0xZGzngFLNoYw8mCsi2bQCvaM6hZwpnv7YpQcxFMd/+3dBZidk9ktfljHfH
         jlo1P8LLIYhEssM/Lgx/fsNLAbdNHb5JKkXl+gG5gkX8MnDiX6BfG0jm5DgBYc6pAioa
         X6rw==
X-Gm-Message-State: APzg51ASUfgh6MfQA40XrPgCEMVZ9z1y6hT7HOLIqWHcb3fdI3QDMLqs
        vrHxKHGJD4VWpKrCi3D04WA=
X-Google-Smtp-Source: ANB0VdYQm5Cl6sZLY2tsBKatwnKPcZAVpsdUtzjPF3O4w7NsMCU0opgo25BpPjTtfHDTX2zeImEWSw==
X-Received: by 2002:aa7:8713:: with SMTP id b19-v6mr37076472pfo.151.1537376976000;
        Wed, 19 Sep 2018 10:09:36 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id g21-v6sm44546409pfe.41.2018.09.19.10.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 10:09:35 -0700 (PDT)
Date:   Wed, 19 Sep 2018 22:39:28 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 1/1] staging: mt7621-mmc: Delete IRQ_MSG() and its
 users.
Message-ID: <20180919170926.GA3780@nishad>
References: <cover.1536978715.git.nishadkamdar@gmail.com>
 <0bc3daf340308eb8a1aa5510ee33417ef7d8bd89.1536978716.git.nishadkamdar@gmail.com>
 <20180918112901.GB14453@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918112901.GB14453@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 01:29:01PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Sep 15, 2018 at 08:28:03AM +0530, Nishad Kamdar wrote:
> > This patch removes IRQ_MSG() and its users as currently it is a no-op.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v7:
> >   - Delete IRQ_MSG() and all its users
> > Changes in v6:
> >   - No change
> > Changes in v5:
> >   - No change
> > ---
> >  drivers/staging/mt7621-mmc/dbg.h | 12 ------------
> >  drivers/staging/mt7621-mmc/sd.c  | 19 -------------------
> >  2 files changed, 31 deletions(-)
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
> > index 7474f9ed7b5b..273593427d3a 100644
> > --- a/drivers/staging/mt7621-mmc/sd.c
> > +++ b/drivers/staging/mt7621-mmc/sd.c
> > @@ -278,8 +278,6 @@ static void msdc_tasklet_card(struct work_struct *work)
> >  		host->mmc->f_max = HOST_MAX_MCLK;
> >  		mmc_detect_change(host->mmc, msecs_to_jiffies(20));
> >  	}
> > -
> > -	IRQ_MSG("card found<%s>", inserted ? "inserted" : "removed");
> >  #endif
> >  
> >  	spin_unlock(&host->lock);
> > @@ -1638,17 +1636,10 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
> >  	if (intsts & MSDC_INT_CDSC) {
> >  		if (host->mmc->caps & MMC_CAP_NEEDS_POLL)
> >  			return IRQ_HANDLED;
> > -		IRQ_MSG("MSDC_INT_CDSC irq<0x%.8x>", intsts);
> >  		schedule_delayed_work(&host->card_delaywork, HZ);
> >  		/* tuning when plug card ? */
> >  	}
> >  
> > -	/* sdio interrupt */
> > -	if (intsts & MSDC_INT_SDIOIRQ) {
> > -		IRQ_MSG("XXX MSDC_INT_SDIOIRQ");  /* seems not sdio irq */
> > -		//mmc_signal_sdio_irq(host->mmc);
> > -	}
> > -
> >  	/* transfer complete interrupt */
> >  	if (data != NULL) {
> >  		if (inten & MSDC_INT_XFER_COMPL) {
> > @@ -1663,10 +1654,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
> >  			msdc_clr_int();
> >  
> >  			if (intsts & MSDC_INT_DATTMO) {
> > -				IRQ_MSG("XXX CMD<%d> MSDC_INT_DATTMO", host->mrq->cmd->opcode);
> >  				data->error = -ETIMEDOUT;
> >  			} else if (intsts & MSDC_INT_DATCRCERR) {
> > -				IRQ_MSG("XXX CMD<%d> MSDC_INT_DATCRCERR, SDC_DCRC_STS<0x%x>", host->mrq->cmd->opcode, readl(host->base + SDC_DCRC_STS));
> >  				data->error = -EIO;
> >  			}
> 
> The {} should be removed here, right?
> 
> thanks,
> 
> greg k-h

Yes, i'll do that.

Thanks for the review.

regards,
nishad
