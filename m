Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF51AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777B42083E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Akl1wqnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfBLJtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:49:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35993 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfBLJtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:49:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id r124so1015834pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+WoxX4f4dFvG7Fg5Su55ld8qwdknNqKwqj4iDiTRN6Q=;
        b=Akl1wqnJmoOozm7GPfGBL6HBvfJEUOQzNoDhr2EMHeNqzskfJU6i3XVffAq9qz7S6u
         1vLgFlfy3Qbejnf3tr2VSRSD1q4WmNS1KXHQnq6qT07nmwTZnrubg8iLO34KQjG+zaji
         PSQExHI27kLxckHht3j26szHHfSdJwwQkki/5Ag3sllnmVv0K2qLijrsmA4m+WlFqdyr
         2M2nX74PlnWGZD4pbZMxkDU4RdBRDC8kgo3mc+iQIaXJtMLlFLOWK2fD8NKuL00PKMom
         j9bWa7oY8QY8sqTciR6XdW//Wt7yqLprjDI1zIvEvKfXh8lQcREgtfFu8Pn0GbAAVBXr
         VnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+WoxX4f4dFvG7Fg5Su55ld8qwdknNqKwqj4iDiTRN6Q=;
        b=FvSwQI/LoscxMF1+BnHX0oagWBKaAVWhPBdZbE6fa8yA+EqFq1WAeISDNUBqa0D0t2
         tgpmlaIyZV9lwvePyfHpUVVys4e1jXu4dKH2+uW4Yy3ibHsRd32ggo5NI7Zht45i7mbc
         fzwl5s1Vdh4YgCU5JeI4KpZg2BIsSU4OgZe8Kzhn8cZz+/9bQuRKZ1CaHWcKAyTMOSQE
         Cfesf4UPJr9H5RXrlNZqjj24JA3XVTi7SmcThm2plrdy+M5Y/l4Xg/vFpVJCpdqQyWKw
         AOOB5/UVzRgzDiI8ttZzvzq8Q7lv1XqKBvKcVSmRONPETM0a6rAjCs0rJarbyyLDH46q
         N5Yg==
X-Gm-Message-State: AHQUAuZdbzfjvf/pcO3bxWsUTOTB3VrLJpWHCMCBgVS9R/rkfn8S+2w6
        IqIoZWpM98PxF+bXqPUGM+JCvQ==
X-Google-Smtp-Source: AHgI3IZ58LRkKsN4quz0RMi6jq3ZKGYjlRL1JEAFlyvd6oLoYahGLD/ea2RHHgiIRxl5a+Ll7m6gIw==
X-Received: by 2002:a63:5343:: with SMTP id t3mr2769013pgl.415.1549964951978;
        Tue, 12 Feb 2019 01:49:11 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id d25sm23098604pfe.40.2019.02.12.01.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 01:49:11 -0800 (PST)
Date:   Tue, 12 Feb 2019 15:19:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] cpufreq: dt: Implement online/offline() callbacks
Message-ID: <20190212094909.5eivfzfnc62lay7x@vireshk-i7>
References: <cover.1549955027.git.viresh.kumar@linaro.org>
 <8030961ef762018fc286e4d3d3a010638e900e53.1549955027.git.viresh.kumar@linaro.org>
 <CAJZ5v0hLOD-5XDp7jAwt4EqWYGAU9VZzumNchW9_+bt7F1MdQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hLOD-5XDp7jAwt4EqWYGAU9VZzumNchW9_+bt7F1MdQw@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-02-19, 10:43, Rafael J. Wysocki wrote:
> On Tue, Feb 12, 2019 at 8:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Implement the light-weight tear down and bring up helpers to reduce the
> > amount of work to do on CPU offline/online operation.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq-dt.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> > index 7ba392911cd0..1aefaa1b0ca2 100644
> > --- a/drivers/cpufreq/cpufreq-dt.c
> > +++ b/drivers/cpufreq/cpufreq-dt.c
> > @@ -295,6 +295,21 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >         return ret;
> >  }
> >
> > +static int cpufreq_online(struct cpufreq_policy *policy)
> > +{
> > +       /* We did light-weight tear down earlier, nothing to do here */
> > +       return 0;
> > +}
> 
> I think you could avoid having to add this empty stub if the core
> checked for both online and offline, that is
> 
> if (driver->offline || driver->online) {

This doesn't look great as all we should care about here is ->online()
and checking for offline as well looks a bit hacky.

>     ret = driver->online ? driver->online(policy) : 0;
> } else {
>     ret = driver->init(policy);
> }
> 
> or similar.

I also thought of a new flag like: CPUFREQ_LIGHT_WEIGHT_OFFLINE and
then we can get rid of both online/offline dummies but then thought of
starting with the dummy routines to begin with :)

-- 
viresh
