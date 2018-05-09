Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753245AbeEIEzJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:55:09 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46848 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752478AbeEIEzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:55:07 -0400
X-Google-Smtp-Source: AB8JxZp3bJgdBCoP010fsRvkOfcQkH94VT5LWrhAd2/eE9Ij0lXMwvKVGdMg89rOgfDqPZKApMOp9A==
Date: Wed, 9 May 2018 10:25:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] Revert "cpufreq: schedutil: Don't restrict kthread to
 related_cpus unnecessarily"
Message-ID: <20180509045504.nmvrobtcdy7tfz7r@vireshk-i7>
References: <20180508073340.13114-1-dietmar.eggemann@arm.com>
 <20180508082242.bre6sjfvefhz6xc3@vireshk-i7>
 <8cf21b1a-ca6e-fed7-43c5-94c66ff5986b@arm.com>
 <20180508094526.ajyjrwytguhv4xpe@vireshk-i7>
 <20180508100227.GB3752@e108498-lin.cambridge.arm.com>
 <20180508103427.w2rq3vz3f66y4cxh@vireshk-i7>
 <CAJZ5v0iN0msbi=ad34nS8eVfGGS1UD-qUeHPeAvq=yW3-4HKCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iN0msbi=ad34nS8eVfGGS1UD-qUeHPeAvq=yW3-4HKCQ@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-05-18, 22:36, Rafael J. Wysocki wrote:
> Because that makes things more complex and harder to debug in general.
> 
> What's the exact reason why non-policy CPUs should ever run the sugov
> kthread for the given policy?

The only benefit was to let the scheduler run the kthread on the best
CPU (according to the scheduler), which may help reducing the delay in
running the kthread. But given the way deadline scheduler works, I
don't see a reason why this should be done anymore.

-- 
viresh
