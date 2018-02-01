Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeBAOiM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:38:12 -0500
Received: from mout.gmx.net ([212.227.15.18]:38539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751408AbeBAOiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:38:11 -0500
Message-ID: <1517495872.23787.20.camel@gmx.de>
Subject: Re: [RFC PATCH] sched/fair: Optionally restrict SMT scheduling
 ("restrict_smt")
From: Mike Galbraith <efault@gmx.de>
To: Sergio Lopez <slp@sinrega.org>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org
Date: Thu, 01 Feb 2018 15:37:52 +0100
In-Reply-To: <20180201123748.32596-1-slp@sinrega.org>
References: <20180201123748.32596-1-slp@sinrega.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:yteeGBWJAvyq/vPiedY97ick14RBq3HnI7GqYe18BmEq7/f6ci1
 Q+KO2h3HozIMPR+K4FNkAOooYzY5sMBWLlmRO0QsuwZlk1CaB0gfZCO3PIXWWIF9ECpJlnJ
 HdQYpZ8TYygQqQdV8Yutpdi5Cx5jGlVTADUTyL36flzLzxo3foBUyrweqi09sh1jRsptTju
 NucKJbdt+6CCTnXt86isQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MKSJgRhYduo=:wIPJch2yAS+gqZ7kuCt3mu
 846NqFhf1Qkna92g5etUlkFzcSykGP78fRaj+KiFY5+Iq6kQgjydsZ4B2tT9rVhjd2UgPetUn
 huZ971FOQ7b77cb1vrcWJidKKissg7R/Ir0YtZpx5sCboaa+Up1lXXTRWmdZ7DhQQUII3Ncvn
 pYLbcHcI1BRJuyXt4jWAZfdXb4lnfzYHBMQYtdv2RztvjbobXeiPPiPDnT1XcwxvZQBr9WulJ
 XTfRLUMYmCZcFDzGR1jCvhm6fEaL7qwciWK1Q2POKkl6RFoZBCAGEyfZzxfcY/Z9yAfX8CmIt
 Z5oMFi8UzpStkf0Z8Q2ex/0irILGmHjDzXvQyw+iFO3+mM7oxRVjx8kME3FLy+P3RJ4gHdju3
 AQ67Vs353ySpYiYLlyCUFEI2i+PwNlIgqGi3VRfc0B9MApSUyIYA5mQR6MLg0FBbUNBBLbgKj
 nDfTjb/vBmZVcRmg8EtcbF0P9wGgfMHM7xX5SKr4EYVQ3zXsFmX/h4oKOVh4ktBgcdjStK+6q
 GSPEcIsp9K/UT04DcMrFhUOHYsxb6komF816Mye1o9PYlndcPeZHGUYypU9wrGzHUx7ZECO1i
 5IuvwCzRL7/XYcvun6HCKq8Ad/aM7CqexTjNVkuUE6naKOAMEnyOtzFUsAPQfzaFEMPFg/YJg
 srl0RLCv5IfhQvLlSIod5+hDAtroV+AN+cyaW3MiOyopX1v2ALGrMiVUTt11k6HuLsWznWfnW
 R/cKRodvliBTrIufiQMacrYbPqUUmowFZIHGC3sk4WQrj8JWgwvT7JrQyOtqOD8TFZq74XYGa
 gy9pP1uYmQF1090OMQamlh+M5jgLgF4/XwYmsS5wRBbm78tOGY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-01 at 13:37 +0100, Sergio Lopez wrote:
> "restrict_smt" is an optional security feature that, when enabled,
> automatically adjusts the cpus_allowed mask of user tasks with CFS
> policies, forcing them to run on the first SMT thread of each core.
> 
> This security feature prevents user tasks from running on SMT sibling
> threads, difficulting the abuse of shared physical resources to
> construct covert side-channels or spying on other tasks. "restrict_smt"
> also helps in the mitigation of some HT-based Spectre v2 attack
> scenarios.
> 
> Users with CAP_SYS_NICE are still able to schedule tasks on secondary
> SMT threads by exclusively pinning to the latter, so "restrict_smt"
> won't interfere with resource planification strategies depending on
> that, like vCPU pinning for KVM Guests.
> 
> Compared against disabling SMT at a hardware level, "restrict_smt"
> presents the following advantages:
>  - Secondary SMT threads can still be used by kthreads, or by user
> tasks exclusively pinned to them.
> 
> Compared against "isolcpus", "restrict_smt" presents the following
> advantages:
>  - Doesn't require prior knowledge of the CPU topology, making it more
> friendly to both end users and automation tools.
>  - Load balancing is still active for tasks pinned to multiple secondary
> SMT threads.

This says that everybody and everything in the box is way smarter than
the admin.

	-Mike
