Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbeCaSTv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 14:19:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:26743 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753017AbeCaSTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 14:19:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,387,1517904000";
   d="scan'208";a="38394138"
Subject: Re: [PATCH 00/11] Use global pages with PTI
To: Ingo Molnar <mingo@kernel.org>
References: <alpine.DEB.2.21.1803271526260.1964@nanos.tec.linutronix.de>
 <c0e7ca0b-dcb5-66e2-9df6-f53e4eb22781@linux.intel.com>
 <alpine.DEB.2.21.1803271949250.1618@nanos.tec.linutronix.de>
 <20180327200719.lvdomez6hszpmo4s@gmail.com>
 <0d6ea030-ec3b-d649-bad7-89ff54094e25@linux.intel.com>
 <20180330120920.btobga44wqytlkoe@gmail.com>
 <20180330121725.zcklh36ulg7crydw@gmail.com>
 <3cdc23a2-99eb-6f93-6934-f7757fa30a3e@linux.intel.com>
 <alpine.DEB.2.21.1803302230560.1479@nanos.tec.linutronix.de>
 <62a0dbae-75eb-6737-6029-4aaf72ebd199@linux.intel.com>
 <20180331053956.uts5yhxfy7ud4bpf@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>, namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <2607b1b1-89a7-635c-0c5d-da9f558241f4@linux.intel.com>
Date: Sat, 31 Mar 2018 11:19:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180331053956.uts5yhxfy7ud4bpf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30/2018 10:39 PM, Ingo Molnar wrote:
> There were a couple of valid review comments which need to be addressed as well, 
> but other than that it all looks good to me and I plan to apply the next 
> iteration.

Testing on that non-PCID systems showed an oddity with parts of the
kernel image that are modified later in boot (when we set the kernel
image read-only).  We split a few of the PMD entries and the the old
(early boot) values were being used for userspace.

I don't think this is a big deal.  The most annoying thing is that it
makes it harder to quickly validate that all of the things we set to
global *should* be global.  I'll put some examples of how this looks in
the patch when I repost.
