Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFE8C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D9820865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqlb7vZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D9820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeIIUL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 16:11:26 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41579 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeIIULZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 16:11:25 -0400
Received: by mail-qt0-f195.google.com with SMTP id t39-v6so21437459qtc.8;
        Sun, 09 Sep 2018 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+ImkJJcmZ+hi5BqYJfS7rFbonGiaWl+xRoz/DkdYVCc=;
        b=tqlb7vZQYBYkK6r5MQoUhjowbS8uWN02otOfzi8bMpH2KXirJzr+Un2o2WpbtnmiE4
         SIzHswWCxlJJgFewvfdMk3ztavCXhYgUJyKgcFpWsD/UPw3SorjP8OHbjerY3xYQP7cq
         SVhWd/+EI7cPCDueQeljpAhu5X7pxT9DrIXEikCGRcN/nCanFsf4u2nb8UsYmrUaR9xI
         wxOENNrB5C+7cUpBGbtiuLabiA5/SfGQNSCxBLoby6hUSP/UWfiZN/wIKMzE8YGSwn9H
         ST7eqPahiktzdV+Xd9GNdeEjf6BGlzRG/vI9zgJMbQ83J0IZJ9FKb1kNz6/9Iu4+CMKd
         K4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+ImkJJcmZ+hi5BqYJfS7rFbonGiaWl+xRoz/DkdYVCc=;
        b=Thj2UQyceIYy51m1QGCVkC1LJUNUpz5PeQcoRSzP1q/7ighxQ+cJmNmxrhik1zysDO
         f/xT567HvUdGRevgRGxcSRE2q3SITxObSzXzRNHBLAD2jyPgVYyvCu3O4t4KqvRAnGNJ
         XSIrJ84KpCnGJ9O1UrYCGsTCRqx5ro26vDTklpD6Bhp/MC5+r50vo6FuYI3SnsTW26BK
         aKrormgI82GRpEWZgj+XmiVHKffGD90zhSr0LBEC6lYEyObt/74CLa0YJbP8feaqtDJy
         u3PxRjkrK3xudueISkfn9VvTIzNzJu0vqH8FjZb3vbmg6CU47HGY6+BWiEq/elJdT6Dt
         eXGg==
X-Gm-Message-State: APzg51C4o1/DlqAr1OJEvyFpi3PiblO7+vrAoJvVrvJtPQ6d3Oe/C4XH
        2P/Yvd/QCxpM8BUXsi5BsC8MR4vqzqSNfYBklpk=
X-Google-Smtp-Source: ANB0VdYa+KasX3XnZ8gJ5NBqMpcFQNDkFr1lPlSqw3iv5fR+0XYe0t3z7YePD6nzxalU60jk11UE5Gqfv8ZF0wQ7ERE=
X-Received: by 2002:a0c:abca:: with SMTP id k10-v6mr11630107qvb.140.1536506484820;
 Sun, 09 Sep 2018 08:21:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 08:21:04 -0700 (PDT)
In-Reply-To: <20180909080200.xn7z4gctf2vrqzst@ltop.local>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com> <20180909080200.xn7z4gctf2vrqzst@ltop.local>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 9 Sep 2018 17:21:04 +0200
Message-ID: <CANiq72kSvH-QgY7rf5VWt+NnmxX8E6h6dt2LEyz_xGO8cZ835Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Compiler Attributes
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-sparse@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

On Sun, Sep 9, 2018 at 10:02 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Sep 08, 2018 at 11:24:46PM +0200, Miguel Ojeda wrote:
>> The Compiler Attributes series is an effort to disentangle
>> the include/linux/compiler*.h headers and bring them up to date.
>>
>> The main idea behind the series is to use feature checking macros
>> (i.e. __has_attribute) instead of compiler version checks (e.g. GCC_VERSION),
>> which are compiler-agnostic (so they can be shared, reducing the size
>> of compiler-specific headers) and version-agnostic.
>>
>> Other related improvements have been performed in the headers as well,
>> which on top of the use of __has_attribute it has amounted to a significant
>> simplification of these headers (e.g. GCC_VERSION is now only guarding 4
>> non-attribute macros).
>>
>> This series should also help the efforts to support compiling the kernel
>> with clang and icc. A fair amount of documentation and comments have also
>> been added, clarified or removed; and the headers are now more readable,
>> which should help kernel developers in general.
>>
>> The series was triggered due to the move to gcc >= 4.6. In turn, this series
>> has also triggered Sparse to gain the ability to recognize __has_attribute
>> on its own.
>>
>> You can also fetch it from:
>>
>>   https://github.com/ojeda/linux/tree/compiler-attributes-v4
>>
>> Enjoy!
>
> It's a nice and welcomed cleanup!
> Everything look good to me, so feel free to add my
>     Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Thanks a lot for the review! :-)

Cheers,
Miguel
