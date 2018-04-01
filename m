Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753820AbeDASXg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 14:23:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753770AbeDASXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 14:23:34 -0400
Date: Sun, 1 Apr 2018 11:24:26 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 0/3] Changes, clean-ups and documentation for
 spin_is_locked()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040118-0056-0000-0000-000004360F91
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008784; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01011656; UDB=6.00515531; IPR=6.00790931;
 MB=3.00020360; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-01 18:23:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040118-0057-0000-0000-0000087820C4
Message-Id: <20180401182426.GJ3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804010203
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 01, 2018 at 06:41:49PM +0200, Andrea Parri wrote:
> Hi Paul,
> 
> This series gathers the change to the arm64 implementation of spin_is_locked()
> and the clean-up to the generic (q)spinlock presented in [1] together with the
> patch adding the docbook header to spin_is_locked() [2].
> 
> Apart from minor adjustments to the commit messages, the patches are unchanged.

I queued these on my lkmm branch and pushed them to -rcu, thank you!

I did rework the commit logs a bit, most notably to add the URLs of
the specific messages discussion the spin_is_locked() investigation.
Please take a look and let me know if I have broken something.

							Thanx, Paul

> Cheers,
>   Andrea
> 
> [1] https://marc.info/?l=linux-kernel&m=152223038924258&w=2
> [2] https://marc.info/?l=linux-kernel&m=151981440005264&w=2
> 
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> 
> Andrea Parri (3):
>   arm64: Remove smp_mb() from arch_spin_is_locked()
>   locking: Clean-up comment and #ifndef for {,queued_}spin_is_locked()
>   Documentation/locking: Document the semantics of spin_is_locked()
> 
>  arch/arm64/include/asm/spinlock.h |  5 -----
>  include/asm-generic/qspinlock.h   |  2 --
>  include/linux/mutex.h             |  3 ---
>  include/linux/spinlock.h          | 11 +++++++++++
>  4 files changed, 11 insertions(+), 10 deletions(-)
> 
> -- 
> 2.7.4
> 
