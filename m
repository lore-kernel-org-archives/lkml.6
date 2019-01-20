Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03204C61CE3
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 03:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D112084A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 03:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fs9fM+bX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfATDtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 22:49:10 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:38665 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbfATDtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 22:49:09 -0500
Received: by mail-lf1-f49.google.com with SMTP id a8so13192265lfk.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 19:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAQVJsI8UcngSUtxBuv3IE4zDR2rqjZLY2mbROvFgrE=;
        b=fs9fM+bXDqo459fQjYUbIrEPfhpoqy+np7j+EBfrd+reL2M/3+AhgR4i8gU66p7dmy
         LqVoqbUSmqO2TOtHHtk5h2bn3SUDYkNN56jURwxWRy1bPn55Ih5JTcKO3qwepgs1TVrS
         d45rlQdJYONPIpNAlp7PbAtTV6bTkabwMsOR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAQVJsI8UcngSUtxBuv3IE4zDR2rqjZLY2mbROvFgrE=;
        b=RBwATyXk3KlvSFKPQmxQn4cc+u6YOtvTskgmoJdaQkK+sNfhGlsLbviszTrP58IVz4
         H2Nb0rCt6FKAfGxmRIhtF84+Wxi2njlZHaYQFH0gMJ+Dgn+CYsHWcH1tl3kjnPb8SkOh
         C8ngBUWmfBeIDZHDo9poe53E8YmehmrOKs/i5zsZDS78ADBbULN6cpdZYxSEMfaBmpaU
         OlWA9X7kK+gu7q+sxxbcDI40xnukBLi44Hjwa5O89VwDJ4SgVdC5hhTJ9b9ra4BijIb4
         DCtM6Mh/7ChX/zdhXICWqYIdn4/sYqGf3UmsOh/HEL5cq6xTFInekHU8CBIR42akczhJ
         qs5Q==
X-Gm-Message-State: AJcUukc2w1SlbggZ0IR+04JfvPaZlKD8Wk7LKeH+0bTWfeUlsgg0USWh
        84qCir1GZEB2bJu3+lAZti0Vv/X+kUfVqA==
X-Google-Smtp-Source: ALg8bN5CBxrW4lbXpo/kiXEF+QW9d04HUOXHftoFWOY3zu0aJkN6hJrOCMemCBGj5KLCL5YohH2PZg==
X-Received: by 2002:a19:945b:: with SMTP id w88mr14782979lfd.15.1547956147124;
        Sat, 19 Jan 2019 19:49:07 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 185-v6sm1465590ljj.49.2019.01.19.19.49.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 19:49:06 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id e26so13189744lfc.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 19:49:06 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr14711802lff.16.1547956145556;
 Sat, 19 Jan 2019 19:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20190119151450.26879-1-Florian.LaRoche@googlemail.com> <20190120000138.GI26876@brain-police>
In-Reply-To: <20190120000138.GI26876@brain-police>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Jan 2019 15:48:49 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjKgJ-9ypvzq+CB_NKnRk6iAqFtgVPwSH17C5RqJoYF=A@mail.gmail.com>
Message-ID: <CAHk-=wjKgJ-9ypvzq+CB_NKnRk6iAqFtgVPwSH17C5RqJoYF=A@mail.gmail.com>
Subject: Re: fix int_sqrt() for very large numbers
To:     Will Deacon <will.deacon@arm.com>
Cc:     Florian La Roche <florian.laroche@googlemail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Crt Mori <cmo@melexis.com>, Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 12:01 PM Will Deacon <will.deacon@arm.com> wrote:
>
> > @@ -52,7 +52,7 @@ u32 int_sqrt64(u64 x)
> >       if (x <= ULONG_MAX)
> >               return int_sqrt((unsigned long) x);
> >
> > -     m = 1ULL << (fls64(x) & ~1ULL);
> > +     m = 1ULL << ((fls64(x) - 1) & ~1ULL);
>
> This just looks like a copy-paste error because there isn't an __fls64().
> But I think your suggestion here is ok, given the previous check against
> ULONG_MAX.

Hmm. We probably *should* add a __fls64().

There looks to be only one user of int_sqrt64(), and that one is
confused. It does int_sqrt64() twice, but since the inner one will
reduce the range to 32 bits, the outer one is just silly.

That one user also had better not be overflowing into the high bit -
it uses "s64" as a type and does seem to use signed operatons, so high
bit set really means negative. sqrt() returning something odd for a
negative number wouldn't be all that odd in that context.

But yes, our current int_sqrt64() does seem buggy as-is, because it's
*supposed* to work on u64's, even if I don't think we really have any
users that care.

And as Will mentioned, the regular int_sqrt() looks perfectly fine,
and subtracting 1 from the __fls() return value would actually
_introduce_ a bug.

            Linus
