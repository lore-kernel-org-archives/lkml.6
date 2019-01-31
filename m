Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABF3C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27C2218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KQ7ACXeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfAaSlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:41:18 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33347 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAaSlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:41:18 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so3154902lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 10:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=piYNYv4PDsYfyxUQBlLsMZX4BiSoVGoWHLxLb7BvlRs=;
        b=KQ7ACXeoPHbZzGK3z5JqRup4ehfx5tPxaRbQpyWz3ZYfcE0X7cWs9KxiT0zddtYwNu
         KaNeZB0IEsETe+qw8kSVZWTI982T3206iUAMOSCTlyrD8/f/7fjTnWkcdeDSfbAPD5K9
         V1oEbO4Qxz+EKV0uej37DOyfWX1pmFiU8g8hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=piYNYv4PDsYfyxUQBlLsMZX4BiSoVGoWHLxLb7BvlRs=;
        b=YfDf5O9Cu2aUTMYDuDFtgyjzB4KLfS/FY2bu5MK2iZT00InhQExeOoFRUoeL3w7en3
         qf/lnJ7RQj0g0JI5+B2viIULQIkEpZUIySJ2Iy+/58SV4P20otQ71NLus7t6BIx7V4Al
         SjID+dX438+SRrby4esJOXj2Nc25xp3vn8XPUGVb4RMFhbH17cugrt3OAFqvmGrKTyOw
         6bYpr1L4FFVSeKoD1cKfeyJl/75qsRCbh03Mc4uv6DSnAT5RFL6U4E3/007A9oJ8kPDw
         Hdmkyf+VMNG34EhlchFCi2uZtxC1JIC08ZuugHidyxUjjvJFPJxDw/RkomRff+S5Jwg+
         d9UA==
X-Gm-Message-State: AJcUukcMRyEDOn+vVehKiz+671rQon567O6hRBqoxhKej89sMICnBKQC
        BcGvSNcIqZBLr4vq9mmtA1R2GQpZ80I=
X-Google-Smtp-Source: ALg8bN7XYUHQ16Fn0i7HWJNQ9wK/M0kIoCUKX2FuvJ6LfwLct4DHVZuXbEHYiLrkHWqyqGLlEKhq7g==
X-Received: by 2002:ac2:53b1:: with SMTP id j17mr27179624lfh.167.1548960075713;
        Thu, 31 Jan 2019 10:41:15 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id k11-v6sm910155ljk.40.2019.01.31.10.41.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:41:14 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id a16so3145135lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 10:41:14 -0800 (PST)
X-Received: by 2002:a19:24c6:: with SMTP id k189mr28273278lfk.77.1548960074256;
 Thu, 31 Jan 2019 10:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20190130203036.11220-1-agruenba@redhat.com>
In-Reply-To: <20190130203036.11220-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Jan 2019 10:40:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg87Y=39-_caKv6apLx4dfyC3ZdaoLvd3xz5zjONbw_Nw@mail.gmail.com>
Message-ID: <CAHk-=wg87Y=39-_caKv6apLx4dfyC3ZdaoLvd3xz5zjONbw_Nw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Revert "Fix loop in gfs2_rbm_find"
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 12:30 PM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> This reverts commit 2d29f6b96d8f80322ed2dd895bca590491c38d34.
>
> It turns out that the fix can lead to a ~20 percent performance regression
> in initial writes to the page cache according to iozone.  Let's revert this
> for now to have more time for a proper fix.

Ugh. I think part of the problem is that the

        n += (rbm->bii - initial_bii);

doesn't make any sense when we just set rbm->bii to 0 a couple of
lines earlier. So it's basically a really odd way to write

        n -= initial_bii;

which in turn really doesn't make any sense _either_.

So I'l all for reverting the commit because it caused a performance
regression, but the end result really is all kinds of odd.

Is the bug as simple as "we incremented the iterator counter twice"?
Because in the -E2BIG case, we first increment it by the difference in
bii, but then we *also* increment it in res_covered_end_of_rgrp()
(which we do *not* do for the "ret > 0" case, which goes to
next_iter).

So if somebody can run the performance test again, how does it look if
*instead* of the revert, we do what looks at least _slightly_ more
sensible, and move the "increment iteration count" up to the
next-bitmap case instead?

At that point, it will actually match the bii updates (because
next_bitmap also updates rbm->bii). Hmm?

Something like the whitespace-damaged thinig below. Completely
untested. But *if* this works, it would make more sense than the
revert..

Hmm?

                   Linus

--- snip snip ---
  diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
  index 831d7cb5a49c..5b1006d5344f 100644
  --- a/fs/gfs2/rgrp.c
  +++ b/fs/gfs2/rgrp.c
  @@ -1796,10 +1796,10 @@ static int gfs2_rbm_find(struct gfs2_rbm
*rbm, u8 state, u32 *minext,
                rbm->bii++;
                if (rbm->bii == rbm->rgd->rd_length)
                        rbm->bii = 0;
  +             n++;
   res_covered_end_of_rgrp:
                if ((rbm->bii == 0) && nowrap)
                        break;
  -             n++;
   next_iter:
                if (n >= iters)
                        break;
