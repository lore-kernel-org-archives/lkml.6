Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6582CC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 14:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C87208EB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 14:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TrL2V/Lt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C87208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeHZSBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 14:01:11 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:45681 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbeHZSBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 14:01:11 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 277309f0;
        Sun, 26 Aug 2018 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=5DWFA2ZhRLp6zw9sspG0okQGiBk=; b=TrL2V/
        Ltov1YVbUcmNP2fnQzHyUs/mgtx5AFPqMzYZtn7Q+Xz7kRdMjCqAFlnNSmyHm0fX
        BZVvgG6aFI/ZDhvZK6tPqJI7tsWUh2rO2SCL2Vd2HSakF5ab5qwMyDsAo+u2qIEj
        /EXbV1Q8FBYNYA0OtLwwXY9T2w8/LH0hmXhBjegqhW4GBB2PgkFfdHddCGNARyNA
        YfE+w5PKQQyFrsU9bystH0Km2CHRCJq/8FyjLOVu6esLSQa3zqROozXekkH58ghk
        iWXLk9oOG2RKT8+vO0JoGwaluY+aUoikOHwXFNhAQ/BqYdaNGP/FOD48wIv4AjqP
        c24Q+K4po2EFE8Aw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 114cadd1 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sun, 26 Aug 2018 14:03:50 +0000 (UTC)
Received: by mail-oi0-f45.google.com with SMTP id l202-v6so16091838oig.7;
        Sun, 26 Aug 2018 07:18:28 -0700 (PDT)
X-Gm-Message-State: APzg51Bbk1l7dAF3sPbn6BiBN9vwzT7/YUitxtMIflEufYHbLWDQUBhJ
        SU4KjV3m+kInIEOE//7EOo4XU8n5Lzy/9ML+3zs=
X-Google-Smtp-Source: ANB0VdbH0V1n0ZBRVX6vkRbuCXbVANEAzuidNlRtURzG2VFAxUq8+vXPystpP9wMNfJ1M2CO2wP8bCQk8W0GFw9wP6Y=
X-Received: by 2002:aca:e6d4:: with SMTP id d203-v6mr9295762oih.311.1535293107830;
 Sun, 26 Aug 2018 07:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com>
 <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de>
 <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com> <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 26 Aug 2018 08:18:15 -0600
X-Gmail-Original-Message-ID: <CAHmME9q+JcT9pnZ5jgowf15O4BkVF-2-QkHA2o1ZKbVe4nAg6g@mail.gmail.com>
Message-ID: <CAHmME9q+JcT9pnZ5jgowf15O4BkVF-2-QkHA2o1ZKbVe4nAg6g@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 8:06 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > Do you mean to say you intend to make kernel_fpu_end() and
> > kernel_neon_end() only actually do something upon context switch, but
> > not when it's actually called? So that multiple calls to
> > kernel_fpu_begin() and kernel_neon_begin() can be made without
> > penalty?
>
> On context switch and exit to user. That allows to keep those code pathes
> fully preemptible. Still twisting my brain around the details.

Just to make sure we're on the same page, the goal is so that this code:

kernel_fpu_begin();
kernel_fpu_end();
kernel_fpu_begin();
kernel_fpu_end();
kernel_fpu_begin();
kernel_fpu_end();
kernel_fpu_begin();
kernel_fpu_end();
kernel_fpu_begin();
kernel_fpu_end();
kernel_fpu_begin();
kernel_fpu_end();
...

has the same performance as this code:

kernel_fpu_begin();
kernel_fpu_end();

(Unless of course the process is preempted or the like.)

Currently the present situation makes the performance of the above
wildly different, since kernel_fpu_end() does something immediately.

What about something like this:
- Add a tristate flag connected to task_struct (or in the global fpu
struct in the case that this happens in irq and there isn't a valid
current).
- On kernel_fpu_begin(), if the flag is 0, do the usual expensive
XSAVE stuff, and set the flag to 1.
- On kernel_fpu_begin(), if the flag is non-0, just set the flag to 1
and return.
- On kernel_fpu_end(), if the flag is non-0, set the flag to 2.
(Otherwise WARN() or BUG() or something.)
- On context switch / preemption / etc away from the task, if the flag
is non-0, XRSTOR and such.
- On context switch / preemption / etc back to the task, if the flag
is 1, XSAVE and such. If the flag is 2, set it to 0.

Jason
