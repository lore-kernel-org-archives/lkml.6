Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753802AbeBVMP0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:15:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:42253 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753640AbeBVMPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:15:25 -0500
Date: Thu, 22 Feb 2018 13:15:06 +0100
From: Borislav Petkov <bp@suse.de>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: Re: [v2 1/3] x86/microcode/intel: Check microcode revision before
 updating sibling threads
Message-ID: <20180222121506.GC27489@pd.tnic>
References: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
 <1519281205-58951-2-git-send-email-ashok.raj@intel.com>
 <20180222110056.GA27489@pd.tnic>
 <20180222115554.GA3797@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180222115554.GA3797@araj-mobl1.jf.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 03:55:54AM -0800, Raj, Ashok wrote:
> The current code wasn't trying to enforce checking the loaded microcode revision on a thread
> before attempting to load the microcode. While you comeback from resume, if C0T0 already
> is up, and we loaded the early microcode, then when handling C0T1 there is no need to 
> do a wrmsrl to reapply microcode since its already loaded as part of C0T0. 

And I'm asking exactly this: is it simply "we don't need to do WRMSR" or
"we should not"?

Because avoiding the WRMSR costs more than simply doing it and letting
the HT thread ignore the supplied microcode.

If it is "we don't need to but there's nothing wrong when we do it" then
we don't need this patch. And I'm pretty sure "nothing wrong when we do
it" would be the answer. Otherwise we have bigger problems.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
