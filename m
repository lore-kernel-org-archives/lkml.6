Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756196AbeEIGyy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 02:54:54 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43131 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755704AbeEIGyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 02:54:52 -0400
X-Google-Smtp-Source: AB8JxZqHvqOEN9kXTbzMg6hN1wE8bCtVOWnR6RYbHnTUu1b1oHFzmEUr2dbNL6wwjkBntyBEfPbfow==
Date: Wed, 9 May 2018 12:24:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
        Claudio Scordino <claudio@evidence.eu.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Joel Fernandes <joelaf@google.com>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH] sched/cpufreq/schedutil: handling urgent frequency
 requests
Message-ID: <20180509065449.c5zotxqmuyatjgfd@vireshk-i7>
References: <1525704215-8683-1-git-send-email-claudio@evidence.eu.com>
 <20180508065435.bcht6dyb3rpp6gk5@vireshk-i7>
 <20180509045425.GA158882@joelaf.mtv.corp.google.com>
 <20180509064530.GA1681@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509064530.GA1681@localhost.localdomain>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-05-18, 08:45, Juri Lelli wrote:
> On 08/05/18 21:54, Joel Fernandes wrote:
> Isn't this potentially introducing unneeded irq pressure (and doing the
> whole wakeup the kthread thing), while the already active kthread could
> simply handle multiple back-to-back requests before going to sleep?

And then we may need more instances of the work item and need to store
a different value of next_freq with each work item, as we can't use
the common one anymore as there would be races around accessing it ?

-- 
viresh
