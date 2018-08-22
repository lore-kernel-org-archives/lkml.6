Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39690C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E375921525
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4/SHEgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E375921525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbeHVOl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:41:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36752 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbeHVOl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:41:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17-v6so790223pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 04:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/b5DGKgbsGa2eyho5iQowptrXGF1VQmgpVBStg9QnAk=;
        b=k4/SHEgISPITDfAeryUbQpWt6uw6pU+N7Jn+LlHOCOr2VeT9zr4qH6+3VDIjjYEQF5
         4lfCe/MXmVtwybd+EhA26qod+MIgYwHwMFMzXaibdpYGAWExLZCigBfLiGw+7R/FgzBY
         XzPRBZQxtPxNF96aCU1t/eJYCKnddvNaG3DXhB3usb6k9M0fLsGdoDBMzQ7n5fL8MuTg
         qGQTel36CKigv6gZtPLGyCkeUyRfLN+Q4ULXtEd9JGJIoIrNlDQUaTCwzmYOfp6TSBkP
         gFESGgQyyuwJC8/miSyK4FhgC5XTUi6OdhiSZXMgLeK47MPsx5fJ/FSy4iLd71BiwgTV
         HCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/b5DGKgbsGa2eyho5iQowptrXGF1VQmgpVBStg9QnAk=;
        b=kskTv6PkeelxDeUsZpr2pB71PLmLFhhkoO2aHbS55T+eFzMuWj4oCg224dvKqlEGsW
         WRS7W7JkihmM5ONR3mXJ2rrBjPg4z+F9LmaAx56Maq9MDp3cRkMrEodvC2Cw9kiGjbLY
         ieJldmhJhxJxtNfGGgtcYnBPhGFFgWzjbOOcGKpJTU12lwKH/99Rgwakd/4e5jrxFMM/
         PLSlr5wDLPH1IRGjsXTI9OPqYZ6oGj6S8Ypvg1xAtFZVrRnOYJz1bUBlubqaJMVwkI4X
         NfqoJmZ+kivAoIWFKDgkF2UiGDp9DvxDhHwGt79Pg6hZx5f/NXmi174g5VW2bilCqTk5
         xLvw==
X-Gm-Message-State: AOUpUlE7FIsEHS54dOKJUYQBmv7XwR2fSQaxRo21toI6Ef3UO6oiJCMV
        Yhf//5tGwL+FqWSUe4qDp7U=
X-Google-Smtp-Source: AA+uWPx9rTEb+MJ7xQQwETIq/wGmA0tQ+z3H01bJft3BGmuHHZpW8G5wX2F8ZbBhUWJ+fBjcZ4xq3g==
X-Received: by 2002:a62:41d6:: with SMTP id g83-v6mr57180815pfd.219.1534936617138;
        Wed, 22 Aug 2018 04:16:57 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id a72-v6sm3618303pge.85.2018.08.22.04.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 04:16:56 -0700 (PDT)
Date:   Wed, 22 Aug 2018 16:46:50 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     i Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        NeilBrown <neil@brown.name>, Joe Perches <joe@perches.com>,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v4 2/4] staging: mt7621-mmc: Fix debug macro ERR_MSG and
 its usages
Message-ID: <20180822111649.GA2766@nishad>
References: <cover.1534923403.git.nishadkamdar@gmail.com>
 <52fcb157ea0de00e7c08d90ebd8a5c1db3c33bae.1534923403.git.nishadkamdar@gmail.com>
 <20180822091342.kngqyebexaboo25g@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822091342.kngqyebexaboo25g@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 12:13:42PM +0300, Dan Carpenter wrote:
> On Wed, Aug 22, 2018 at 02:13:07PM +0530, Nishad Kamdar wrote:
> > diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> > index 04d23cc7cd4a..6b2c72fc61f2 100644
> > --- a/drivers/staging/mt7621-mmc/sd.c
> > +++ b/drivers/staging/mt7621-mmc/sd.c
> > @@ -466,7 +466,8 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
> >  	//u8  clksrc = hw->clk_src;
> >  
> >  	if (!hz) { // set mmc system clock to 0 ?
> > -		//ERR_MSG("set mclk to 0!!!");
> > +		//dev_err(mmc_dev(host->mmc), "%d -> set mclk to 0!!!\n",
> > +		//	  host->id);
> 
> Just delete commented out code.
> 
> >  		msdc_reset_hw(host);
> >  		return;
> >  	}
> 
> regards,
> dan carpenter
> 

Ok, I'll do that.

Thanks for the review.

regards,
nishad
