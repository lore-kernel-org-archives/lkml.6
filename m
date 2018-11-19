Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA09BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07CC2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsjE8AHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07CC2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732176AbeKTEZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:25:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34273 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730227AbeKTEZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:25:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so8672236pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 10:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MgahdtnYV32tyTGT6Q6qYILjgWU8vS94WNHJ16VkQL0=;
        b=MsjE8AHqOTkfoJWpebl+tpxtfNlNmed5qqOm2Gn0fZ2giDQDEbQcvoZyn4S3T5Miy9
         n7l0azdmhCXoaAdY4d3q2MM9ioP4sjGmo0SgACMGRsjWWHHc/U6t5TqG9QTdlQSKBTV5
         BxLjox6/HO7azwt961teqQ8sHdDjGXkK7yLJ6N2xAnOdu0P6TrZJVt+O/wtWfIKU4PRy
         EI+C9Ft9fkuoSt2z0D6RZCs8HIoFswPy1JFiw+dMMrC5h6t3yqz1k3Zff9IaRro8TwW7
         V0yplHDIUdK2/jqUqD1Sth1evWmlqKj7g1svgdnSW/mALXPD2f/+nA3arLozfruttbhC
         S4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MgahdtnYV32tyTGT6Q6qYILjgWU8vS94WNHJ16VkQL0=;
        b=mDYR8oUCGwwUGu8EXE2g0+aixoghkUJDrm7HfLrCZE3BgBfZk3mGuHg+TISzFttA6L
         9CfoCaEYrRq/ws5gi0CfMEMLzIeJXKc4AW+MCPy1u7AnTASunsxl40cMJc4sKWxMsMD1
         X22CN8KQbJkO+wtAyHwYIajUTYqP/o29deedZR0w1K3A1soQX+cuBlV4ngnt5fMDZxWG
         yDIR0kGg3TbAjqmEzp2enfgybCuKdC5l+PA8ktqmWfdbG43UHX0jPXcQSJA4V55PIrWx
         S+8Glgw4rxs4CON5g2Y3rLI37eYCsmOJd3bvG3/dFfi0LQLginjEoPGiUBBWh/l24fi4
         sqhw==
X-Gm-Message-State: AGRZ1gKpGwELZ0iIUci/kIsnpd9BpJBa2egkuuuJxlFd6cE+IyOENJbC
        nLLbZcqNms86mSKhPM6F6MpQK+YWQFKErBYvlhpxFQ==
X-Google-Smtp-Source: AJdET5ez1+TLV2ljhvoP0C5vVPcFdoakXgFCkL/SIgsEeus4TZzvamsoEvKy84rAnlNjcQGw9aHFWAvX7NVf4JVdOnI=
X-Received: by 2002:a63:e156:: with SMTP id h22mr21165415pgk.255.1542650465972;
 Mon, 19 Nov 2018 10:01:05 -0800 (PST)
MIME-Version: 1.0
References: <1542623503-3755-1-git-send-email-yamada.masahiro@socionext.com>
 <1542623503-3755-3-git-send-email-yamada.masahiro@socionext.com> <20181119123732.zcb6axl25bixgtly@ltop.local>
In-Reply-To: <20181119123732.zcb6axl25bixgtly@ltop.local>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 19 Nov 2018 10:00:54 -0800
Message-ID: <CAKwvOdk7WAeLPibZojsPFjvnnWWL8xE0D8=SxxWjNeoO3EY9rQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] build_bug.h: remove most of dummy BUILD_BUG_ON
 stubs for sparse
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, josh@joshtriplett.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 4:37 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Mon, Nov 19, 2018 at 07:31:43PM +0900, Masahiro Yamada wrote:
> > The introduction of these dummy BUILD_BUG_ON stubs dates back to
> > commit 903c0c7cdc21 ("sparse: define dummy BUILD_BUG_ON definition
> > for sparse").
> >
> > At that time, BUILD_BUG_ON() was implemented with the negative array
> > trick *and* the link-time trick, like this:
> >
> >   extern int __build_bug_on_failed;
> >   #define BUILD_BUG_ON(condition)                                \
> >           do {                                                   \
> >                   ((void)sizeof(char[1 - 2*!!(condition)]));     \
> >                   if (condition) __build_bug_on_failed = 1;      \
> >           } while(0)
> >
> > Sparse is more strict about the negative array trick than GCC because
> > Sparse requires the array length to be really constant.
> >
> > Here is the simple test code for the macro above:
> >
> >   static const int x = 0;
> >   BUILD_BUG_ON(x);
> >
> > GCC is absolutely fine with it (-Wvla was not enabled at that time),
> > but Sparse warns like this:
> >
> >   error: bad constant expression
> >   error: cannot size expression
> >
> > (If you are using a newer version of Sparse, you will see a different
> > warning message, "warning: Variable length array is used".)
> >
> > Anyway, Sparse was producing many false positive warnings, hence
> > silenced.
> >
> > With the previous commit, the leftover negative array trick is gone.
> > Sparse is fine with the current BUILD_BUG_ON(), which is implemented
> > by using the 'error' attribute. (assuming your Sparse version supports
> > -Wno-unknown-attribute option)
> >
> > I am keeping the stub for BUILD_BUG_ON_ZERO(). Otherwise, Sparse
> > would complain about the following code, which GCC is fine with:
> >
> >   static const int x = 0;
> >   int y = BUILD_BUG_ON_ZERO(x);
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Acked-by: Kees Cook <keescook@chromium.org>
>
> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Clang builds not affected. Tested a quick arm64 defconfig build with
Clang + this patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
