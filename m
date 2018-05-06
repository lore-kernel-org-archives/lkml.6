Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3711471-1525635226-3-14950207260839528995
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525635226; b=DzLM096RPZk3M8ywg0dRPiWE/WZKD76d/PJdFKihHSXFaK6LtM
    Ek8ec7TrIfsx2mWVN9JvZbf+0NkMLUiD6Gfws8MR9pKPICEYpU+qGkmm1MBvJxgj
    yfr/Yrxqx2e5jSLfd6PvzBzIiTJ/R51EMn5ZI9D4l8XrhKpTRaU7CIOeJ0T3wh/a
    ze949rHR6VaPBMB+WyOqjhWkSTw4QP/W50FN/GlxzoQgQRN101vdCxVj3XyrYHDl
    1ev/U4CjAqZXYhUpO5zp/TLh8UR4frsBrZY8QXC1hAD4o2LY2fHu34sk/VCjfeVr
    YnVGlLHb2sPkk8TPFm0Rd7Eoxkqw+KbuyrhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525635226; bh=omRzlOpKABUbZoIFWBOWZAHJwXr5O5qBQ/hIKYF+bK
    8=; b=cU3CwGjoMT2WawrNumzcVl2nLCj+8OrwgpX8yPW356zfW2oTcjBPbVGP+I
    fzuG4z12WD22jmX0fFvGfDdAEypeu+4Tjgit9Zis5vBiYEWrUAEeiIr1Hj9EYI/A
    KH13wnEUItcsf/PiLesl4osbbiRPVNjv+FuVyb4j59+G6NfCF1OMsnY9nOaDHNKT
    Y2A4ASYRE1p+VfCe5yGX3u07i/VpG1gLZXkKKEk7l25bvWqNvT5c2P2iLbnI+W3R
    Qeyv9clGtBAsI5mKT06NvGcW/bj2sCg7TlTSHurGo83tCy3zg9CZw9rYYc7eIklJ
    fzMf7jCwWkVh3bScNRRg9rEbHLrw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=Tq3UYLvk x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=oJwGU1IY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=Tq3UYLvk x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=oJwGU1IY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE/JMK2WeWWvD3ikm6+syPgkXZXtmDJ3My28uwcnONUkvMUPWY6WW4WfyrJzsUIFIq67d26tJJp73mq5SgNhtt/22tqKaSCt5/LA7OztOe97+T7/jzru
    YlTzyq2j/iQZvXW0AkLqkYoFhV4+CyfUPSTLCP+sZNTdfRtPdcbEmsStfL7LuK8Z9+CSerQs1N2VrtZSVQY8zcit9Owh+oYfjVj1AIU5PJ+ymdiSyshicqCM
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=wi13LW8sokUA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=rWkr9Ua9AAAA:8
    a=tOO0nKmCAAAA:8 a=pGLkceISAAAA:8 a=9CkB29Aspn8U76tXNjYA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Qv-QrLrHZjTXZfLJ-zom:22 a=Gz67Kf0DkuxJ4rqyVRET:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeEFTdn (ORCPT <rfc822;linux@kroah.com>);
        Sun, 6 May 2018 15:33:43 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42538 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeEFTdm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 May 2018 15:33:42 -0400
X-Google-Smtp-Source: AB8JxZp0jfM3XerOGam55w40DnFCOBBQMPF51rK7N9T4PvjQ8dttenMVmQKjxvHgfdFpveU6RVXxrLSkJF+fKEF/FpI=
MIME-Version: 1.0
In-Reply-To: <a20761a842efe590da08e835ecc5690a4cf50213.1523959603.git-series.jhogan@kernel.org>
References: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
 <a20761a842efe590da08e835ecc5690a4cf50213.1523959603.git-series.jhogan@kernel.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 6 May 2018 12:33:21 -0700
Message-ID: <CAEdQ38HfabRWgfLTStuZDOz0yjnfMNRc5beRdVcQhFfMi1SFKg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] alpha: Use OPTIMIZE_INLINING instead of asm/compiler.h
To: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 3:11 AM, James Hogan <jhogan@kernel.org> wrote:
> Use CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING and CONFIG_OPTIMIZE_INLINING
> instead of undefining the inline macros in the alpha specific
> asm/compiler.h. This is to allow asm/compiler.h to become a general
> header that can be used for overriding linux/compiler*.h.
>
> A build of alpha's defconfig on GCC 7.3 before and after this series
> (i.e. this commit and "compiler.h: Allow arch-specific overrides" which
> includes asm/compiler.h from linux/compiler_types.h) results in the
> following size differences, which appear harmless to me:
>
> $ ./scripts/bloat-o-meter vmlinux.1 vmlinux.2
> add/remove: 1/1 grow/shrink: 3/0 up/down: 264/-348 (-84)
> Function                                     old     new   delta
> cap_bprm_set_creds                          1496    1664    +168
> cap_issubset                                   -      68     +68
> flex_array_put                               328     344     +16
> cap_capset                                   488     500     +12
> nonroot_raised_pE.constprop                  348       -    -348
> Total: Before=5823709, After=5823625, chg -0.00%
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org

Looks fine to me.

Acked-by: Matt Turner <mattst88@gmail.com>

Should I take it through the alpha tree?
