Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753235AbeFDNKm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:10:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753187AbeFDNKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:10:40 -0400
Date: Mon, 4 Jun 2018 06:09:34 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 05/19] sched/numa: Use task faults only if numa_group is
 not yet setup
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-6-git-send-email-srikar@linux.vnet.ibm.com>
 <20180604122408.GT12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180604122408.GT12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18060413-0016-0000-0000-000001D784F6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060413-0017-0000-0000-0000322A1679
Message-Id: <20180604130934.GC38574@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=990 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040156
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
> > numa01.sh      Real:      478.45      565.90      515.11       30.87 	 16.29%
> > numa01.sh       Sys:      207.79      271.04      232.94       21.33 	 -15.8%
> > numa01.sh      User:    39763.93    47303.12    43210.73     2644.86 	 14.04%
> > numa02.sh      Real:       60.00       61.46       60.78        0.49 	 0.871%
> > numa02.sh       Sys:       15.71       25.31       20.69        3.42 	 17.35%
> > numa02.sh      User:     5175.92     5265.86     5235.97       32.82 	 0.464%
> > numa03.sh      Real:      776.42      834.85      806.01       23.22 	 -7.47%
> > numa03.sh       Sys:      114.43      128.75      121.65        5.49 	 -19.5%
> > numa03.sh      User:    60773.93    64855.25    62616.91     1576.39 	 -5.36%
> > numa04.sh      Real:      456.93      511.95      482.91       20.88 	 2.930%
> > numa04.sh       Sys:      178.09      460.89      356.86       94.58 	 -11.3%
> > numa04.sh      User:    36312.09    42553.24    39623.21     2247.96 	 0.246%
> > numa05.sh      Real:      393.98      493.48      436.61       35.59 	 0.677%
> > numa05.sh       Sys:      164.49      329.15      265.87       61.78 	 38.92%
> > numa05.sh      User:    33182.65    36654.53    35074.51     1187.71 	 3.368%
> > 
> > Ideally this change shouldn't have affected performance.
> 
> Ideally you go on here to explain why it does in fact do affect
> performance.. :-)

I know it looks bad, but I have been unable to figure out why this patch
affects performance. I repeated the experiment multiple times to recheck
if it was not a one off problem. While there is a variance in different
runs, we do see a change in numbers before and after this patch atleast
on my machine.
