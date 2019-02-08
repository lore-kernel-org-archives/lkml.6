Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DCEC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FE9206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FENGPQuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfBHKXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:23:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41488 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBHKXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:23:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so1466618pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 02:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ompwQ1OdklRy24O9pJjo1FPddnXjgXtH+oByiW02lMI=;
        b=FENGPQuAnWHfpAcIyywDFj42SPo2PY9re5BfGuFNz+jyyT12VEJinXPPRZ9zr3cIt+
         gsfu+urzXcZyPvdcDYP2bx3sOT7wIN3ZZXvfcJFFJXW00YWMu+f0AdiP47C1VssQj4ob
         aY3cj3iUirOue7TZ6FQinEDJusFZURz2yVCyS39uZb+wjgdHFaNL0/AekHKbyFYxWsIL
         cKwztE+3TAlZoaWTx5J7CTYI2QDDcTvSv7zLKGXFivIai4auYYS5W2hYhbZHre7wA3n+
         6q1thMatXQ/ychIeptNZuwLSrv3mmlUAfsxNcTyt2a1VPSsqJ4UF1QYCCqkHbqsNDCnE
         ERWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ompwQ1OdklRy24O9pJjo1FPddnXjgXtH+oByiW02lMI=;
        b=nThlheO5/7LvxyhI7eVT8fMBvCg0r9/RGnFoWdWuYEQX49NZlaA8JztfATzZEr5rx+
         WV9S7CSvMALgC88RsLFZgBIHH5rEmqqnflTWTTSnQclTBEfZF6kXNuLf0mXeq2KKIPg/
         UFKqWU31ZyYT5tEuOrSsRaj85H8iKZ9SNYJbjK5B+yyi+rZsRN9OcVTrQsCG+fmJghMx
         0xJ2Ndb7sJtEBmhTWs6WF63kPBEnDZsYggmJ8mgPvqGKOY1KosDI9c2xpye5vI9+rw00
         jqymYOyGRqzvkWsThUBgke8xO1i7qoE3L52WCUlvEYpbmyXBJUJaboeEgdOpYkDzNcvS
         yejw==
X-Gm-Message-State: AHQUAuaEkUKCYE8RPAXSHGhdSo4rDSSHqMoHR6BIZgOcQGkPKm8wXDOk
        HOq/RPV6dgHnnhtzDhubrkzE+A==
X-Google-Smtp-Source: AHgI3Iay3INKVAwWcLkDmNZEfaVGeTjNjir262wXwMUAHvELJm5fYgrb0qKjy1PVs1cQLGsohhbevg==
X-Received: by 2002:a63:c01:: with SMTP id b1mr20018231pgl.182.1549621429334;
        Fri, 08 Feb 2019 02:23:49 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id h15sm2024075pgl.43.2019.02.08.02.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 02:23:48 -0800 (PST)
Date:   Fri, 8 Feb 2019 15:53:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] drivers: Frequency constraint infrastructure
Message-ID: <20190208102346.ophy3eqhxjzaqsxr@vireshk-i7>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
 <20190208090912.43aao5kny42iirum@vireshk-i7>
 <CAJZ5v0iE9tFt9Xs27EYcjv6N1KAq-LaAQnv=QBvnbNRpfwrWCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iE9tFt9Xs27EYcjv6N1KAq-LaAQnv=QBvnbNRpfwrWCg@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-19, 10:53, Rafael J. Wysocki wrote:
> On Fri, Feb 8, 2019 at 10:09 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 11-01-19, 10:47, Rafael J. Wysocki wrote:
> > > On Fri, Jan 11, 2019 at 10:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > This commit introduces the frequency constraint infrastructure, which
> > > > provides a generic interface for parts of the kernel to constraint the
> > > > working frequency range of a device.
> > > >
> > > > The primary users of this are the cpufreq and devfreq frameworks. The
> > > > cpufreq framework already implements such constraints with help of
> > > > notifier chains (for thermal and other constraints) and some local code
> > > > (for user-space constraints). The devfreq framework developers have also
> > > > shown interest [1] in such a framework, which may use it at a later
> > > > point of time.
> > > >
> > > > The idea here is to provide a generic interface and get rid of the
> > > > notifier based mechanism.
> > > >
> > > > Only one constraint is added for now for the cpufreq framework and the
> > > > rest will follow after this stuff is merged.
> > > >
> > > > Matthias Kaehlcke was involved in the preparation of the first draft of
> > > > this work and so I have added him as Co-author to the first patch.
> > > > Thanks Matthias.
> > > >
> > > > FWIW, This doesn't have anything to do with the boot-constraints
> > > > framework [2] I was trying to upstream earlier :)
> > >
> > > This is quite a bit of code to review, so it will take some time.
> >
> > @Rafael: You are going to provide some more feedback here, right ?
> 
> I think I've said something already.
> 
> TLDR: I'm not convinced.
> 
> PM QoS does similar things in a similar way.  Why does it have to be a
> different framework?

I did it because no one objected to the initial proposal [1]. But you
weren't directly cc'd (but only PM list) so can't blame you either :)

Maybe we can make it work with PM QoS as well, I will see that aspect.

> Using freq constraints for thermal reasons without coordinating it
> with scheduling is questionable in general, because thermal control
> may work against scheduling then.

Sure, I agree but all we are talking about here is the mechanism with
which the constraints should be put and it doesn't make things bad
than they already are. With the notifiers in place currently, thermal
core doesn't talk to scheduler.

I think a different set of people are trying to fix that by issuing
some calls to scheduler from thermal core, or something like that but
I still consider that work orthogonal to the way constraints should be
added instead of notifiers.

Will implementing it the QoS way would be fine from thermal-scheduler
standpoint ?

> AFAICS, the original reason for notifiers in cpufreq was to avoid
> drawing too much power (and frequency was a proxy of power then) and
> they allowed the firmware to set the additional limit when going from
> AC to battery, for example.  That appears to be a different goal,
> though.

-- 
viresh

[1] https://marc.info/?l=linux-pm&m=153851798809709
