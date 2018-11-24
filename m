Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51592C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D292086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+zes3dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D292086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeKXWj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 17:39:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40170 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbeKXWj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 17:39:58 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so21095469ita.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 03:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1vtbLZUZf25H9xAyClXglD+IeH8ApqZe6Hv9KdmvqQM=;
        b=b+zes3ddE9TmiUkMud2EUv88/Qss58WHzjzejdmyxImMYvk+WYuH0IuOzOj+IFH5KT
         hpW/PnQ4PilEbVQSfNOl9TXn8O3sx7ZZS/LxGnaXMbpSv8M3ih2ObFSqGcWXjv/OGKeu
         BQNDMA5z7fWlktZWLXXKw4ISic6BKtReC6GIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1vtbLZUZf25H9xAyClXglD+IeH8ApqZe6Hv9KdmvqQM=;
        b=FOpq2vIbzvQXJ7XED6o74putSO008qqBjqKh0M+uCmOM/wLMOzvOLbDIYGddzt3nvO
         DHNjVGleEYKbQ3OScMj7YrmYMAvQ3RKbPkJRizs7ygR/TJf24dw22Jl6Gc/jLJKEqoH/
         F1f4nrpiYh1SLnuszDpioi5p9RuCbaOG1DQGw6KSPFqH/5spMLI5EvMPFmMGeTqU1z6f
         TqQPkNT3mYFdJLgF65BKIWQiGf7PME2x+ipdUrxfsfbL0Y2dPTEzSyi2FF4W6dr8N5md
         rclkmvMVKtHvze7c9KvEucaXvWByUF0tom2iEoDirMX5yPox2Ty53ktJvpipqnwzjtYE
         uyMA==
X-Gm-Message-State: AGRZ1gIn2BXaGh6qJhdOs1HCXndKuVVZuVlI+8THg32cWZfaqe1UZRca
        x/YYNNOZJKN61RoPOwIkgCeRwxLXI94WX1BCJ+Q5ow==
X-Google-Smtp-Source: AJdET5fZulLjiJEbV3Yz+3R78BelSX+4sJOqpj6WPW91WGcFhvCYewlwaVidXn4JcyRyAe4TU1RxZYcnXe89usO3im0=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr16938680itk.71.1543060302010;
 Sat, 24 Nov 2018 03:51:42 -0800 (PST)
MIME-Version: 1.0
References: <0DF8AA8C9CD0FB4ABF4E83674055F7E2D82974@dggemi508-mbx.china.huawei.com>
 <CAKv+Gu-ffSgS-ZH58u5mNYnqR0++osS-PHn8oHW72o2kRfDYCw@mail.gmail.com>
