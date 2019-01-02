Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6447DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2426F218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="dpwcP/BQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfABLQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:16:06 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45022 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbfABLQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:16:05 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so25811104edd.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 03:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rtFVI3fk/KkfKLAmAe8eL9UhZGNuM1DrGCtJlY3CQwc=;
        b=dpwcP/BQzjGa2oNExz0Nt5RlVigZFpoHr1xpCrAHvfS59eLxU30pjZ361gE3xXvNX0
         e6eQfiQF1khldD2B8cYUtedeSPefpc4FOQtuabl8I2QS/ER/UtGFyR5w/6Qi/WWfoFYh
         Qpr+bEf1SxXciyRUMDsjDSTrAloCuBA/HDJheADuEY2ZzZAw/lAmzP2XRWuXfFkREaHs
         wghNSBmxu20qBD7e2WWilMuWmyMk71/WFxoQuMiv56Lvrvt6VtUtFMUTc8Ir4oQb1Bnl
         2q+5083LM2SBzkh7eoWCf9+O2bsE8zGMvWdJ3dZIrQZAdSg96UPJipTDwRwSBnk/edBm
         ypyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rtFVI3fk/KkfKLAmAe8eL9UhZGNuM1DrGCtJlY3CQwc=;
        b=QXd1xuhsZ6H2QlujRVuuZc2IAFOsR2UKfq13lahLky3oRpmuV2CaogB3Ivvwzjnkud
         24A+we+kBMpoTptRU0z0yuUxXLke4WA3p54A4xiQzWnPLsN8Iy/QslD/+SNtN/CcUEj8
         l8zl7BN8Io44UcUfItkYrItm8hXZYGxHq7ihnWQQRHXmkqUhczNQJ3vN7DQOEDLWEgtY
         eZEXeFzQMKZ/VSVHP1r+leu2e1GESaZQ5Frh9sV+kQz26vtIurOyIfBZJn+5JoM/tO/7
         HsEpuBrByqNodxLM5EQrsev1dt5Ksdk+E9UOzYyM52gpm7mbGVVLwUjfYVZKK5SFgNOz
         9hwg==
X-Gm-Message-State: AA+aEWapXGjL7Clg3zhEo6+jzVveCukXlcn8KAYZdAnIhvYMJsym/MRN
        xdhkNnO0XF0UmDKNi+rZz5duyX2c0wM=
X-Google-Smtp-Source: AFSGD/Uel86CkkY/E5TKn4626ej24F9IsFKA9trNxkaW5wWNxvsNxTX30q7oyEPSI0h5FmoBgywEQA==
X-Received: by 2002:aa7:c594:: with SMTP id g20mr36752575edq.79.1546427763978;
        Wed, 02 Jan 2019 03:16:03 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:d6c:700b:b2fa:de8a:175d])
        by smtp.gmail.com with ESMTPSA id v20-v6sm12076682ejr.46.2019.01.02.03.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 03:16:03 -0800 (PST)
Date:   Wed, 2 Jan 2019 12:16:02 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, arve@android.com, maco@android.com,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v1 1/2] binderfs: implement "max" mount option
Message-ID: <20190102111601.gvvxtfw7kg64rczf@brauner.io>
References: <20181223143550.10672-1-christian@brauner.io>
 <20190102091731.GB3781@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190102091731.GB3781@kadam>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 12:17:31PM +0300, Dan Carpenter wrote:
> On Sun, Dec 23, 2018 at 03:35:49PM +0100, Christian Brauner wrote:
> >  static inline struct binderfs_info *BINDERFS_I(const struct inode *inode)
> > @@ -110,10 +132,16 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
> >  
> >  	/* Reserve new minor number for the new device. */
> >  	mutex_lock(&binderfs_minors_mutex);
> > -	minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR, GFP_KERNEL);
> > +	if (++info->device_count <= info->mount_opts.max)
> > +		minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR,
> > +				      GFP_KERNEL);
> > +	else
> > +		minor = -ENOSPC;
> >  	mutex_unlock(&binderfs_minors_mutex);
> > -	if (minor < 0)
> > +	if (minor < 0) {
> > +		--info->device_count;
> 
> Isn't this decrement supposed to happen under binderfs_minors_mutex?

Indeed. Good catch!
Leftover from when this was an atomic_t.

Thanks!
Christian
