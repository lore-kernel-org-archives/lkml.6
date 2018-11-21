Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051F8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC3E20878
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I4QN5yp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC3E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732715AbeKVHM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:12:28 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37066 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730044AbeKVHM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:12:26 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so10853749iti.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PSWyxBOlwKkcl1ioDrFGqpS2m3Dvm6IkOsIEY++i27Q=;
        b=I4QN5yp0wqD6Q6V6wb4E+S+8SwBtTdRh7R1m2DLbih1+A0DJs1TlJZ3K3B33njdkij
         Y3To/sFL+9ZmLxLYDyvQ0pqlhOMKOPd+DNc/CFEEAS/lAH6+JzBY1Exwb/n1tq7fRWj7
         ABjQpDsxeu1ZCFqO1bUDY9jp2OKgsZQDYDF8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PSWyxBOlwKkcl1ioDrFGqpS2m3Dvm6IkOsIEY++i27Q=;
        b=fXUQRR+2Og63yT9xSmUu0H8n12AsJSp9HcgXzB8YH+THHXB8Y4HDnvh3zbSa+HQE3m
         Pb5nLB2Xmw+pvuxviKx6EI7dOcSP7Yt4ZWv8fG1yWaS3cCVoGPOC7OeW5Ui5nX18GPtQ
         jG0noHK9OFen+phcIL4wN7XUhDri0Hiubml48DgNZqjWrJ2epntHEnq0t6iMO7j/Qzk7
         IRBoguTd/D+y6VF65lPqo7fKFET9CwPk0Zv9MNg4oG5ztcQrFgoV2ZbR0wdH+OLdKC3G
         zkifqhqF89JHphoE6tQBJdd9CFP+PkCLmljMyP698juNflpUTH/MnV2xn6DQNw0IAQoE
         1mQg==
X-Gm-Message-State: AGRZ1gIylfi6Imc7lcaF1AKwMryUYTqhLkIgAU95K/mzx2TqugHRK+r6
        LtnqPVrDRySXy5f2b2XBNC0/KO7Jh61guZLCNYGh0w==
X-Google-Smtp-Source: AJdET5ftS7yQmDrTQDYLxNX3P/eaTKZgllp5AsBfM29MFdpBkxTp5EKYiJzEhO6rTXtdk9v6CfcfrY0zODF+0hFjbSE=
X-Received: by 2002:a02:8449:: with SMTP id l9-v6mr7111833jah.130.1542832592857;
 Wed, 21 Nov 2018 12:36:32 -0800 (PST)
MIME-Version: 1.0
References: <20181121131733.14910-1-ard.biesheuvel@linaro.org> <9d7f77959e1be0a9a3ff511a8fc45518068c85a6.camel@intel.com>
In-Reply-To: <9d7f77959e1be0a9a3ff511a8fc45518068c85a6.camel@intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 21 Nov 2018 21:36:22 +0100
Message-ID: <CAKv+Gu9jrYH_79b11nZgb5NOJrZrRNEz7Sy3OrgVHE+rRsYigg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] bpf: permit JIT allocations to be served outside
 the module region
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 at 20:48, Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Wed, 2018-11-21 at 14:17 +0100, Ard Biesheuvel wrote:
> > On arm64, modules are allocated from a 128 MB window which is close to
> > the core kernel, so that relative direct branches are guaranteed to be
> > in range (except in some KASLR configurations). Also, module_alloc()
> > is in charge of allocating KASAN shadow memory when running with KASAN
> > enabled.
> >
> > This means that the way BPF reuses module_alloc()/module_memfree() is
> > undesirable on arm64 (and potentially other architectures as well),
> > and so this series refactors BPF's use of those functions to permit
> > architectures to change this behavior.
> >
> Hi Ard,
>
> I am looking at adding optional BPF JIT in vmalloc functionality for x86 that
> would use this refactor. In fact I have done the same thing with just different
> names.
>
> My implementation intends to use the module space until a usage limit is reached
> and then overflow into vmalloc, so it would be an additional knob like
> "bpf_jit_limit". Wondering if that should be a cross-arch concept that connects
> to this. Does it fit in with what you are trying to do for arm64 here?
>

Hi Rick,

As I understand it, x86 requires the BPF allocations to be located
within 2 GB of the core kernel, so that RIP-relative 32-bit jumps are
in range (I read that in a comment somewhere, or a git commit log
perhaps)

That requirement does not exist on arm64: ordinary function calls and
tail calls emitted by the BPF JIT code have unlimited range, and so
there is simply no reason to prefer the module region for these
allocations. I guess we could achieve the same when reusing your
approach by setting the threshold to zero.
