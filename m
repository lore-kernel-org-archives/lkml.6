Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbeBQNHz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 08:07:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:57021 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750960AbeBQNHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 08:07:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,524,1511856000";
   d="scan'208";a="30857134"
Date: Sat, 17 Feb 2018 05:07:53 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/3] x86/CPU: Add a microcode loader callback
Message-ID: <20180217130753.GA25024@araj-mobl1.jf.intel.com>
References: <20180216112640.11554-1-bp@alien8.de>
 <20180216112640.11554-3-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216112640.11554-3-bp@alien8.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

Sorry this is coming late... Thought i mentioned it earlier.

On Fri, Feb 16, 2018 at 12:26:39PM +0100, Borislav Petkov wrote:
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 23fdaf4ec925..856669b90a0c 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -977,4 +977,5 @@ bool xen_set_default_idle(void);
>  
>  void stop_this_cpu(void *dummy);
>  void df_debug(struct pt_regs *regs, long error_code);
> +void microcode_check(void);

microcode_check() is only called from microcode/core.c

Could you only list it there instead? common.c has no other
microcode related functions other than this.?

Cheers,
Ashok
