Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754730AbeBNMKy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:10:54 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38130 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbeBNMKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:10:53 -0500
X-Google-Smtp-Source: AH8x22751mqItchJNOrBnZUiOSx5ME3/3CS0AWBQ93W5F6bpgLUd5lPLDLvDOQaMni2j9M6NCwLf0g==
Date: Wed, 14 Feb 2018 13:10:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] x86/mm: Adjust virtual address space layout in early
 boot
Message-ID: <20180214121049.z4cjsdwxaaq5gpv5@gmail.com>
References: <20180214111656.88514-1-kirill.shutemov@linux.intel.com>
 <20180214111656.88514-10-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214111656.88514-10-kirill.shutemov@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> We need to adjust virtual address space to support switching between
> paging modes.
> 
> The adjustment happens in __startup_64().
> 
> We also have to change KASLR code that doesn't expect variable
> VMALLOC_SIZE_TB.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/boot/compressed/kaslr.c        | 14 ++++++++--
>  arch/x86/include/asm/page_64_types.h    |  9 ++----
>  arch/x86/include/asm/pgtable_64_types.h | 25 +++++++++--------
>  arch/x86/kernel/head64.c                | 49 +++++++++++++++++++++++++++------
>  arch/x86/kernel/head_64.S               |  2 +-
>  arch/x86/mm/dump_pagetables.c           |  3 ++
>  arch/x86/mm/kaslr.c                     | 11 ++++----
>  7 files changed, 77 insertions(+), 36 deletions(-)

This is too large and risky - would it be possible to split this up into multiple, 
smaller patches?

Thanks,

	Ingo
