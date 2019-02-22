Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D5EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6028E20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsTCGuPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfBVIZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:25:45 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40395 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVIZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:25:44 -0500
Received: by mail-yb1-f194.google.com with SMTP id k2so537138ybk.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 00:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Juvo6YoafK7P9NBv3OsbnNSCijGL+nyK5BSklUU99wo=;
        b=zsTCGuPj/YYjFDZrJrd0kzmOkMzLVn+tD02CZ4Xq0ROvNkjS86YLq0nYXkPjrSWbrW
         r6/EUjIJ4Ci5AZHKC0+UoqJnRUeGmYYg8V3QsNmppbZiI3FdH5Gy17ak2wxtI72VOKJh
         810uMhhXb8I1DleqvpqkIidOMuLinvYXeg2w7wNyRFXAewZIYFLJ4I4aKuj/NB1tdcrn
         ByOQpmd+Yvw7TKj+q8AAQZhWgYNcdnSdeCH0eR9RvatGxAMjbfLQ3Z66Y8tsseNftoRW
         ona2P2HeZTDFqT4MteAHsnczj11/y5Cd4Z9Spe5WbzFUcyiocfCo/tilYCXuQpP7ATdm
         5OwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Juvo6YoafK7P9NBv3OsbnNSCijGL+nyK5BSklUU99wo=;
        b=HaY2jqoYQOAapBoXhCqyMDNKJdRT+glZNnwpG1N9qd5fpdjNjsK/VOgOK0OVYbxTxR
         IfWRvCGf3HECkItnXCKRX4aiGOoDqZbrxjt8huuUoLbHfVCEgmYvnKfplNrUX3Y354e2
         LIXIIK3CN8Y30NNAVvsiJJvbOF31Bu3O+oDDaqX0Kucg1jCEZ8mE8K8DrRPpadRLu+AP
         w1SOoarjlHsuwYezRq/9M+Gb0MN1aR1lFE8Uh3y9GDvywHVRxXPVcqNrBO9lZvnniyWE
         MzXx5xWGXAlx2WIo6PoODqNXOa3NiUjI11pB4Be9MeISE0N6Zlkdh3lIX80NcMg2JaZA
         0hFw==
X-Gm-Message-State: AHQUAubPZjqzLRSFjyQxar1PxXOTz2FJxMpnzXS9UiC7jWPuiVKGNa7C
        dEjbB4VITqbzBkd3tlFVHUFjV3YXKa7bEN5bAOYwHg==
X-Google-Smtp-Source: AHgI3IaVl4/sqU7sb9k1qScUeH5ISNUMhuGVbBdmiuQlTZ0gVEzWQE7l7VaEq6dXOeaK7QR/KBNaAyDn31B6m7Co2KQ=
X-Received: by 2002:a25:d94:: with SMTP id 142mr2319596ybn.256.1550823943784;
 Fri, 22 Feb 2019 00:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20190221084425.9574-1-anders.roxell@linaro.org> <c93b8a98-f76f-7c45-817a-0cd334273306@iogearbox.net>
In-Reply-To: <c93b8a98-f76f-7c45-817a-0cd334273306@iogearbox.net>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 22 Feb 2019 09:25:32 +0100
Message-ID: <CADYN=9Le_rHyMuPf04xk-pM1-xU2g_MUxER8Esu9-iSiz5O3_Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: test_bpf: turn of preemption in function __run_once
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 at 16:38, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 02/21/2019 09:44 AM, Anders Roxell wrote:
> > When running test seccomp_bpf the following splat occurs:
> >
> > [ RUN      ] global.secseccomp_bpf.c:2136:global.detect_seccomp_filter_flags:Expected 22 (22) == (*__errno_location ()) (14)
> > seccomp_bpf.c:2138:global.detect_seccomp_filter_flags:Failed to detect that an unknown
> >   filter flag (0x8) is unsupported! Does a new flag need to be added to this test?
> > [ 2155.677841] BUG: assuming atomic context at kernel/seccomp.c:271
> > [ 2155.689351] in_atomic(): 0, irqs_disabled(): 0, pid: 28540, name: seccomp_bpf
> > [ 2155.696597] INFO: lockdep is turned off.
> > [ 2155.700605] CPU: 5 PID: 28540 Comm: seccomp_bpf Tainted: G        W         5.0.0-rc7-next-20190220 #1
> > [ 2155.709972] Hardware name: HiKey Development Board (DT)
> > [ 2155.715232] Call trace:
> > [ 2155.717710]  dump_backtrace+0x0/0x160
> > [ 2155.721399]  show_stack+0x24/0x30
> > [ 2155.724742]  dump_stack+0xc8/0x114
> > [ 2155.728172]  __cant_sleep+0xf0/0x108
> > [ 2155.731777]  __seccomp_filter+0x8c/0x5c8
> > [ 2155.735727]  __secure_computing+0x4c/0xe8
> > [ 2155.739767]  syscall_trace_enter+0xf8/0x2b8
> > [ 2155.743982]  el0_svc_common+0xf0/0x130
> > [ 2155.747758]  el0_svc_handler+0x38/0x78
> > [ 2155.751534]  el0_svc+0x8/0xc
> >
> > Rework so that preemption is disabled when we loop over function
> > 'BPF_PROG_RUN(...)'.
> > Commit 568f196756ad ("bpf: check that BPF programs run with preemption disabled")
> > highlighted the issue.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
> Hmm, wrong commit description?

urgh, you are correct. I'm sorry.
Sending a v2 shortly.

> Below code is not related to seccomp
> but rather BPF test suite. Could you fix it up and resubmit? Rest
> looks okay to me.
>
> > ---
> >  lib/test_bpf.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> > index f3e570722a7e..0845f635f404 100644
> > --- a/lib/test_bpf.c
> > +++ b/lib/test_bpf.c
> > @@ -6668,12 +6668,14 @@ static int __run_one(const struct bpf_prog *fp, const void *data,
> >       u64 start, finish;
> >       int ret = 0, i;
> >
> > +     preempt_disable();
> >       start = ktime_get_ns();
> >
> >       for (i = 0; i < runs; i++)
> >               ret = BPF_PROG_RUN(fp, data);
> >
> >       finish = ktime_get_ns();
> > +     preempt_enable();
> >
> >       *duration = finish - start;
> >       do_div(*duration, runs);
> >
>
