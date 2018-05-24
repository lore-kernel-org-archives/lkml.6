Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034700AbeEXWGW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:06:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33927 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034671AbeEXWGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:06:18 -0400
X-Google-Smtp-Source: AB8JxZrYMSeLw2nsgDnIE+fL8kSiUIVSgNI5FbqKNFpn9Df7IWpbJScCWogs09ImncGD+ocncREbtA==
Date: Fri, 25 May 2018 00:06:10 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, linux-arm-kernel@lists.infradead.org,
        yamada.masahiro@socionext.com
Subject: Re: [PATCH 6/9] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
Message-ID: <20180524220610.GA7607@andrea>
References: <1527159586-8578-1-git-send-email-will.deacon@arm.com>
 <1527159586-8578-7-git-send-email-will.deacon@arm.com>
 <20180524124410.GF12198@hirez.programming.kicks-ass.net>
 <20180524124734.GE8689@arm.com>
 <20180524130948.f37eltocl5tnittp@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524130948.f37eltocl5tnittp@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> As an aside, If I complete the autogeneration stuff, it'll be possible
> to generate those. I split out the necessary barriers in [1], but I
> still have a lot of other preparatory cleanup to do.

I do grasp the rationale behind that naming:

  __atomic_mb_{before,after}_{acquire,release,fence}()

and yet I remain puzzled by it:

For example, can you imagine (using):

  __atomic_mb_before_acquire() ?

(as your __atomic_mb_after_acquire() is whispering me "acquire-fences"...)

Another example:

  the "atomic" in that "smp_mb__{before,after}_atomic" is so "suggestive"!
   
(think at x86...), but it's not explicit in the proposed names.

I don't have other names to suggest at the moment...  ;/ (aka just saying)

  Andrea


> 
> IIUC, the void-returning atomic ops are relaxed, so trying to unify that
> with the usual rule that no suffix means fence will slow things down
> unless we want to do a treewide substitition to fixup for that.
> 
> Thanks,
> Mark.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=atomics/api-unification&id=c6b9ff2627d06776e427a7f1a7f83caeff3db536
