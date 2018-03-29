Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeC2Ox4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:53:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750708AbeC2Oxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:53:54 -0400
Date: Thu, 29 Mar 2018 16:53:43 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
In-Reply-To: <20180329140748.GB12958@lerouge>
References: <1522290425-22844-1-git-send-email-frederic@kernel.org>
        <1522290425-22844-11-git-send-email-frederic@kernel.org>
        <20180329071619.GO4082@hirez.programming.kicks-ass.net>
        <20180329134745.GA12958@lerouge>
        <20180329140111.GC4043@hirez.programming.kicks-ass.net>
        <20180329140748.GB12958@lerouge>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18032914-0044-0000-0000-000005414FF4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032914-0045-0000-0000-0000288152EF
Message-Id: <20180329165343.39f4486f@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803290157
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018 16:07:49 +0200
Frederic Weisbecker <frederic@kernel.org> wrote:

> On Thu, Mar 29, 2018 at 04:01:11PM +0200, Peter Zijlstra wrote:
> > On Thu, Mar 29, 2018 at 03:47:46PM +0200, Frederic Weisbecker wrote:  
> > > On Thu, Mar 29, 2018 at 09:16:19AM +0200, Peter Zijlstra wrote:  
> > > > On Thu, Mar 29, 2018 at 04:27:05AM +0200, Frederic Weisbecker wrote:  
> > > > > The last user of __ARCH_SET_SOFTIRQ_PENDING has been converted to generic
> > > > > per-cpu softirq mask. We can now remove this conditional.  
> > > > 
> > > > This seems like half a cleanup; who still has local_softirq_pending()
> > > > after this?  
> > > 
> > > Only s390 because it uses lowcore to store such cpu data.  
> > 
> > Is it worth keeping it there? It seems an aweful shame to keep this
> > stuff special cased for just the one arch. At the very least this
> > should've mentioned s390 is special and why.  
> 
> Right, I thought well about moving that special case to s390. I can
> do that in v2.

The lowcore optimization for softirq_pending field is not really needed,
just nice to have. But if there is a strong reason to make a common
definition for it we can certainly do that.

First try has hit the wall due to include file hell though.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
