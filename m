Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DBCC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 20:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633CF20C0B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 20:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xyoxjk33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633CF20C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeHSXlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 19:41:13 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53133 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeHSXlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 19:41:13 -0400
Received: by mail-it0-f67.google.com with SMTP id d9-v6so17929433itf.2;
        Sun, 19 Aug 2018 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KALrPVZhv+Pq7ddzg8b4zbzs9zKWiphfvp9Iz01Q05g=;
        b=Xyoxjk33fGxY7KWve7mOVZt7IBmEZsmfyFmD/tO6A6OpAjy7j/x6tMEHoI11tlGsTb
         NAI+uVoYM+r4h4m9RgYxOLKGqZQe/6M4zvMGSRPbi8S46zsNStyiabV9ZNwSQbnGJWaK
         TYc1+5alwoJQqrLgDOBapcAwNku5YcqrVF4PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KALrPVZhv+Pq7ddzg8b4zbzs9zKWiphfvp9Iz01Q05g=;
        b=nQv5890RCi35mlsRJIPPh1WKRq/ziYW5qRU7yjmzTyK5bTNsO3Dspc1mauuuMOSnQ9
         1JrALLnPP1CYSmutH2WaYZb+tHwB82IArjPgq7DbGRxKJrWAHnpHWqGEBeXryboHPFeJ
         Mnj22eNwajptmBk+M96Tn7XFq6mqaEAEeauhRiXGz9VbBl7zo/5tal3T5tDxMYq3rvS2
         kI3EcnHM/fR2Idqkq+Fq2YNtI74QifD8CZg6Y4J/DO4Gg2yB+UKMQtSHaExZJmISbogo
         rsKDnDRcNBknyPGBjD0mQL5sVZ7ve7UYuJ8I7WSwtGZgm1mytLwHZHCurORJdzALiFPU
         FtEw==
X-Gm-Message-State: AOUpUlEDK0og8eoWnbtPX9t6dewvBWKt6Z9lbe4fLb2LeYcwPaCUdE+x
        NzWq5ZJ2weH6lNxbWnzzMnHNoj4nK9XutJcT3OA=
X-Google-Smtp-Source: AA+uWPwrM4t6uhEPzU6honBFJgxFfaUHj6pi7cdsvvutSytMAQJRX1QSfalEYGcpljlZiK0dFYYCopElxG1TTUJ+DTQ=
X-Received: by 2002:a24:e0ca:: with SMTP id c193-v6mr11760628ith.22.1534710510022;
 Sun, 19 Aug 2018 13:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com> <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Aug 2018 13:28:18 -0700
Message-ID: <CA+55aFwbdc5172q5fErgqhUmt48ZYQCrc0ftN+Cn6O-xQ8Tfrg@mail.gmail.com>
Subject: Re: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Hogan <james.hogan@imgtec.com>, joe@ovn.org,
        daniel.santos@pobox.com, Rusty Russell <rusty@rustcorp.com.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Christopher Li <sparse@chrisli.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gbiv@google.com, James Y Knight <jyknight@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 1:25 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> + gbiv who wrote this cool paste (showing alternatives to
> _Static_assert, which is supported by both compilers in -std=gnu89,
> but not until gcc 4.6): https://godbolt.org/g/DuLsxu
>
> I can't help but think that BUILD_BUG_ON_MSG should use
> _Static_assert, then have fallbacks for gcc < 4.6.

Well, it turns out that we effectively stopped supporting gcc < 4.6
during this merge window for other reasons, so..

             Linus
