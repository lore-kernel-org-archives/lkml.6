Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754619AbeBGPTM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:19:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:57541 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754091AbeBGPTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:19:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="172445703"
Date: Wed, 7 Feb 2018 07:18:54 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Ingo Molnar <mingo@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH tip-pti 2/2] x86/entry: interleave XOR register clearing
 with PUSH/MOV instructions
Message-ID: <20180207151854.GB10945@tassilo.jf.intel.com>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206091727.GB15925@isilmar-4.linta.de>
 <20180206105139.nwlg3fwdxyhhrtc4@gmail.com>
 <20180206213202.GB2026@light.dominikbrodowski.net>
 <CA+55aFyXfMhUNoU9WveiMyKq32LftUGzF-BAP7hxEQOfwBTJrA@mail.gmail.com>
 <20180206235402.GN30338@tassilo.jf.intel.com>
 <CA+55aFzRMn6+tFFkAbMT_iDcMphDZFU9+OALEn+ecqa7=RqvUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzRMn6+tFFkAbMT_iDcMphDZFU9+OALEn+ecqa7=RqvUA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Plus the fastpath couldn't clear those registers anyway, since it
> didn't even _save_ them - exactly because the whole point of the
> fastpath was that not all registers are clobbered by the calling
> conventions.

Fast path saves more than just register saving.  I changed the fast path
to save all registers in my earlier clearregs branches

https://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git/log/?h=spec/clearregs-3

It is still quite a bit faster than all the slow stuff the C do_syscall
code does (e.g. reloading all the arguments, setting up unnecessary
frame pointers etc.).

Just take a look at the disassembly of that function. It's really
not very optimized.

-Andi
