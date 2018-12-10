Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A97C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9370A2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJUlaOMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9370A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbeLJUss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:48:48 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42630 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJUsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:48:47 -0500
Received: by mail-ot1-f68.google.com with SMTP id v23so11806581otk.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 12:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPc87t3VAq9HeDqQFIyYmKoC+eBpfSY1KnbMliRPxUc=;
        b=LJUlaOMthNwgyRFQ3YXrW0DfyuoUQ6Z5c6TJBjWF3oJGio/ZIXs8G1U3ehUNcSoYMI
         TwsgJeW/74KXgUyYO//HJRkQ2bgH2df+E2CyoCTJR0S97k8ZE6lUApXBiXXP0tBd08fm
         kU4FISgFljCPislmFGJXbkAEr/2kBl6FBuJ26kKEaPDw/yn1KGN9MCOlGvkagF0kWGZH
         XpV0fsA6n5gaHYO+lZHYBs4z9MTL7fkxcNHw91XG4yLnqvBx3T92KsiJsOxA4h9E8DbB
         ezIRgbBi/NL9CKwOXqG5jtxbGSViv+tqy6VilPGrMRvN4yF1cOfvVstB+mtig4JtO0gw
         +gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPc87t3VAq9HeDqQFIyYmKoC+eBpfSY1KnbMliRPxUc=;
        b=U26Zs71U7U6nbwkT6hg/gX8+dBN4TSCIbYG1+tCeMrhT80udDqhm/okPRErAeWXw7M
         f964z8I1/0uKFQ1i7KtkOv15ealgxdmLKxoEJzzspG4Qwnlx3K2jDq+FccBj4tOL0VVK
         ZRaBH6KZ5aPH9OUixDikDBAsFKmWHmc+Zw3pnnVaLJ/rCLFw9SaR68pwjvswicukYCOr
         Ii08QQc1reE9zxh8W35IwYCH0t4TtYiEO6BwwgNpSRbZ2Y06/oO0PV7KRb42kpHhlv/l
         mJcexXbWV9mV+hM33nslSE4ebPWJyF0K7g9YxtlO3HtoUEXk+CeiHMZqaM70nhqU9+rZ
         zE8A==
X-Gm-Message-State: AA+aEWY7LK6eECKUVb1GEk2uVqVgMqzdB/FK/cn3RHxdvVxo3kEwc0+B
        /4UpJpGxO9PMx9KziNR7ynpylhCNvNZw0DFI8DP//NeC
X-Google-Smtp-Source: AFSGD/Vo16M2jBUU/VJotaDnyAqtNMwCm54MuXbPbCEVpLZY9cpVChUcx9Y00mYA03M4WlZAqI4BYlBXv7HoaMDJMO0=
X-Received: by 2002:a9d:dc3:: with SMTP id 61mr9457508ots.345.1544474927093;
 Mon, 10 Dec 2018 12:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20181206152635.1869-1-david.abdurachmanov@gmail.com> <mhng-49f84968-18a7-4acb-b41a-f056d1ee7034@palmer-si-x1c4>
In-Reply-To: <mhng-49f84968-18a7-4acb-b41a-f056d1ee7034@palmer-si-x1c4>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Mon, 10 Dec 2018 21:48:36 +0100
Message-ID: <CAEn-LTqP70BXjVGosw1KFTP1gSaTdji3174Hc3skZA2chdJXgA@mail.gmail.com>
Subject: Re: [PATCH 0/2] riscv: enable syscalls tracepoints
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 9:32 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Thu, 06 Dec 2018 07:26:33 PST (-0800), david.abdurachmanov@gmail.com wrote:
> > Depends on audit patch:
> > http://lists.infradead.org/pipermail/linux-riscv/2018-October/001931.html
> >
> > audit patch is already merged into linux-next.
> >
> > This simply fixes compilation error in do_syscall_trace_exit() and
> > enables syscalls tracepoints.
> >
> > David Abdurachmanov (2):
> >   riscv: fix trace_sys_exit hook
> >   riscv: add HAVE_SYSCALL_TRACEPOINTS to Kconfig
> >
> >  arch/riscv/Kconfig         | 1 +
> >  arch/riscv/kernel/ptrace.c | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
>
> I've attempted to add this on top of next-audit, which I've merged into
> for-next.  Let me know if something went wrong.

Two things:
- The order of commits are wrong. Right now the commits are in
  reverse order, i.e. audit patches are on top.
- Intel kbuild test bot found compilation errors with riscv-allmodconfig
  config. I fixed those and posted two patches:
  http://lists.infradead.org/pipermail/linux-riscv/2018-December/002508.html
