Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeEGVlb convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:41:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51653 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753102AbeEGVla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:41:30 -0400
Date: Mon, 07 May 2018 14:41:14 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180507213755.GA32406@avx2>
References: <20180507213755.GA32406@avx2>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] x86: pad assembly functions with INT3
To: Alexey Dobriyan <adobriyan@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com
CC: linux-kernel@vger.kernel.org, x86@kernel.org
From: hpa@zytor.com
Message-ID: <EF6BC538-EED3-4718-8AD2-DA2F60B580B1@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 7, 2018 2:37:55 PM PDT, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>Use INT3 instead of NOP. All that padding between functions is
>an illegal area, no legitimate code should jump into it.
>
>I've checked x86_64 allyesconfig disassembly, all changes looks sane:
>INT3 is only used after RET or unconditional JMP.
>
>Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>---
>
> arch/x86/include/asm/linkage.h |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>--- a/arch/x86/include/asm/linkage.h
>+++ b/arch/x86/include/asm/linkage.h
>@@ -18,7 +18,7 @@
> 	name:
> 
> #if defined(CONFIG_X86_64) || defined(CONFIG_X86_ALIGNMENT_16)
>-#define __ALIGN		.p2align 4, 0x90
>+#define __ALIGN		.p2align 4, 0xCC
> #define __ALIGN_STR	__stringify(__ALIGN)
> #endif
> 

Acked-by: H. Peter Anvin <h.peter.anvin@in tel.com>
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
