Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeCOJVt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:21:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52872 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeCOJVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:21:48 -0400
Date: Thu, 15 Mar 2018 10:21:40 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 3/3] x86/asm: Add support for WBNOINVD instruction
In-Reply-To: <20180119121821.77018-4-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1803151017120.1525@nanos.tec.linutronix.de>
References: <20180119121821.77018-1-kirill.shutemov@linux.intel.com> <20180119121821.77018-4-kirill.shutemov@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2018, Kirill A. Shutemov wrote:

> This patch implements infrastructure to call WBNOINVD instruction.

grep 'This patch' Documentation/process/

> The basic idea is to match what we have for WBINVD.

Is it just an idea or is it actually doing it?

> The instruction is defined as WBINVD with REP (0xf3) prefix. If the
> machine doesn't support the instruction the prefix will be ignored and
> we would fallback to WBINVD.

We fallback? We do nothing.

The CPU ignores the prefix and falls back to WBINVD, right?

> +
> +#define wbnoinvd_on_cpu(cpu)     wbnoinvd()
> +static inline int wbnoinvd_on_all_cpus(void)

Bah. Please stop glueing defines in front of the function body. That's just
makes it harder to read.

Thanks,

	tglx
