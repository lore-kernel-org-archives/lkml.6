Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4635C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B6A2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch3/Jork"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B6A2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbeITE2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:28:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33918 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeITE2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:28:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id g33-v6so7417473wrd.1;
        Wed, 19 Sep 2018 15:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BKe82irUmk4TztYyEekvlXjy7nPU33NyfDQ6bNUxM3A=;
        b=ch3/JorkMw5cp+L7pTOYCcQIsszQIWw6ol/5OVCcinIjNqNkANLpm5hw2g7WwuRXmH
         XvKsMcCZF+6NiCI5+F24I/5G8+56+oUQogEysurRuLEKuR8x5BUuJFeSJf3Qwciive/M
         cFaqDQJOST/5pJzaTm+LwoXbKLRKmx1JuxjbNOr+w19UgAkOz+WXjaFMvpzPFWqNjCli
         iCtH/cYk0RaQegRYNKscBO2sKNpCPamreM0Y7sfZy3M+jyEcGqGmuz8EPHfc306/498X
         Aoa3gL9JK5fIgJzkPLE2pgD1WekqGsYt1qGAwwX9/uZCdNEOoOLID06REHpeaAl3bxjv
         Juiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BKe82irUmk4TztYyEekvlXjy7nPU33NyfDQ6bNUxM3A=;
        b=BuZb1K7+3rSswNcdXWXE0bDW79PXWPrY/IqY4eWaHjT9OPAEfTazZMSswJQat4Zt5a
         DUp5ZCXM6x4Zu7qBzWpRCEbJMZMYUiPlsBpRu+2/TCpJAcj05E86GC0wrEh2O+9eNcmU
         sypaRKKBPFmNbnljwqozMBjbTEcv9Y+c4WE6o0d/IpEZr+itnJwhob3LK51K+coxZ8K1
         ak5EwMK4SkHezagBcOm7o/NPO1BcA3WjiQEe8Al0TBs1wurEJBAjqdEjkb8IQUXtRVV6
         jIp6OnuWvFbgFVZG/joocXZYS+3vG9ahe8TwifxH7DKfUB+guYvvf7rZQb4LB4SkzEOq
         4v6g==
X-Gm-Message-State: APzg51C0tGvRHt6XFRu+6bCoxW5NC/KiQnaKG4G68tiVyebiVievHYA9
        txl8T8jVRDLc/dnyD/JoxLY=
X-Google-Smtp-Source: ANB0VdY2ViLs43k1+/nF4qBC9OnckKX4O8hsX/NRy2uz6B1IYWcjxEIqaNQj6xW4UMTduTxRs/Fn8w==
X-Received: by 2002:a5d:5685:: with SMTP id f5-v6mr31445010wrv.58.1537397294387;
        Wed, 19 Sep 2018 15:48:14 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id s10-v6sm71249wmd.22.2018.09.19.15.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:48:13 -0700 (PDT)
Date:   Wed, 19 Sep 2018 15:48:11 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, ndesaulniers@google.com,
        ilia.lin@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: qcom-kryo: Fix section mismatch warning
Message-ID: <20180919224811.GA4310@flashbox>
References: <20180919182247.1101-1-natechancellor@gmail.com>
 <CAKwvOdnW8p4Tj2n+Y4XyMMVdD7W90W4NTLkJHKhZ6604ah4fnw@mail.gmail.com>
 <20180919215039.mb7prmmfs5jek3aj@vireshk-mac-ubuntu>
 <20180919215418.y2jsrsj73vy3dudd@vireshk-mac-ubuntu>
 <CAJZ5v0ipkaudrv7W5VP1_e9LERF6DLZuw+HtTf2Si4p=pbv9bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ipkaudrv7W5VP1_e9LERF6DLZuw+HtTf2Si4p=pbv9bw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 12:45:55AM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 19, 2018 at 11:54 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 19-09-18, 14:50, Viresh Kumar wrote:
> > > On 19-09-18, 14:45, Nick Desaulniers wrote:
> > > > On Wed, Sep 19, 2018 at 11:22 AM Nathan Chancellor
> > > > <natechancellor@gmail.com> wrote:
> > > > >
> > > > > WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
> > > > > the function qcom_cpufreq_kryo_probe() to the function
> > > > > .init.text:qcom_cpufreq_kryo_get_msm_id()
> > > > > The function qcom_cpufreq_kryo_probe() references
> > > > > the function __init qcom_cpufreq_kryo_get_msm_id().
> > > > > This is often because qcom_cpufreq_kryo_probe lacks a __init
> > > > > annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.
> > > > >
> > > > > Add the '__init' annotation to qcom_cpufreq_kryo_probe so that there is
> > > > > no more mismatch warning.
> > > >
> > > > I wonder why this driver has an exit function marked __init rather
> > > > than __exit?
> > >
> > > I think it was just a mistake.
> > >
> > > > Does that mean it gets cleaned up after kernel init, and
> > > > so on unloading of the driver, the kernel jumps to unmapped memory?
> > >
> > > The __init/exit sections are only useful when the driver is builtin
> > > and so there is no unloading. Yeah, if you would have tried to call
> > > shutdown for the kernel, it may have crashed or something. I don't
> > > know.
> > >
> > > > Does this patch now produce a warning for `qcom_cpufreq_kryo_driver`
> > > > referencing `qcom_cpufreq_kryo_probe`?
> > >
> > > Why should it ? It doesn't though.
> >
> > I thought you replied to my commit where I marked the exit routine
> > with __exit and realised just now that it wasn't the case. I haven't
> > build-tested this thing, but the question still stands. Why should it
> > ?
> 
> Because __init things go away at one point and calling them from the
> other sections is a bad idea.  OTOH, __exit things are simply not
> needed in built-in drivers and they are never there if the driver is
> built-in, so calling them from the other sections is a bad idea too.
> 
> Can you guys, please, prepare *one* patch fixing all of the
> __init/__exit annotations in this driver and post it?
> 
> Thanks,
> Rafael

Hi Rafael,

Yes, I will work on this and send out a v3 for review.

Thanks,
Nathan
