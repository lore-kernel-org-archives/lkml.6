Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754820AbeDCFwn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 01:52:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754305AbeDCFwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 01:52:42 -0400
Date: Tue, 3 Apr 2018 07:52:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH 10/10] softirq: Remove __ARCH_SET_SOFTIRQ_PENDING
In-Reply-To: <20180329180836.GS4082@hirez.programming.kicks-ass.net>
References: <1522290425-22844-1-git-send-email-frederic@kernel.org>
        <1522290425-22844-11-git-send-email-frederic@kernel.org>
        <20180329071619.GO4082@hirez.programming.kicks-ass.net>
        <20180329134745.GA12958@lerouge>
        <20180329140111.GC4043@hirez.programming.kicks-ass.net>
        <20180329140748.GB12958@lerouge>
        <20180329165343.39f4486f@mschwideX1>
        <20180329180836.GS4082@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18040305-0040-0000-0000-00000448FD40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040305-0041-0000-0000-000020ED0620
Message-Id: <20180403075225.69ad3d25@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804030062
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018 20:08:36 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Mar 29, 2018 at 04:53:43PM +0200, Martin Schwidefsky wrote:
> > The lowcore optimization for softirq_pending field is not really needed,
> > just nice to have. But if there is a strong reason to make a common
> > definition for it we can certainly do that.  
> 
> A slightly related question; would it make sense to move all kernel
> static per-cpu stuff into lowcore, or is that asking for too much
> trickery?
 
The space in lowcore is quite limited, for zArch the structure is 8K with
many pre-defined fields. I fear that putting all of the static per-cpu
stuff in there is too much. 

So far I used the lowcore as optimization for selected per-cpu fields
which are performance relevant.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
