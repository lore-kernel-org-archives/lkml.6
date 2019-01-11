Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD983C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949BB20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CFO5Mf2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbfAKRz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:55:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41074 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732762AbfAKRz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:55:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15-v6so13666013ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rku8Slm2VY1GhTz6XxU7X738jMc4ItiPAPrWqE3HaQM=;
        b=CFO5Mf2haZIr6gZNyW/XvZnH4ExELh0SgdhHEe0Pu1TiwPWqDC48AWWHQk4e/hxSWt
         eMjXc4TO7IhhhctO4IQrA3zghpv0ghXPr+B5NekePh3LAezdtXSHgwDy7+mxuZ0ehLTG
         njIRA3/ot1avdum1SvneopI16J0Nwiufs6T8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rku8Slm2VY1GhTz6XxU7X738jMc4ItiPAPrWqE3HaQM=;
        b=rRXu/x4go5cmRfPC8XFCR7LQPX2/OIRscQJqRbCczfPEud2q4jZ3doH9XTaJKWfqWg
         ab97e1FN+aqSTjZ8HH0QafoHqM+SNzBQZ0zUxeZBYNLvQjQMZiYV7lBXg6d/qGaw7Nkd
         Ly1fWKFoV9A7MjpPxANRATj3Hjg5hj/yOnJDSGqdzC5pi6NKlJ9pbCEXX8Y834zmY8hR
         yBuheQToj9mg6jyu/LFe02Kr3LPWnF2i6TUTsas3ebyRD9gh3Ygrgso4oDMIfY37HNL2
         +XSxAfQBs4/8IZmDN9CHT1rcsqlLOiLJJhc16YjK8CaecbxVu9M6/mRMQSovuqYM7Xph
         GFyA==
X-Gm-Message-State: AJcUukfySxhhrOY7/7S9alQcmX8+Xf06A+Pt8/Dd3gAuR5VDaIpFb7De
        zirG+DgKlOQu++AysMgDq15o7CUG2TE=
X-Google-Smtp-Source: ALg8bN6O33BP3mKr+zutOW8keAJKhaKd+6fK+pS8Ur+hk/AB/OR/zltjH0jyJ4FsZie2cZKYOLX/xA==
X-Received: by 2002:a2e:681a:: with SMTP id c26-v6mr8795407lja.175.1547229353506;
        Fri, 11 Jan 2019 09:55:53 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id o25sm14429579lfd.29.2019.01.11.09.55.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:55:52 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id g11-v6so13710576ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:55:52 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr8923846ljh.59.1547229352080;
 Fri, 11 Jan 2019 09:55:52 -0800 (PST)
MIME-Version: 1.0
References: <20190111074614.GA68053@gmail.com> <CAKv+Gu8oY6VFeuH3T0FU452W-rKGGQk3top5kEbuP2aCxzJTCQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu8oY6VFeuH3T0FU452W-rKGGQk3top5kEbuP2aCxzJTCQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Jan 2019 09:55:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjNhQsT2h0M25dDELgaCfkWYBGx_5gQw=yEM10uTO4Ycw@mail.gmail.com>
Message-ID: <CAHk-=wjNhQsT2h0M25dDELgaCfkWYBGx_5gQw=yEM10uTO4Ycw@mail.gmail.com>
Subject: Re: [GIT PULL] EFI fix
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 6:22 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> I was hoping we could merge this patch (so we can backport it), but
> resolve the conflict by dropping the kmemleak_ignore() again [..]

Well, we'd drop the new #include line also, since it would be
pointless without the kmemleak_ignore().

End result: there would be nothing left. Better not to merge it at all.

It's easy enough to backport, and just say "done differently upstream
in commit 80424b02d42b ("efi: Reduce the amount of memblock
reservations for persistent allocations").

The stable tree doesn't require that the *same* commits be upstream,
it only requires that the fixes be upstream and Greg&al want a pointer
to the upstream fix just so that they know they're not fixing
something that might still be broken upstream.

See for example (just random googling)

   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=37435f7e80ef9adc32a69013c18f135e3f434244

which shows that "fixed differently upstream" case and points to why.

                  Linus
