Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751762AbeFEIuw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:50:52 -0400
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:52753 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751539AbeFEIuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:50:51 -0400
Date: Tue, 5 Jun 2018 09:50:49 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 07/19] sched/numa: Skip nodes that are at hoplimit
Message-ID: <20180605085049.uphvewwssbjujxje@techsingularity.net>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-8-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1528106428-19992-8-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 03:30:16PM +0530, Srikar Dronamraju wrote:
> When comparing two nodes at a distance of hoplimit, we should consider
> nodes only upto hoplimit. Currently we also consider nodes at hoplimit
> distance too. Hence two nodes at a distance of "hoplimit" will have same
> groupweight. Fix this by skipping nodes at hoplimit.
> 
> Testcase       Time:         Min         Max         Avg      StdDev
> numa01.sh      Real:      478.45      565.90      515.11       30.87
> numa01.sh       Sys:      207.79      271.04      232.94       21.33
> numa01.sh      User:    39763.93    47303.12    43210.73     2644.86
> numa02.sh      Real:       60.00       61.46       60.78        0.49
> numa02.sh       Sys:       15.71       25.31       20.69        3.42
> numa02.sh      User:     5175.92     5265.86     5235.97       32.82
> numa03.sh      Real:      776.42      834.85      806.01       23.22
> numa03.sh       Sys:      114.43      128.75      121.65        5.49
> numa03.sh      User:    60773.93    64855.25    62616.91     1576.39
> numa04.sh      Real:      456.93      511.95      482.91       20.88
> numa04.sh       Sys:      178.09      460.89      356.86       94.58
> numa04.sh      User:    36312.09    42553.24    39623.21     2247.96
> numa05.sh      Real:      393.98      493.48      436.61       35.59
> numa05.sh       Sys:      164.49      329.15      265.87       61.78
> numa05.sh      User:    33182.65    36654.53    35074.51     1187.71
> 
> Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
> numa01.sh      Real:      414.64      819.20      556.08      147.70 	 -7.36%
> numa01.sh       Sys:       77.52      205.04      139.40       52.05 	 67.10%
> numa01.sh      User:    37043.24    61757.88    45517.48     9290.38 	 -5.06%
> numa02.sh      Real:       60.80       63.32       61.63        0.88 	 -1.37%
> numa02.sh       Sys:       17.35       39.37       25.71        7.33 	 -19.5%
> numa02.sh      User:     5213.79     5374.73     5268.90       55.09 	 -0.62%
> numa03.sh      Real:      780.09      948.64      831.43       63.02 	 -3.05%
> numa03.sh       Sys:      104.96      136.92      116.31       11.34 	 4.591%
> numa03.sh      User:    60465.42    73339.78    64368.03     4700.14 	 -2.72%
> numa04.sh      Real:      412.60      681.92      521.29       96.64 	 -7.36%
> numa04.sh       Sys:      210.32      314.10      251.77       37.71 	 41.74%
> numa04.sh      User:    34026.38    45581.20    38534.49     4198.53 	 2.825%
> numa05.sh      Real:      394.79      439.63      411.35       16.87 	 6.140%
> numa05.sh       Sys:      238.32      330.09      292.31       38.32 	 -9.04%
> numa05.sh      User:    33456.45    34876.07    34138.62      609.45 	 2.741%
> 
> While there is a regression with this change, this change is needed from a
> correctness perspective. Also it helps consolidation as seen from perf bench
> output.
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Agreed that it's better from a correctness POV

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
