Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D24C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0509B20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0509B20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeLGLPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:15:23 -0500
Received: from ozlabs.org ([203.11.71.1]:45329 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbeLGLPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:15:22 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43B8yV2KbGz9s47;
        Fri,  7 Dec 2018 22:15:14 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "GitAuthor\: Christophe Leroy" <christophe.leroy@c-s.fr>,
        Douglas Anderson <dianders@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v2 2/2] kgdb/treewide: constify struct kgdb_arch arch_kgdb_ops
In-Reply-To: <5e130b11680be09537913aae9649c84ede763ec8.1544083483.git.christophe.leroy@c-s.fr>
References: <030d63848e4b0ef4d76ca24597ab8302a393d692.1544083483.git.christophe.leroy@c-s.fr> <5e130b11680be09537913aae9649c84ede763ec8.1544083483.git.christophe.leroy@c-s.fr>
Date:   Fri, 07 Dec 2018 22:15:14 +1100
Message-ID: <87va45k2pp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> checkpatch.pl reports the following:
>
>   WARNING: struct kgdb_arch should normally be const
>   #28: FILE: arch/mips/kernel/kgdb.c:397:
>   +struct kgdb_arch arch_kgdb_ops = {
>
> This report makes sense, as all other ops struct, this
> one should also be const. This patch does the change.
...

> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 59c578f865aa..bdb588b1d8fb 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -477,7 +477,7 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>  /*
>   * Global data
>   */
> -struct kgdb_arch arch_kgdb_ops;
> +const struct kgdb_arch arch_kgdb_ops;
>  
>  static int kgdb_not_implemented(struct pt_regs *regs)
>  {

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
