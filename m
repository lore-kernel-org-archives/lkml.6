Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932652AbeBVNpR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:45:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:48961 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932467AbeBVNpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:45:16 -0500
Date: Thu, 22 Feb 2018 14:44:58 +0100
From: Borislav Petkov <bp@suse.de>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: Re: [v2 1/3] x86/microcode/intel: Check microcode revision before
 updating sibling threads
Message-ID: <20180222134259.GD27489@pd.tnic>
References: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
 <1519281205-58951-2-git-send-email-ashok.raj@intel.com>
 <20180222110056.GA27489@pd.tnic>
 <20180222115554.GA3797@araj-mobl1.jf.intel.com>
 <20180222121506.GC27489@pd.tnic>
 <20180222131918.GB3797@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180222131918.GB3797@araj-mobl1.jf.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 05:19:18AM -0800, Raj, Ashok wrote:
> This isn't a simple WRMSR like others. Microcode engine needs to do 
> a bunch of validation.

So this is slowly starting to resemble a real reason why not to. That
should be part of the code comment.

> We now have new guidance that the sibling must be spinning and not
> doing other things that can introduce instability around loading
> microcode.

Why isn't *this* in the code comment?

> I think its safer...

That's not good enough - it should be:

"It is not safe because... <insert reasons here>".

So that you can justify the overhead.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
