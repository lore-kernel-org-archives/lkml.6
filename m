Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeEDOiK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:38:10 -0400
Received: from foss.arm.com ([217.140.101.70]:54548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbeEDOiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:38:09 -0400
Date: Fri, 4 May 2018 15:38:05 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dvyukov@google.com, mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH 2/3] kcov: prefault the kcov_area
Message-ID: <20180504143805.bwakjtfryrw7l2qx@lakrids.cambridge.arm.com>
References: <20180504135535.53744-1-mark.rutland@arm.com>
 <20180504135535.53744-3-mark.rutland@arm.com>
 <2389e204-1b78-00a8-d69d-0ca4969be1fd@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2389e204-1b78-00a8-d69d-0ca4969be1fd@virtuozzo.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 05:36:49PM +0300, Andrey Ryabinin wrote:
> 
> 
> On 05/04/2018 04:55 PM, Mark Rutland wrote:
> 
> >  
> > +static void kcov_fault_in_area(struct kcov *kcov)
> > +{
> > +	unsigned long stride = PAGE_SIZE / sizeof(unsigned long);
> > +	unsigned long *area = kcov->area;
> > +	unsigned long offset;
> > +
> > +	for (offset = 0; offset < kcov->size; offset += stride) {
> > +		READ_ONCE(area[offset]);
> > +	}
> 
> Usually we don't use {} for a single statement blocks.
> 
> > +}
> > +

I'll remove the braces.

Can I consider that an ack, otherwise? :)

Thanks,
Mark.
