Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966814AbeEJR6k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 13:58:40 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38469 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966718AbeEJR6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 13:58:38 -0400
X-Google-Smtp-Source: AB8JxZqz3SSkiWeaTStmfgx5LIPbwykHWjOwc4iaTA60JMSXguKXQJbj8GBs403WoQDXo+CK07HgRQ==
Date: Thu, 10 May 2018 10:58:35 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Yonghong Song <yhs@fb.com>,
        mingo@kernel.org, torvalds@linux-foundation.org, ast@fb.com,
        daniel@iogearbox.net, linux-kernel@vger.kernel.org, x86@kernel.org,
        netdev@vger.kernel.org, kernel-team@fb.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH bpf v3] x86/cpufeature: bpf hack for clang not supporting
 asm goto
Message-ID: <20180510175833.nujqinu26mydeape@ast-mbp.dhcp.thefacebook.com>
References: <20180504033119.2130788-1-yhs@fb.com>
 <20180510100634.GZ12217@hirez.programming.kicks-ass.net>
 <20180510155240.5s2fpgm2fwal3jlj@ast-mbp.dhcp.thefacebook.com>
 <20180510162028.GB16130@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510162028.GB16130@pd.tnic>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 06:20:28PM +0200, Borislav Petkov wrote:
> On Thu, May 10, 2018 at 08:52:42AM -0700, Alexei Starovoitov wrote:
> > That makes me wonder what happened with "we do not break user space" rule?
> 
> As someone already pointed out on IRC, arch/x86/include/asm/cpufeature.h
> is solely a kernel header so nothing but kernel should include it. So
> forget the userspace breakage "argument".

libbcc is a library. It's not only used by bcc scripts, but by production
services that compile bpf programs with clang.
Without this kernel fix the companies won't be able to upgrade the kernel.
Even if we could somehow hack libbcc and workaround in user space
(which is not possible as already explained), it's a long dependency chain
to recompile and upgrade core services before upgrading the kernel
which makes even theoretical user space fix impractical.
I see no option, but to fix the kernel.
Regardless whether it's called user space breakage or kernel breakage.
