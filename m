Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D277DECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8113A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkzZRnBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8113A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeJYCXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:23:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33602 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYCXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:23:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id z2-v6so2691828pgp.0;
        Wed, 24 Oct 2018 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5E/SLD3zvXkmRZmRVY3YzYigx55SojYgK5wKWNP+0+s=;
        b=NkzZRnBQzDR7tcL0ngfmIWyrn1rtsWKB0UthhoNgI2EZHvS7Wo1/S214L4n8wvvbUi
         L047W41hQ5BzWVO/erVdZKoQ/RX5pff/bak41iusWTwvEc0uixilMQM4ZlnnCfQ9+8av
         dQ1D/BU8HHgyNin5nnqai2C39AEYEaSwobJmeMm0eRZChkDYI2WU6f67KsGK5r7aY6Qy
         6tj7Q3kySuFKDxfZgVZD8KygsgpH3icI8T7Bl9Zzp1UnkgFcuv4ihMtsm2D8miWpYjlY
         7JEk8cIJnt8vqisG2ahKqdq30LuPi8ZYYSfMUS6HUzd/W82UEiD3YBsvNldJOHjiEetj
         mJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5E/SLD3zvXkmRZmRVY3YzYigx55SojYgK5wKWNP+0+s=;
        b=kCz2ANl3/kySJbv3/Nvp/Tfp4zVwVX9HvxCErJwH8EAZtjPcidMMJaKyAZVDyTmkwG
         rmy4kRcOo3jFTk74qjVHKazshkfSZdhMkMKpzmcNXFpCaw6rfi3ho08jJonRvtxxLxMc
         kz5PCqEOkYdUwP6/KzEzwq76Zt5D4oVqV0/7sgBvVYOEYZdv80Mg5RuNWwyqih/GLjHx
         2tVvrcbIdx3W0IUlgcmtyIAysvGLD1d2B21kRBX6Fb/nKZ8jfELxN3QQwfOaT40v/EY4
         KfR8W20vHayvPYTPVk16T4BjiRhMaIF3p+c6/6WSRhgEZYwYt1QyXBSLi6VLJ7owETo2
         9dAg==
X-Gm-Message-State: AGRZ1gLeJXryYKtpqUlhwks5+wejI8suvrCJyoK8PGTyj19gDNTPrRv8
        1pQ8TOCV7jEizFGe9sdWtkSi28BW
X-Google-Smtp-Source: AJdET5e6Qcu+Slvktahnr9ghtuCc64Fo9CV/lm7Qa2PxzAap+DItBksV60UORM2LULba3yNnwoN9Mw==
X-Received: by 2002:a63:121b:: with SMTP id h27-v6mr3533208pgl.120.1540403644476;
        Wed, 24 Oct 2018 10:54:04 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id d2-v6sm6651402pfd.100.2018.10.24.10.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 10:54:04 -0700 (PDT)
Date:   Wed, 24 Oct 2018 10:54:00 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] hwmon: (ina3221) Make sure data is ready before
 reading
Message-ID: <20181024175400.GA6374@Asurada-Nvidia.nvidia.com>
References: <20181024023623.4231-1-nicoleotsuka@gmail.com>
 <20181024023623.4231-5-nicoleotsuka@gmail.com>
 <20181024091035.Horde.F-g3MefpEv95EQd6w9-rB3D@cp2.active-venture.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024091035.Horde.F-g3MefpEv95EQd6w9-rB3D@cp2.active-venture.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 09:10:35AM +0000, linux@roeck-us.net wrote:
> > @@ -150,6 +183,12 @@ static int ina3221_read_in(struct device *dev, u32
> > attr, int channel, long *val)
> >  		if (!ina3221_is_enabled(ina, channel))
> >  			return -ENODATA;
> > 
> > +		ret = ina3221_wait_for_data(ina);
> > +		if (ret) {
> > +			dev_err(dev, "Timed out at waiting for CVRF bit\n");
> > +			return ret;
> > +		}
> 
> Thanks for explaining why we can't just blindly wait.
> However, I am concerned about this log message: If something is wrong
> with the chip, this will spam the kernel log. Can you drop the message
> here and below ? After all, the error will be reported to userspace,
> and a kernel log message should not be necessary.

Will do that.

Thanks
Nicolin

> 
> Thanks,
> Guenter
> 
> > +
> >  		ret = ina3221_read_value(ina, reg, &regval);
> >  		if (ret)
> >  			return ret;
> > @@ -189,6 +228,13 @@ static int ina3221_read_curr(struct device *dev,
> > u32 attr,
> >  	case hwmon_curr_input:
> >  		if (!ina3221_is_enabled(ina, channel))
> >  			return -ENODATA;
> > +
> > +		ret = ina3221_wait_for_data(ina);
> > +		if (ret) {
> > +			dev_err(dev, "Timed out at waiting for CVRF bit\n");
> > +			return ret;
> > +		}
> > +
> >  		/* fall through */
> >  	case hwmon_curr_crit:
> >  	case hwmon_curr_max:
> > --
> > 2.17.1
> 
> 
> 
