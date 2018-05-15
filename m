Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeEOFeC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 01:34:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40800 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbeEOFeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 01:34:01 -0400
X-Google-Smtp-Source: AB8JxZrWpesFYpjw8bTDosgOYkZfnUrNXfWBfSiQLkbUZTsGCi7F8H9LkDSXfwm8jo6KYCNenyOFww==
Date: Tue, 15 May 2018 07:33:57 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: add the flag -fno-reorder-blocks-and-partition
Message-ID: <20180515053357.GA18398@gmail.com>
References: <alpine.LRH.2.02.1805150121340.30961@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1805150121340.30961@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mikulas Patocka <mpatocka@redhat.com> wrote:

> GCC 8 turns on -freorder-blocks-and-partition by default, the ORC unwinder 
> can't deal with it and it results in a lot of warnings "sibling call from 
> callable instruction with modified stack frame". This patch adds the 
> -fno-reorder-blocks-and-partition option to KBUILD_CFLAGS.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> 
> ---
>  arch/x86/Makefile |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-2.6/arch/x86/Makefile
> ===================================================================
> --- linux-2.6.orig/arch/x86/Makefile	2018-05-15 07:19:40.000000000 +0200
> +++ linux-2.6/arch/x86/Makefile	2018-05-15 07:19:40.000000000 +0200
> @@ -59,6 +59,7 @@ endif
>  #
>  KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
>  KBUILD_CFLAGS += $(call cc-option,-mno-avx,)
> +KBUILD_CFLAGS += $(call cc-option,-fno-reorder-blocks-and-partition,)

Could you check whether the latest objtool fixes in -tip:

  git git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git master

solves those warnings?

Thanks,

	Ingo
