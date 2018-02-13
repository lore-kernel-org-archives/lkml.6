Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935277AbeBMNVC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:21:02 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50535 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935174AbeBMNVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:21:01 -0500
Date: Tue, 13 Feb 2018 14:21:03 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Pavel Machek <pavel@ucw.cz>
cc: Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] x86/cpu, x86/pti: Do not enable PTI on AMD processors
In-Reply-To: <20180212152630.GD13962@amd>
Message-ID: <alpine.DEB.2.21.1802131304440.1130@nanos.tec.linutronix.de>
References: <20171227054354.20369.94587.stgit@tlendack-t1.amdoffice.net> <20180212152630.GD13962@amd>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018, Pavel Machek wrote:

> On Tue 2017-12-26 23:43:54, Tom Lendacky wrote:
> > AMD processors are not subject to the types of attacks that the kernel
> > page table isolation feature protects against.  The AMD microarchitecture
> > does not allow memory references, including speculative references, that
> > access higher privileged data when running in a lesser privileged mode
> > when that access would result in a page fault.
> > 
> > Disable page table isolation by default on AMD processors by not setting
> > the X86_BUG_CPU_INSECURE feature, which controls whether X86_FEATURE_PTI
> > is set.
> 
> PTI was originally meant to protect KASLR from memory leaks, before
> Spectre was public. I guess that's still valid use on AMD cpus?

The KASLR attacks against which PTI protects are not based on a memory
leak. The KASLR attacks are revealing the kernel virtual address space w/o
revealing any data.

Quite some of those attacks can be mitigated via PTI, but only some of the
attacks work on AMD CPUs. The bulk (and easy to conduct) attacks do not
work work on AMD CPUs due to the same reason why Meltdown does not work.

Thanks,

	tglx
