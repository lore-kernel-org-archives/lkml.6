Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D5FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC5320865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz+xeMef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC5320865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeKXTRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 14:17:17 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41874 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbeKXTRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 14:17:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so12403291ljb.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 00:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kU1ElEhVkbr30oK8MLui4GfD2NPYz5fVABy0vwjSEFk=;
        b=Fz+xeMefCjlyeh8dq8n2CnOQE8EVVSD1pG6i+ZsxPrIKQrP1WxPCZJZMpDHMgs05GU
         lDxUNvl8a+KDzfUphm/rBCKAGqovGHaOp1QlIg5Wg7PAQUSaKxA3tqcO1FQqvsPgGVae
         x3ZnVgAqDscXtdnwWEi95JfjZ8ImqDvqQs0NVIo0JQ+yj066G4zbb/wfY8XChSuoTWEt
         85rzXc+0zFxd2SfngerJ5Uw1GZISYZbzQ5sgLRKnvzz+8b97NWwCuaw2PgVmckWu6COQ
         ZnVg2l1Ycp09GroPPs5dVHgfvHQ747xKGEN1Lr3+WQDSSMMkRFsy/zBeX4fbP0xk/Rv7
         a2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kU1ElEhVkbr30oK8MLui4GfD2NPYz5fVABy0vwjSEFk=;
        b=NPlgeRmCHeExQQuw8jIYNzU0xsFO/ZhnvYckMv8gCz2SlaUCMuFM0U2DWO9JndOkxW
         ecbfuSITqPHIJ7yvdoBwDIMmRXmFupUUr6djUpCteLLSCOvblb/L7wTZ3+LGxdnlceE/
         SemAtzXBdNfnaTfbInSBIqky8lIL88tzq6AMTG/FPJgOb3nABpNKozfiU2fQk1XxaS52
         9K7ncfKU1cAIZ1WRc4EhPLfJgsxO+lwMJ6nJ9pfHIBBLFeqtSw6q4JAxYUBfLuQDXgzl
         RCQTfcG4U9uQfvxTC+LtTB508caoUsumM6nUX44RsfLsWAf+fzwqMhg+mxEy7TQ+pLlJ
         anBA==
X-Gm-Message-State: AA+aEWYVefhjMe7wPMliVtfwn34A7CwcIISeiPAwiMkXmNVLoaPB602R
        I5gqb0N3aEi+rqFs9U59tWfGKmOyh4cFVNbjseI=
X-Google-Smtp-Source: AFSGD/W7uVn++HR4iDKkrxrpcQCAazfFdJyTddXL9zh8UdVvvV17eieQtZsQEW49BdbTANWo/qRo9nL9ACevISVTap0=
X-Received: by 2002:a2e:6f11:: with SMTP id k17-v6mr11715111ljc.94.1543048169760;
 Sat, 24 Nov 2018 00:29:29 -0800 (PST)
MIME-Version: 1.0
References: <1542856462-18836-1-git-send-email-yamada.masahiro@socionext.com> <1542856462-18836-3-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1542856462-18836-3-git-send-email-yamada.masahiro@socionext.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 24 Nov 2018 09:29:19 +0100
Message-ID: <CANiq72n25pSbQgHqYtLOFYMkWyzfFLfsMRmzpHNZHh=APXoFww@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] build_bug.h: remove most of dummy BUILD_BUG_ON
 stubs for Sparse
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, josh@joshtriplett.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 5:08 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
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
> GCC is absolutely fine with it (-Wvla was enabled only very recently),
> but Sparse warns like this:
>
>   error: bad constant expression
>   error: cannot size expression
>
> (If you are using a newer version of Sparse, you will see a different
> warning message, "warning: Variable length array is used".)
>
> Anyway, Sparse was producing many false positives, and noisier than
> it should be at that time.
>
> With the previous commit, the leftover negative array trick is gone.
> Sparse is fine with the current BUILD_BUG_ON(), which is implemented
> by using the 'error' attribute.
>
> I am keeping the stub for BUILD_BUG_ON_ZERO(). Otherwise, Sparse
> would complain about the following code, which GCC is fine with:
>
>   static const int x = 0;
>   int y = BUILD_BUG_ON_ZERO(x);
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Nice to see those CHECKER blocks are being reduced!

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
