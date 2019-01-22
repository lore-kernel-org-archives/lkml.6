Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BD4C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D0721721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAHz9ViX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfAVERt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:17:49 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39161 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfAVERt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:17:49 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so18352087itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 20:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNCiLSCOs3HIOeMuRVgReUCd+ne31UPnW0KZgc5m+zA=;
        b=QAHz9ViXtFffS1ULvCTtubzPehSRnYyYPPoHXhvVBgqhIPiQxlN67iGbs9/m9fptlW
         mbftemqKpCPpb84j8a3fXCUhA0Nnqu73NSxtd+5KItm+8aaLI1FRIvXOIudxnEgFWbBF
         BhuTTuQQk8dO+BCA12SMxl+9K4k7vgKF4R4xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNCiLSCOs3HIOeMuRVgReUCd+ne31UPnW0KZgc5m+zA=;
        b=mQ5WUEb+uCinruT+UiEJ5UmYNHJs1TaRCNrEBj7I9iUsrDHSTtkpx72XD14V67Yhev
         /Zz14BOS8ES/rwgUG8Cxvcp2pCqD5+7/mgdIDjWZi2v2XhWVeKnsv+433Sst/EsfSMHK
         nnNrjI2WhKT0VUskjp+LJXxoTfKLzLdaCPsIKLfm7zGak0y6TMOMrjPfHKgBLUkChWkW
         b1Ls9lVSnTSbuKpb1wskKX2PSkI0mrRzRh4xj0/Jz9Jvz98UhuRtnZpQeC49MpLyenVC
         0vGHM9+h/UOKNmUo+QTA5SH4aYmKSsFA3vEMHtOpC8ae3QLmsJMvQm15T1G55isz8g0l
         BsZw==
X-Gm-Message-State: AJcUukd9EDcoMiIagaS9fekwje32d5JAip2fUfIcaZInOr7/g6OJFzHO
        cBX0APwtkvNFbaZ4aMwV4YBddXh5oC9e1cqdsCLrZA==
X-Google-Smtp-Source: ALg8bN5GlXzkDXSzuQpWtdpGUbIFc+urhwgY4mQj32A/c4P4ZfZKF6yRF0pHgpLttOBuPMH4biJBmbF2qhFL+K+RKlg=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr1180269iti.166.1548130667985;
 Mon, 21 Jan 2019 20:17:47 -0800 (PST)
MIME-Version: 1.0
References: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
 <20190119235650.GC26876@brain-police> <CAK8P3a1kiS7oF=eKLqPs6kKTYE1uTjhz++edH_J-tCUmXY2PNQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1kiS7oF=eKLqPs6kKTYE1uTjhz++edH_J-tCUmXY2PNQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 22 Jan 2019 09:47:36 +0530
Message-ID: <CALxhOngnGKk==Cj+3EM1LkBK4FYRXNu4JxVg-d=3uttVcLwqQw@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: system call table generation for asm-generic
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Will,

thanks for the email.

I'm want to abandon this patch series. Will post new patch series for
system call
table generation support for asm-generic and some other stuff together by end of
this week or early next week.

Thanks
Firoz

On Mon, 21 Jan 2019 at 21:24, Arnd Bergmann <arnd@arndb.de> wrote:
>
> n Sun, Jan 20, 2019 at 12:57 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > On Thu, Jan 03, 2019 at 09:10:22PM +0530, Firoz Khan wrote:
> > > This will be an automated scripts to provide easy support
> > > for add/modify/delete the system call entry by add in
> > > respective *.tbl file.
> > >
> > > System call table generation support for asm-generic is
> > > provide for arm64 architecture which will use the common
> > > scripts resides in scripts directory and use syscall.tbl
> > > syscall_arm32.tbl files as inputs. This implementation
> > > will replace asm-generic/unistd.h.
> > >
> > > This patch depends on:
> > >  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
> > >  https://lore.kernel.org/lkml/1546520681-24453-1-git-send-email-firoz.khan@linaro.org/
> >
> > I'm having a hard time understanding what the benefit of this series is,
> > given that we only support EABI compat tasks. When adding a new compat
> > system call, you can't just blindly hook it up without checking whether it
> > needs a wrapper to deal with any type conversion etc, so really we're just
> > replacing one table with another as far as I can tell. What am I missing?
>
> The point that is missing in the description above is that all unistd.h
> and syscall.S files are now being generated from a .tbl file, across
> all architectures. This was already done on arm32, x86 and s390
> before 4.20, but is now done on all architectures that don't use
> the uapi/asm-generic/unistd.h header, and the arm32 compat version for
> arm64.
>
> The newly added file has the same format as all other tables, and
> will be easier to synchronize with the arm32 version, which has
> almost the same contents (arm32 has oabi support, arm64 has
> compat support).
>
> > I also really don't think we should be generating the 32-bit UAPI headers
> > from the 64-bit compat system call support (if that's what you're trying to
> > do -- make headers_check fails with your patches applied). arch/arm/ is the
> > canonical place for the 32-bit UAPI, and we're just implementing that.
>
> I think you just misread what Firoz was trying to say here: The
> arm64 uapi/asm/unistd.h file is now being generated from the
> generic syscall.tbl file, while the compat asm/unistd32.h file is not
> part of the UAPI. In both cases though, the data from the old files
> is being replaced with data in the more compact and (hopefully)
> more readable format.
>
>
>     Arnd
