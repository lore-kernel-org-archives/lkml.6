Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbeBEJXR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:23:17 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37932 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbeBEJXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:23:08 -0500
X-Google-Smtp-Source: AH8x226ZWmw+JnrDHV09/XhyrhdyAO2SUrA3xwolta7v9MivbvprBWG4j6Uy/qLMMaGvkIQGuSBItA==
Date: Mon, 5 Feb 2018 14:53:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bo Yan <byan@nvidia.com>, sgurrappadi@nvidia.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: skip cpufreq resume if it's not suspended
Message-ID: <20180205092305.GF28462@vireshk-i7>
References: <1516744675-21233-1-git-send-email-byan@nvidia.com>
 <1563547.VDOW1Ixonm@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563547.VDOW1Ixonm@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-02-18, 10:19, Rafael J. Wysocki wrote:
> On Tuesday, January 23, 2018 10:57:55 PM CET Bo Yan wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 41d148af7748..95b1c4afe14e 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1680,6 +1680,10 @@ void cpufreq_resume(void)
> >  	if (!cpufreq_driver)
> >  		return;
> >  
> > +	if (unlikely(!cpufreq_suspended)) {
> > +		pr_warn("%s: resume after failing suspend\n", __func__);
> > +		return;
> > +	}
> >  	cpufreq_suspended = false;
> >  
> >  	if (!has_target() && !cpufreq_driver->resume)
> 
> I've just edited this patch somewhat (mostly by dropping the pr_warn())
> and queued it up.

You can add my Ack as well.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
