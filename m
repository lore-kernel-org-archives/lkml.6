Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeEBSIF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:08:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:39818 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbeEBSIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:08:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,354,1520924400";
   d="scan'208";a="196194920"
Subject: Re: [tip:x86/urgent] x86/cpu: Restore CPUID_8000_0008_EBX reload
To: mingo@kernel.org, jrg.otte@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, linux-tip-commits@vger.kernel.org
References: <alpine.DEB.2.21.1805021043510.1668@nanos.tec.linutronix.de>
 <tip-c65732e4f72124ca5a3a0dd3bee0d3cee39c7170@git.kernel.org>
From: Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <868ee0c5-d10a-157a-18cb-ef9ea0f6b220@linux.intel.com>
Date: Wed, 2 May 2018 11:08:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <tip-c65732e4f72124ca5a3a0dd3bee0d3cee39c7170@git.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 07:48 AM, tip-bot for Thomas Gleixner wrote:
> Commit-ID:  c65732e4f72124ca5a3a0dd3bee0d3cee39c7170
> Gitweb:     https://git.kernel.org/tip/c65732e4f72124ca5a3a0dd3bee0d3cee39c7170
> Author:     Thomas Gleixner <tglx@linutronix.de>
> AuthorDate: Mon, 30 Apr 2018 21:47:46 +0200
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Wed, 2 May 2018 16:44:38 +0200
> 

snip

> 
> In hindsight this should have used completely synthetic bits for IBRB,

s/IBRB/IBPB

> IBRS, STIBP instead of reusing the AMD bits, but that's for 4.18.
> 
> /me needs to find time to cleanup that steaming pile of ...
> 
> Fixes: d94a155c59c9 ("x86/cpu: Prevent cpuinfo_x86::x86_phys_bits adjustment corruption")
> Reported-by: Jörg Otte <jrg.otte@gmail.com>
> Reported-by: Tim Chen <tim.c.chen@linux.intel.com>

Fix works for me too.  You can also add 
Tested-by: Tim Chen <tim.c.chen@linux.intel.com>

Thanks.

Tim

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Jörg Otte <jrg.otte@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: kirill.shutemov@linux.intel.com
> Cc: Borislav Petkov <bp@alien8.de
> Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1805021043510.1668@nanos.tec.linutronix.de
> ---
