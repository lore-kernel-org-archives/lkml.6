Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeB0PnY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:43:24 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51780 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753942AbeB0PnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:43:20 -0500
X-Google-Smtp-Source: AG47ELu2xmJhfd0kQeh9EYL+oa9DqUsuKDe9d74OJ2QOuyyl4QqF/auvsBCidOdTbvJCGsiSVIbu3A==
Date: Tue, 27 Feb 2018 18:43:09 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86/mm/sme: Disable stack protection for
 mem_encrypt_identity.c
Message-ID: <20180227154309.3gt2tylttsnt2en2@node.shutemov.name>
References: <20180226232554.14108.16881.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226232554.14108.16881.stgit@tlendack-t1.amdoffice.net>
User-Agent: NeoMutt/20171215
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

Looks good to me.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
