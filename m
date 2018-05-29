Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933398AbeE2Lpt convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:45:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:39507 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933363AbeE2Lpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:45:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,456,1520924400";
   d="scan'208";a="43641680"
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: DRI <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20180529192605.617c02ef@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>
References: <20180529192605.617c02ef@canb.auug.org.au>
Message-ID: <152759434328.7210.11935906789217675792@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: linux-next: build failure after merge of the drm-intel-fixes tree
Date: Tue, 29 May 2018 14:45:43 +0300
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Rothwell (2018-05-29 12:26:05)
> Hi all,
> 
> After merging the drm-intel-fixes tree, today's linux-next build (i386
> defconfig) failed like this:

Thanks for reporting. I've added a patch to fix the issue now.

I'll talk with our CI team about testing 32-bit building to try to
avoid these in the future.

Regards, Joonas

> 
> In file included from include/asm-generic/barrier.h:20:0,
>                  from arch/x86/include/asm/barrier.h:86,
>                  from include/linux/nospec.h:8,
>                  from drivers/gpu/drm/i915/i915_query.c:7:
> drivers/gpu/drm/i915/i915_query.c: In function 'i915_query_ioctl':
> include/linux/compiler.h:339:38: error: call to '__compiletime_assert_119' declared with attribute error: BUILD_BUG_ON failed: sizeof(_s) > sizeof(long)
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>                                       ^
> include/linux/compiler.h:319:4: note: in definition of macro '__compiletime_assert'
>     prefix ## suffix();    \
>     ^~~~~~
> include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>   ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:69:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>   BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>   ^~~~~~~~~~~~~~~~
> include/linux/nospec.h:55:2: note: in expansion of macro 'BUILD_BUG_ON'
>   BUILD_BUG_ON(sizeof(_i) > sizeof(long));   \
>   ^~~~~~~~~~~~
> drivers/gpu/drm/i915/i915_query.c:118:15: note: in expansion of macro 'array_index_nospec'
>     func_idx = array_index_nospec(func_idx,
>                ^~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   540ead8c5a0e ("drm/i915/query: Protect tainted function pointer lookup")
> 
> I have reverted that commit for today.
> 
> -- 
> Cheers,
> Stephen Rothwell
