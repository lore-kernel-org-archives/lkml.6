Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245BFC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF122086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF122086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJIVTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:19:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbeJIVTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:19:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82CE53082143;
        Tue,  9 Oct 2018 14:01:56 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0631702EC;
        Tue,  9 Oct 2018 14:01:55 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 14599109; Tue,  9 Oct 2018 11:01:53 -0300 (BRT)
Date:   Tue, 9 Oct 2018 11:01:53 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 01/12] tools include: Adopt linux/bits.h
Message-ID: <20181009140152.GA2486@redhat.com>
References: <20181009005427.6607-1-acme@kernel.org>
 <20181009005427.6607-2-acme@kernel.org>
 <f40d9bab-dd39-5a88-6e85-36f4c6069668@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f40d9bab-dd39-5a88-6e85-36f4c6069668@nokia.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 09 Oct 2018 14:01:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 09, 2018 at 10:47:35AM +0200, Alexander Sverdlin escreveu:
> Hello Arnaldo,
> 
> On 09/10/2018 02:54, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > So that we reduce the difference of tools/include/linux/bitops.h to the
> > original kernel file, include/linux/bitops.h, trying to remove the need
> > to define BITS_PER_LONG, to avoid clashes with asm/bitsperlong.h.
> 
> thanks for looking into this, but I don't quite get your plan here,
> you neither remove redefinition of BITS_PER_LONG in this patch, nor
> in any following patch in the series.

I tried looking into this, got these patches as preparatory, but then
got sidetracked, pushed what I had, have to continue working on it. But
I'm busy with other stuff right now, again.

- Arnaldo

> Have you forgot to include another patch or shall I try to come up with
> a patch removing BITS_PER_LONG from bitops.h? 
> 
> > And the things removed from tools/include/linux/bitops.h are really in
> > linux/bits.h, so that we can have a copy and then
> > tools/perf/check_headers.sh will tell us when new stuff gets added to
> > linux/bits.h so that we can check if it is useful and if any adjustment
> > needs to be done to the tools/{include,arch}/ copies.
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> > Cc: David Ahern <dsahern@gmail.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Wang Nan <wangnan0@huawei.com>
> > Link: https://lkml.kernel.org/n/tip-y1sqyydvfzo0bjjoj4zsl562@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/include/linux/bitops.h |  7 ++-----
> >  tools/include/linux/bits.h   | 26 ++++++++++++++++++++++++++
> >  tools/perf/check-headers.sh  |  1 +
> >  3 files changed, 29 insertions(+), 5 deletions(-)
> >  create mode 100644 tools/include/linux/bits.h
> > 
> > diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
> > index acc704bd3998..0b0ef3abc966 100644
> > --- a/tools/include/linux/bitops.h
> > +++ b/tools/include/linux/bitops.h
> > @@ -3,8 +3,6 @@
> >  #define _TOOLS_LINUX_BITOPS_H_
> >  
> >  #include <asm/types.h>
> > -#include <linux/compiler.h>
> > -
> >  #ifndef __WORDSIZE
> >  #define __WORDSIZE (__SIZEOF_LONG__ * 8)
> >  #endif
> > @@ -12,10 +10,9 @@
> >  #ifndef BITS_PER_LONG
> >  # define BITS_PER_LONG __WORDSIZE
> >  #endif
> > +#include <linux/bits.h>
> > +#include <linux/compiler.h>
> >  
> > -#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
> > -#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
> > -#define BITS_PER_BYTE		8
> >  #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
> >  #define BITS_TO_U64(nr)		DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u64))
> >  #define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u32))
> > diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
> > new file mode 100644
> > index 000000000000..2b7b532c1d51
> > --- /dev/null
> > +++ b/tools/include/linux/bits.h
> > @@ -0,0 +1,26 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __LINUX_BITS_H
> > +#define __LINUX_BITS_H
> > +#include <asm/bitsperlong.h>
> > +
> > +#define BIT(nr)			(1UL << (nr))
> > +#define BIT_ULL(nr)		(1ULL << (nr))
> > +#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
> > +#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
> > +#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
> > +#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
> > +#define BITS_PER_BYTE		8
> > +
> > +/*
> > + * Create a contiguous bitmask starting at bit position @l and ending at
> > + * position @h. For example
> > + * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> > + */
> > +#define GENMASK(h, l) \
> > +	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
> > +
> > +#define GENMASK_ULL(h, l) \
> > +	(((~0ULL) - (1ULL << (l)) + 1) & \
> > +	 (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
> > +
> > +#endif	/* __LINUX_BITS_H */
> > diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> > index 466540ee8ea7..c72cc73a6b09 100755
> > --- a/tools/perf/check-headers.sh
> > +++ b/tools/perf/check-headers.sh
> > @@ -14,6 +14,7 @@ include/uapi/linux/sched.h
> >  include/uapi/linux/stat.h
> >  include/uapi/linux/vhost.h
> >  include/uapi/sound/asound.h
> > +include/linux/bits.h
> >  include/linux/hash.h
> >  include/uapi/linux/hw_breakpoint.h
> >  arch/x86/include/asm/disabled-features.h
> > 
> 
> -- 
> Best regards,
> Alexander Sverdlin.