In-Reply-To: <CAKv+Gu-ffSgS-ZH58u5mNYnqR0++osS-PHn8oHW72o2kRfDYCw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 24 Nov 2018 12:51:30 +0100
Message-ID: <CAKv+Gu_V_ZVSEH_3WOaFS8awVjduWU-B9E70yhVxjNseJJqSxQ@mail.gmail.com>
Subject: Re: Re: [PATCH] arm64: crc: accelerated-crc32-by-64bytes
To:     sunrui26@huawei.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Nov 2018 at 10:56, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>
> On Sat, 24 Nov 2018 at 07:42, sunrui <sunrui26@huawei.com> wrote:
> >
> >
> > On Thu, 22 Nov 2018 at 02:50, sunrui <sunrui26@huawei.com> wrote:
> > >
> > >
> > >
> > > On Sun, 18 Nov 2018 at 23:30, Rui Sun <sunrui26@huawei.com> wrote:
> > >
> > > >
> > >
> > > > add 64 bytes loop to acceleration calculation
> > >
> > > >
> > >
> > >
> > >
> > > Can you share some performance numbers please?
> > >
> > >
> > >
> > > Also, we don't need 64 byte, 32 byte and 16 byte code paths: just mak=
e the 8 byte one a loop as well, and drop the 32 byte and 16 byte ones.
> > >
> > >
> > >
> > > --
> > >
> > >
> > >
> > > Consider of some processor has instruction N-way parallel function, w=
ith the increase of the data buf=E2=80=99s size, 64B loop will performance =
better than 16B loop.
> > >
> > >
> > >
> > > On the other hand, in the same environment I tested the 8B loop, whic=
h is worse than the 16-byte loop.
> > >
> > >
> > >
> > > The test result is shown in the fellow excel(crc test result.xlsx)
> > > sheet1(64B loop) and sheet2(8B loop)
> > >
> > >
> > >Maybe I phrased that wrong: if we add the 64-byte loop, there is no ne=
ed for a 32-byte block, a 16 byte block and a 8 byte block, since they all =
use the same crc32x instruction. After the 64-byte loop, just loop in the 8=
-byte sequence until the remaining data is less than 8 bytes.
> > >
> > >
> > >
> > I think we should not use 8-byte loop after 64-byte loop. Although the =
number of code lines is reduced, but it will run more subs and b.cond instr=
uction. I test it and shown the result in the fellow excel.
> >
>
> OK
>
> > Why I used three temp variables to do the ldp below is because our proc=
essor have two load/store unit, if we use the registers which are independe=
nt, it can processed in parallel.
> >
>
> Yes, but you are adding three instructions to a tight loop, which will
> be noticeable on in-order cores.
>
> Just use something like
>
> ldp x3, x4, [x0]
> ldp x5, x6, [x0, #16]
> ldp x7, x8, [x0, #32]
> ldp x9, x10, [x0, #48]
> add x0, x0, #64
>
> Those are completely independent as well
>
> > By the way,  In most cases, crc short XOR 0xffffffff before and after t=
he calculation, if we add 'mvn w0, w0' at the beginning and before the retu=
rn will bring some benefits. What do you think about it?
>
> The C code will take care of that.
>

I tested your code on Cortex-A57, and it performs worse in tcrypt:

Before:
testing speed of async crc32c (crc32c-generic)
tcrypt: test  0 (   16 byte blocks,   16 bytes per update,   1
updates): 35416299 opers/sec, 566660784 bytes/sec
tcrypt: test  1 (   64 byte blocks,   16 bytes per update,   4
updates): 5342888 opers/sec, 341944832 bytes/sec
tcrypt: test  2 (   64 byte blocks,   64 bytes per update,   1
updates): 30056634 opers/sec, 1923624576 bytes/sec
tcrypt: test  3 (  256 byte blocks,   16 bytes per update,  16
updates): 1543567 opers/sec, 395153152 bytes/sec
tcrypt: test  4 (  256 byte blocks,   64 bytes per update,   4
updates): 4865198 opers/sec, 1245490688 bytes/sec
tcrypt: test  5 (  256 byte blocks,  256 bytes per update,   1
updates): 12709474 opers/sec, 3253625344 bytes/sec
tcrypt: test  6 ( 1024 byte blocks,   16 bytes per update,  64
updates): 401746 opers/sec, 411387904 bytes/sec
tcrypt: test  7 ( 1024 byte blocks,  256 bytes per update,   4
updates): 2576764 opers/sec, 2638606336 bytes/sec
tcrypt: test  8 ( 1024 byte blocks, 1024 bytes per update,   1
updates): 4464109 opers/sec, 4571247616 bytes/sec
tcrypt: test  9 ( 2048 byte blocks,   16 bytes per update, 128
updates): 202236 opers/sec, 414179328 bytes/sec
tcrypt: test 10 ( 2048 byte blocks,  256 bytes per update,   8
updates): 1344017 opers/sec, 2752546816 bytes/sec
tcrypt: test 11 ( 2048 byte blocks, 1024 bytes per update,   2
updates): 2000544 opers/sec, 4097114112 bytes/sec
tcrypt: test 12 ( 2048 byte blocks, 2048 bytes per update,   1
updates): 2395890 opers/sec, 4906782720 bytes/sec
tcrypt: test 13 ( 4096 byte blocks,   16 bytes per update, 256
updates): 101569 opers/sec, 416026624 bytes/sec
tcrypt: test 14 ( 4096 byte blocks,  256 bytes per update,  16
updates): 687876 opers/sec, 2817540096 bytes/sec
tcrypt: test 15 ( 4096 byte blocks, 1024 bytes per update,   4
updates): 1029042 opers/sec, 4214956032 bytes/sec
tcrypt: test 16 ( 4096 byte blocks, 4096 bytes per update,   1
updates): 1206227 opers/sec, 4940705792 bytes/sec
tcrypt: test 17 ( 8192 byte blocks,   16 bytes per update, 512
updates):  50842 opers/sec, 416497664 bytes/sec
tcrypt: test 18 ( 8192 byte blocks,  256 bytes per update,  32
updates): 347779 opers/sec, 2849005568 bytes/sec
tcrypt: test 19 ( 8192 byte blocks, 1024 bytes per update,   8
updates): 525054 opers/sec, 4301242368 bytes/sec
tcrypt: test 20 ( 8192 byte blocks, 4096 bytes per update,   2
updates): 600919 opers/sec, 4922728448 bytes/sec
tcrypt: test 21 ( 8192 byte blocks, 8192 bytes per update,   1
updates): 606954 opers/sec, 4972167168 bytes/sec

With your patch applied:

testing speed of async crc32c (crc32c-generic)
tcrypt: test  0 (   16 byte blocks,   16 bytes per update,   1
updates): 29524327 opers/sec, 472389232 bytes/sec
tcrypt: test  1 (   64 byte blocks,   16 bytes per update,   4
updates): 4299236 opers/sec, 275151104 bytes/sec
tcrypt: test  2 (   64 byte blocks,   64 bytes per update,   1
updates): 25492193 opers/sec, 1631500352 bytes/sec
tcrypt: test  3 (  256 byte blocks,   16 bytes per update,  16
updates): 1076108 opers/sec, 275483648 bytes/sec
tcrypt: test  4 (  256 byte blocks,   64 bytes per update,   4
updates): 4201545 opers/sec, 1075595520 bytes/sec
tcrypt: test  5 (  256 byte blocks,  256 bytes per update,   1
updates): 12872662 opers/sec, 3295401472 bytes/sec
tcrypt: test  6 ( 1024 byte blocks,   16 bytes per update,  64
updates): 283351 opers/sec, 290151424 bytes/sec
tcrypt: test  7 ( 1024 byte blocks,  256 bytes per update,   4
updates): 2548369 opers/sec, 2609529856 bytes/sec
tcrypt: test  8 ( 1024 byte blocks, 1024 bytes per update,   1
updates): 4315953 opers/sec, 4419535872 bytes/sec
tcrypt: test  9 ( 2048 byte blocks,   16 bytes per update, 128
updates): 148377 opers/sec, 303876096 bytes/sec
tcrypt: test 10 ( 2048 byte blocks,  256 bytes per update,   8
updates): 1321415 opers/sec, 2706257920 bytes/sec
tcrypt: test 11 ( 2048 byte blocks, 1024 bytes per update,   2
updates): 1915036 opers/sec, 3921993728 bytes/sec
tcrypt: test 12 ( 2048 byte blocks, 2048 bytes per update,   1
updates): 2349295 opers/sec, 4811356160 bytes/sec
tcrypt: test 13 ( 4096 byte blocks,   16 bytes per update, 256
updates):  74167 opers/sec, 303788032 bytes/sec
tcrypt: test 14 ( 4096 byte blocks,  256 bytes per update,  16
updates): 675385 opers/sec, 2766376960 bytes/sec
tcrypt: test 15 ( 4096 byte blocks, 1024 bytes per update,   4
updates): 981948 opers/sec, 4022059008 bytes/sec
tcrypt: test 16 ( 4096 byte blocks, 4096 bytes per update,   1
updates): 1178119 opers/sec, 4825575424 bytes/sec
tcrypt: test 17 ( 8192 byte blocks,   16 bytes per update, 512
updates):  38580 opers/sec, 316047360 bytes/sec
tcrypt: test 18 ( 8192 byte blocks,  256 bytes per update,  32
updates): 340715 opers/sec, 2791137280 bytes/sec
tcrypt: test 19 ( 8192 byte blocks, 1024 bytes per update,   8
updates): 498960 opers/sec, 4087480320 bytes/sec
tcrypt: test 20 ( 8192 byte blocks, 4096 bytes per update,   2
updates): 594188 opers/sec, 4867588096 bytes/sec
tcrypt: test 21 ( 8192 byte blocks, 8192 bytes per update,   1
updates): 599264 opers/sec, 4909170688 bytes/sec

Note that these are all integral multiples of 16 bytes, so the
coverage is not great. Could you share your test script please?
