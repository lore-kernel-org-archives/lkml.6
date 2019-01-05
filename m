Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B889C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E0C222EB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cJhb6LH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfAEUoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:44:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38694 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfAEUod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:44:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so2604740lfk.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 12:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdijyVIkjZNRx/nrM2SmFgETwq3q933x1OT4uWxhoNw=;
        b=cJhb6LH0FSwWg/cZXfcNKelvXrE/ft5aquv/Z2jWkpBLUZEgoUH7AnZe2EEBLUSvUM
         6O5f1svd5sLzDX/AMT49SvjDpEQ6McZQwPPi6FEIYWeHSOucf8g20YCjj94NNGXN4Zt/
         pcyFc9u2eyHGNsjtie7tBcd2XilkFN1JSWP/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdijyVIkjZNRx/nrM2SmFgETwq3q933x1OT4uWxhoNw=;
        b=eP3GGk8D/HbmjY1KqHWGPxWwuAakM75KwUEKMC4EjavHTEwsV+1vyZYD29vkWaA9V+
         EKCFy/Sg6EmLjMTTiLJ682Q4ips2sJ42TR7buVHYeDQBGcdVtB4569JmtYLOnscMrqD9
         RJ9pMoT3nJKAG9gR0eT/3UYvCItrJTHJVAULtjbAv490bUGOE7QCfrBDOmSXjWCpOPnb
         WLVi8MZLxt8dwGIinUk42KLlKY3r4q/8QliIE8KVOXfsLSM+CXAakuUO5h87CDJQhD32
         CPMvYGsDkwGOXS2R8zoI7DBHELk7BCjqVIngCImgwDehYyZS2XxCJrROylvghUdiFf+g
         Cr1g==
X-Gm-Message-State: AA+aEWaGRxOxXrvxkQgUCFGFq6f4c9HnimgPvEeNaB2NNDrSs3bp+01I
        7bqAeLq/zN+9z+gR/172v/84Fxwxhp0=
X-Google-Smtp-Source: AFSGD/U3L+VtxOvQfWW/y5/uedCpFqcCVp8MGJehsFVljTS4w2DgWRw+Xf7nNay54GGl4aJS3rOMsg==
X-Received: by 2002:a19:cd50:: with SMTP id d77mr26998986lfg.125.1546721071191;
        Sat, 05 Jan 2019 12:44:31 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id w16-v6sm13206140ljw.11.2019.01.05.12.44.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 12:44:30 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id b20so27623285lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 12:44:30 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id p129mr29617815lfa.135.1546721069892;
 Sat, 05 Jan 2019 12:44:29 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAQzEHv7Y69xFTPDEhyMP6JX4ghb96UMqMdxYyVyah6-VA@mail.gmail.com>
 <CAHk-=whg49nn5q_2QVMGN0u4rQFBmRKywtqJUSk+5=rBzTk1kg@mail.gmail.com> <20190105203906.GA22423@ravnborg.org>
In-Reply-To: <20190105203906.GA22423@ravnborg.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 12:44:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh0rrLKYOxW6hAVaQ8rFGno7Q=XKrd13mfLXyd__WnTPw@mail.gmail.com>
Message-ID: <CAHk-=wh0rrLKYOxW6hAVaQ8rFGno7Q=XKrd13mfLXyd__WnTPw@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] Kbuild updates for v4.21
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 12:39 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Not exactly what you ask for - but we have make V=2

Yeah, that's certainly more convenient than "make --debug".

That said, I was more thinking of not any particular "oh, it's
recompiling everything" situation (by then it's too late, obviously),
but if somebody has been looking at tools for finding and maybe
breaking some of our deeper include chains.

I know it has come up before (the x86 people did the
<linux/schedule.h> split some years ago) and then it was all manual.
But I was kind of hoping that maybe some of the kbuild people had
looked at this?

             Linus
