Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164367AbeBOWIc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 17:08:32 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49146 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162892AbeBOWIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 17:08:31 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Bo Yan <byan@nvidia.com>,
        sgurrappadi@nvidia.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: skip cpufreq resume if it's not suspended
Date: Thu, 15 Feb 2018 23:06:39 +0100
Message-ID: <2807403.a9gdqJGhH8@aspire.rjw.lan>
In-Reply-To: <5A85FB2E.2050407@codeaurora.org>
References: <1516744675-21233-1-git-send-email-byan@nvidia.com> <20180205090546.GE28462@vireshk-i7> <5A85FB2E.2050407@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 15, 2018 10:27:10 PM CET Saravana Kannan wrote:
> On 02/05/2018 01:05 AM, Viresh Kumar wrote:
> > On 05-02-18, 09:50, Rafael J. Wysocki wrote:
> >> By design (which I admit may be confusing) it should be fine to call
> >> dpm_resume_end() after a failing dpm_suspend_start(), whatever the reason
> >> for the failure is.  cpufreq_suspend/resume() don't take that into account,
> >> everybody else does.
> >
> > Hmm, I see. Can't do much then, just fix the only broken piece of code :)
> >
> 
> Sorry for the late reply, this email didn't get filtered into the right 
> folder.
> 
> I think the design of dpm_suspend_start() and dpm_resume_end() generally 
> works fine because we seem to keep track of what devices have been 
> suspended so far (in the dpm_suspended_list) and call resume only of 
> those. So, why isn't the right fix to have cpufreq get put into that 
> list?

Because it is more complicated?

> Instead of just always call it on the resume path even if it 
> wasn't suspended? That seems to be the real issue.
> 
> So, we should either have dpm_suspend/resume() have a flag to keep track 
> of if cpufreq_suspend/resume() was called and make sure they are called 
> in proper pairs.

Why?

> Or have cpufreq register in a way that gets it put in 
> the suspend/resume list.
> 
> I'd still like to NACK this change.

It's gone in already, sorry.
