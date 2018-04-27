Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757867AbeD0Ja3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:30:29 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:43842 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbeD0Ja2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:30:28 -0400
X-Google-Smtp-Source: AB8JxZrcTXWsrK2za6uPazNr9fb2/4Jm/DQH/jLEfmHZIkp0cFYCova4HpWwaGybjKUMXPF+XHgoaQ==
Date: Fri, 27 Apr 2018 15:00:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: Avoid calling sync_entity_load_avg()
 unnecessarily
Message-ID: <20180427093025.q4e6nb4kttgrg6nt@vireshk-i7>
References: <20831b8d237bf3a20e4e328286f678b425ff04c9.1524738578.git.viresh.kumar@linaro.org>
 <cd019d1753824c81130eae7b43e2bbcec47cc1ad.1524738578.git.viresh.kumar@linaro.org>
 <c1dba90d-d464-9286-94e3-e399f0b71281@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1dba90d-d464-9286-94e3-e399f0b71281@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On 27-04-18, 10:30, Dietmar Eggemann wrote:
> I would suggest we leave the call to sync_entity_load_avg() in the slow path
> of strf() so that we're not forced to call it in
> find_energy_efficient_cpu().

Well, that's what I did in the very first attempt:

https://lkml.kernel.org/r/20180425051509.aohopadqw7q5urbd@vireshk-i7

But then I realized that based on the current state of code, its
better to move it to find_idlest_cpu() instead.

I would be fine with sending the above patch instead (if Peter
agrees). Though it should be trivial to move it back to strq() in the
patch where you are adding call to find_energy_efficient_cpu().

I am fine with both the options though.

-- 
viresh
