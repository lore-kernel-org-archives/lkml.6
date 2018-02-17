Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeBQN2K (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 08:28:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45984 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbeBQN2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 08:28:09 -0500
Date: Sat, 17 Feb 2018 14:28:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] x86/CPU: Add a microcode loader callback
Message-ID: <20180217132800.GA10565@pd.tnic>
References: <20180216112640.11554-1-bp@alien8.de>
 <20180216112640.11554-3-bp@alien8.de>
 <20180217130753.GA25024@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180217130753.GA25024@araj-mobl1.jf.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 05:07:53AM -0800, Raj, Ashok wrote:
> Could you only list it there instead? common.c has no other
> microcode related functions other than this.?

I already explained that to you: this function is called by the loader
but it uses facilities which are closer to cpu/common.c - get_cpu_cap(),
etc.

Also, this file will be split eventually after the CPUID cleanup.

So it could just as well be called recheck_cpu_caps(), without the
"microcode" prefix.

So no need to do anything now.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
