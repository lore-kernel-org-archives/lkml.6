Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbeCTJRl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:17:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37532 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751402AbeCTJRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:17:40 -0400
Date: Tue, 20 Mar 2018 09:17:35 +0000
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Gaku Inami <gaku.inami.xh@renesas.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 0/7] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
Message-ID: <20180320091735.GN4589@e105550-lin.cambridge.arm.com>
References: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
 <OSBPR01MB1800210FC368705EAADA27C4A2AB0@OSBPR01MB1800.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB1800210FC368705EAADA27C4A2AB0@OSBPR01MB1800.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 20, 2018 at 05:30:00AM +0000, Gaku Inami wrote:
> Hi
> 
> > -----Original Message-----
> > From: Morten Rasmussen [mailto:morten.rasmussen@arm.com]
> > Sent: Thursday, March 15, 2018 11:47 PM
> > To: peterz@infradead.org; mingo@redhat.com
> > Cc: valentin.schneider@arm.com; dietmar.eggemann@arm.com; vincent.guittot@linaro.org; Gaku Inami
> > <gaku.inami.xh@renesas.com>; linux-kernel@vger.kernel.org; Morten Rasmussen <morten.rasmussen@arm.com>
> > Subject: [PATCHv2 0/7] sched/fair: Migrate 'misfit' tasks on asymmetric capacity systems
> [snip]
> > 
> > The patches have been tested on:
> >    1. Arm Juno (r0): 2+4 Cortex A57/A53
> >    2. Hikey960: 4+4 Cortex A73/A53
> > 
> 
> I have tested this on our R-Car again and it works well. In addition,
> I confirmed that this patch-set also brings performance improvement to
> other benchmarks(e.g. memory load latency in LMbench). You can add:
> 
> Tested-by: Gaku Inami <gaku.inami.xh@renesas.com>
> 
> The patches have been tested on:
>    3. Renesas R-Car H3 : 4+4 Cortex A57/A53
> 
> Results:
> Single runs with completion time of each task
> R-Car H3 (tip)
>     total time:                          0.9435s
>     total time:                          0.9952s
>     total time:                          1.3511s
>     total time:                          1.6747s
> 
> R-Car H3 (misfit)
>     total time:                          0.9387s
>     total time:                          0.9280s
>     total time:                          0.9616s
>     total time:                          0.9934s
> 
> 10 run summary (tracking longest running task for each run)
> 	R-Car H3
> 	avg	max
> tip     1.6737  1.6758
> misfit  0.9980  1.0409

Thanks a lot for testing again.

Morten
