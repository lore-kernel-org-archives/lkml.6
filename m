Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71AEC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897F221934
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e+umDjSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391295AbeLVWUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 17:20:37 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44024 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390403AbeLVWUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 17:20:37 -0500
Received: by mail-lf1-f65.google.com with SMTP id u18so6240582lff.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 14:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwnfrEAjHDla7LXLdwF7RBMsXu5hlkxtNxschIszU/c=;
        b=e+umDjSbbk/BrgodItrvj48YSPtQU00PA6q/AA6grwoRJ6LW/jvMcTyaeP6fpDZ6NV
         1brkwPTAj1Gfi6sPtWG9wP4UlVImC+bNQTBkh6HfR0/yT2nQk/tgDOuEfrWxSX44kWVf
         td7RTbCoV6+VXAoKlXZa0A8D5hGfxPwL7kYZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwnfrEAjHDla7LXLdwF7RBMsXu5hlkxtNxschIszU/c=;
        b=lpetC+bVzOanlDyB7gStDdr5FskAAQuCBC/4m2GUirlcVpulHNnKu1MFkpNWvqwom0
         +nbtJjrL+3Xeu8DXBDl3bv0aX99sWzAsJmlD3y6R2skIEqWR7XinBONVgKur+Z0lCP98
         O2t2wv/Y1eXU3bCXB9SrvntL5O7ZoFD3cnrqA8e/Cy1l29/xHIYjZnb2rreHdf4SQJky
         Q/lR0o8Z8ZOUarYsFtyeghAZfIYDt5GpiqfkHVnT7PJclr4ToOU1gIbKkPZN0b/AzE2Z
         xdE1SN4Er7dhlr9XcC8XmqgQO2QR3jwvghLZHjDf3yzUWtGDatoMBnZwxCaAgo47sQ1g
         cHUw==
X-Gm-Message-State: AA+aEWYprPnz5LeZy2wPID01y+SUZE6P9fGuTX6qPSYqd95RqDkPUOpB
        RcJW+hMZx8Lhpzw+tvWDXDu170Xxkys=
X-Google-Smtp-Source: AFSGD/XrLO56km9x5afDqQE08sTOO9Q5LEcILbdMzJrh0OfB76R10zJGa9bW8285UWA1ChrZjILXEA==
X-Received: by 2002:a19:9508:: with SMTP id x8mr4167355lfd.112.1545517234379;
        Sat, 22 Dec 2018 14:20:34 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id e13-v6sm5498750ljk.53.2018.12.22.14.20.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 14:20:33 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id n18so6251844lfh.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 14:20:32 -0800 (PST)
X-Received: by 2002:a19:7013:: with SMTP id h19mr4312126lfc.147.1545517232586;
 Sat, 22 Dec 2018 14:20:32 -0800 (PST)
MIME-Version: 1.0
References: <e62d4c3a-b89b-2380-7b39-66733b389145@gmail.com> <CAEJqkggwbNP3Q+7AWr4i64CvAdCp15jVLOtUsnMo6rLk3ExTkA@mail.gmail.com>
In-Reply-To: <CAEJqkggwbNP3Q+7AWr4i64CvAdCp15jVLOtUsnMo6rLk3ExTkA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Dec 2018 14:20:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjd2VJDM+RXwg30MpW45F5EHZtLErzxQzYxi4+Dnm3sjw@mail.gmail.com>
Message-ID: <CAHk-=wjd2VJDM+RXwg30MpW45F5EHZtLErzxQzYxi4+Dnm3sjw@mail.gmail.com>
Subject: Re: [BREAKAGE] Since 4.18, kernel sets SB_I_NODEV implicitly on
 userns mounts, breaking systemd-nspawn
To:     nix.or.die@gmail.com, "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     ellierevves@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, seth.forshee@canonical.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric, this is entirely unacceptable.

On Sat, Dec 22, 2018 at 12:58 PM Gabriel C <nix.or.die@gmail.com> wrote:
>
> Added some people to CC that might want to see this..

Thanks.

> > Here's an email that was sent to lkml about the subject:
> >
> > https://lkml.org/lkml/2018/7/5/742
> >
> > I link also this, quoting the last of it:
> >
> > https://lkml.org/lkml/2018/7/5/701
> >
> > It has never been the case that mknod on a device node will guarantee
> > that you even can open the device node.  The applications that regress
> > are broken.  It doesn't mean we shouldn't be bug compatible, but we darn
> > well should document very clearly the bugs we are being bug compatible with.

Yeah, this is complete garbage.

We have very clear rules in the kernel: if some change breaks existing
setups, it is ABSOLUTELY NEVER the application that is broken.

It is the kernel.

There is absolutely zero gray areas here. Eric, your behavior is
entirely out of line, and now we apparently have a regression that
goes back to June that I was not told about because of your incorrect
stance.

Eric, I want to make this 1000% clear: there are no user space bugs.
If it used to work, then user space was clearly doing the right thing.
The fact that you tried to several times claim it was buggy user space
is a serious breach of trust. You KNOW this is the case.

Seriously. There are no excuses.

That commit is now reverted in my tree, and furthermore I will not
take any pull requests from you until you have made it clear that you
comprehend this very fundamental issue.

Why did it take so long for this issue to be elevated to me?

                   Linus
