Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbeEWKNw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:13:52 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42047 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932180AbeEWKNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:13:48 -0400
X-Google-Smtp-Source: AB8JxZp6LAU62/D5FPUwKzsZJE9YaKVDomyXx2iluI2s/YJlJDiLGqZw7rzP3d4gh76aBL/r2M//gQ==
Date: Wed, 23 May 2018 12:13:44 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>, claudio@evidence.eu.com,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] cpufreq: schedutil: Avoid missing updates for one-CPU
 policies
Message-ID: <20180523101344.GB30909@localhost.localdomain>
References: <1672734.JYOlA1IWnU@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1672734.JYOlA1IWnU@aspire.rjw.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/18 11:47, Rafael J. Wysocki wrote:
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

I don't have a platform at hand where to test this. But, it looks OK to
me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,

- Juri
