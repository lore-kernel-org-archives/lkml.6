Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033806AbeCASON (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:14:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033762AbeCASOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:14:11 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C04F217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELvKCHmhxvgTXVccwYUlR/NAl0mv3OnoytodPPQWwa0KMVRtKUCmJS0whPaV+vX1UQ1JI/z908CQEX21hwu6RJI=
MIME-Version: 1.0
In-Reply-To: <CAK7LNATiM0o4KX1Lt+cP6APVzTMVN195yiuUiD9Ny5roZgrK1g@mail.gmail.com>
References: <20180228233249.26281-1-robh@kernel.org> <20180228233249.26281-5-robh@kernel.org>
 <CAK7LNATiM0o4KX1Lt+cP6APVzTMVN195yiuUiD9Ny5roZgrK1g@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Mar 2018 12:13:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLvGAtgnLnQMm9b0qyHdt+RKD1WLqg3PKXQ=WjKwFG9Kw@mail.gmail.com>
Message-ID: <CAL_JsqLvGAtgnLnQMm9b0qyHdt+RKD1WLqg3PKXQ=WjKwFG9Kw@mail.gmail.com>
Subject: Re: [PATCH 4/6] scripts/dtc: generate lexer and parser during build
 instead of shipping
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 10:34 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-03-01 8:32 GMT+09:00 Rob Herring <robh@kernel.org>:
>> Now that the kernel build supports flex and bison, remove the _shipped
>> files and generate them during the build instead.
>>
>> Based on Masahiro's original patch.
>>
>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  scripts/dtc/Makefile                 |    6 +-
>>  scripts/dtc/dtc-lexer.lex.c_shipped  | 2259 ---------------------------------
>>  scripts/dtc/dtc-parser.tab.c_shipped | 2321 ----------------------------------
>>  scripts/dtc/dtc-parser.tab.h_shipped |  125 --
>>  scripts/dtc/update-dtc-source.sh     |    5 -
>
>
>
>
> As you know, this introduces
> scripts/dtc/dtc-parser.y: warning: 3 shift/reduce conflicts [-Wconflicts-sr]
> then, the next commit will fix it.
>
> I do not have a strong opinion about the parch order.
> It would be ridiculous to update *_shipped
> that will be immediately removed.  So, probably this is OK.
>
>
>
> FWIW.
>
> This is completely out of realm of my field since
> I speak Japanese in my daily life.
>
> Is it better to change
> the 'singular vs plural' in the comment block?
>
>
> # This script assumes that the dtc and the linux git trees are in the
> # same directory. After building dtc in the dtc directory, it copies the
> # source files and generated source files into the scripts/dtc directory
> # in the kernel and creates a git commit updating them to the new
> # version.
>
>
> After this commit, 'version_gen.h' will be the only generated file.
> "generated source files" sounds like we have more.

You are right as we do have that hidden generated file. I worry
changing it could become stale too if we add more generated files
sometime in the future. I've changed it to "generated source file(s)"
to cover both cases. Not sure that's really proper English grammar,
but it is widely used.

> Please take it FWIW.
> I am just nit-picking
> according to what I learned at junior high school, which might be wrong.
>
>
>
> Otherwise,
>
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks.
