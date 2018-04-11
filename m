Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756842AbeDKTre (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:47:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755829AbeDKTrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:47:33 -0400
Date: Wed, 11 Apr 2018 16:47:29 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Yonghong Song <yhs@fb.com>
Cc: Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        acme@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bpf: handling non BPF register names in inline assembly with
 -target bpf
Message-ID: <20180411194729.GD12166@redhat.com>
References: <c8b0b3c0-6687-1be2-66d0-95b20662145d@fb.com>
 <20180411183902.GC12166@redhat.com>
 <613f0a0d-c433-8f4d-dcc1-c9889deae39e@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <613f0a0d-c433-8f4d-dcc1-c9889deae39e@fb.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 11, 2018 at 12:22:37PM -0700, Yonghong Song escreveu:
> Look at test bpf-script-test-kbuild.c, I think you can drop
> uapi/asm/ptrace.h from include file list. This way, you do not need
> __BPF__ in x86/include/asm/asm.h. At the same time, you can
> remove __BPF__ as well.

That's even better, I'll try that approach, that code was done by
someone else, so I ended up not considering looking if removing a
unnecessary header would fix the issue, I'll check and if that works
I'll revert the patch that introduced that ifndef __BPF__.

- Arnaldo
