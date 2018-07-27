Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E093C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9337208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSJ2xz6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9337208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbeG0MAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:00:43 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37348 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbeG0MAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:00:43 -0400
Received: by mail-ua0-f194.google.com with SMTP id y10-v6so3038867uao.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 03:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GNpiQh7ABwX5CzZaDSFk4r46vvFK7pNN6hDEEKpsaq0=;
        b=BSJ2xz6yFRhH+LpqtO9EL31GMQbBsZsA/L3u4/Va1E/Gjdz3e+c/RCRJwtvRLX3+pL
         ATkum5z/7PbSUZMoGn8kbaey1OLOn7cwUDJC7VpL3irwD0IDl4VL6NDTDB+uk5lu/HqG
         fh9Y5Ou78rKes3Y3GxYtdyYdqIMpsydzlzmoDaXq2BFg/6qul0e8/RDUpG4lIDRW/Lno
         0Y55Y4mqZRM6Kpgy0oJ36ZJCTIOAYy3YcnMuq1lQoggV2SEVZ+yP74HFWqdRbgtLW3t2
         p9TAQbGZwHhPkczd9i3ACkFvEmabNVUbNi7LiMu3AqqOAqO/xmJZ9gKhiVVvINPxFCmI
         30AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GNpiQh7ABwX5CzZaDSFk4r46vvFK7pNN6hDEEKpsaq0=;
        b=VyodCY5k72X0/ws+5f9BN/jgz+TvWuP+WBbLix/vMqMQxFB4wfwRnLlzNU/8WA3RsA
         bGQ5wY61SSgU8wvegRskwr4+oUP/yXBAyb0OQZ/wPReMygoaHKD6/alUnfv9ME1vQJxp
         hqoa14lK/KPbZSE6ulEzpgVcn36bCjFhysMKj51kx2yrxsXvpo++mKuDLjJGYN95NNJ1
         HpruF1C46cbMb5H3tu8RMe7y8qy03nA6WUU62fzow04/sF+lyV2uYQCZrvTz9ARbZG0x
         xfkpvgVV4S+/dDqP1+RFBElzCpe97tJMofaV5KmZaxzY1Z/1QYp/UgVWNvhzOiF2XatC
         jbXQ==
X-Gm-Message-State: AOUpUlFbhQX5fzNM6/skxXx5CEWtrBhGytbsJsA7Xp+5lvNKbawBmtL6
        /L6N0fXG4fKTcLAZwzODaceKQZu6odWMJUY/6w0=
X-Google-Smtp-Source: AAOMgpf7U2GeE6c/NZ/gn2uKTzb5LsKSkSkwyNuOmPXQJCTryXLrvV+wZiihBkK4rXHo9/TxMm6mjLcveIIRTbN5BbY=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr4085827ual.28.1532687962582;
 Fri, 27 Jul 2018 03:39:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 03:39:22
 -0700 (PDT)
In-Reply-To: <6dc928cd-adbb-0304-1308-fb556d48698d@163.com>
References: <20180722173715.25327-1-zengzhaoxiu@163.com> <20180722183706.GA7979@kroah.com>
 <9b18802b-a451-eb81-3317-1de406f03118@163.com> <6dc928cd-adbb-0304-1308-fb556d48698d@163.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Jul 2018 13:39:22 +0300
Message-ID: <CAHp75Vd2Lu110om-hPE2bx_XFa0zpNHHC4RC_uLsTBSywJO2KQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: use sunday algorithm to do strstr() and strnstr()
To:     Zhaoxiu Zeng <zengzhaoxiu@163.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 8:48 AM, Zhaoxiu Zeng <zengzhaoxiu@163.com> wrote:
> =E5=9C=A8 2018/7/27 1:17, Zhaoxiu Zeng =E5=86=99=E9=81=93:
>> =E5=9C=A8 2018/7/23 2:37, Greg Kroah-Hartman =E5=86=99=E9=81=93:
>>> On Mon, Jul 23, 2018 at 01:37:15AM +0800, Zhaoxiu Zeng wrote:

>>>> The Sunday algorithm is a variation of Boyer-Moore algorithm, it is ea=
sy and fast.
>>>> For the Sunday algorithm, to see
>>>>     http://www.inf.fh-flensburg.de/lang/algorithmen/pattern/sundayen.h=
tm
>>>
>>> So you say, but what does this really buy us?  Why make this change?
>>> How was it tested?  What is the downside of not taking this?

>> I use the following program to test on fc28.
>> Compile with O2, the new version is almost 2X faster than the original.

>> The code size of the original is 0x80, the newer is 0xB0.

So, output of bloat-o-meter would be good to have in commit message.

>> The test result:

Compact performance statistics as well.

>> Thanks!

> The original strnstr might has a bug too!
> For example, assume s1 is "123\0abc...." and s2 is "abc\0",
> call strnstr(s1, s2, 7) will return &s1[4], but the correct result is NUL=
L.

If there is a bug, send another patch to fix the bug first.

--=20
With Best Regards,
Andy Shevchenko
