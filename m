Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeC2OGM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:06:12 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:39293 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752511AbeC2OGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:06:11 -0400
X-Google-Smtp-Source: AIpwx482aBMLpeZ6/bGZOvHzrMgfx+oLVN77LM7YRwul4oLfvAfUb6Vv1OfcLhUxN6aBRs3GPY++RA==
Date: Thu, 29 Mar 2018 16:06:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] perf, pt, coresight: Clean up address filter structure
Message-ID: <20180329140606.zcomu2u2xzyss4tm@gmail.com>
References: <20180329120648.11902-1-alexander.shishkin@linux.intel.com>
 <20180329121036.GZ4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329121036.GZ4043@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Mar 29, 2018 at 03:06:48PM +0300, Alexander Shishkin wrote:
> > This is a cosmetic patch that deals with the address filter structure's
> > ambiguous fields 'filter' and 'range'. The former stands to mean that the
> > filter's *action* should be to filter the traces to its address range if
> > it's set or stop tracing if it's unset. This is confusing and hard on the
> > eyes, so this patch replaces it with 'action' enum. The 'range' field is
> > completely redundant (meaning that the filter is an address range as
> > opposed to a single address trigger), as we can use zero size to mean the
> > same thing.
> > 
> > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Ingo, can you merge this?

Sure, will do!

Thanks,

	Ingo
