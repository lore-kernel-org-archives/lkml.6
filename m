Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA8FC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B7B214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/1NQkkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B7B214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeJJDhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:37:06 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52486 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeJJDhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:37:06 -0400
Received: by mail-it1-f195.google.com with SMTP id 134-v6so4732158itz.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 13:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJ5NMaNNETqyc6A6yRZZINFjSOJuyWDFoQxNboxqLZk=;
        b=Z/1NQkkJuVJ5leecIhOlH4oFQQYJOE4xxdZcAqSYlUl+uwA5PUYZx7gTBSzqtlj2/I
         hDgEurqisn3AG+ScAC51BXQVV6dEJqqBCrXz7BYmnLmok0g70/csiYwHaflmkM2fjYLL
         GN70ULtPsC6evhW/CSf7vNC9BPECCLr+cUT1BX4OlHi9Yb12Isvah+XgJhpd6CXCYSpM
         Aqnx+Wzcb02I4+E+J8rJS16qnAHLuDWhEsy7VkbEEEk11qWEtfqeEm8e/8xY6OBUVZsl
         QvRxjKghLaT/ZVAwWeMxocvW/7jpNi1sRabMMj/u/NE7rTg7fEbzPyMG2Euo9MwAt7Du
         BIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJ5NMaNNETqyc6A6yRZZINFjSOJuyWDFoQxNboxqLZk=;
        b=rXA0QixFlpVlMfrzu1fFzLRTAkjCsKoNGWIFszUDs0SjUTDfjZDQYKZNRi9XZ+7ekq
         o4kCzcDXDpYkhwRu0IEaOqSMfaHWwY504amJYkIvtN3g3JUWchdf9ZWDsLry7PWLKz8t
         G/+vZSMBhNBir/ZwC8u4QOPsLVnEPL12FRrha5puRTs0wnj10G6Rnl+I7Gga1qcqC48W
         Ad4UZGu+zKp9k0ryZ7OUc6SyFtRrnY3Gvodjk0faRcfLCr2ecMY5Bwm5ROH2W9nzMcOI
         gdkySHM7w7q6CGcB3T6P8krVtRcyUf6JcAxxm1wn9meOl2rcxlMIA74yx6fMT72X7V/X
         ARhw==
X-Gm-Message-State: ABuFfoi3yCnK10IDH7vPZOgjyBQde5zCP1kvn0cMxilOhdZcxQD0TAf3
        7zJS4iGPeCAuAXfqtRf068XJFQWVsr25FXoBj0k=
X-Google-Smtp-Source: ACcGV62c8cofsx+9oVgGAd5TdZ2OsOoGDEjJdAHUF5+G7XuHr2DshMAMT2odtRlB8TBZ2jDmpFiVpVLmD1lG99UZWtw=
X-Received: by 2002:a24:9d90:: with SMTP id f138-v6mr3113705itd.57.1539116306925;
 Tue, 09 Oct 2018 13:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAO49afLqUGuBi_R7BKyojqnkHrMGqXquy-FdVFscOu6Ez0cVFw@mail.gmail.com>
 <20181009164743.GA22886@krava> <CAO49af+zxxVh9HGfjKxS=vQcD5po7-oLU87Zp0F21M-C64nWUA@mail.gmail.com>
In-Reply-To: <CAO49af+zxxVh9HGfjKxS=vQcD5po7-oLU87Zp0F21M-C64nWUA@mail.gmail.com>
From:   Anthony LaTorre <tlatorre9@gmail.com>
Date:   Tue, 9 Oct 2018 15:18:12 -0500
Message-ID: <CAO49afJVHsywYdosSqceQiMzFdaYivm4kiNnC_+WKq15jsA7Dg@mail.gmail.com>
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

Ok, I can reliably reproduce it by profiling the following program:

#include <math.h>

int main(int argc, char **argv)
{
    int i;
    double sum;

    while (1) {
        sum += exp(++i);
    }

    return 0;
}

compiled with:

$ cc -o test test.c -lm

with the following command:

$ perf record -F 99 -p 20016 --call-graph dwarf sleep 10

Tony
On Tue, Oct 9, 2018 at 1:54 PM Anthony LaTorre <tlatorre9@gmail.com> wrote:
>
> Can you reproduce the segfault from the perf.data file I provided?
>
> Tony
> On Tue, Oct 9, 2018 at 11:47 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Oct 09, 2018 at 11:27:04AM -0500, Anthony LaTorre wrote:
> > > Hi,
> > >
> > > I'm currently running Linux kernel 4.18.10-100.fc27.x86_64 and have a
> > > problem profiling a program that used to work. Currently when I
> > > profile the program with the following command:
> > >
> > > $ perf record -F 99 -p PID --call-graph dwarf sleep 10
> > >
> > > it produces a data file which causes perf report to segfault:
> > >
> > > $ perf report
> > > perf: Segmentation fault
> > > -------- backtrace --------
> > > perf(+0x325302)[0x55860ae79302]
> > > /lib64/libc.so.6(+0x347d0)[0x7fbc8f3987d0]
> > > perf(+0x273e80)[0x55860adc7e80]
> > > perf(unwind__get_entries+0x1d9)[0x55860ae4ace9]
> > > perf(thread__resolve_callchain+0xfd)[0x55860adce7dd]
> > > perf(sample__resolve_callchain+0x58)[0x55860adc45b8]
> > > perf(hist_entry_iter__add+0x98)[0x55860adfa908]
> > > perf(+0x1ab8d9)[0x55860acff8d9]
> > > perf(+0x280603)[0x55860add4603]
> > > perf(+0x283c63)[0x55860add7c63]
> > > perf(+0x280e04)[0x55860add4e04]
> > > perf(perf_session__process_events+0x8ae)[0x55860add6bee]
> > > perf(cmd_report+0x190f)[0x55860ad01a4f]
> > > perf(+0x21a961)[0x55860ad6e961]
> > > perf(+0x21ac6e)[0x55860ad6ec6e]
> > > perf(main+0x361)[0x55860ace8411]
> > > /lib64/libc.so.6(__libc_start_main+0xea)[0x7fbc8f384fea]
> > > perf(_start+0x2a)[0x55860ace889a]
> > >
> > > I've attached the data file which is causing the issue.
> > >
> > > The perf version is:
> > >
> > > $ perf --version
> > > perf version 4.18.10
> > >
> > > and I'm running Fedora 27 if that makes a difference.
> > >
> > > I've tried to reproduce with simpler programs so I could send a
> > > minimal working example, but it doesn't appear to cause the issue.
> >
> > please do, I can't reproduce this
> >
> > thanks,
> > jirka
