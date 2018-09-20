Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3336CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B522152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HKRSV2j8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B522152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387980AbeITX6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:58:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36072 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387865AbeITX6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:58:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so4756669pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9UiHCpKRHeSCRRkXkk4H5zDXhYS9CBAjPx09y9oizA=;
        b=HKRSV2j8+njucOpHgxQt7RBbIh2AaZMW8acrDdMgA1q5jbQK/WkopTSM8qLbYlFCzF
         xQiQC4MPPRvRO8V6heZL1mHfGSMjzTkia2r5XiCJJBLTo1om0ZGxV/xq5sJvuGmzZ2Ho
         oXLpGdlnBj/kZzJnOmvxh5SP0jCUKUK86+QWId2t+fi0oN5K8+h+EZiIYWPE9T3CVnrQ
         i9Tr0/B0gJMqwrmZPR9qQXTUMkj29XBLyIDp0STlHqOWM30pb2VDS3sR0QSj0LRFgxyu
         vGK8z3WYFMLr67VI5QfYRz5QOIGsBzpAaxDQToWpF9SaH6Ap1d/GYUJvo9JVNDYBJCjW
         Jizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9UiHCpKRHeSCRRkXkk4H5zDXhYS9CBAjPx09y9oizA=;
        b=gwG+wcPshkwErQ+KXDZ9gmTCKhDqbZOX4k43ulmu9Fzyz8LE5nF/82tMqgVTxupcqY
         DJus0Y2t4SIxz+6mJtr1YsyXjp3dzBa5mvJjeZel8h8GdD5YpRa+vTG1oxmr8/xkNKmr
         96HOIW2IVZsA1ty8jXrwWnUWTNzvvfdfCO0a4YYiR/1A9ZWdykORq9pHKj/dRuCC4LSS
         7LnKmW9M563pT+v80L8RERy3L7ygfaMYgWJiZ7rYnSwUIQ4x3aHck/NK9tS/74lGPEYc
         fjJvkWOgs7zkSSm4iLTLJ3Ah2y2tpLs3CckHXJXaYmpJU32b2Q1uPSZn6Jd3VloePKA8
         cTaw==
X-Gm-Message-State: APzg51ByHFNwBrJcwn0XUkdFAIPrH4uhL/LitETfsHcU/k5+HDcqS7lm
        QlLb7HPR8ADAhlpYGYdZfBVBiCQe4FwcWyQv2KssDtVffOJlyA==
X-Google-Smtp-Source: ANB0VdbwVHrBxV2d//T3izakJs71TnhcDe2fakSTl7GxXbF+96wIpWcatozM0TCj0lplRQs4IEHqmwdzvwnPmmhh5IU=
X-Received: by 2002:a62:591a:: with SMTP id n26-v6mr42576364pfb.94.1537467239330;
 Thu, 20 Sep 2018 11:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com> <20180920172301.21868-16-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-16-miguel.ojeda.sandonis@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Sep 2018 11:13:48 -0700
Message-ID: <CAKwvOdnF=65Fj3zXP5KWVqWkKKFoPMvKox0iWFTObxdQiSgqog@mail.gmail.com>
Subject: Re: [PATCH v5 15/15] Compiler Attributes: ext4: remove local
 __nonstring definition
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, adilger.kernel@dilger.ca,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, rostedt@goodmis.org,
        mchehab+samsung@kernel.org, olof@lxom.net,
        konstantin@linuxfoundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        sandipan@linux.vnet.ibm.com,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        paul.burton@mips.com, David Rientjes <rientjes@google.com>,
        w@1wt.eu, msebor@gmail.com, sparse@chrisli.org,
        Jonathan Corbet <corbet@lwn.net>, tytso@mit.edu,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, joe@perches.com,
        Arnd Bergmann <arnd@arndb.de>, asmadeus@codewreck.org,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:23 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Commit 072ebb3bffe6 ("ext4: add nonstring annotations to ext4.h")
> introduced a local definition of __nonstring to suppress some false
> positives in gcc 8's -Wstringop-truncation.
>
> Since now we support __nonstring for everyone, remove it.

... from a patch in the current series (Note to other reviewers).

>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  fs/ext4/ext4.h | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index caff935fbeb8..2acdfdad3d3f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -45,15 +45,6 @@
>
>  #include <linux/compiler.h>
>
> -/* Until this gets included into linux/compiler-gcc.h */
> -#ifndef __nonstring
> -#if defined(GCC_VERSION) && (GCC_VERSION >= 80000)
> -#define __nonstring __attribute__((nonstring))
> -#else
> -#define __nonstring
> -#endif
> -#endif
> -
>  /*
>   * The fourth extended filesystem constants/structures
>   */
> --
> 2.17.1
>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
