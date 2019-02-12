Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF594C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE6A20863
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ed6pvDtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfBLMWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:22:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfBLMWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NsLRrNbafIHTfDLz8D4xhJHCooT7lkn4ijDZY6W/w4k=; b=Ed6pvDtueIPmZ/q3r2nNrq5Sl
        pg/qJpW6afXw5o69VH4TsgPl06FcDS7HxW5LzLE2edJYp57aT0eL0mH4LpVn/aEJSuIuvyxJtelEv
        QPhChQfH8sJyfelCCawqHPlL0nljFr1Fl8lYUPpkkGv9jsBDRLEfPL/Pp71oKy6BQchwILc28yZqX
        RqtFP3ZpNzpu3qmqPA7EGal0HliYrydfmpcA6sYwLE7U2cH/COoWy50yHkqRE1urFPmscyAhVQ3R7
        Mpo4pt6wvZQEl3b7Xc6+TiB2P3idq330+IomaXT2YQ1Pp+Pn8DI1xjdCyX0isL1tJf57ewsq8tXqI
        giRsonnUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtX4z-0002C1-5q; Tue, 12 Feb 2019 12:22:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6043923EB8AF7; Tue, 12 Feb 2019 13:22:21 +0100 (CET)
Date:   Tue, 12 Feb 2019 13:22:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     ndesaulniers@google.com
Cc:     yamada.masahiro@socionext.com, natechancellor@gmail.com,
        sedat.dilek@gmail.com, keescook@chromium.org,
        samitolvanen@google.com, michal.lkml@markovi.net,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux@dominikbrodowski.net, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, gor@linux.ibm.com, adrian@lisas.de,
        rgb@redhat.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rui Ueyama <ruiu@google.com>
Subject: Re: [PATCH v2 4/4] Makefile: lld: set -O2 linker flag when linking
 with LLD
Message-ID: <20190212122221.GF32494@hirez.programming.kicks-ass.net>
References: <20190211193008.24101-1-ndesaulniers@google.com>
 <20190211193008.24101-4-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211193008.24101-4-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:30:06AM -0800, ndesaulniers@google.com wrote:
> For arm64:
> 0.34% size improvement with lld -O2 over lld for vmlinux.
> 3.3% size improvement with lld -O2 over lld for Image.lz4-dtb.

The Changelog is utterly failing to explain what it does.

> Link: https://github.com/ClangBuiltLinux/linux/issues/343

That is irrelevant crap.

> Suggested-by: Rui Ueyama <ruiu@google.com>
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes V1->V2:
> * add tested and reviewed by tags.
> 
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 00e8e01d23fc..8011555745aa 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -718,6 +718,10 @@ else
>  KBUILD_CFLAGS += -Wno-unused-but-set-variable
>  endif
>  
> +ifdef CONFIG_LD_IS_LLD
> +KBUILD_LDFLAGS += -O2
> +endif
> +
>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
>  ifdef CONFIG_FRAME_POINTER
>  KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
> -- 
> 2.20.1.791.gb4d0f1c61a-goog
> 
