Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967796AbeE2WqC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:46:02 -0400
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:42832 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935806AbeE2WqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:46:01 -0400
Date: Tue, 29 May 2018 22:46:00 +0000
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Thomas Garnier <thgarnie@google.com>
cc: kernel-hardening@lists.openwall.com,
        Skip Dave Hansen <dave.hansen@linux.intel.com>,
        Skip Vitaly Kuznetsov <vkuznets@redhat.com>,
        Skip Tom Lendacky <thomas.lendacky@amd.com>,
        Skip Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Skip Frederic Weisbecker <frederic@kernel.org>,
        Skip Nicholas Piggin <npiggin@gmail.com>,
        Skip Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Tejun Heo <tj@kernel.org>, Dennis Zhou <dennisszhou@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Borislav Petkov <bp@suse.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 14/27] x86/percpu: Adapt percpu for PIE support
In-Reply-To: <20180529221625.33541-15-thgarnie@google.com>
Message-ID: <01000163ae145cac-5ac07b51-8f08-4da5-bb93-0238d59756d3-000000@email.amazonses.com>
References: <20180529221625.33541-1-thgarnie@google.com> <20180529221625.33541-15-thgarnie@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.05.29-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018, Thomas Garnier wrote:

> Perpcu uses a clever design where the .percu ELF section has a virtual
> address of zero and the relocation code avoid relocating specific
> symbols. It makes the code simple and easily adaptable with or without
> SMP support.
>
> This design is incompatible with PIE because generated code always try to
> access the zero virtual address relative to the default mapping address.

We always access relative to the "segment register".

You can already change the segment register to relocate the per cpu
sections arbitrarily since all per cpu "addresses" are offsets relative to
the segment register. I am not sure what exactly you are trying to
accomplish here?

Maybe you need to explain it better?
