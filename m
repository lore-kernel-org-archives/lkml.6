Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753426AbeEPJww (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:52:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38128 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeEPJwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:52:49 -0400
Date: Wed, 16 May 2018 11:52:42 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] x86/boot/compressed/64: Set up GOT for paging_prepare()
 and cleanup_trampoline()
In-Reply-To: <20180516080131.27913-2-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1805161151490.1627@nanos.tec.linutronix.de>
References: <20180516080131.27913-1-kirill.shutemov@linux.intel.com> <20180516080131.27913-2-kirill.shutemov@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018, Kirill A. Shutemov wrote:

> Eric and Hugh have reported instant reboot due to my recent changes in
> decompression code.
> 
> The root cause is that I didn't realize that we need to adjust GOT to be
> able to run C code that early.
> 
> The problem is only visible with an older toolchain. Binutils >= 2.24 is
> able to eliminate GOT references by replacing them with RIP-relative
> address loads[1].
> 
> We need to adjust GOT two times:
>  - before calling paging_prepare() using the initial load address
>  - before calling C code from the relocated kernel
> 
> [1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commitdiff;h=80d873266dec
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 194a9749c73d ("x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G")
> Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
> Reported-by: Hugh Dickins <hughd@google.com>

Very nice and well done!

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
