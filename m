Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED67C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD0A2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL8P91vG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD0A2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeIAAct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:32:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41804 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeIAAcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:32:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id h138-v6so2229161qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I4py86YBpf1bydNyjTGneqK3X6aQRKMnrnbOyepFLKg=;
        b=EL8P91vGttg6OF9s/XHHfyaU5B/9qQyHuZvmKm4H2nm/3S0NJDnRGL6AzXpo3KK8NZ
         bS6X76g6pHrYB2IXjxzn1KPojfmjDkL6OptK3RgPKa4bbmrzexo+QZnxTDB53tLGkIGO
         wqsZLpe+Itn8bkNRGMS79eKsNkjPTbqVJJGAyvF45deNI4xIAR2DVGsSLDJ2nVae/W3W
         Y8l11cbfz44cuzl4sxKGdkwjhlJgJOgVUuC3NtV+zySYNCzJH4iUt4ng4kBf/s8Mz0FP
         F5QpQrYV7M8X59u7VjlN++2hIGi6bLITFzXGJhAK+xccqKUkTJdlL7pP6OZvuARSJARi
         Mgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I4py86YBpf1bydNyjTGneqK3X6aQRKMnrnbOyepFLKg=;
        b=M5Rw8MBH6gaXIkgMeudQmm0HwkvWLxlQf8WvSkBSxdY5jnsdYLSYXq7b6mRiFfIaB4
         uhcsvM5cKOKHfwMeg3+7YFBXGPTYzIc6k8qqgDKecrXBFoJ5/EMCkj3RXqscDxOuLCvE
         iq3irDet/dBfO65l7Bh97ZcPyZWwx+IB1RZAhMqeKy8s0Ex7+go2/zyyIyCPYQGAE5o1
         kXilQZQ1B5ce/aNq/5rI34cjfDWnca4JAXYfsg0TaLo06O8GKqoqYIe2HJMuMozZXZEt
         F2Y2LWiwL1S9M1eZN0GwRQQJMGbdR8X2oBqMW4lkn5V7vKuFMrowCRx164lHq79rPy39
         GIOQ==
X-Gm-Message-State: APzg51Bm9mtEuFokoAtJF9AZbixzIZWwubhAYPNuCJUC5SHzccm+WqbK
        2VIsg8McqlOgTvV8yLsedw1MnhO8UOcrno61gFA=
X-Google-Smtp-Source: ANB0VdZO/SRV5mdl/TOiYee6p8ekMJPqC/1Oh73SJNX9Zw3/BLFl2D/yITdjacPQ+/r4dtGUKkZeH/oN7Tq3zOpFq+w=
X-Received: by 2002:ae9:ed4b:: with SMTP id c72-v6mr16149093qkg.54.1535747021942;
 Fri, 31 Aug 2018 13:23:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2291:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 13:23:21
 -0700 (PDT)
In-Reply-To: <CAKwvOd=kePHrDA7NJKyu8aiXVt7iRsxXNRe3tkG3rp-c0xpO5A@mail.gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <a1d6922dea4f80be097fdb912a545727ff96f1b1.camel@perches.com> <CAKwvOd=kePHrDA7NJKyu8aiXVt7iRsxXNRe3tkG3rp-c0xpO5A@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 31 Aug 2018 22:23:21 +0200
Message-ID: <CANiq72kA=hdg00FeWovJcXpY54hJx-bLYy_Cpd9PsOdTEYHGog@mail.gmail.com>
Subject: Re: [PATCH 1/7] Compiler Attributes: remove unused attributes
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 8:43 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Fri, Aug 31, 2018 at 10:28 AM Joe Perches <joe@perches.com> wrote:
>>
>> On Fri, 2018-08-31 at 19:05 +0200, Miguel Ojeda wrote:
>> > __optimize and __deprecate_for_modules are unused in
>> > the whole kernel tree. Simply drop them.
>>
>> Nice series, thanks Miguel.
>>
>> It'd be good to have a cover letter for the series.
>>
>> And I believe there should be the equivalent of:
>>
>> #if GCC_VERSION < 40600
>> # error Sorry, your compiler is too old - please upgrade it.
>> #endif
>>
>> for compiler-intel.h and compiler-clang.h so that
>> each supported compiler minimum version is checked.
>>
>> Is it clang > 13 and icc > 3 ?
>
> Eh, I'm not sure I want to commit yet to a specific minimal version of
> Clang.  Right now, we're fixing things so depending on arch's and
> configs, the answer might be Top of Tree clang builds.  For Pixel, we
> shipped with Clang-4, but pretty quickly we needed Clang-5.
> https://lkml.org/lkml/2017/11/22/943
>
> I had sent patches previously for detecting clang version from the C
> preprocessor, maybe I should dust those off, then commit to clang 5.

In my opinion, even if you require clang 7, that is fine, as long as
we get a working build mainlined.

By the way, I am testing the series with clang 8 (2018-08-14) (after
reverting e501ce957a78), and it seems to work. Hopefully that makes
you happy! ;-)

>
> I don't think minimal supported versions are required for these clean
> ups, and would not block these patches from landing on that.
>
> Also, haven't found anyone using ICC yet to comment on minimal version
> requirements.

For clang, by the way, __naked should go out of -gcc.h. I guess that
is breaking ARM clang builds at the moment (didn't check)? I will
include the move for v3.

Cheers,
Miguel
