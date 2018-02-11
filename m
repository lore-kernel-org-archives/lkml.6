Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753317AbeBKLqt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 06:46:49 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33035 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753065AbeBKLqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 06:46:47 -0500
X-Google-Smtp-Source: AH8x227T3OawUnF9/eZCHOfjMKkBSShlUM2SkLSX+masAEzkFrePzXDTa6oFldzUqiO1S4qi53+pNQ==
Date: Sun, 11 Feb 2018 12:46:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: tglx@linutronix.de, karahmed@amazon.de, sironi@amazon.de,
        x86@kernel.org, kvm@vger.kernel.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com
Subject: Re: [PATCH v2 6/6] x86/speculation: Use IBRS if available before
 calling into firmware
Message-ID: <20180211114643.mek3zydznbernsdr@gmail.com>
References: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
 <1518305967-31356-7-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518305967-31356-7-git-send-email-dwmw@amazon.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* David Woodhouse <dwmw@amazon.co.uk> wrote:

> Retpoline means the kernel is safe because it has no indirect branches.
> But firmware isn't, so use IBRS for firmware calls if it's available.

Ok, this approach looks good to me in principle, but:

> --- a/arch/x86/include/asm/apm.h
> +++ b/arch/x86/include/asm/apm.h
> @@ -7,6 +7,8 @@
>  #ifndef _ASM_X86_MACH_DEFAULT_APM_H
>  #define _ASM_X86_MACH_DEFAULT_APM_H
>  
> +#include <asm/spec_ctrl.h>

I cannot see this header file upstream anywhere, nor in any other patch in my mbox 
- is there some dependency that has to be applied first?

Thanks,

	Ingo
