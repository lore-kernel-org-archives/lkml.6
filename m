Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8197C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D4E20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqK2BEuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D4E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeK3WPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:15:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33176 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeK3WPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:15:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so2655798plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 03:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MUZ7zDnWP8V5recdomUKPLArgypbwKsg7dOhAi2kYkY=;
        b=OqK2BEufEg3BPa9jZghYUTLb0PlkJjV0fPmHj5eLsRTYLJu+TjScLZFK+RFsSh28zO
         tlKbb1ngRl6VnQPEgen8FLOsDNXDpRWQ34faJTPNyQ4dm/yud+a3t4uVWYLocFO/OxuJ
         nacJuUrMlr4FTcegP3xO6BkySB/oAy3OicoAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MUZ7zDnWP8V5recdomUKPLArgypbwKsg7dOhAi2kYkY=;
        b=CbO8KnBM7vLVVKhT9Z5L3D6JaH7I79RLKzM3OEB26ZDUeu1vVZlgf1S0A8KRkRr4Ae
         p4UZcARfWgWPm77FJn2UVsefN4a97s0PJFoTtOcg7+ozEHvtq3dI9sQ04DAKNRcVzxF5
         ozIpH9B1TII0obLnTlrQcJH5Y6XgifDgfhbETl8RA/ABQs25d78N+RJtJjO0vq/9qw0n
         uPdCYdzfRFzJYcsfJcqJIyuz1qv3S+y4yDDZUDKpuSA37WujEx4vsle9dnaA8unbzAK+
         ttiYHzJlX6mGI9mYUMOzgezkMpaft7ttZ0Xo58tEtqzuXoGnXmgLHGnkqkjGHrHmn5g4
         fKfw==
X-Gm-Message-State: AA+aEWYWU0q6SSf+IYnHa2CGhvb2VIdSqy2Xb79cPUkspsg4SulaAKCM
        QOiUAWAYhktIiERe2i726LJhxQ==
X-Google-Smtp-Source: AFSGD/UBEetQD1FVKJEuCviLk9JLvrrk2v9uMPSNI8mZ3NnE5PLZwupnc455XU4WoopVVb5xGmUEfA==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr5359716plb.52.1543576013867;
        Fri, 30 Nov 2018 03:06:53 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id d25sm6629385pfe.40.2018.11.30.03.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 03:06:52 -0800 (PST)
Date:   Fri, 30 Nov 2018 16:36:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 5/5] PM / Domains: Propagate performance state updates
Message-ID: <20181130110650.6ni2ft3wud7gn6jz@vireshk-i7>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
 <5a29ceb2704239a8efb4db2e47ca155a422a6e57.1543219386.git.viresh.kumar@linaro.org>
 <CAPDyKFpp1iPQ08QQjoi9b4RGUo2Zw_L_vjy8xtnSpg34gn--eA@mail.gmail.com>
 <20181130095912.7hutbsrihpg4gez4@vireshk-i7>
 <CAPDyKFocp63hUOYOJ3HUXBj2CcHZGXMQ6n873SmMSfpDhRjB7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFocp63hUOYOJ3HUXBj2CcHZGXMQ6n873SmMSfpDhRjB7g@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-11-18, 11:18, Ulf Hansson wrote:
> On Fri, 30 Nov 2018 at 10:59, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Sure, but the ordering of locks is always subdomain first and then master.
> > Considering the case of Qcom, we have two domains Cx (sub-domain) and Mx (master).
> >
> > On first genpd_power_on(Cx) call, we will first call genpd_power_on(Mx) which
> > will just power it on as none of its master will have perf-state support. We
> > then call _genpd_power_on(Cx) which will also not do anything with Mx as its own
> > (Cx's) pstate would be 0 at that time. But even if it had a valid value, it will
> > propagate just fine with all proper locking in place.
> 
> Can you explain that, it's not super easy to follow the flow.

Sorry, I somehow assumed you would know it already :)

> So what will happen if Cx has a value that needs to be propagated?
> What locks will be taken, and in what order?
> 
> Following, what if we had a Bx domain, being the subdomain of Cx, and
> it too had a value that needs to be propagated.

Lets take the worst example, we have Bx (sub-domain of Cx), Cx (sub-domain of
Mx) and Dx (master). Normal power-on/off will always have the values 0, so lets
consider resume sequence where all the domains will have a value pstate value.
And please forgive me for any bugs I have introduced in the following
super-complex sequence :)

genpd_runtime_resume(dev) //domain Bx
    -> genpd_lock(Bx)
    -> genpd_power_on(Bx)
 
        -> genpd_lock(Cx)
        -> genpd_power_on(Cx)
 
            -> genpd_lock(Dx)
            -> genpd_power_on(Dx)
 
                -> _genpd_power_on(Dx)
                    -> _genpd_set_performance_state(Dx, Dxstate) {
                        //Doesn't have any masters
                        -> genpd->set_performance_state(Dx, Dxstate);
                    }
 
            -> genpd_unlock(Dx)
 
            -> _genpd_power_on(Cx)
                -> _genpd_set_performance_state(Cx, Cxstate) {
                    //have one master, Dx
                    -> genpd_lock(Dx)
                        -> _genpd_set_performance_state(Dx, Dxstate) {
                            //Doesn't have any masters
                            -> genpd->set_performance_state(Dx, Dxstate);
                        }
 
                    -> genpd_unlock(Dx)
 
                    // Change Cx state
                    -> genpd->set_performance_state(Cx, Cxstate);
                }
 
        -> genpd_unlock(Cx)
 
        -> _genpd_power_on(Bx)
            -> _genpd_set_performance_state(Bx, Bxstate) {
                //have one master, Cx
                -> genpd_lock(Cx)
                -> _genpd_set_performance_state(Cx, Cxstate) {
                    //have one master, Dx
                    -> genpd_lock(Dx)
                        -> _genpd_set_performance_state(Dx, Dxstate) {
                            //Doesn't have any masters
                            -> genpd->set_performance_state(Dx, Dxstate);
                        }
 
                    -> genpd_unlock(Dx)
 
                    // Change Cx state
                    -> genpd->set_performance_state(Cx, Cxstate);
                }
                -> genpd_unlock(Cx)
 
                -> genpd->set_performance_state(Bx, Bxstate);
            }
 
    -> genpd_unlock(Bx)



> It sounds like we will
> do the propagation one time per level. Is that really necessary,
> couldn't we just do it once, after the power on sequence have been
> completed?

It will be a BIG hack somewhere, isn't it ? How will we know when has the time
come to shoot the final sequence of set_performance_state() ? And where will we
do it? genpd_runtime_resume() ? And then we will have more problems, for example
Rajendra earlier compared this stuff to clk framework where it is possible to do
clk_set_rate() first and then only call clk_enable() and the same should be
possible with genpd as well, i.e. set performance state first and then only
enable the device/domain. And so we need this right within genpd_power_on().

I know things are repetitive here, but that's the right way of doing it IMHO.
What do you say ?

-- 
viresh
