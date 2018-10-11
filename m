Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09FCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662572086D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxFdIFNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662572086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbeJKHsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:48:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40770 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeJKHsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:48:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id 1-v6so3293432plv.7;
        Wed, 10 Oct 2018 17:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SZGhp7orgzcPxPac4+YIqRAzHlrD99to0F7TKPZOTHw=;
        b=kxFdIFNti8R3Gr/F9Zu7+uJyzD2S17RtjFx79cLOrnsdrBu02icQxyBlvygWjuRFFR
         x0436B+AkRia9BKlYVt2eHaLj8RrqHhmmxEPf+mL/RtHY+5BGA68u7hA0nGMbml9nCfq
         XeaQDDt059xCYQqQptIZVd8vR5MZmbdI0b0A/diHp15L2E2k0Ac7dbaE1qe792l0mzA/
         FohJr2DIsYr83yQM4o7tkBftnbjvSlEGLk/2HPLkbv4VK3Kml7nn2mPltuXATimYFoli
         +siCkzzKBLboY67L2y6yiu8xBI2Vbzuf/WwUxYLbNThXxnaHH6Jkp7yrz4nT6vBRihaq
         PYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SZGhp7orgzcPxPac4+YIqRAzHlrD99to0F7TKPZOTHw=;
        b=KMGEP0vhAKXvxSs+70S32vNdzenB2g9mmNqYihIyaGm8iQant6yHIi7R119XLN/OSr
         rGVYmaFa7XetLczeYbwOnuJhu7EMBNfsJag8RCcH7UmoJn3jWtOdRsKP06ztTt3Tglno
         nzkAg2fPbg5YZf4EqlxgXzcO3SaidCvMGAuZEl/WG3fLPNQFt7wsphH/CYCygHuIh86w
         0L1FHUomRTv9DwcZK2QxDPoxF1vI8KCynereSNY1YUfzyLWqX01h+nlh8oCxcn4YdIbZ
         pA2PCD6p87ZSWRcmUjR551WkczJwuI6xTzg3FN5jlEFrppebln0R/hfaiEbGh0nHFh6A
         8CwQ==
X-Gm-Message-State: ABuFfojRAtFNvHf6OSsEZxqIW4CaO+dqYi++nLQ77sscntt9Rvzu+/Nk
        Q1RDBZvBOH/8Vm79Qi0pZms=
X-Google-Smtp-Source: ACcGV60/ilmvzimZvtp+1Jxpy9DHn2MUknTFe9E6SG+Zgxz2ZKNy04Ry12iMccifOtkHVuBTnDBloQ==
X-Received: by 2002:a17:902:850b:: with SMTP id bj11-v6mr35656183plb.107.1539217456742;
        Wed, 10 Oct 2018 17:24:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e134-v6sm33506191pfh.26.2018.10.10.17.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:24:16 -0700 (PDT)
Date:   Wed, 10 Oct 2018 17:24:12 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (ina3221) Add operating mode support
Message-ID: <20181011002411.GA10379@Asurada-Nvidia.nvidia.com>
References: <20181010043310.30873-1-nicoleotsuka@gmail.com>
 <20181010043310.30873-3-nicoleotsuka@gmail.com>
 <32c22986-544e-aca1-12bf-9080667cf499@roeck-us.net>
 <20181010230906.GB1706@Asurada-Nvidia.nvidia.com>
 <20181010234300.GA25480@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010234300.GA25480@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Wed, Oct 10, 2018 at 04:43:00PM -0700, Guenter Roeck wrote:
> > > The effort to do all this using CPU cycles would in most if not all cases
> > > outweigh any perceived power savings. As such, I just don't see the
> > > practical use case.
> > 
> > It really depends on the use case and how often the one-shot gets
> > triggered. For battery-powered devices, running in the continuous
> > mode does consume considerable power based on the measurement from
> > our power folks. If a system is running in a power sensitive mode,
> > while it still needs to occasionally check the inputs, it could be
> > a use case for one-shot mode, though it's purely a user decision.
> > 
> That would actually be a use case for runtime power management.
> The power used by a modern sensor chip is miniscule compared
> to the power consumed by other components in the system,
> which may explain why no one bothered looking into runtime
> power management for sensors.
> 
> This is also an argument against any device or subsystem specific solution:
> Users will want to be able to control power consumption for all devices
> in the system, not just for sensors. A device specific power control
> mechanism would, from user space perspective, be a nightmare.

That makes sense to me. Actually we wanted a solution more on the
driver side so that user space doesn't need to be involved. But our
downstream solution (switching different modes when certain number
of CPUs get hot plugged in/out) wasn't accepted years ago by other
subsystem maintainers, being commented that it's a user decision,
IIRC. So I thought that having a sysfs node might be a generic way
for "user decision". But I guess I should have tried to seek for a
solution in the kernel like runtime PM as you said.

> > > power-down mode effectively reinvents runtime power management (runtime
> > > suspend/resume support) and is thus simply unacceptable.
> > 
> > Similar to one-shot, if a system is in a low power mode where it
> > doesn't want to check the inputs anymore, I feel the user space
> > could at least make the decision to turn on/off the chips, I am
> > not quite sure if the generic runtime PM system already has this
> > kind of support though.
> > 
> Please look up "runtime power management". It provides the basic
> mechanism to turn off / disable a device if it is not used. The point
> here is that the basic mechanism is there, even though it may not
> be perfect. If it is not perfect, it needs to be improved.
> Implementing a per-subsystem alternate method would be the wrong
> approach.

I have implemented runtime PM suspend/resume in other drivers but
what I know is that it relies on someone to call get_sync and put
functions accordingly and it doesn't seem to have built-in system
level low-power or power-sensitive mode for those use cases that
I mentioned previously. But I agree with your point and will take
a closer look.

One more question here, and this might sound a bit abuse of using
the existing hwmon ABI: would it sound plausible to you that the
driver powers down the chip when all three channels get disabled
via in[123]_enable nodes? :)

Thanks
Nicolin
