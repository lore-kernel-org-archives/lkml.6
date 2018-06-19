Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C1CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A072083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="sDt1aDtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A072083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeFSEI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:08:27 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:45193 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750718AbeFSEI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:08:26 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d6e5fd93
        for <linux-kernel@vger.kernel.org>;
        Tue, 19 Jun 2018 04:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=62IULhG24/vJtvRYDGsowsqVdbI=; b=sDt1aD
        tSA/AVB4clusYBH+WS1JLrBf5+H7FRcpVaPE0R1/jrHfyWBGc60v7xXfHx00T5eC
        HCpWSG7YpxxZC5xEcDf/mIbH5o96WwnfIf07FfkBExa5ya99GRax6yb3XFKI+J6J
        lxZwVKANt8Qi+8vn7qCyOdv4N0095y2VLKnXUF91go2HDUk9drthrm2PI80OIkuN
        2Szvlpiz7JhCS0AVLblU+yqj4XzNiQZkUNkpJaUHItlmpxkn0PmmKwpSRF9iBQKn
        HqfzVRIbuLV7Z8J0HdAe+9eEcQcEU/Yguhz6t7hFeLAJsxOUiOgqVOkCovF7AimW
        XXXT/t4KhAKdx+Tw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bbeb3508 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 19 Jun 2018 04:02:35 +0000 (UTC)
Received: by mail-oi0-f45.google.com with SMTP id e8-v6so16941915oii.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 21:08:25 -0700 (PDT)
X-Gm-Message-State: APt69E3n9QUUTiiCTyBCfQXVKWbWyAJMBROvL5+LLrc/6ck8W0wgJaAb
        0SqkP5FXp+W9zWSRjiqCaU28XeNBBUFwYv+04oY=
X-Google-Smtp-Source: ADUXVKI3f6KZojNmW/Ips6REO6yW71CHkIOkojWxGkxhHZOAjPRchpnKnQx+JfgQLH8juOT9ajpojQbSjX3zxqGgY6w=
X-Received: by 2002:aca:52cb:: with SMTP id g194-v6mr6495025oib.241.1529381303173;
 Mon, 18 Jun 2018 21:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com>
 <CALvZod6Dxx79ztxzHsDVe6pj7Fa7ydJAjMf_EHV9H15+AsVwdA@mail.gmail.com>
In-Reply-To: <CALvZod6Dxx79ztxzHsDVe6pj7Fa7ydJAjMf_EHV9H15+AsVwdA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 19 Jun 2018 06:08:11 +0200
X-Gmail-Original-Message-ID: <CAHmME9qvRDQOJYdSPaAf-hg5raacu4TBgStLy7NzFL+j+dXheQ@mail.gmail.com>
Message-ID: <CAHmME9qvRDQOJYdSPaAf-hg5raacu4TBgStLy7NzFL+j+dXheQ@mail.gmail.com>
Subject: Re: Possible regression in "slab, slub: skip unnecessary kasan_cache_shutdown()"
To:     Shakeel Butt <shakeelb@google.com>
Cc:     aryabinin@virtuozzo.com, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 5:59 AM Shakeel Butt <shakeelb@google.com> wrote:
> Hi Jason, yes please do send me the test suite with the kernel config.

$ git clone https://git.zx2c4.com/WireGuard
$ cd WireGuard/src
$ [[ $(gcc -v 2>&1) =~ gcc\ version\ 8\.1\.0 ]] || echo crash needs 8.1
$ export DEBUG_KERNEL=yes
$ export KERNEL_VERSION=4.18-rc1
$ make test-qemu -j$(nproc)

This will build a kernel and a minimal userland and load it in qemu,
which must be installed.

This code is what causes the crash:
The self test that's executed:
https://git.zx2c4.com/WireGuard/tree/src/selftest/ratelimiter.h
Which exercises this code:
https://git.zx2c4.com/WireGuard/tree/src/ratelimiter.c

The problem occurs after gc_entries(NULL) frees things (line 124 in
ratelimiter.h above), and then line 133 reallocates those objects.
Sometime after that happens, elsewhere in the kernel invokes this
kasan issue in the kasan cache cleanup.

I realize it's disappointing that the test case here is in WireGuard,
which isn't (yet!) upstream. That's why in my original message I
wrote:

> Rather, it looks like this
> commit introduces a performance optimization, rather than a
> correctness fix, so it seems that whatever test case is failing is
> likely an incorrect failure. Does that seem like an accurate
> possibility to you?

I was hoping to only point you toward my own code after establishing
the possibility that the bug is not my own. If you still think there's
a chance this is due to my own correctness issue, and your commit has
simply unearthed it, let me know and I'll happily keep debugging on my
own before pinging you further.

Regards,
Jason
