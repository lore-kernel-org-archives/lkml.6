Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0864C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDB32089D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oU1E8Yp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDB32089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbeKQMGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:06:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40079 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeKQMG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:06:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22-v6so6492994pls.7;
        Fri, 16 Nov 2018 17:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kFrk3ZvTxnuIJmqdWeNtTuoVcmDrFGU5o+QORm1j6zU=;
        b=oU1E8Yp2hbJ2rrUDA6X3YC6xPk69kVrvM23B8FiIzJnvKcPc7KJhkXLv9S1gpiPUGC
         pkdglfwv09SxgdiNjJ5Lj9/vrds4iWKcNCPFYQW+F+Y0qqLXOXWjWxKQTuZiyZ62EEKm
         EBR8iOORxYm0gsl9jNeA3TiKN98ZXYuV1ZL+N9QPb1r8jA+qpdpQSx363xyHWXDHuHw2
         WLK3vcsJ7ABBp/XG6f28DvJB5SQ+wjjtOKOJYvP5/+fEJNhiv2FgzL9fGQ+B5588XA8Z
         2Fv8yDWTag8SuruXLHYDocc2f07BFcYWaiP6syjQdinQnypX+Y3Tua7m3rIPulT1OOhH
         82vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kFrk3ZvTxnuIJmqdWeNtTuoVcmDrFGU5o+QORm1j6zU=;
        b=DJ66zrxxEuhuEJTor8X6vRxh0l6OBq+eVJbZXsl4BqUhRZhHGJy0Q1FtgGv2bsqZ/b
         f//ylDWLxZGWsIvj1cNx0kUAibjwZFVOEtyWKXhFAopykM4HaVUFLZIALFRN4xhie1PV
         WntTQrxKv6JSxXkO2nzgslyD1sabnciQfohgZDEF/Oy+JmZAn2ksWKTJ4iekjNrgePvN
         gsmlTU+21F05O5MuOo7W3RUZzRXsn7DkZ8IpsA8RWmEAqNFCOuiBvpIEsZIkmlQlRcFQ
         wGilUjmrkPbq/gQkXxY/JADlJ8DJO3LJwYrTp/j0nNZwdPbIafLQ5DWLzuuUeUXiFl4u
         TnJA==
X-Gm-Message-State: AGRZ1gJjD5gwx1zzC3LIO/dcEHY5giDBil7ZDUGjmVOIRuwC9WnXgbo/
        zxHJJDKWBVWPTZYLdH9AerU=
X-Google-Smtp-Source: AJdET5cyb5XPVOCc+yUpqDI3a0kgKTfWEhaH5W0oFafa3He4vRUEpGIsx+7Y39nJDSzxwl6Egc6/JQ==
X-Received: by 2002:a17:902:e085:: with SMTP id cb5mr8786227plb.24.1542419499719;
        Fri, 16 Nov 2018 17:51:39 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id c23-v6sm34674488pfn.95.2018.11.16.17.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 17:51:38 -0800 (PST)
Date:   Fri, 16 Nov 2018 17:51:34 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon (ina3221) Add single-shot mode support
Message-ID: <20181117015131.GA10407@Asurada-Nvidia.nvidia.com>
References: <20181113042353.1507-1-nicoleotsuka@gmail.com>
 <20181113043248.GB11205@roeck-us.net>
 <20181113045823.GB26327@Asurada-Nvidia.nvidia.com>
 <20181113172102.GA21714@roeck-us.net>
 <20181114001141.GA14925@Asurada-Nvidia.nvidia.com>
 <20181114172330.GA25592@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114172330.GA25592@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guenter,

On Wed, Nov 14, 2018 at 09:23:30AM -0800, Guenter Roeck wrote:
> > An alternative way (without the sysfs node), after looking at
> > other hwmon code, could be to have a timed polling thread and
> > read data using an update_interval value from ABI. This might
> > turn out to be more complicated as it'll also involve settings
> > of hardware averaging and conversion time. Above all, I cannot
> > figure out a good threshold of update_interval to switch modes.
> > 
> update_interval should only be used if it can be configured
> into hardware, not to trigger a polling thread. It should only
> be used in the driver to determine caching intervals.

I see..so it's more like the conversion time settings instead.

> > If you can give some advice of a better implementation, that'd
> > be great.
> > 
> From your description, the only real feasible solution would be a
> generic one, with a well defined interface either to userspace or
> to the kernel. The best I can think of would be an in-kernel API
> setting the power operational mode via callbacks. Alternative would
> be a generic ability to set power operational mode from userspace,
> using an ABI which applies to all drivers, not just one.

Hmm. That would make the situation really complicated, I could
understand your concern though.

I searched a little and found that, while the initial ina3221
hwmon driver was under review, Laxman submitted an IIO version
where Jonathan had a similar comments against its "mode" node:
https://www.spinics.net/lists/linux-hwmon/msg00219.html

Quote from his comments {
 * There is a lot of ABI in here concerned with oneshot vs continuous.
 This seems to me to be more than it should be. We wouldn't expect to
 see stuff changing as a result of switching between these modes other
 than wrt to when the data shows up.  So I'd expect to not see this
 directly exposed at all - but rather sit in oneshot unless either:
 1) Buffered mode is running (not currently supported)
 2) Alerts are on - which I think requires it to be in continuous mode.
}

Since hwmon driver doesn't support buffered mode, what do you
think about having the chip run in single-shot mode by default
but changing it if alerts are on? Though the driver also needs
to support to enable warning/critical alert pins.

In short, other than exposing it via a generic ABI to the user
space, how about defining some policy to maintaining it within
the driver?

Thanks
Nicolin
