Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4410C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495322086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoyfiSiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495322086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeJKHHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:07:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35073 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKHHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:07:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so3245180pgb.2;
        Wed, 10 Oct 2018 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y/ospkn93L347mrsbpw1MzaF6RU4CH2cmJUqRSLorso=;
        b=BoyfiSivkEQsLpVnhiX7unS3tAiOSniW8BkRlKw31dDpSsohSeTB1UYWAAIy+taciE
         uZpl8pcowRyXuyv/NC87FmtMMTP6j5CjZQk3qjdyTPsN1Vbr2nF/HiGNffe9rsHdT9GO
         jk8JnuLVUIsZ75t6++JBCmOJjgZ1alvcITtJgLYt7WMJYE7DEdxHjFuQBmAaA2urFJuU
         deIH8u18mhSoklmHzYHYLMr0UBJHzK55tkCMEB5YVzhFP9NSGPjpYADGBJ6ezDxSYFMV
         wWlHL8oCL7NmsMXSZr9ML6t60SRezCcR4XxCMrfFmYs1M4wA9lMgNSOkoWxXkwcHuEiv
         X1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=y/ospkn93L347mrsbpw1MzaF6RU4CH2cmJUqRSLorso=;
        b=i4gmT7e+B+2uI+IM7iRtfEJYbHYHP0sTucJFdlF5qmw33RqArCKL4w8I57+iMT1KpS
         pzdNH66Gy/AqJcqOTJp3L/uy5tjAGQijacvUNkgln/IumY7DvzI258PbElDSy7wRuGjz
         mOiSImLR8ReA63SbQ0heZBffD3lIrgueekpTXt8OKB1CFXRe856mo9c4FDo3IxzbcwiW
         dp2MDjnJxJKBEoV+HZG6mPWqmqLHpPsTf+2vGhxDm37+nYN37m5nNDZQuymjJYSGtBgT
         dConQakvPGv8myyT536XtEF8nPiqGUTSYfxqXV/FCYv/XaZ5x6sPim6yx7R0YRa/ZvuK
         7xWA==
X-Gm-Message-State: ABuFfoh7ol4xAobU6dUA5gd8CErT8XMwS9XF9V0Ii5oMJ/FX0LYgvL5G
        NXiWe3wElY7Ra0YLfgPG1X0=
X-Google-Smtp-Source: ACcGV61bw5NF3Z9O3/PWPbvbNuhIo1BBY8ckjrs2S6pFaCI1bs/QLWzuy1KhgHFZ0hrozNJ/DHSZ9A==
X-Received: by 2002:a62:9b9a:: with SMTP id e26-v6mr37959261pfk.181.1539214982499;
        Wed, 10 Oct 2018 16:43:02 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m15-v6sm35035753pgt.28.2018.10.10.16.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 16:43:01 -0700 (PDT)
Date:   Wed, 10 Oct 2018 16:43:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (ina3221) Add operating mode support
Message-ID: <20181010234300.GA25480@roeck-us.net>
References: <20181010043310.30873-1-nicoleotsuka@gmail.com>
 <20181010043310.30873-3-nicoleotsuka@gmail.com>
 <32c22986-544e-aca1-12bf-9080667cf499@roeck-us.net>
 <20181010230906.GB1706@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010230906.GB1706@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On Wed, Oct 10, 2018 at 04:09:07PM -0700, Nicolin Chen wrote:
> Hello Guenter,
> 
> On Wed, Oct 10, 2018 at 06:22:39AM -0700, Guenter Roeck wrote:
> 
> > > The hwmon core now has a new optional mode interface. So this patch
> > > just implements this mode support so that user space can check and
> > > configure via sysfs node its operating modes: power-down, one-shot,
> > > and continuous modes.
> 
> > One-shot mode on its own does not make sense or add value: It would require
> > explicit driver support to trigger a reading, wait for the result, and
> > report it back to the user. If the intent here is to have the user write the
> > mode (which triggers the one-shot reading), wait a bit, and then read the
> > results, that doesn't make sense because standard userspace applications
> > won't know that. Also, that would be unsynchronized - one has to read the
> > CVRF bit in the mask/enable register to know if the reading is complete.
> 
> I think I oversimplified the one-shot mode here and you are right:
> there should be a one-shot reading routine; the conversion time in
> the configuration register also needs to be taken care of.
> 
> > The effort to do all this using CPU cycles would in most if not all cases
> > outweigh any perceived power savings. As such, I just don't see the
> > practical use case.
> 
> It really depends on the use case and how often the one-shot gets
> triggered. For battery-powered devices, running in the continuous
> mode does consume considerable power based on the measurement from
> our power folks. If a system is running in a power sensitive mode,
> while it still needs to occasionally check the inputs, it could be
> a use case for one-shot mode, though it's purely a user decision.
> 
That would actually be a use case for runtime power management.
The power used by a modern sensor chip is miniscule compared
to the power consumed by other components in the system,
which may explain why no one bothered looking into runtime
power management for sensors.

This is also an argument against any device or subsystem specific solution:
Users will want to be able to control power consumption for all devices
in the system, not just for sensors. A device specific power control
mechanism would, from user space perspective, be a nightmare.

> > power-down mode effectively reinvents runtime power management (runtime
> > suspend/resume support) and is thus simply unacceptable.
> 
> Similar to one-shot, if a system is in a low power mode where it
> doesn't want to check the inputs anymore, I feel the user space
> could at least make the decision to turn on/off the chips, I am
> not quite sure if the generic runtime PM system already has this
> kind of support though.
> 
Please look up "runtime power management". It provides the basic
mechanism to turn off / disable a device if it is not used. The point
here is that the basic mechanism is there, even though it may not
be perfect. If it is not perfect, it needs to be improved.
Implementing a per-subsystem alternate method would be the wrong
approach.

> > I am open to help explore adding support for runtime power management
> > to the hwmon subsystem, but that would be less than straightforward and
> > require an actual use case to warrant the effort.
> 
> Is there any feasible solution from your point of view?
> 

You mean to implement runtime suspend/resume for hwmon drivers,
or some other approach ? As for implementing it in hwmon drivers,
I don't know; I don't recall this ever coming up, and never
thought about it. This is where the use case comes in - if done,
it has to be done properly, which will require some thinking and
a substantial amount of time. It simply does not make sense to
spend time on that effort if there is no actual use case.

Implementing an alternate mechanism is simply a no-go.

Guenter
