Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935321AbeEXA4c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 20:56:32 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34528 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935196AbeEXA43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 20:56:29 -0400
X-Google-Smtp-Source: AB8JxZryEOri6LPIYBlN5vyaxYDW7UxJ/vfbKdvn/pueQD5H4f88CY3QYFQYSTz9GlI696QCWgkb4g==
Date: Wed, 23 May 2018 17:56:27 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>, claudio@evidence.eu.com,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] cpufreq: schedutil: Avoid missing updates for one-CPU
 policies
Message-ID: <20180524005627.GB171060@joelaf.mtv.corp.google.com>
References: <1672734.JYOlA1IWnU@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1672734.JYOlA1IWnU@aspire.rjw.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 11:47:45AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 152db033d775 (schedutil: Allow cpufreq requests to be made
> even when kthread kicked) made changes to prevent utilization updates
> from being discarded during processing a previous request, but it
> left a small window in which that still can happen in the one-CPU
> policy case.  Namely, updates coming in after setting work_in_progress
> in sugov_update_commit() and clearing it in sugov_work() will still
> be dropped due to the work_in_progress check in sugov_update_single().
> 
> To close that window, rearrange the code so as to acquire the update
> lock around the deferred update branch in sugov_update_single()
> and drop the work_in_progress check from it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
 
