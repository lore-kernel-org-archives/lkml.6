Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F76C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63B0244AF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63B0244AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933748AbeGDKut (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:50:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43851 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932536AbeGDKuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:50:46 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id d3d41238ebde07d5; Wed, 4 Jul 2018 12:50:44 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V10] powercap/drivers/idle_inject: Add an idle injection framework
Date:   Wed, 04 Jul 2018 12:49:21 +0200
Message-ID: <2148928.GlOskIdrt7@aspire.rjw.lan>
In-Reply-To: <20180626110105.qqsrslavtfxuubcm@vireshk-i7>
References: <1530010416-30692-1-git-send-email-daniel.lezcano@linaro.org> <20180626110105.qqsrslavtfxuubcm@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 26, 2018 1:01:05 PM CEST Viresh Kumar wrote:
> On 26-06-18, 12:53, Daniel Lezcano wrote:
> > Initially, the cpu_cooling device for ARM was changed by adding a new
> > policy inserting idle cycles. The intel_powerclamp driver does a
> > similar action.
> > 
> > Instead of implementing idle injections privately in the cpu_cooling
> > device, move the idle injection code in a dedicated framework and give
> > the opportunity to other frameworks to make use of it.
> > 
> > The framework relies on the smpboot kthreads which handles via its
> > main loop the common code for hotplugging and [un]parking.
> > 
> > This code was previously tested with the cpu cooling device and went
> > through several iterations. It results now in split code and API
> > exported in the header file. It was tested with the cpu cooling device
> > with success.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Javi Merino <javi.merino@kernel.org>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: Kevin Wangtao <kevin.wangtao@linaro.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Rui Zhang <rui.zhang@intel.com>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> > ---
> > 
> > V10:
> >    - Remove set_freezable (Rafael J. Wysocki)
> >    - Reduce the prefixed names 'injection' by 'inject" (Rafael J. Wysocki)
> >    - Rename 'idle_injection_wakeup_fn()' to 'idle_inject_timer_fn()' (Rafael J. Wysocki)
> >    - Shorten label 'out_rollback_per_cpu' to 'out_rollback' (Rafael J. Wysocki)
> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

I've applied the patch, but I've rewrittent all of the comments in it.

Daniel, please check the result in linux-next and let me know if you see any
problems.

Thanks,
Rafael

