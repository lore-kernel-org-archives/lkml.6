Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B775C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07732083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTQSOUQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07732083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeKFNfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 08:35:46 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43092 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbeKFNfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 08:35:46 -0500
Received: by mail-io1-f68.google.com with SMTP id t81-v6so8262862iod.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 20:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPZWIOUHlEUWfw1HewNH7v4q/K/KJkWO/6VxNoNAols=;
        b=LTQSOUQbC2qBR1w6jxK00K0lvSS+eDQIvpZ13UI/+4zbqDkpYbHQkqx57WDTzIj+VE
         B/KFwkU00IsyEfNiHZENRL5lGXSc0k8pcJJqMjZ1NcGR5ByE6Cd+3ivuGydHxJRLECuq
         AY6XcHn/yhqYCvJuiYy/NSTIssmJtnuqXRqgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPZWIOUHlEUWfw1HewNH7v4q/K/KJkWO/6VxNoNAols=;
        b=g0HlJdotoj2utuwedeIOCc3zZ26pWsXM4Wz0yIsxTWslNLHU3ouKaTRcYABVkaSLzm
         cOOzYujNm4dNUHoG4xfNS3BiFT6R6P6ygRzeFhyuSmSX5EsW3Aov2Fp5tAzheGKrbR6E
         3dYqo69FhSJUk7wBZEcimSD4xks5H8ZdnIWWsPQIl6pWj8ctxJh5H4LKrNQmblIhL4l9
         se53MI+awouCENkJR4DP7guldynm0OlMvrjAzI2Ar7y4+YvFVH3hXssVueUEpJbPTVC5
         4pbEuuGatmCNEplOSDRywK1sP8yA8pGIRfgXpnIi3QByk+zn9ENL9vHnoHuhhn5Bw8SP
         rBvA==
X-Gm-Message-State: AGRZ1gKiPDvfNAH+9LMCSjm2NyNadZiCb6RLUq5p7j2QD7O/jUXTb988
        ztcqFi1N+RcChPUnbMFuheP9Xiu+Y8EH/T7HjfrX/g==
X-Google-Smtp-Source: AJdET5fwkdx4E9yl2GA98ceiMY/zyPaFOMdkThkI0ggmrT6P2wyikXjR+JuXcgN0I4Elbe2FONza3yocpSrg8QlO2uY=
X-Received: by 2002:a6b:cc05:: with SMTP id c5-v6mr20084050iog.171.1541477553059;
 Mon, 05 Nov 2018 20:12:33 -0800 (PST)
MIME-Version: 1.0
References: <1541079817-3431-1-git-send-email-firoz.khan@linaro.org> <CAEdQ38FckCWguy5MUYkjwhmc3eA30WXB5QNGaU2Yv8gjHvGc=A@mail.gmail.com>
In-Reply-To: <CAEdQ38FckCWguy5MUYkjwhmc3eA30WXB5QNGaU2Yv8gjHvGc=A@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 6 Nov 2018 09:42:21 +0530
Message-ID: <CALxhOnjYVVC7-_h8975OLKZg4x8ApgfG4EaxmGy3HLFiLCcdGw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] alpha: system call table generation support
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On Tue, 6 Nov 2018 at 03:01, Matt Turner <mattst88@gmail.com> wrote:
>
> On Thu, Nov 1, 2018 at 6:44 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > The purpose of this patch series is, we can easily
> > add/modify/delete system call table support by cha-
> > nging entry in syscall.tbl file instead of manually
> > changing many files. The other goal is to unify the
> > system call table generation support implementation
> > across all the architectures.
> >
> > The system call tables are in different format in
> > all architecture. It will be difficult to manually
> > add, modify or delete the system calls in the resp-
> > ective files manually. To make it easy by keeping a
> > script and which'll generate uapi header file and
> > syscall table file.
> >
> > syscall.tbl contains the list of available system
> > calls along with system call number and correspond-
> > ing entry point. Add a new system call in this arch-
> > itecture will be possible by adding new entry in the
> > syscall.tbl file.
>
> Sounds like a worthy goal.

Thanks! This is Arnd's idea to come up with a common script
for all the architecture. This implementation is a groundwork to
solve Y2038 issue.

>
> I tried applying the patches and it seems they haven't been rebased
> since v4.18. My rebases are in
> https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git/log/?h=for-linus

I was rebased with 4.19-rc8 before sending v2 (what I remember).

>
> They seem to work for me, FWIW.
>
> Is your plan to have the patches go through the separate architecture
> trees, or go in together? I think I'd at least prefer for another
> architecture to take the plunge before alpha.

I would like Arnd's to comment on this as it is my first patch series. As I
mentioned in the cover letter this implementation done for 8 architecture-
alpha, ia64, m68k, microblaze, parisc, sh, sparc, and xtensa. Most of the
review are also done. mips and powerpc are *almost* completed. FYI,
The system call table generation script for IA64 merged in linux-next.

Firoz
