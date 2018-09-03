Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA00C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B54C20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiO4/BGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B54C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeICWZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:25:23 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:34329 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbeICWZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:25:23 -0400
Received: by mail-qt0-f175.google.com with SMTP id m13-v6so1398991qth.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kkp5FG76M3en+ymcrA3Q22WXbQvarJuXBkfwB2yoOOs=;
        b=oiO4/BGF8LxVRTmjLYXHRWRd6iBsAlbEf+jg7+Hx+XQrplBE8HCJbWqjUXRcIfSedy
         s0Vj0FocnnQ5Z87Xae6V9X4CF48jCYfig043UPs3KwDLwQSsqXLvEEqDVqmbBwgiTMVn
         b6QI7PGUuzuhQyb8Bt7MpHhzElO2ZsG+pqXLU0sKbE3EejMDXs0WScKmfrLIwaaFuuTf
         wKMpgzz8dLz2+lfp1lOh93BOM4p1Q1WBTmrzyIyVlfCTktmNxWFmbDP7h+LiT0sOWujq
         mQNAUJffcKSnPFKuWWIVMB5jtgGAH4tPWhhemLpkzTvkrPEooJtBuLHAGNuwyClILVul
         BRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kkp5FG76M3en+ymcrA3Q22WXbQvarJuXBkfwB2yoOOs=;
        b=ikJ92mzLKkbEphsIBeUJfDhHeo3aLgDTM96KTc9HMgMFVZzRgzuvEzcJ0vUK3RsHj0
         5O15qFDXQAmW3GBz1C5+Zw9p3V/hNz60B4QR7baB9/4lW4KMn5JS4xiFSQzv4aBy86kR
         WLyKivlpe9iFJbRHOYvFv84L74jB3tH3K1jDQBZyw/aE9eIAPaU0NkojwxX0AHipxu0i
         +0t6FHF1mMVy1nf4qowAlYKm4Pp22jaHOeoh/2BKQLMXL12lOMoRTA1CILZ28htogJZN
         xL47ZfzJ/irqeehVplbZMS0W0woY4WHepZC5Hmb+5cxaC6bzBnzwpZeE9UdzcJ29Nfpe
         Zh7g==
X-Gm-Message-State: APzg51Cgczbha2pAOkNWqW7IYtmpMTIn+EIgomnkHyiKgnzyVx6NYEyM
        9x0e2UWoJj+e3HaWWVwVboxLWtQnYeYy81BR/0NLsuGZnuI=
X-Google-Smtp-Source: ANB0VdaPiKe8qrcVkPLz3DR3ujKP33UDDZZ82S/H012NsPkCQ7FGMlhnwrlqxhikQFRA50dQbh3DjfIF0J07p6x66hg=
X-Received: by 2002:a0c:aac9:: with SMTP id g9-v6mr26832134qvb.78.1535997845561;
 Mon, 03 Sep 2018 11:04:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:34a7:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 11:03:45 -0700 (PDT)
In-Reply-To: <20180901141747.GA20900@nautica>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com> <20180901101430.GA21877@nautica>
 <CANiq72=pMSOaY5rYvJFgWKjiqAMjEVFu8GXRHx=Tz4sXqP-SSw@mail.gmail.com> <20180901141747.GA20900@nautica>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 3 Sep 2018 20:03:45 +0200
Message-ID: <CANiq72=M8130yO4BfYbzHWhr9y4DENH6rO3oN0Y+jx=4EoaFxA@mail.gmail.com>
Subject: Re: [PATCH 7/7] Compiler Attributes: use feature checks instead of
 version checks
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominique,

On Sat, Sep 1, 2018 at 4:17 PM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> I'm honestly not using icc much, I just have access to machines where it
> is installed...
> Actually, now I'm looking there is some html documentation installed
> along with icc, but it does not seem complete; instead it points to
> software.intel.com ... which has _some_ documentation on attributes, but
> is missing a _lot_ of them, see :
> https://software.intel.com/en-us/cpp-compiler-18.0-developer-guide-and-reference-attributes
>

Hm... I am finishing v3 and I was thinking of adding this link (since
it is what we should link to), but it has so little information on
just a few attributes that I don't think it is worth it :-(

Thanks for finding it out, though!

Cheers,
Miguel
