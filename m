Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9F5C43444
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2B720874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNVQenO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfADKQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:16:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40905 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfADKQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:16:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so17247340plq.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 02:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e0v/J119cUda2esQEjVh+aFzshtuHBTqU46owA02KgI=;
        b=dNVQenO4JCbAMAAPJDJSdlvv4NXOnbaA6TGUFuyLb9neNo2zroesebC8tUb/sKmnUR
         d+wM3D8zDhr6/MfSASAIgXp2mqX5cJuUaLy6pIloeiXTji9we1abvHZiFAYRNN1htwz9
         7kGznB5U5edZayNyg4HWGZ7nUnhu95dTBWjEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e0v/J119cUda2esQEjVh+aFzshtuHBTqU46owA02KgI=;
        b=uhiZeAFvZmGIWOJDNJG6CWp4J6Cd0armrTVc4BrQsN6Ub21qff1CJxaSof6wvUc4Oq
         uz1VT8d3NO9xkhWKHhzMw3/idVHVKxZzeXqkhQUzAbLWZoGCwHT5YdAgzwYAiqvvYZ4i
         udBs4byDC5JVbUYpbrxKzUz1oB+K/MMqjqRpaOqat9Bs9V2sfp03DgQXpmjO9LxI07J4
         tUSeupr+fTHZYxRL9TaQd9qXxVz0RHIvQg+jFPK/7ZvdlvFvT2DQCT+Wu5hy76+TuqUS
         N1WhiVdxuv2Z0rDEzQ8QsC/VuEAC45s/qkRH6f0p4omO84gC7prL7dp6o25SCE64EkLy
         JC7Q==
X-Gm-Message-State: AJcUukc7PSDwm7i+2ZvQrgIcqyEzoRRAkuGY7nQHKKXGCk7fdARDNTAS
        YC/99HNiKnwMs1/RBYRHj1xiow==
X-Google-Smtp-Source: ALg8bN4shCnfxgvs1tyOF58w+3udY2yziO8YKNPPSRVIxYteRyIp9CT295A9l1cv+823xkM65TeR/w==
X-Received: by 2002:a17:902:7e0d:: with SMTP id b13mr50960281plm.154.1546596964671;
        Fri, 04 Jan 2019 02:16:04 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id x27sm108630943pfe.178.2019.01.04.02.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 02:16:03 -0800 (PST)
Date:   Fri, 4 Jan 2019 15:46:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Douglas.Raillard@arm.com, "4 . 20" <stable@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: scpi/scmi: Fix freeing of dynamic OPPs
Message-ID: <20190104101601.mpo4vpfcvsfauk2u@vireshk-i7>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org>
 <CAJZ5v0g4ABiPGGeLuzLN=1cT+7ejUP5hCgoN3_nhvr=Foaxa6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g4ABiPGGeLuzLN=1cT+7ejUP5hCgoN3_nhvr=Foaxa6Q@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-01-19, 11:10, Rafael J. Wysocki wrote:
> On Fri, Jan 4, 2019 at 10:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Since the commit 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from
> > _dev_pm_opp_remove_table()"), dynamically created OPP aren't
> > automatically removed anymore by dev_pm_opp_cpumask_remove_table(). This
> > affects the scpi and scmi cpufreq drivers which no longer free OPPs on
> > failures or on invocations of the policy->exit() callback.
> >
> > Create a generic OPP helper dev_pm_opp_remove_all_dynamic() which can be
> > called from these drivers instead of dev_pm_opp_cpumask_remove_table().
> >
> > In dev_pm_opp_remove_all_dynamic(), we need to make sure that the
> > opp_list isn't getting accessed simultaneously from other parts of the
> > OPP core while the helper is freeing dynamic OPPs, i.e. we can't drop
> > the opp_table->lock while traversing through the OPP list. And to
> > accomplish that, this patch also creates _opp_kref_release_unlocked()
> > which can be called from this new helper with the opp_table lock already
> > held.
> >
> > Cc: 4.20 <stable@vger.kernel.org> # v4.20
> > Reported-by: Valentin Schneider <valentin.schneider@arm.com>
> > Fixes: 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()")
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> I guess I'll pick it up by hand.

Sure.

> I'm assuming that you have tested it, have you?

Yes, but I had to fake few dynamic OPPs and ignore the static ones
coming from DT. Lets wait for Sudeep or Valentin to test this, who
have real hardware to fix with this patch.

-- 
viresh
