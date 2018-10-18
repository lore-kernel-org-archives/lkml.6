Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2100AECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBAD21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHDrm/ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBAD21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeJRJCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:02:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37905 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeJRJCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:02:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id f8-v6so13347558pgq.5;
        Wed, 17 Oct 2018 18:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UY62mvqtM/unYgUND7INQVh8XrI3/TzTd+hVtlDZBjw=;
        b=nHDrm/cePdB+gNG0y6XN3Vk/ryGpJhsyB+gHbxHCiZ+jWeD2SOI6EW+/tPHKPZgt8i
         TWemFTszC+8oXQGOJh/diZHhL4FUSy9l3QdOvu2eTBcDtGNMSnrMoSIqJTL1gGiA8xRn
         aAOX8ROuCH1yXqNoapryndhkcQN0mN5RvfLM4pE3Mv9/fH7yc5zSoTewJWWJtBVp4+wm
         a8/+Xe8EGZbbX49xOOV2c6Qb77vbeZoHcsTifxXDJdrwy2N0+a+poCnl4wt7+M0vM3QB
         HEtAcWzE7FZQ1fkMGM9uwaw2BY4JyOGjDWsjAFgScaW8ubt7KKZc+6/EM9djW0xYUFy8
         rldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UY62mvqtM/unYgUND7INQVh8XrI3/TzTd+hVtlDZBjw=;
        b=LJWxw0gIU8afNRBTIrPqe1qez7KUmAW2sUAoywbJ9NEH+BRAapyDUqnwRSyjj5yRKV
         g+Lg7XIt7ARkkFbLGTV5BptNYqb4Z2Qgu4rxdKzXsfw7MyyHWQQRDhUSw9PfFAdws6ZI
         6SfL+LtkXtQ4lRZlRyQfQT/f0WnJg2msBNmyz70uS6vEQc16oEuQaEcKOlZzItiA0uyT
         5M/lwvxazkgRMYlbtGDXA00f/8QHElKtej76ar800hTLWGCffITK+lN1nz26j/UWzyWY
         DXgobXzvQAF/AP0MmGrVtIWDLBGyJBUBZZllRPdPj9GPWcNhIA/wkDzSAgskX/UXlQlc
         bw6g==
X-Gm-Message-State: ABuFfoil/jy0Zpuw81V0i9CF0EheXM9yKIgGL5nhgKWbOS/frpmYTVeI
        9iE0/S/K0VNw0zlW8/oE7KuqDeL6
X-Google-Smtp-Source: ACcGV62QQmuwB6UOcXDcKw8zPJzr/R98Gph7Xc1GzDb6hceHR9MYeLkjMe+y7rcbJtXKB27jBwQbSQ==
X-Received: by 2002:a63:541e:: with SMTP id i30-v6mr26665068pgb.413.1539824622314;
        Wed, 17 Oct 2018 18:03:42 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j19-v6sm20859283pfi.137.2018.10.17.18.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 18:03:42 -0700 (PDT)
Date:   Wed, 17 Oct 2018 18:03:35 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] hwmon: (ina3221) Return -ENODATA for two alarms
 attributes
Message-ID: <20181018010335.GA15221@Asurada-Nvidia.nvidia.com>
References: <20181017012426.26958-1-nicoleotsuka@gmail.com>
 <20181017012426.26958-3-nicoleotsuka@gmail.com>
 <20181017194605.GB6812@roeck-us.net>
 <20181017203917.GB15941@Asurada-Nvidia.nvidia.com>
 <20181017211426.GA10990@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017211426.GA10990@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 02:14:26PM -0700, Guenter Roeck wrote:
> On Wed, Oct 17, 2018 at 01:39:17PM -0700, Nicolin Chen wrote:
> > On Wed, Oct 17, 2018 at 12:46:05PM -0700, Guenter Roeck wrote:
> > > On Tue, Oct 16, 2018 at 06:24:23PM -0700, Nicolin Chen wrote:
> > > > There is nothing critically wrong to read these two attributes
> > > > without having a is_enabled() check at this point. But reading
> > > > the MASK_ENABLE register would clear the CVRF bit according to
> > > > the datasheet. So it'd be safer to fence for disabled channels
> > > > in order to add pm runtime feature.
> > > > 
> > > > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > > > ---
> > > >  drivers/hwmon/ina3221.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> > > > index d61688f04594..3e98b59108ee 100644
> > > > --- a/drivers/hwmon/ina3221.c
> > > > +++ b/drivers/hwmon/ina3221.c
> > > > @@ -200,6 +200,8 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
> > > >  		return 0;
> > > >  	case hwmon_curr_crit_alarm:
> > > >  	case hwmon_curr_max_alarm:
> > > > +		if (!ina3221_is_enabled(ina, channel))
> > > > +			return -ENODATA;
> > > 
> > > Makes sense, but can you check what the sensors command does with this ?
> > 
> > Not quite understanding the question. Do you mean the user case
> > causing the race condition -- wiping out the CVRF bit?
> > 
> No. Question is what the "sensors" command reports if reading the alarm
> attribute returns -ENODATA. If it reports an error, we would have a regression.

I see. I will return 0 instead.

Thanks
Nicolin
