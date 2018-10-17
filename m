Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F64BECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F39A208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O30+RJzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F39A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeJREM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:12:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38644 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725737AbeJREM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:12:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so13047942pgq.5;
        Wed, 17 Oct 2018 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nrtSpmGjBXVdHO7Av1Tvi+PPHLlbTkswLCSQT6BvVjE=;
        b=O30+RJzzLPmwpKMKAH2rqg48tD9p2RawIQKf4QO3csxTXuF0aYl5yqFT2neobverkl
         aG9ooPzieXiMNsnmfZnr8ifxOcu8CmxT0iJSOeRUYsX51YMkPDWJh6dwoOSO6CwqyEcZ
         GKg8JdoQXoJoWu/x1AfqrhLvVY29z5/oszPchMMPA/8tOLEWptLX+m+WpAmiqnri+r8E
         BpBrlNzdnTiT+6uiLHw+SaZ4oYWS0y8Nr5tQvFmKePE9f7BtdloRortG24GNQjl1wOV9
         RKhhO1hE0yuT6YEbX37oLiBLcKciBvNeDG8epUCHKkoQsmwDGjDfyRvdpkHYVrIgxWVe
         2ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nrtSpmGjBXVdHO7Av1Tvi+PPHLlbTkswLCSQT6BvVjE=;
        b=oIyux4b43PUO+b2tNLt4mmA47F5/dOaugGwi2OnwBvpZcWpdOODAnPYP9JeJZKOJsD
         iwMJ+a8Hn6u1lDP9uX6IsVxK/DdxWkSm4PoOkQL+I3CrlgCNE2GcZlr79tYIsHoFk8c/
         5zdoEHkaVg2bEdKZ+8zHcJ2TkkQEQjDat72r26Be4H1UJZvoMj71JWVL7/tNnqQuqwbp
         bWbOHKMUOIyXxHLpgb1jMOKmdcoOgZNhCOtyBJ946UkvwkDX+XeDhwWadgZdS9C65cZn
         mJasiV/9HUGFcqNzpiogtG6oJQrs4Qc1X+Fg5HCFmpQQljuCo7lepD77VYTvDNiZWS94
         M/iw==
X-Gm-Message-State: ABuFfojFuqBPFb/55jK8cZ+ZA3M6FCM4ZcC2wGRoihqoUL4kzbrtKrqr
        y6sSuYnkeRx5Eu4Z8KShqQj6AoWx
X-Google-Smtp-Source: ACcGV63ThV/TzIyCZwbDQ7S/WSv12DvAxAsgshMdcfVCS43xPDtVZqez9XrN9W0Z3AlPF9U1GLH+wA==
X-Received: by 2002:a62:5ac6:: with SMTP id o189-v6mr28299801pfb.40.1539807306864;
        Wed, 17 Oct 2018 13:15:06 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n64-v6sm27065918pfi.185.2018.10.17.13.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 13:15:06 -0700 (PDT)
Date:   Wed, 17 Oct 2018 13:15:02 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] hwmon: (core) Inherit power properties to hdev
Message-ID: <20181017201501.GA15941@Asurada-Nvidia.nvidia.com>
References: <20181017012426.26958-1-nicoleotsuka@gmail.com>
 <20181017012426.26958-2-nicoleotsuka@gmail.com>
 <20181017194430.GA6812@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017194430.GA6812@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:44:30PM -0700, Guenter Roeck wrote:

> > +	hdev->driver = dev->driver;
> > +	hdev->power = dev->power;
> > +	hdev->pm_domain = dev->pm_domain;
> 
> dev can, unfortunately, be NULL
> 
> >  	hdev->of_node = dev ? dev->of_node : NULL;
> 
> ... as you can see here.

Oops..will fix it.

Thanks!

> 
> Guenter
> 
> >  	hwdev->chip = chip;
> >  	dev_set_drvdata(hdev, drvdata);
> > -- 
> > 2.17.1
> > 
