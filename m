Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9330C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C5B20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1SU/A3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C5B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeK2VrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:47:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41607 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbeK2VrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:47:20 -0500
Received: by mail-lj1-f193.google.com with SMTP id z80-v6so1275447ljb.8;
        Thu, 29 Nov 2018 02:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vJiD2gHR+MF5RjPnef/auMHW0hV5W0v/nqU+sxRqOCw=;
        b=U1SU/A3IatGOZE7wXm1wjl6gxhHHd6RtlY0/oeRb4PXHwYWJTtzmaMTNQtRnz+l0Eb
         cwndUU+KRHmzxOvNrMO+cWStJlUvkF4we3vgGGm8VQ2lDJiN088zZHisIECvmFPf2RK5
         UlTrMjEotjZhWfqfsAfXSpSKZxRx7rh8ZPPayV9Yk6JfjBa7UeII3RgIygM1kxn7LIyS
         shtyn7au33jnXrX4bJTr6HqsbQ2s+D1uTVXQ3Y6kKy83Dov0Hco6lOuayMWcDDjcNo/M
         vjA+r7AodYSvNtRi/Yb+a0FTtCSKycGUWNPO14S4/C8aOy26v6rNZ3i2ah4MDJciCZGD
         WGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vJiD2gHR+MF5RjPnef/auMHW0hV5W0v/nqU+sxRqOCw=;
        b=ePQ/xGCN6UnbDDb52HPXEdQPeoZSosg2sA/gEyiIwMfpoPPYSb0fgCjaJJ9XWAMzEO
         xq0gwOVPt0epI1Fia4gj1YVQQm96qa3rHzAnMfgIzt3N61EB/aCBlX4uaMwAA4+arCeA
         dDgTlnGjrZOrE+LQhxz90fG/mstHGtq0MuW+kgnM0kfiwLdehgne+VV+V9U8LFPfmfyY
         VNC8JW4ntKPnwHNmrJcRWGNVa0nQ32OugCrAup5iJ+JQ2sSnGVD0fkrOl6hSqTD7Fa6m
         +Uucaef5EfGTtPkHUKh3Fh6LXvuDSyEsxNiuveWPi7Bg0cHvh0gCGDIs02kdPS05Erzn
         Gzwg==
X-Gm-Message-State: AA+aEWb/WSAQp/Kuh9wiFo4UcDVHGaalnBtCOcW9UQ+PTUdUbz0Re1ON
        fGNFUtxEmDS9IJovoLMlEpboEdPeFVJnIc/7MEnkIrL4
X-Google-Smtp-Source: AFSGD/W5pnvwVJT/dv4nXX5xsY5mZ3cbZ/aZyCxY3q+VtMwmI48k9lg6m1B0yvWzoFwPm+h2x+24FX3QkDzbr6ziSY8=
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr790478ljb.52.1543488143583;
 Thu, 29 Nov 2018 02:42:23 -0800 (PST)
MIME-Version: 1.0
References: <20181128140852.178260-1-liuxiaozhou@bytedance.com>
 <CANiq72kzHqQ-M2Gyrf7iy1BQMabM6txChYwa8hrDkMmc3w8ORw@mail.gmail.com> <20181129021635.rzmehzzfgt2jvpgi@bytedancedeMacBook-Air.local>
In-Reply-To: <20181129021635.rzmehzzfgt2jvpgi@bytedancedeMacBook-Air.local>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 29 Nov 2018 11:42:11 +0100
Message-ID: <CANiq72=uwbHqPB_1b7q+dD7FaqZ+HOmOvXMPX3d=z7-xqzwFzQ@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: move kernel-only attributes into __KERNEL__
To:     lxz1983@gmail.com
Cc:     Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, ast@kernel.org,
        daniel@iogearbox.net, yhs@fb.com, jakub.kicinski@netronome.com,
        quentin.monnet@netronome.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 3:16 AM Xiaozhou Liu <lxz1983@gmail.com> wrote:
>
> On Wed, Nov 28, 2018 at 06:35:18PM +0100, Miguel Ojeda wrote:
>
> By `these' I mean inline and the like, to be clear.

Ah, that makes more sense! Sorry.

> > That is not exactly correct -- a3f8a30f3f00 moved some attributes to
> > another file, moving them into __KERNEL__ (in particular,__gnu_inline
> > is).
>
> Yes, that is what a3f8a30f3f00 did. Sorry.
> Turns out the commits in question are 815f0ddb346c and a3f8a30f3f00.

No problem! It was a bit confusing indeed.

> Yes and no. Let's recall the whole story.
>
> Before 815f0ddb346c("include/linux/compiler*.h: make compiler-*.h mutuall=
y exclusive"),
> __gnu_inline and inline were both *in* __KERNEL__ as the were in
> <linux/compiler-gcc.h>, which was entirely put to __KERNEL__ in
> <linux/compiler_types.h>. Everything was fine.
>
> Then 815f0ddb346c moved inline and __gnu_inline *out* of __KERNEL__
> and put them in <linux/compiler_types.h> so userspace could see them
> both. Not sure if it's intended behavior, but everything looked fine.
>
> Then a3f8a30f3f00 moved __gnu_inline back into __KERNEL__ and left
> inline behind. Since inline depends on __gnu_inline, error showing
> "unknown type name =E2=80=98__gnu_inline=E2=80=99" pops up.

Exactly, thanks a lot for clarifying it up (we should put this in the
commit message, I would say). That also answers my question: it is
clear everything should be back into __KERNEL__. The only worry is
that the v4.19 release contained 815f0ddb346c, so it has them exposed,
so someone could have started relying on them. Or, more likely, the
exposed macros could break some source code out there. Hm... Should a
"fix" be backported?

Cheers,
Miguel
