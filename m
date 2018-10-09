Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71059ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBBE214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6Cd5L1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBBE214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJJCNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:13:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40848 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbeJJCNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:13:24 -0400
Received: by mail-io1-f66.google.com with SMTP id w16-v6so1993045iom.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0vbDsaEKkIKZq5l2wHrOtVOmgn2viL0y8nScmEDj1A=;
        b=l6Cd5L1otMYTi1bK9E9RWUqoQG/BuNBmd0t9Wmp6dmuzwyiz7QJtUSgAPY/1f81ZoD
         /6yFjmrBVhkUQ7dn8yxcXEWlHP8717cRu4e/hD7ffx5xTxtm/AkvDFDLYZSgumxwQotK
         fR/c4oiNRLLAVc15mbjKAS0PlJKWf+ntE2zyBssOuCk+8sxLxl286Uqsvoqp0cgsdQfZ
         p0xgodr7fIyKVEFm+4u/6ZHEQzN4D1r6Y5v0IPjVnbEvESahlG3fyJtRPLAhuIuOM0Gk
         uW9SkX5oRhEJID/pRrUFEp2pKm2rh7Pu9dZ5/RgKy2OeMcms548mT6+ki2CH/jh96vO9
         lsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0vbDsaEKkIKZq5l2wHrOtVOmgn2viL0y8nScmEDj1A=;
        b=HozPhM35MZdco7P+RnJSl4AgM35pVaf0CmSE3SLnni8YdMlNkXEGRjyk93XvnZskBj
         3EqogDQMeXLDaVev4H1Qnny+KVzpcrB0RY2zIcQB1m9/Wh0MaNSDZ3jTkSztGUShzbsp
         9qJ7HsXfym++0asf2TIRiI4meANStvP43gBhn6OPWrme9AaD8fdnDyXL2CQhbQ4fzSFa
         LE7WzZmN8RpIF/UcOqmdup6CJbNFFnZsZj6vRrBQheYo9P0K9e5rwbOr/4B2GzAYFGtO
         YHQ9IGkDFZDgpdDbvm2x+m3iYHJkPa6+RYTlY7gD1N+5C9oIsdK9PqRSB4PnIqyj+tBL
         7xeA==
X-Gm-Message-State: ABuFfohEF4Xh+XFnmI6gkf4FaZWyPM7KgB3dBETP07SA1YW6HM/pjfqu
        bVZxVwtsFuus72P65AOFbI25Uv1FrsgFGSLKeKiRqQ==
X-Google-Smtp-Source: ACcGV60LVr/m6ppL4mERb/dK2iZf/MuAe3zDUNpj5wixFw5/e/9B4d22axu8wtwP5LdFQBSpSJnMvBbXzHm7I69hYuI=
X-Received: by 2002:a6b:b48f:: with SMTP id d137-v6mr19243105iof.163.1539111301613;
 Tue, 09 Oct 2018 11:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAO49afLqUGuBi_R7BKyojqnkHrMGqXquy-FdVFscOu6Ez0cVFw@mail.gmail.com>
 <20181009164743.GA22886@krava>
In-Reply-To: <20181009164743.GA22886@krava>
From:   Anthony LaTorre <tlatorre9@gmail.com>
Date:   Tue, 9 Oct 2018 13:54:48 -0500
Message-ID: <CAO49af+zxxVh9HGfjKxS=vQcD5po7-oLU87Zp0F21M-C64nWUA@mail.gmail.com>
Subject: Re: perf report segfault
To:     jolsa@redhat.com
Cc:     peterz@infradead.org, mingo@redhat.com, jolsa@kernel.org,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you reproduce the segfault from the perf.data file I provided?

Tony
On Tue, Oct 9, 2018 at 11:47 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Oct 09, 2018 at 11:27:04AM -0500, Anthony LaTorre wrote:
> > Hi,
> >
> > I'm currently running Linux kernel 4.18.10-100.fc27.x86_64 and have a
> > problem profiling a program that used to work. Currently when I
> > profile the program with the following command:
> >
> > $ perf record -F 99 -p PID --call-graph dwarf sleep 10
> >
> > it produces a data file which causes perf report to segfault:
> >
> > $ perf report
> > perf: Segmentation fault
> > -------- backtrace --------
> > perf(+0x325302)[0x55860ae79302]
> > /lib64/libc.so.6(+0x347d0)[0x7fbc8f3987d0]
> > perf(+0x273e80)[0x55860adc7e80]
> > perf(unwind__get_entries+0x1d9)[0x55860ae4ace9]
> > perf(thread__resolve_callchain+0xfd)[0x55860adce7dd]
> > perf(sample__resolve_callchain+0x58)[0x55860adc45b8]
> > perf(hist_entry_iter__add+0x98)[0x55860adfa908]
> > perf(+0x1ab8d9)[0x55860acff8d9]
> > perf(+0x280603)[0x55860add4603]
> > perf(+0x283c63)[0x55860add7c63]
> > perf(+0x280e04)[0x55860add4e04]
> > perf(perf_session__process_events+0x8ae)[0x55860add6bee]
> > perf(cmd_report+0x190f)[0x55860ad01a4f]
> > perf(+0x21a961)[0x55860ad6e961]
> > perf(+0x21ac6e)[0x55860ad6ec6e]
> > perf(main+0x361)[0x55860ace8411]
> > /lib64/libc.so.6(__libc_start_main+0xea)[0x7fbc8f384fea]
> > perf(_start+0x2a)[0x55860ace889a]
> >
> > I've attached the data file which is causing the issue.
> >
> > The perf version is:
> >
> > $ perf --version
> > perf version 4.18.10
> >
> > and I'm running Fedora 27 if that makes a difference.
> >
> > I've tried to reproduce with simpler programs so I could send a
> > minimal working example, but it doesn't appear to cause the issue.
>
> please do, I can't reproduce this
>
> thanks,
> jirka
