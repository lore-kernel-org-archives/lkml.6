Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbeBFJFB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:05:01 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:57482 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBFJE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:04:57 -0500
Date: Tue, 6 Feb 2018 10:04:55 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: tglx@linutronix.de, mingo@kernel.org, Andi Kleen <ak@linux.intel.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        luto@kernel.org
Subject: Re: [PATCH v3 2/3] x86/entry: Clear registers for 64bit
 exceptions/interrupts
Message-ID: <20180206090455.GA15925@isilmar-4.linta.de>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 05:18:11PM -0800, Dan Williams wrote:
> @@ -1178,6 +1180,7 @@ ENTRY(paranoid_entry)
>  	cld
>  	SAVE_C_REGS 8
>  	SAVE_EXTRA_REGS 8
> +	CLEAR_REGS_NOSPEC
>  	ENCODE_FRAME_POINTER 8
>  	movl	$1, %ebx
>  	movl	$MSR_GS_BASE, %ecx
> @@ -1185,7 +1188,6 @@ ENTRY(paranoid_entry)
>  	testl	%edx, %edx
>  	js	1f				/* negative -> in kernel */
>  	SWAPGS
> -	xorl	%ebx, %ebx

Here, %ebx will be filled with $1 (see code snipped above) *after* the
call to CLEAR_REGS_NOSPEC. That's what this line has been clearing in the
past. So I'm not sure whether this line should be removed.

Thanks,
	Dominik
