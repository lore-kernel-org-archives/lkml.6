Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeC2Nrw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751908AbeC2Nru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:47:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC39621773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Thu, 29 Mar 2018 15:47:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>
Subject: Re: [PATCH 10/10] softirq: Remove __ARCH_SET_SOFTIRQ_PENDING
Message-ID: <20180329134745.GA12958@lerouge>
References: <1522290425-22844-1-git-send-email-frederic@kernel.org>
 <1522290425-22844-11-git-send-email-frederic@kernel.org>
 <20180329071619.GO4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329071619.GO4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 09:16:19AM +0200, Peter Zijlstra wrote:
> On Thu, Mar 29, 2018 at 04:27:05AM +0200, Frederic Weisbecker wrote:
> > The last user of __ARCH_SET_SOFTIRQ_PENDING has been converted to generic
> > per-cpu softirq mask. We can now remove this conditional.
> 
> This seems like half a cleanup; who still has local_softirq_pending()
> after this?

Only s390 because it uses lowcore to store such cpu data.
