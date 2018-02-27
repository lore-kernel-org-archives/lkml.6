Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeB0J2h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:28:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43336 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbeB0J2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:28:34 -0500
Date: Tue, 27 Feb 2018 10:28:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86/mm/sme: Disable stack protection for
 mem_encrypt_identity.c
Message-ID: <20180227092810.GA26097@pd.tnic>
References: <20180226232554.14108.16881.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180226232554.14108.16881.stgit@tlendack-t1.amdoffice.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 05:25:54PM -0600, Tom Lendacky wrote:
> Stack protection is not compatible with early boot code.  All of the early
> SME boot code is now isolated in a separate file, mem_encrypt_identity.c,
> so arch/x86/mm/Makefile can be updated to turn off stack protection for
> the entire file.  This eliminates the need to worry about other functions
> within the file being instrumented with stack protection (as was seen
> when a newer version of GCC instrumented sme_encrypt_kernel() where an
> older version hadn't).  It also allows removal of the __nostackprotector
> attribute from individual functions.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/mm/Makefile               |    1 +
>  arch/x86/mm/mem_encrypt_identity.c |    4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
