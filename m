Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750987AbeFAXMI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 19:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750736AbeFAXMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 19:12:05 -0400
Date: Sat, 2 Jun 2018 08:12:01 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Josef Bacik <jbacik@fb.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] error-injection: Simplify arch specific helpers
Message-Id: <20180602081201.7fa34675839a53822b5d795f@kernel.org>
In-Reply-To: <1527761241.kc7z6i13ny.naveen@linux.ibm.com>
References: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
        <8f4883f08feaf6e040255015af2da7bbc7741e41.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
        <20180530174156.cb1799687fb834f26fe570a9@kernel.org>
        <1527761241.kc7z6i13ny.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018 15:39:03 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > On Tue, 29 May 2018 18:06:02 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> >> We already have an arch-independent way to set the instruction pointer
> >> with instruction_pointer_set(). Using this allows us to get rid of the
> >> need for override_function_with_return() that each architecture has to
> >> implement.
> >> 
> >> Furthermore, just_return_func() only has to encode arch-specific
> >> assembly instructions to return from a function. Introduce a macro
> >> ARCH_FUNC_RET to provide the arch-specific instruction and move over
> >> just_return_func() to generic code.
> >> 
> >> With these changes, architectures that already support kprobes, only
> >> just need to ensure they provide regs_set_return_value(), GET_IP() (for
> >> instruction_pointer_set()), and ARCH_FUNC_RET to support error
> >> injection.
> > 
> > Nice! the code basically good to me. Just one comment, ARCH_FUNC_RET sounds
> > like a function. Maybe ARCH_RETURN_INSTRUCTION will be better name, isn't it? :)
> 
> Sure -- I thought of writing ARCH_FUNCTION_RETURN, but felt that was too 
> verbose. How about ARCH_FUNC_RET_INST?

It is OK if we can recognize it is an instruction.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
