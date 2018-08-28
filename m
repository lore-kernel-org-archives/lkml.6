Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ADEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F20F20868
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FsdoKy5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F20F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbeH2Cy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:54:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46941 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH2Cy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:54:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so1406744pga.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 16:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bE9wJ9fEKlFzXrt1nBEEL+L9t4J/pFX7OB46Vh8MtIc=;
        b=FsdoKy5OoI0YgLR/VrTG8WN2fCMsmI02bV79cuQfti0KWxpJSwWnqPti6xj2AG4tVK
         zsjIpFUj47RTKlpNwYeflQOmLkwJxSrrkB75y32vfQtY9KHgalvdZpt26YlWtAd4OCMX
         BucUTNNSSRrJTIUtxRHNxKHXRL+MIrbMA+7jqpG97bsoVO/YvBP9Mz1TvbZ4dgv9DHNk
         IRJJ3BjpK1SOBiIYN1uyD/VtN4AAw9vkmuBvhLIvpqKvdJyevOh4G1sKG95UA7xgA8GP
         peDujpJ68cKVUs2v8KZMOV3dwmAiJhStw/u2+Nv86h87fAGJUiyuyAbA/IjbROgv0brj
         BqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bE9wJ9fEKlFzXrt1nBEEL+L9t4J/pFX7OB46Vh8MtIc=;
        b=qyNmzNkyOweUemtB0c31LxT4g5+Y280+azbNqjma57og3FL1WmD4am33oSrH4etno2
         wIezgqRhFcqLX866hXgoi/oMPc1bbZR980CNR/l966a0Ebq7k1PNu4x0z3mHZnEsZgZ5
         TRZEGOIqOkFFe0GqUKp1o+dP/J/NiGz3YibFv1i0f1P/83dJIzJSciDxeJI4oUGwUdnV
         6pwii4s2Ej73Fkn8k52f2cExpprgLR5O9VppOycyK2jYSb+9amzIbzLDUCSSEgigRNMh
         kgKa+RzocgBr8c2hrlGiPrVWAHewdDtNSmu2xgM0Dqga660kIAi+ALSlTmlyDPPnIgRL
         Hz5A==
X-Gm-Message-State: APzg51BfRQk3w5N/wvpXItInt9rzZB5jp1VaXFShQJapx0hwiWogauhv
        PkzlTKk27IC2Jm52d2eMPT7+i5fnlKiRpueGyBcIgA==
X-Google-Smtp-Source: ANB0VdaSPfimA2ObvMKOH2TRLRjMOosusUnqqYzMk+RfsiLyL7ovS9tnM8n2SPqv11JYpZMfIt/69KNQv2vDTeKVSr0=
X-Received: by 2002:a63:1e11:: with SMTP id e17-v6mr3225377pge.225.1535497266867;
 Tue, 28 Aug 2018 16:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
 <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com> <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com>
In-Reply-To: <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 28 Aug 2018 16:00:55 -0700
Message-ID: <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     daniel.santos@pobox.com
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, sparse@chrisli.org,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 1:42 PM Daniel Santos <daniel.santos@pobox.com> wrote:
>
> Hello Nick,
>
> On 08/27/2018 03:09 PM, Nick Desaulniers wrote:
> >>> Let's give up __compiletime_assert_fallback().  This commit does not
> >>> change the current behavior since it just rips off the useless code.
> >> Clang is not the only target audience of
> >> __compiletime_assert_fallback().  Instead of ripping out something that
> >> may benefit builds with gcc 4.2 and earlier, why not override its
> > Note that with commit cafa0010cd51 ("Raise the minimum required gcc
> > version to 4.6") that gcc < 4.6 is irrelevant.
>
> Ah, I guess I'm not keeping up, that's wonderful news!  Considering that
> I guess I would be OK with its removal, but I still think it would be
> better if a similar mechanism to break the Clang build could be found.

I'm consulting with our best language lawyers to see what combinations
of _Static_assert and __builtin_constant_p would do the trick.
