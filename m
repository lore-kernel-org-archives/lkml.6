Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbeC0UTn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 16:19:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:36761 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751008AbeC0UTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 16:19:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,368,1517904000";
   d="scan'208";a="45795143"
Subject: Re: [PATCH 00/11] Use global pages with PTI
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
References: <20180323174447.55F35636@viggo.jf.intel.com>
 <CA+55aFwEC1O+6qRc35XwpcuLSgJ+0GP6ciqw_1Oc-msX=efLvQ@mail.gmail.com>
 <be2e683c-bf0a-e9ce-2f02-4905f6bd56d3@linux.intel.com>
 <alpine.DEB.2.21.1803271526260.1964@nanos.tec.linutronix.de>
 <c0e7ca0b-dcb5-66e2-9df6-f53e4eb22781@linux.intel.com>
 <alpine.DEB.2.21.1803271949250.1618@nanos.tec.linutronix.de>
 <20180327200719.lvdomez6hszpmo4s@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>, namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <a3837d26-031f-6bce-cb1e-f34e5c0cfd2f@linux.intel.com>
Date: Tue, 27 Mar 2018 13:19:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327200719.lvdomez6hszpmo4s@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 01:07 PM, Ingo Molnar wrote:
>  - To see at minimum stddev numbers, to make sure we are not looking at some weird
>    statistical artifact. (I also outlined a more robust measurement method.)
> 
>  - If the numbers are right, a CPU engineer should have a look if possible, 
>    because frankly this effect is not expected and is not intuitive. Where global 
>    pages can be used safely they are almost always an unconditional win.
>    Maybe we are missing some limitation or some interaction with PCID.
> 
> Since we'll be using PCID even on Meltdown-fixed hardware, maybe the same negative 
> performance effect already exists on non-PTI kernels as well, we just never 
> noticed?

Yep, totally agree.  I'll do the more robust collection and also explore
on "real" !PCID hardware.  I also know the right CPU folks to go ask
about this, I just want to do the second round of robust data collection
before I bug them.
