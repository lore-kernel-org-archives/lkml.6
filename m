Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8395C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739DB20844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="duNSyzCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfAUUZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:25:38 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45079 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfAUUZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:25:37 -0500
Received: by mail-vk1-f196.google.com with SMTP id n126so4846947vke.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 12:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVMi40kJJBnZyDdlQUsJhig7OCy1+OLmvOMehMVnCgk=;
        b=duNSyzCnehl4IWXlHY9/nwFXPPbRsApqPg96nwTBFXqJ9F0hyyQAIP9EMtqeXoubV3
         wqhdcEYvOQwydFBL/FCbTe4WXvYZ8459t51T/Bnfax/n91nJsDDa+CRiE+MDHzY30Udo
         B0wbVWGPy+082BrAeYxKisee1gPKusjvmB0yu6uTez2rwqKZYH3fpbMJTfOUqiEKeBoT
         r6YNFKX0YqAWqINc+iX3cO30P+64Rzk+nzt6DO9wjcSSsh3fXpa/vugkHWV/FASuaQij
         ZEjPh7Qf0w9RhCiLPba2mH8B7FLNtZA35yXXXIqhFf3D4SsRA5cfu+h6jnBO5szsYlT4
         Srjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVMi40kJJBnZyDdlQUsJhig7OCy1+OLmvOMehMVnCgk=;
        b=HTcqJq4N8+RULUmNrz+p1pdG+O+pwPDartPjlWVRbZXh8NkKJxcecW6xHX7FGSGUxv
         IQxKa9fJ0YOtMcvHmF21xLzUR4nNMjqcMAEp8hVB0Ln3MqcOBGmQ8iFVKS4Ib4N1w9dL
         xPhN7ht3JDCXy0IXH2nQkPSHE9hxLQqOQKAl5EKul4syH3OREWlvxAfmNRkrWg556IMy
         hlJAcUoxTlgOtA8tDXGKh5D0EiegnDz8fViK2HVqlBAxlN3FQ9SA+3jOvSNd+as/I3Cd
         v108g2knWK/LRxBR29rxTk56hAJREsIY7NvUKGDDy7E43zW+YjAhCqtxmGiDh99OvXWJ
         R8Og==
X-Gm-Message-State: AJcUukfN87eq7irYuJNCWI5RYQ9cf5Uve3GDbxEB+W9WBxlxbcZcfKr3
        4WnjV6TXxE5mfQu6u0JbUx2UabG3lvkdXwXzGjbJtA==
X-Google-Smtp-Source: ALg8bN4QMSdPukZgNDoOhxCcycRy3WgUtmWJpS66FrNZUwdHPQR2x+WEqUMum3CJnla9A/Ke9uZ3YrgM3r+uaYmn9Nk=
X-Received: by 2002:a1f:4d47:: with SMTP id a68mr12083806vkb.34.1548102336281;
 Mon, 21 Jan 2019 12:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20190119151450.26879-1-Florian.LaRoche@googlemail.com> <CAHk-=wjruxUdKWjn-PvZMOPn3pGO5yTcbc_J4hc4TrS0P15vaw@mail.gmail.com>
In-Reply-To: <CAHk-=wjruxUdKWjn-PvZMOPn3pGO5yTcbc_J4hc4TrS0P15vaw@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 21 Jan 2019 21:25:00 +0100
Message-ID: <CAKv63uu+-gF_zci8NrRDB4g7ujkbz7dPnAEAjY6_ZVXB9NOWGA@mail.gmail.com>
Subject: Re: fix int_sqrt() for very large numbers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Florian La Roche <florian.laroche@googlemail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 at 01:20, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Jan 20, 2019 at 4:15 AM Florian La Roche
> <florian.laroche@googlemail.com> wrote:
> >
> > @@ -52,7 +52,7 @@ u32 int_sqrt64(u64 x)
> >         if (x <= ULONG_MAX)
> >                 return int_sqrt((unsigned long) x);
> >
> > -       m = 1ULL << (fls64(x) & ~1ULL);
> > +       m = 1ULL << ((fls64(x) - 1) & ~1ULL);
>
> I've applied this part of the patch as commit fbfaf851902c ("fix
> int_sqrt64() for very large numbers") with slightly edited commit
> log.
>

Thanks for the patch - I its indeed my copy-paste error, because
__fls64 does not exist on 32bit CPU, but the fls64 is not "equal"
replacement. I am very sorry for the bug.

> I still think there are some oddities in here in the types. I
> mentioned the caller that unnecessarily does the int_sqrt64() twice,
> even though the outer one doesn't actually take a 64-bit value.
>

True. This is oddity is originating from time where mlx90632 used its
own function for int_sqrt64 on 32bit.

> But in the very line above, there's another type oddity: the "& ~1ULL"
> is entirely the wrong type. The shift *count* shouldn't be an unsigned
> long long, so that type doesn't make much sense. It should be just a
> ~1, or even just "62".
>

This was also inline with above copy-paste and variable expansion to
force the 64bit everywhere. I will prepare a patch to clean this line
to ~1, question is why does the int_sqrt is having UL if this should
just be "62". I was thinking because we want to cast to the type
before we shift.

> But I didn't actually start micro-editing the patch, and just did that
> one-liner off-by-one fix.
>
>              Linus
