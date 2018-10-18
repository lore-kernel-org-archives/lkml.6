Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC25ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAE121473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzIcd8Ej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAE121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeJRJCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:02:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41093 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeJRJCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:02:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so14031983pfi.8;
        Wed, 17 Oct 2018 18:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kNqAjg08tKISgqKowhYOCOdMSZmLsMJyv5NnjUEsWC0=;
        b=JzIcd8EjNbihqjbzuBGkzNz6XrUaQToc4QfrSSMFYiU7f3zLXwD4P+ZYGUQXrdnSHB
         e59yGaUpfUyzsfflNAnsZDtWm+RZHQAewLA+X11BV4tp+P5/oly+FRzMbg+tp4dBrDDD
         TWG8jpvds1cpilaaWK+xtZe59+KVcYCsWyD8hLp/T7pPv4yM4T4vonCCEvTaFfJ3AlLs
         PaE4UDI+nP1gilqrZZA063lJ5dQVFQLrVKiCtL51lNj6xOTK8l+egUO84cHuzKilaidn
         Bp3ywi9/tpYYeBDOW50QFFzZ9nSrNFI7B3ZlBtJTA/GgCA4s0bqaeUs5PAPXx8b606HH
         BvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kNqAjg08tKISgqKowhYOCOdMSZmLsMJyv5NnjUEsWC0=;
        b=Qj1N30TlcyXqJaCHP94GsL75EIT7UDMEOmtpgkuHlX044ZIAs4QPjEjmWjc7rFzR12
         6hW1dvcOFV6WY8b/oE6tTnt0XH511Y2QUNopD3Uuq26khcwTqJQVzwqHdBvwrFNkm7K+
         TpamjN2Uz80z83BbzTkhoKi9wu5Tf+yD4bLYzRL9+cvA47yhfaNGA1kQ5HBUf3LA+5bg
         7U6dbJ0hmIBy8//KpMuNzUxYcGijFFluJbHVvjHmcAEPtTiuysclPPggvNJ8ByVxE6ZC
         7s7iCpJbjuJANmsZZK4AiCNnkwI+K7oIr76tGEfEWRoQ4NqhkTQThRYFcYeDf682dL7P
         ZChw==
X-Gm-Message-State: ABuFfoglsLEKA7LZ6v+XbIbGoPhTvPMPdgbICFmwsRRJHkQgNzzbc+vg
        AA280JWE+zYIyM4RNYclro0=
X-Google-Smtp-Source: ACcGV63sbPVFab4DZJxLUOMASB0HpmB8iDnrfi6+H9hhNq/7n3KQcXi6fjjdS3lpKIxmpMTEuT+P6w==
X-Received: by 2002:a62:f715:: with SMTP id h21-v6mr27812935pfi.169.1539824660597;
        Wed, 17 Oct 2018 18:04:20 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id h5-v6sm12242498pgh.42.2018.10.17.18.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 18:04:20 -0700 (PDT)
Date:   Wed, 17 Oct 2018 18:04:18 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] hwmon: (ina3221) Make sure data is ready after
 channel enabling
Message-ID: <20181018010417.GB15221@Asurada-Nvidia.nvidia.com>
References: <20181017012426.26958-1-nicoleotsuka@gmail.com>
 <20181017012426.26958-5-nicoleotsuka@gmail.com>
 <20181017165543.GA22822@roeck-us.net>
 <20181017205348.GC15941@Asurada-Nvidia.nvidia.com>
 <20181017211714.GB10990@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017211714.GB10990@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 02:17:14PM -0700, Guenter Roeck wrote:
> On Wed, Oct 17, 2018 at 01:53:48PM -0700, Nicolin Chen wrote:
> > Hello Guenter,
> > 
> > On Wed, Oct 17, 2018 at 09:55:43AM -0700, Guenter Roeck wrote:
> > > > @@ -676,6 +701,13 @@ static int __maybe_unused ina3221_resume(struct device *dev)
> > > >  	if (ret)
> > > >  		return ret;
> > > >  
> > > > +	/* Make sure data conversion is finished */
> > > > +	ret = ina3221_wait_for_data_if_active(ina);
> > > 
> > > This is quite expensive and would delay resume (and enable, for that matter).
> > > A less expensive solution would be to save the enable time here and in
> > > ina3221_write_enable(). ina3221_wait_for_data_if_active() can then be called
> > > from read functions and would wait if not enough time has expired.
> > > 
> > > 	if (time_before(...))
> > > 		usleep_range(missing wait time, missing_wait_time * 2);
> > > 
> > > or something like that. This could be done per channel or, to keep
> > > things simple, just using a single time for all channels.
> > 
> > I was thinking something that'd fit one-shot mode too so decided
> > to add a polling. But you are right. It does make sense to skip
> > polling until an actual read happens, though it also feels a bit
> > reasonable to me that putting a polling to the enabling routine.
> > 
> > The wait time would be sightly more complicated than the polling
> > actually, as it needs to involve total conversion time which may
> > vary depending on the number of enabled channels. I will see what
> > would be safer and easier and apply that in v2.
> > 
> It isn't that complex; we have done it in other drivers. It is less
> costly and has less overhead than extra i2c read operation(s).

OK. Will follow them in v2.

Thanks
Nicolin
