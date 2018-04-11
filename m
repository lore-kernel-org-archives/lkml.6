Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeDKXRh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 19:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751734AbeDKXRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 19:17:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F4121722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 11 Apr 2018 20:17:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bpf: handling non BPF register names in inline assembly with
 -target bpf
Message-ID: <20180411231733.GB24386@kernel.org>
References: <c8b0b3c0-6687-1be2-66d0-95b20662145d@fb.com>
 <20180411183902.GC12166@redhat.com>
 <613f0a0d-c433-8f4d-dcc1-c9889deae39e@fb.com>
 <20180411194729.GD12166@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411194729.GD12166@redhat.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 11, 2018 at 04:47:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Apr 11, 2018 at 12:22:37PM -0700, Yonghong Song escreveu:
> > Look at test bpf-script-test-kbuild.c, I think you can drop
> > uapi/asm/ptrace.h from include file list. This way, you do not need
> > __BPF__ in x86/include/asm/asm.h. At the same time, you can
> > remove __BPF__ as well.
> 
> That's even better, I'll try that approach, that code was done by
> someone else, so I ended up not considering looking if removing a
> unnecessary header would fix the issue, I'll check and if that works
> I'll revert the patch that introduced that ifndef __BPF__.

So this is what I've pushed to my perf/core branch:

https://git.kernel.org/acme/c/707ba03243d2 (HEAD -> perf/core) Revert "x86/asm: Allow again using asm.h when building for the 'bpf' clang target"
https://git.kernel.org/acme/c/4364203f5563 pref tests bpf: Remove unused ptrace.h include from LLVM test

Thanks,

- Arnaldo
