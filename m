Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCE1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C710820868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfA2Utjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C710820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeJLRsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:48:23 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36436 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbeJLRsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:48:22 -0400
Received: by mail-yw1-f68.google.com with SMTP id e201-v6so4754800ywa.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 03:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+qq8jh6HvIleMYuIkP+oiavuoCqeRrRHTb+pmsSF5c=;
        b=QfA2UtjxaExSv9wt6R2WEMGCes3T0pnETWxUhlGIbUzlmzDkCEUIb5D7ToIsI9v6NG
         4dUFeWKWeCUyoaUu1EWqkWUU0rDdHN2LWD74dsFX2eN9jT1lTmIJOFEF2Xeq/03T8PfU
         J/uAvZz+UZnQbPqWmTf+D0gsfMyF9ixN5A7z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+qq8jh6HvIleMYuIkP+oiavuoCqeRrRHTb+pmsSF5c=;
        b=X/n1eSGaFdBG34onXZtNgGZUU9zEtv4bSC3DgaZhQRRgtyiCskxiKCMnp0fbrFOFEy
         kB3HykT9wnNYTbv5kDXdWy2ac4gMc/16I5PNkS/PaF1UNI7k+X6SaNf4BpJxxUEzvqSN
         UG7yaOdE4SCyubQwrDwa85utHJYyM/P9Y29CA9h1GhEJ2oO4YpdNpCFkty4an6tv29qn
         6rIch5cDKu1QHy1tNH0HQs3TW1uNI9EGoz+R8h2FrR9IXlJqx7npHxYuPRu6e3Uw1pNP
         kQv3tlBtsOFU+//yf6lMRq5T4H7jM+2FK2T2Hsd2KccG8wse+TkM/VfbLGMDJjO9r6A3
         Yuig==
X-Gm-Message-State: ABuFfoiW3I3cdI810kflx+VInPFo2gj6/1YZUOlDwZNK/Lf6CGpd5SLv
        Qg7ssKabqO6AxQpCVgETw7HDql5wXJhM3MJUnDIKSA==
X-Google-Smtp-Source: ACcGV626c13IVIVQFiApY+O4msn6DrIl1B4My/agaCKbjM4zPQPcw3nruZ57mozYF8v+4UbCcnwqGJwhR+KyY1o0NI0=
X-Received: by 2002:a81:5f86:: with SMTP id t128-v6mr2987521ywb.84.1539339401379;
 Fri, 12 Oct 2018 03:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-6-git-send-email-firoz.khan@linaro.org> <CAK8P3a1gsuM7mBGm9hx-BTs=HAG3cSjB6M7N-kpMmPy3kixeCQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1gsuM7mBGm9hx-BTs=HAG3cSjB6M7N-kpMmPy3kixeCQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 12 Oct 2018 15:46:29 +0530
Message-ID: <CALxhOnhj7qUj57tLX12KmbcE5G-zDK2Qf2fTUbQ=jpmiUcr52w@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] parisc: wire up rseq system call
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, 12 Oct 2018 at 15:26, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Oct 12, 2018 at 11:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > Wire up rseq system call requires an architecture specific
> > implementation as it not present now.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>
> Didn't we conclude that this should be skipped?

Helge told "I prefer to keep the warning for rseq for now.
It reminds me that we still may want the rseq syscall.
If the warning is a problem, you may simply add the __IGNORE_rseq define."

I chose this option; I feel it looks clean
"# rseq requires an architecture specific implementation" in syscall.tbl
hopefully remind him to add rseq syscall implementation in this architecture.

Firoz

>
>        Arnd
