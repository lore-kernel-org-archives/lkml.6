Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D7C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9C420863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="q5wrC9We"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfBHPmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:42:47 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40388 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbfBHPmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:42:46 -0500
Received: from zn.tnic (p200300EC2BC9F9007DDA8219BB83B60F.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:f900:7dda:8219:bb83:b60f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C1701EC096B;
        Fri,  8 Feb 2019 16:42:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549640564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/A7uikAdQaVJMXlK4goukqq7euk9Zo9vixwi+aS0DAs=;
        b=q5wrC9WeY49gravJvyv8XnuFWX1MaQhoJiauR3tRbke7zHeb0B0AKUPnTDUEdNaWPfdGpR
        +G3C1LmHlBkM06k6g4tdhzRk/rOX2oAWhPcFvR4xl+DZljX6lMG0/RxBjpZ7wtGceS/W1c
        tD5xbn3IlldBnkFhCjnRoOkFYd8NSBg=
Date:   Fri, 8 Feb 2019 16:42:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH 1/3] x86/mpx: tweak header name
Message-ID: <20190208154239.GI674@zn.tnic>
References: <20190124142448.23243-1-mst@redhat.com>
 <20190124142448.23243-2-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124142448.23243-2-mst@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 01:02:53AM -0500, Michael S. Tsirkin wrote:
> Use linux/mman.h to make sure we get all mmap flags we need.

Why, asm/mman.h is not enough or is this fixing a build issue or what is that
patch supposed to address?

> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/x86/mm/mpx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
> index de1851d15699..c805db6236b4 100644
> --- a/arch/x86/mm/mpx.c
> +++ b/arch/x86/mm/mpx.c
> @@ -9,12 +9,12 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/mm_types.h>
> +#include <linux/mman.h>
>  #include <linux/syscalls.h>
>  #include <linux/sched/sysctl.h>
>  
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
> -#include <asm/mman.h>
>  #include <asm/mmu_context.h>
>  #include <asm/mpx.h>
>  #include <asm/processor.h>
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
