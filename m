Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C74C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE6920811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDCRYKFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE6920811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeLMV7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:59:24 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35946 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeLMV7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:59:23 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so2766222lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 13:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/i3Qn5RbIp1Jj9tl455vSrzT6kqJoyyhRMnpm0rgy6M=;
        b=aDCRYKFw4DNAg/YTIDlFZfBRTdrjnwxkDhVWmL7eqcMCSR0qTFQuxZluHZkAKL53Id
         uEqlpBG9+byF5aRVn9qTvWoY93PKGLuBXJaYqNcASFfZH3N3XJZfuOiTCQG94uMqrW5f
         2YO/EoMWUSQG1s6zKsjon+ttOFmbo0jo7i5OT5Bb03YQlvhLm5jdrfPV/s+CKYr5PLSm
         HtfsBM7kKjgyL15TzgsOnqUABF7A1omVmpEi2M91H+ewCYSLfMlMJwADuh3CUH2Xdf2M
         MjOrAH3PB5x7ewIRZMorDGdDvUwzgDnXZSFrBtyltfSWkJGkZfY6Q47Ndzzh7xzNBLKJ
         uJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/i3Qn5RbIp1Jj9tl455vSrzT6kqJoyyhRMnpm0rgy6M=;
        b=NQzSbtb5hBOzBKvgh2iImeelW3G5Rg7oeqgWBSqRB3Ld7SbuctVNSXoKpPjQQWU832
         XlDVzfVGohq3SxuVJSRUclryagGUjlB/C4ZZ+JrQbMl0N6XImJ6tEzgLBvKTVOVm7aY0
         3pBZp+0wrHdniQSUY4M8OScI79AN06FxfEu+Oh0O1G/cDCqye2Zkw4LOhIaMeU7wEAce
         hdpX9P06GqjL2slhLae4faFATUV9QsptOUw1KFPU1/ooUBaem+xugkDWIPD8AJl259Fw
         oFf5FH/iAxaApk+XKDmvZNBbjPhS0p3FQyT99Hz9HPRq0oqMaQbIbGR9u/T0Yy4vAlhx
         vSig==
X-Gm-Message-State: AA+aEWanuoVi7M/wpdIvXiA8P0ykOd6cBRkw3+DzZC4wDoqzpnXwKye8
        K/lwj3kpGgrYCSs8EHdg0d0KyNfl/x8i6NQOeupVVdRrTzs=
X-Google-Smtp-Source: AFSGD/WKgTsUh/0smVGyEgvXuGsh4JAwWwdrTdvIYFPbl8OH/2hIssxfKG8DZwxEvirSCwq5ggXoF/3ssL5FB3zMs4A=
X-Received: by 2002:a19:54d7:: with SMTP id b84mr237163lfl.131.1544738361431;
 Thu, 13 Dec 2018 13:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20181209032715.3466040-1-liuxiaozhou@bytedance.com>
In-Reply-To: <20181209032715.3466040-1-liuxiaozhou@bytedance.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 13 Dec 2018 22:59:10 +0100
Message-ID: <CANiq72nqFuJm5f69G-Pc_9QHz+anwaon-WfVsPrkZWah1OP7Fg@mail.gmail.com>
Subject: Re: [PATCH v2] Compiler Attributes: don't pollute userspace with
 macro definitions
To:     liuxiaozhou@bytedance.com, Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaozhou,

Couple of comments.

On Sun, Dec 9, 2018 at 4:27 AM Xiaozhou Liu <liuxiaozhou@bytedance.com> wrote:
>
> v2: update commit message.

This line should go below the "---", since it shouldn't be part of the
commit message.

> +#ifdef __KERNEL__
> +
>  #ifdef CONFIG_ENABLE_MUST_CHECK
>  #define __must_check           __attribute__((__warn_unused_result__))
>  #else
> @@ -215,4 +217,6 @@ struct ftrace_likely_data {
>   */
>  #define noinline_for_stack noinline
>
> +#endif /* __KERNEL */

I wonder if we can/should simply move them into the __KERNEL__ &&
!__ASSEMBLY__ block that is above, instead. It would be simpler to
read, and there aren't apparently dependencies to those outside it
that go after the block.

I took a look at where the macros were at each "step", and, on one
hand, compiler-gcc.h was (and is) included entirely inside it, which
is from where most of the macros come originally from. On the other
hand, not all do: __must_check (the generic version, not the one in
-gcc.h) and noinline_for_stack were defined in __KERNEL__ (only)
before commit 815f0ddb346c ("include/linux/compiler*.h: make
compiler-*.h mutually exclusive"). But anyway using those two in
assembly does not make sense, right?

What do you think?

Greg/Linus, are you going to pick this (or a v3) directly? If not, I
can pick it up in compiler-attributes tree linux-next.

PS: In addition (related to this but not for this patch), we should
review whether other macros that are currently outside should be there
or simply pushed back into __KERNEL__ (and possibly __ASSEMBLY__). For
instance, __latent_entropy (the generic one) is outside, but it is
only defined in compiler-gcc.h, so the generic one should be inside
the __KERNEL__ && !__ASSEMBLY__ block, no?

Cheers,
Miguel
