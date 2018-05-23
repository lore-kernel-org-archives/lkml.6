Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932145AbeEWJBJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:01:09 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34929 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754378AbeEWJBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:01:06 -0400
X-Google-Smtp-Source: AB8JxZpHBwMCLHfvddBII282QaLulOths3mvnAQluWRhHrL/GCoxwD+L84+s2mjuGn/1hdGA3Fj69w==
Date: Wed, 23 May 2018 14:31:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Joel Fernandes (Google.)" <joelaf@google.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        claudio@evidence.eu.com, kernel-team@android.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Message-ID: <20180523090101.6xifikvjpirqafox@vireshk-i7>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180522103415.cuutobi5kbhj4gcw@vireshk-i7>
 <20180522220953.GB40506@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522220953.GB40506@joelaf.mtv.corp.google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-18, 15:09, Joel Fernandes wrote:
> I agree with the race you describe for single policy slow-switch. Good find :)
> 
> The mainline sugov_work could also do such reordering in sugov_work, I think. Even
> with the mutex_unlock in mainline's sugov_work, that work_in_progress write could
> be reordered by the CPU to happen before the read of next_freq. AIUI,
> mutex_unlock is expected to be only a release-barrier.
> 
> Although to be safe, I could just put an smp_mb() there. I believe with that,
> no locking would be needed for such case.
> 
> I'll send out a v3 with Acks for the original patch, and the send out the
> smp_mb() as a separate patch if that's Ok.

Maybe it would be better to get the fix (with smp_mb) first and then
this optimization patch on the top? That would mean that the fix can
get applied to stable kernels easily.

-- 
viresh
