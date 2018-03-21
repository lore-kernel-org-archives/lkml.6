Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeCUOF0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:05:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:55459 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751856AbeCUOFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:05:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,340,1517904000";
   d="scan'208";a="213566803"
Subject: Re: [PATCH] x86/speculation: Fill the RSB on context switch also on
 non-IBPB CPUs
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
References: <9eb945bd-f77e-0301-d977-d1acf931b19d@maciej.szmigiero.name>
Cc: "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, thomas.lendacky@amd.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <f9e5bb98-a211-c220-8a70-6febbcba371d@intel.com>
Date: Wed, 21 Mar 2018 07:05:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9eb945bd-f77e-0301-d977-d1acf931b19d@maciej.szmigiero.name>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/2018 04:17 AM, Maciej S. Szmigiero wrote:
> If we run on a CPU that does not have IBPB support RSB entries from one
> userspace process can influence 'ret' target prediction in another
> userspace process after a context switch.
> 
> Since it is unlikely that existing RSB entries from the previous task match
> the new task call stack we can use the existing unconditional
> RSB-filling-on-context-switch infrastructure to protect against such
> userspace-to-userspace attacks.
> 
> This patch brings a change in behavior only for the following CPU types:
> * Intel pre-Skylake CPUs without updated microcode,

The assumption thus far (good or bad) is that everything will get a
microcode update.  I actually don't know for sure if RSB manipulation is
effective on old microcode before Skylake.  I'm pretty sure it has not
been documented publicly.

How did you decide that this is an effective mitigation?
