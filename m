Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA4EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF230208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJIVNUy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF230208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeHWUqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:46:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41110 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeHWUqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:46:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id h79-v6so2227475pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/b5DGKgbsGa2eyho5iQowptrXGF1VQmgpVBStg9QnAk=;
        b=HJIVNUy+IubfFAYNyBxyXVQCslussjDZ0dGi6Zp298JEhaq39rNhP+KD+uOYMJJobY
         3s26/e4sPUAt/94jCk5v4h/WqPiqqdtJvqfEEuwgih2QqIz+lq+r6Qz+MlNlIZgey68U
         cDO0FBfA0X09zwhsHxjQWK/AkWA9B5ieIIT+Gc+XQEeggN5NeMfsAUKde/kUvBZ6POA/
         qC+y0vJ10co5ftcQTdZ1A+/eKucBsbVeN3cTb+KeyIFeDdfKmRnd5su8ZIYJInkbHzjD
         TxNmClZuyuHMz2y6pX1bSBA3tjFfIdhrsN+ZtlOGMwRP+nTw+advHEkkW/LI277jlI5W
         QOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/b5DGKgbsGa2eyho5iQowptrXGF1VQmgpVBStg9QnAk=;
        b=h8WZ+DT8nIyE45Ch8Q+vwLqC6lMxHHnhwVC0N4ZyIF3NQ1EsulUNUkqxLqKMnM4wcy
         0ZFmmV0Z+86s/tpYyLbr4NTI9xxEpSH0uNx77cOLTZZXoPe1SzSpd1wwsGtz8utdIBBE
         G5QPlji5aIQsJGWch64CVtxDcmTH8yWNrhVL0D0LcMiITNEk8cRPuBsb7X7a5zFLwamg
         D/WwOq87XvlEFEe4eGqTZrHsNLN6duRy/u+XeQz4RoGSFqyqqyz79a6RnenkmGkcujpW
         YREuanjdBKma5/e6z/t0iOFBJtUNotsZZgCHXsec2mYEjr0ZNsXEd97m68MdaXL0fvrV
         Bxbg==
X-Gm-Message-State: APzg51BRPVnNVILXvIzMGcLOgMZbt5SAeObmVD6R55Ft9/7cY+0P3T4u
        /V/CIzti9KWgYB29IapbSCI=
X-Google-Smtp-Source: ANB0VdZaY7XouWJM7U4aGjANHQAcEJ8ahaupd6AqolGBgInrbuvPRHHu/PWIN6PM/ECXQZS7rtFuAw==
X-Received: by 2002:a17:902:b201:: with SMTP id t1-v6mr471653plr.84.1535044565847;
        Thu, 23 Aug 2018 10:16:05 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id 1-v6sm7833435pfm.145.2018.08.23.10.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 10:16:05 -0700 (PDT)
Date:   Thu, 23 Aug 2018 22:45:58 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v4 2/4] staging: mt7621-mmc: Fix debug macro ERR_MSG and
 its usages
Message-ID: <20180823171557.GB18185@nishad>
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
