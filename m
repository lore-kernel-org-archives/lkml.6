Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CADECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A62820854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=markrailton-com.20150623.gappssmtp.com header.i=@markrailton-com.20150623.gappssmtp.com header.b="Kr8qrIf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A62820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=markrailton.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeGUNTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:19:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43062 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbeGUNTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:19:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id b20-v6so11825332edt.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=markrailton-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KD3ucTab7mlsk4MKyDrJVQnJHhVawsLdQtIf3L/B03o=;
        b=Kr8qrIf6LPZ5oltVu8DZtkNuYyQiExySgtIWUuW4AzjsqcBqzCArCWsVGdSGyZdflI
         aGcvxt4xTM668L0qRDyksL4PtTtHH57muTaz9cxnLw1JLaIi/PBlXF6tyGueM5r1Mdqk
         Jlku/OhAQlcb8a4G4skQpoHICZd2Crp8dCJLjQEvqy7USLjMV9lbFIP56/dAQjLY/JrW
         UujabhlTBAPhJ3abWmhCPEL85pHDCqN1uewvM4ij+/yt7mO7zGuAYVPokeC+qmxck6KC
         T8j6KKohsmjzV6Nvx/lj2gCNHo1D+Wa3N94pAOR6NrSvlWe9IHWoqOOTlCim42u7CC5h
         LB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KD3ucTab7mlsk4MKyDrJVQnJHhVawsLdQtIf3L/B03o=;
        b=aWugDwk5mQEEGGZilXoS1MWEVVw3h/ic3tivGj2+31fcY2rYTL2woPySFNjHmtpWaa
         hqfuZgEF9yZTjyvlBDWshWKTXmSZ4N0YZ/Jw+9mGaK0yP44ffS4DqUERJhK97RETP0WF
         21lyGqejW2R6HVYYKEjyDzqhFqow9upAcg0+NcPHdiVjieywIELYsIkzUDrKgg9iVnMJ
         NuVDRnQZWymL3Ij2Cpc11dtROMjLu4/hN4oxBObC15gTm+pQHp2pmSavM8XiyPgHA11U
         PVGt9J/wEVgHr1NhMkHnes73iWKoHNHvSw6eK+YydM8NfkLaOSDyNtSG7x1hXGIRQDkx
         mLKw==
X-Gm-Message-State: AOUpUlHrsfQNpTy0MBLoNBQ0lETAZvAn9h6dOKvo3AwSN9jCx8emT0nV
        hXpgkGFMroGbLErK9kN675/WtQ==
X-Google-Smtp-Source: AAOMgpdee1mKjWpcw8TScGLUGWJMHNPcFDUGkjkd4/AWvJxV9R0RGuvD5IwY/QVlOEQpTXSqwfoFxA==
X-Received: by 2002:a50:a166:: with SMTP id 93-v6mr6239880edj.184.1532176004250;
        Sat, 21 Jul 2018 05:26:44 -0700 (PDT)
Received: from ZeroCool ([89.204.252.36])
        by smtp.gmail.com with ESMTPSA id s23-v6sm2307913edm.74.2018.07.21.05.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 05:26:43 -0700 (PDT)
Date:   Sat, 21 Jul 2018 13:26:41 +0100
From:   Mark Railton <mark@markrailton.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: pi433: rf69: fixed a multi line comment issue
Message-ID: <20180721122641.GA7556@ZeroCool>
References: <20180719214318.388-1-mark@markrailton.com>
 <20180721065321.GB24909@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721065321.GB24909@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 08:53:21AM +0200, Greg KH wrote:
> On Thu, Jul 19, 2018 at 10:43:18PM +0100, Mark Railton wrote:
> > Fixed a coding style issue
> > 
> > Signed-off-by: Mark Railton <mark@markrailton.com>
> > ---
> >  drivers/staging/pi433/rf69.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
> > index 90280e9b006d..14826fb505dd 100644
> > --- a/drivers/staging/pi433/rf69.c
> > +++ b/drivers/staging/pi433/rf69.c
> > @@ -618,7 +618,8 @@ bool rf69_get_flag(struct spi_device *spi, enum flag flag)
> >  	case fifo_full:
> >  		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_FULL);
> >  /*	case fifo_not_empty:
> > - *		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_NOT_EMPTY); */
> > + *		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_NOT_EMPTY);
> > + */
> 
> Ick, just delete this whole thing if it isn't being used, don't make it
> prettier :)
> 
> thanks,
> 
> greg k-h

Apologies, should have realised that to begin with. Have sent a new
patch with the correct change.

Thanks,

Mark
