Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeEDO4b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:56:31 -0400
Received: from foss.arm.com ([217.140.101.70]:54714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEDO4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:56:30 -0400
Date: Fri, 4 May 2018 15:56:26 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH 1/3] kcov: ensure irq code sees a valid area
Message-ID: <20180504145626.gup5ytwt3uqt57xm@lakrids.cambridge.arm.com>
References: <20180504135535.53744-1-mark.rutland@arm.com>
 <20180504135535.53744-2-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504135535.53744-2-mark.rutland@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 02:55:33PM +0100, Mark Rutland wrote:
> In kcov_init_task() Since we update t->kcov_{mode,area,size} with plain
> stores, which may be re-ordered, torn, etc. Thus
> __sanitizer_cov_trace_pc() may see bogus values for any of these fields,
> and may attempt to write to memory which is not mapped.

Whoops; that 'Since' shuoldn't be there. I've fixed this up locally.

Mark.
