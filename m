Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B0AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA1E2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA1E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeK3SES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:04:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:55086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726456AbeK3SER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:04:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E5FDAF58;
        Fri, 30 Nov 2018 06:55:58 +0000 (UTC)
Subject: Re: arch/x86/include/asm/cmpxchg.h:245:2: error: 'asm' operand has
 impossible constraints
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <201811301413.r3UWSoXH%fengguang.wu@intel.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <56b6dc1c-d596-56a2-7c64-7e31a7c81f50@suse.com>
Date:   Fri, 30 Nov 2018 07:55:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <201811301413.r3UWSoXH%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 07:44, kbuild test robot wrote:
> Hi Juergen,
> 
> FYI, the error/warning still remains.

This problem is one of gcc. It is in no way the (direct) result of my
patch. Please see my gcc bug report:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=908154


Juergen

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   94f371cb73944b410a269d570d6946c042f2ddd0
> commit: 6da63eb241a05b0e676d68975e793c0521387141 x86/paravirt: Move the pv_irq_ops under the PARAVIRT_XXL umbrella
> date:   3 months ago
> config: i386-randconfig-sb0-11301144 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         git checkout 6da63eb241a05b0e676d68975e793c0521387141
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/x86/include/asm/atomic.h:8:0,
>                     from arch/x86/include/asm/msr.h:67,
>                     from arch/x86/include/asm/processor.h:21,
>                     from arch/x86/include/asm/cpufeature.h:5,
>                     from arch/x86/include/asm/thread_info.h:53,
>                     from include/linux/thread_info.h:38,
>                     from arch/x86/include/asm/preempt.h:7,
>                     from include/linux/preempt.h:81,
>                     from include/linux/spinlock.h:51,
>                     from include/linux/mmzone.h:8,
>                     from include/linux/gfp.h:6,
>                     from include/linux/mm.h:10,
>                     from mm/slub.c:13:
>    mm/slub.c: In function '__slab_free':
>>> arch/x86/include/asm/cmpxchg.h:245:2: error: 'asm' operand has impossible constraints
>      asm volatile(pfx "cmpxchg%c4b %2; sete %0"   \
>      ^
>    arch/x86/include/asm/cmpxchg.h:254:2: note: in expansion of macro '__cmpxchg_double'
>      __cmpxchg_double(LOCK_PREFIX, p1, p2, o1, o2, n1, n2)
>      ^
>    include/asm-generic/atomic-instrumented.h:457:2: note: in expansion of macro 'arch_cmpxchg_double'
>      arch_cmpxchg_double(__ai_p1, (p2), (o1), (o2), (n1), (n2)); \
>      ^
>    mm/slub.c:403:7: note: in expansion of macro 'cmpxchg_double'
>       if (cmpxchg_double(&page->freelist, &page->counters,
>           ^
> 
> vim +/asm +245 arch/x86/include/asm/cmpxchg.h
> 
> 3d94ae0c Jeremy Fitzhardinge 2011-09-28  235  
> cdcd6298 Jan Beulich         2012-01-02  236  #define __cmpxchg_double(pfx, p1, p2, o1, o2, n1, n2)			\
> cdcd6298 Jan Beulich         2012-01-02  237  ({									\
> cdcd6298 Jan Beulich         2012-01-02  238  	bool __ret;							\
> cdcd6298 Jan Beulich         2012-01-02  239  	__typeof__(*(p1)) __old1 = (o1), __new1 = (n1);			\
> cdcd6298 Jan Beulich         2012-01-02  240  	__typeof__(*(p2)) __old2 = (o2), __new2 = (n2);			\
> cdcd6298 Jan Beulich         2012-01-02  241  	BUILD_BUG_ON(sizeof(*(p1)) != sizeof(long));			\
> cdcd6298 Jan Beulich         2012-01-02  242  	BUILD_BUG_ON(sizeof(*(p2)) != sizeof(long));			\
> cdcd6298 Jan Beulich         2012-01-02  243  	VM_BUG_ON((unsigned long)(p1) % (2 * sizeof(long)));		\
> cdcd6298 Jan Beulich         2012-01-02  244  	VM_BUG_ON((unsigned long)((p1) + 1) != (unsigned long)(p2));	\
> cdcd6298 Jan Beulich         2012-01-02 @245  	asm volatile(pfx "cmpxchg%c4b %2; sete %0"			\
> cdcd6298 Jan Beulich         2012-01-02  246  		     : "=a" (__ret), "+d" (__old2),			\
> cdcd6298 Jan Beulich         2012-01-02  247  		       "+m" (*(p1)), "+m" (*(p2))			\
> cdcd6298 Jan Beulich         2012-01-02  248  		     : "i" (2 * sizeof(long)), "a" (__old1),		\
> cdcd6298 Jan Beulich         2012-01-02  249  		       "b" (__new1), "c" (__new2));			\
> cdcd6298 Jan Beulich         2012-01-02  250  	__ret;								\
> cdcd6298 Jan Beulich         2012-01-02  251  })
> cdcd6298 Jan Beulich         2012-01-02  252  
> 
> :::::: The code at line 245 was first introduced by commit
> :::::: cdcd629869fabcd38ebd24a03b0a05ec1cbcafb0 x86: Fix and improve cmpxchg_double{,_local}()
> 
> :::::: TO: Jan Beulich <JBeulich@suse.com>
> :::::: CC: Ingo Molnar <mingo@elte.hu>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

