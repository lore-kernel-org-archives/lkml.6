Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2E3ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C6F214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le1GbbPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C6F214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeIWPbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 11:31:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39610 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeIWPbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 11:31:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so7804000pff.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 02:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=853+wXPZXaA/y8zlhPk0YkJuJFJ+zrRWHOdlglJdZRY=;
        b=Le1GbbPa/IwZYnATAKC1apngF12WWDsKBagxvdtl5SzLzzBoOxW6Y1q9gSPeSoWFsA
         xZhEapusAttCXNiS20qV4abbDdtoG6JK1BAidNnnMNN7jYQ8Ty+Vtazf9A8GENfMox4N
         LU9RTo9LsA2Q/T/Rzn7ksGFmsS2A2ujIK4MDp+VJfvevz9H4z7VdnMnShW7N/VBndlJG
         b4ek9UlPGyo/WvXcEutG0jSnCQZI7zaISkU0FbXLPOrdVeFSKDHu/qddbHYPqvSWuEKk
         J9mG5PawH9a2lAs4hfje0ULyURguKoeE6e/bkCUlQDXl+r7WH/GWJFWTPNAB78j0riRe
         8oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=853+wXPZXaA/y8zlhPk0YkJuJFJ+zrRWHOdlglJdZRY=;
        b=M65ccFV2ZxYVq9ISOde5NcMOqvfSiSimPDA4ByghpPCrZT+WEx4kMWeH3RyKe8WBv9
         p1PmNJQrrJStlERSN8ugLBYwFzjJh/VpDNQIleQXWc1VOXJAllCl9oqw390Mvk9yByaH
         JmC/f4laJgmY+C2hNNdN+wcJGS95OttRdwiaNVBmaadKBjXcaRP1LHV0OUnzb/k1LTfV
         8P2DKGxZ/hEdxJXLZSxGwqGNI6AYDsdZACfqH+GwCWgay8h+nqiUWKI0rnzcAFsJUHOA
         MO5oc7qT/+aR5haABIEXXsdGuUoUFQqJsz8GoXJAatYR1W6Ds6XZdzIs9q32DXriRXiB
         HJiw==
X-Gm-Message-State: ABuFfoh8+CW7QoGpZkcYDiq5LnF5Z/MkVEKx5TFzLVwzzaKBlR62covi
        scr3E3DnnppIyJFkLhyr0Kc=
X-Google-Smtp-Source: ACcGV60wgLocEBEFStlWvJjg5KikV4ML1tIZrlGJb4Kk9j1Cona+zrJmdf+icFudLK5qv0vX5vGdjA==
X-Received: by 2002:a63:5ec5:: with SMTP id s188-v6mr5095540pgb.126.1537695259338;
        Sun, 23 Sep 2018 02:34:19 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id v126-v6sm1687269pgb.47.2018.09.23.02.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 02:34:18 -0700 (PDT)
Date:   Sun, 23 Sep 2018 15:04:12 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: mt7621-mmc: Remove do {} while (0) loop for
 single statement macro
Message-ID: <20180923093410.GA20551@nishad>
References: <20180915131748.GA19661@nishad>
 <20180918112711.GA14453@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918112711.GA14453@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 01:27:11PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Sep 15, 2018 at 06:47:51PM +0530, Nishad Kamdar wrote:
> > This patch removes do {} while (0) loop for single statement macros.
> > Issue found by checkpatch.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/mt7621-mmc/sd.c | 28 +++++++---------------------
> >  1 file changed, 7 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> > index 7474f9ed7b5b..ec12a3a5a926 100644
> > --- a/drivers/staging/mt7621-mmc/sd.c
> > +++ b/drivers/staging/mt7621-mmc/sd.c
> > @@ -104,14 +104,10 @@ static int cd_active_low = 1;
> >  /* gate means clock power down */
> >  static int g_clk_gate = 0;
> >  #define msdc_gate_clock(id) \
> > -	do {					       \
> > -		g_clk_gate &= ~(1 << ((id) + PERI_MSDC0_PDN));	\
> > -	} while (0)
> > +	(g_clk_gate &= ~(1 << ((id) + PERI_MSDC0_PDN)))
> 
> This should become an inline function, right?
> 
> 
> >  /* not like power down register. 1 means clock on. */
> >  #define msdc_ungate_clock(id) \
> > -	do {					    \
> > -		g_clk_gate |= 1 << ((id) + PERI_MSDC0_PDN);	\
> > -	} while (0)
> > +	(g_clk_gate |= 1 << ((id) + PERI_MSDC0_PDN))
> 
> Same here.
> 
> >  
> >  // do we need sync object or not
> >  void msdc_clk_status(int *status)
> > @@ -170,9 +166,7 @@ static void msdc_clr_fifo(struct msdc_host *host)
> >  	} while (0)
> >  
> >  #define msdc_irq_restore(val) \
> > -	do {					\
> > -		sdr_set_bits(host->base + MSDC_INTEN, val);	\
> > -	} while (0)
> > +	(sdr_set_bits(host->base + MSDC_INTEN, val))
> 
> Just call the one function where this is used and delete this #define.
> 
> Same type of changes for the rest of these as well.
> 
> thanks,
> 
> greg k-h

Ok. I'll do that.

Thanks for the review.

regards,
nishad
