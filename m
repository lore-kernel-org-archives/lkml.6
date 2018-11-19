Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B268C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D87F206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jad4LtkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D87F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeKSXBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:01:07 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34756 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbeKSXBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:01:07 -0500
Received: by mail-ed1-f68.google.com with SMTP id b3so2523283ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 04:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uerP6zERXnXOELK7KdfQ8/C1wBZMRrgOAy1qLZQVpIU=;
        b=Jad4LtkQCHXmxMRzrwOgl64u9JcaFMUAtlDltdcXGHMch7IDR7BBcHhtrvlTScHYzw
         uUaiKsOA0slRHRscZxPzMw43caO6/FYTfSt+WSigT2PsLiikS7QTiUwCV8+pfHp34v4v
         r2A7aXTiHrIS49DNG7UNdTPq+eAyhfoH6bSUqjyHoFyZ353S+bJET0QoN4hUi4x2rDzc
         KpRLVaaVQiLjc1V4umGVBKbct+VMQ0ARnHzSVtcW377+5KOc0ASyvVN9SMvI0snd5OMH
         Cl61mfe9UNy7PZ4zYQQlLoP6+DhIFroS9fCinvL08Uq0Oa72PXhofRetyuCrl3Gc9y2u
         S3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uerP6zERXnXOELK7KdfQ8/C1wBZMRrgOAy1qLZQVpIU=;
        b=mkcU7o9XqAMOoXwmMtSFXvSjj6lBWrEt7lWevWgWdUZSe7ghN9Nwk1SDL3bI4QBn/f
         U1kKthtYIroiAyGLtHnGtE5dAVVAqVjmEQRcpjEXfKbV7qceYfCSp8W6bB3CuMcZfe00
         SFfCMRrLZkgdFBHfbZZnHAi0bnfHkOTXx+pG3ha+u1P7T0E+ivFc4JLB3bvBhl19Sxy0
         J00aIuIV+rLOGSNeDm38opLXgH1dsBKNDj0FeAD/AglFSl/L4DfOVV3A2sJ+QA7hmRZq
         Jcd+hzV7zjylG+bJh1Y6xV8waQohxcbV6vWqgE7BIy59AlOTEWz1+7GhAa5fs1F1kC6q
         jNAw==
X-Gm-Message-State: AGRZ1gJ0sNF6UymzEbEmu/LA4n9GN3qUJU1Y0UsxO7j94Hncgudy4y5L
        4Sik1cb6yZwQnY8LHjVs/tY=
X-Google-Smtp-Source: AJdET5enGJkpczabqRELSdejiWnkjUG/52bslxoNdjJ1UUnfWk+YiMk4yc247a1C8NzD3euMSLHcRw==
X-Received: by 2002:a17:906:16ca:: with SMTP id t10-v6mr16563323ejd.200.1542631055489;
        Mon, 19 Nov 2018 04:37:35 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40bc:4d00:b8ae:204:75e7:9858])
        by smtp.gmail.com with ESMTPSA id b49sm8584204edb.73.2018.11.19.04.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 04:37:35 -0800 (PST)
Date:   Mon, 19 Nov 2018 13:37:33 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] build_bug.h: remove most of dummy BUILD_BUG_ON
 stubs for sparse
Message-ID: <20181119123732.zcb6axl25bixgtly@ltop.local>
References: <1542623503-3755-1-git-send-email-yamada.masahiro@socionext.com>
 <1542623503-3755-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542623503-3755-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 07:31:43PM +0900, Masahiro Yamada wrote:
> The introduction of these dummy BUILD_BUG_ON stubs dates back to
> commit 903c0c7cdc21 ("sparse: define dummy BUILD_BUG_ON definition
> for sparse").
> 
> At that time, BUILD_BUG_ON() was implemented with the negative array
> trick *and* the link-time trick, like this:
> 
>   extern int __build_bug_on_failed;
>   #define BUILD_BUG_ON(condition)                                \
>           do {                                                   \
>                   ((void)sizeof(char[1 - 2*!!(condition)]));     \
>                   if (condition) __build_bug_on_failed = 1;      \
>           } while(0)
> 
> Sparse is more strict about the negative array trick than GCC because
> Sparse requires the array length to be really constant.
> 
> Here is the simple test code for the macro above:
> 
>   static const int x = 0;
>   BUILD_BUG_ON(x);
> 
> GCC is absolutely fine with it (-Wvla was not enabled at that time),
> but Sparse warns like this:
> 
>   error: bad constant expression
>   error: cannot size expression
> 
> (If you are using a newer version of Sparse, you will see a different
> warning message, "warning: Variable length array is used".)
> 
> Anyway, Sparse was producing many false positive warnings, hence
> silenced.
> 
> With the previous commit, the leftover negative array trick is gone.
> Sparse is fine with the current BUILD_BUG_ON(), which is implemented
> by using the 'error' attribute. (assuming your Sparse version supports
> -Wno-unknown-attribute option)
> 
> I am keeping the stub for BUILD_BUG_ON_ZERO(). Otherwise, Sparse
> would complain about the following code, which GCC is fine with:
> 
>   static const int x = 0;
>   int y = BUILD_BUG_ON_ZERO(x);
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
