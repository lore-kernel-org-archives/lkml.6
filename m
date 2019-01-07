Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3A7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A8F2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njmpcKyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfAGTmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:42:49 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40251 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfAGTmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:42:49 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so659209pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 11:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQnOEASg1G9SHRxqD6ig+kcQJmVRl7JrNnFY/K4/2b4=;
        b=njmpcKyZ7mzw6ok1+1DVLRtDjp7JBoPK9rQ1cYsPLwdQQrP9OCeNF11CJXfIFmbT+x
         gAOuJ31JMe8/7OgK0+eZoYQszed5TfeukZUt6BzNZzeRrEE7l6tYkako9a00pt2nHblL
         8CoBALMZN5eEHi5Miq9YuKNQXK41KQDWrTmiV4WZS0yQL/EyWNh1VYo73OFRSix61rwa
         KE+0w8MaTvWBwvjngLTIgbVcvcL5XaECwGJuljn7kbyvy/VO0yPMqb3rlUM15cNcWg5p
         N86fA7haTUbGMPa7wqV5MIEbCYgB8YwYZ5EA1PYE16VvZntzB5fIch+AvAaCeA6AxLpi
         8NSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQnOEASg1G9SHRxqD6ig+kcQJmVRl7JrNnFY/K4/2b4=;
        b=gNjKBM0+MaQwfiY8zz9xBL1XMldF1drlEep3iGue6b4d8WCVcPnF3vrEyU+BNPxvY2
         6501W9xpGr4ZFPtVKlKzUq2mF8PlxWM7lcTXCqCfYwn467cmzi4yMnKzzJmU8fsA3m+c
         388jIMDpU7zT1C2uGdSfWouqCJnjWE8gOSvNNJPRGfjEEZVsvUH9I23MyWDB2+eJObwx
         xYnjJgwoVjJDaNmUIqjcIc0/sn4r1y6yvzMGvc1+7ZMS4Y1BDOxCPuIZCh1CEC6U2b30
         s8n4nrEAVUBFnhpe68Ex+p6/6LxPrw1xvfb5X5efJKBcsJgDA43plo+l2XgvI1AkOdvQ
         NR0w==
X-Gm-Message-State: AJcUukfpAInfsWmqqFRubLwYWiHZRCn0fGLVzw7bS3Lseo1iMTgKah4O
        yvIIC4YFixsEadErChgYsQeOJ3k6TluSJQKYUJgtVg==
X-Google-Smtp-Source: ALg8bN7JDwIy9oh11W1Mc1WZPHJ5YJqJSxWCPpMdFqpF86J/9zEsTim/1nXAlaMqxNeN8V+VzjqV1e8uX0Jr4VvtI9Y=
X-Received: by 2002:a63:42c1:: with SMTP id p184mr11973123pga.202.1546890167491;
 Mon, 07 Jan 2019 11:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com> <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox> <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
 <20181205183606.GA7274@flashbox> <CAKv+Gu-2JAiAJqWu9VaaEJ3uFr_B--J7s=iHAN9ze90HD=pXEQ@mail.gmail.com>
 <20181205194519.GA9197@flashbox> <9f43145527aa4220ecde4c3b263241e6@agner.ch>
In-Reply-To: <9f43145527aa4220ecde4c3b263241e6@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Jan 2019 11:42:36 -0800
Message-ID: <CAKwvOdk-YkXtOKs0SFc3=pEyoe5FaeNqW-JhJii6u34HUvdDNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
To:     Stefan Agner <stefan@agner.ch>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 4:27 AM Stefan Agner <stefan@agner.ch> wrote:
>
> On 05.12.2018 20:45, Nathan Chancellor wrote:
> > On Wed, Dec 05, 2018 at 07:39:55PM +0100, Ard Biesheuvel wrote:
> >> On Wed, 5 Dec 2018 at 19:36, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >> >
> >> > On Wed, Dec 05, 2018 at 09:09:56AM +0100, Ard Biesheuvel wrote:
> >> > > (+ Arnd)
> >> > >
> >> > > On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >> > > >
> >> > > > On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> >> > > > > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >> > > > > >
> >> > > > > > This flag is not supported by lld:
> >> > > > > >
> >> > > > > >     ld.lld: error: unknown argument: --pic-veneer
> >> > > > > >
> >> > > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >> > > > >
> >> > > > > Hi Nate,
> >> > > > >
> >> > > > > Does this mean ld.lld is guaranteed to produce position independent
> >> > > > > veneers if you build kernels that are bigger than the typical range of
> >> > > > > a relative branch?

Just for the list, 2 patches to lld:
https://github.com/ClangBuiltLinux/linux/issues/286#issuecomment-452027802


-- 
Thanks,
~Nick Desaulniers
