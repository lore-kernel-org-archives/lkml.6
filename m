Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755567AbeEHRY4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:24:56 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:49878 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755212AbeEHRYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:24:53 -0400
Date: Tue, 8 May 2018 13:26:40 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: kernel test robot <xiaolong.ye@intel.com>
Cc: linux-kernel@vger.kernel.org, lkp@01.org
Subject: Re: [lkp-robot] [mm]  e27be240df:  will-it-scale.per_process_ops
 -27.2% regression
Message-ID: <20180508172640.GB24175@cmpxchg.org>
References: <20180508053451.GD30203@yexl-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508053451.GD30203@yexl-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, May 08, 2018 at 01:34:51PM +0800, kernel test robot wrote:
> FYI, we noticed a -27.2% regression of will-it-scale.per_process_ops due to commit:
> 
> 
> commit: e27be240df53f1a20c659168e722b5d9f16cc7f4 ("mm: memcg: make sure memory.events is uptodate when waking pollers")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: will-it-scale
> on test machine: 72 threads Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz with 128G memory
> with following parameters:
> 
> 	nr_task: 100%
> 	mode: process
> 	test: page_fault3
> 	cpufreq_governor: performance
> 
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale

This is surprising. Do you run these tests in a memory cgroup with a
limit set? Can you dump that cgroup's memory.events after the run?

Thanks
