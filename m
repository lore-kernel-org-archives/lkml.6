Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BD9ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766A0204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMXsc05H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766A0204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeJREgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:36:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33261 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeJREgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:36:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id 78-v6so11375459pfq.0;
        Wed, 17 Oct 2018 13:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=shlcZbQuTf7r78BCoHEmmHt1QYCsX/LLQU4uV4byB0w=;
        b=AMXsc05HbZfD0StBfN6o3kWpzR2fln1q4bUdprm6QlQAxcWOfIpGfzyYOiuY7e3mO3
         GIpL1ryK+2YvOCRNDe2cdRBJA6EfOVnwftzC7zUJkyQlXnSXK3O/ITe9xg930Un38Zx1
         QDCutUUHjQYbb2AbEfNKKEaPSz5q0kXwtTWuj/sOnFeMIAoov+SHCGd+6sqFL5Ow1bxR
         H4xmfuAICjWbaRDjXHd38sXiHSjTmODlIZoxeQ3zemyR390+apXSey2xo1BnAEE5320p
         bQGrExSIR9qjWnkrDeapBViatnhXdS0kGphCw+cNQB+eMJgbuQF3tFHmiCnppLswY8QD
         RGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=shlcZbQuTf7r78BCoHEmmHt1QYCsX/LLQU4uV4byB0w=;
        b=gYyMcuFcgnO560JgbPO0q4beLUDlTM1C3LveL+ARumI8UnoWJJcjNcgqh8nEKxcJ+Y
         7ykroie/YSCij1bI1WD3Rfr6cqZhdQL/L1FLPNchPPcKScjGjVC8g4nIDKcmsZGQuOFy
         x8O8IYu/SZBYDpOKsIwyJRdIWqPBcCVDFP8BiNYIczB1b82IxVdTSteTkbwq0Oz21q2F
         T+/qWwcbtcaGdhbmhbiUnBE/72uzUCVW/iZfnjr14VdS/wwXiujL3rr2eMAsygscVon6
         Cv8qT42iUTdq8u2KEKYrPzDwXiO0BcsiHeC/UIBkXILXmJb6zk/iCqtEfbmuR0N/xs4R
         u+cQ==
X-Gm-Message-State: ABuFfojg6wqwo1PUOdqUi2x6/Pnp8Pg5gzCfmjCf6271ndz+u8tmV/3T
        bzC+EIuMMdQd8mYgf+f91qvSCJHQ
X-Google-Smtp-Source: ACcGV6265FkFpcIsQoAtA94DB6lBphLDyQgdzzuBocL3698KXER9H+wlylAUinCKzNGg+6MApfz6vQ==
X-Received: by 2002:a63:6307:: with SMTP id x7-v6mr2640893pgb.196.1539808759910;
        Wed, 17 Oct 2018 13:39:19 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x73-v6sm25244436pfk.139.2018.10.17.13.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 13:39:19 -0700 (PDT)
Date:   Wed, 17 Oct 2018 13:39:17 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] hwmon: (ina3221) Return -ENODATA for two alarms
 attributes
Message-ID: <20181017203917.GB15941@Asurada-Nvidia.nvidia.com>
References: <20181017012426.26958-1-nicoleotsuka@gmail.com>
 <20181017012426.26958-3-nicoleotsuka@gmail.com>
 <20181017194605.GB6812@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017194605.GB6812@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:46:05PM -0700, Guenter Roeck wrote:
> On Tue, Oct 16, 2018 at 06:24:23PM -0700, Nicolin Chen wrote:
> > There is nothing critically wrong to read these two attributes
> > without having a is_enabled() check at this point. But reading
> > the MASK_ENABLE register would clear the CVRF bit according to
> > the datasheet. So it'd be safer to fence for disabled channels
> > in order to add pm runtime feature.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >  drivers/hwmon/ina3221.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> > index d61688f04594..3e98b59108ee 100644
> > --- a/drivers/hwmon/ina3221.c
> > +++ b/drivers/hwmon/ina3221.c
> > @@ -200,6 +200,8 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
> >  		return 0;
> >  	case hwmon_curr_crit_alarm:
> >  	case hwmon_curr_max_alarm:
> > +		if (!ina3221_is_enabled(ina, channel))
> > +			return -ENODATA;
> 
> Makes sense, but can you check what the sensors command does with this ?

Not quite understanding the question. Do you mean the user case
causing the race condition -- wiping out the CVRF bit?

> If it bails out I'd rather have the code return 0 and no error (after all,
> the sensor is disabled, so any alarm would be bogus).

That's true. Since they are alert flags, should return 0. I will
fix it.

Thanks
