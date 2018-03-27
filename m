Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753698AbeC0Qcf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:32:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:62350 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753639AbeC0Qc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:32:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,367,1517904000";
   d="scan'208";a="45736048"
Subject: Re: [PATCH 00/11] Use global pages with PTI
To: Thomas Gleixner <tglx@linutronix.de>
References: <20180323174447.55F35636@viggo.jf.intel.com>
 <CA+55aFwEC1O+6qRc35XwpcuLSgJ+0GP6ciqw_1Oc-msX=efLvQ@mail.gmail.com>
 <be2e683c-bf0a-e9ce-2f02-4905f6bd56d3@linux.intel.com>
 <alpine.DEB.2.21.1803271526260.1964@nanos.tec.linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>, namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <c0e7ca0b-dcb5-66e2-9df6-f53e4eb22781@linux.intel.com>
Date: Tue, 27 Mar 2018 09:32:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803271526260.1964@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 06:36 AM, Thomas Gleixner wrote:
>>                         User Time       Kernel Time     Clock Elapsed
>> Baseline ( 0 GLB PTEs)  803.79          67.77           237.30
>> w/series (28 GLB PTEs)  807.70 (+0.7%)  68.07 (+0.7%)   238.07 (+0.3%)
>>
>> Without PCIDs, it behaves the way I would expect.
> What's the performance benefit on !PCID systems? And I mean systems which
> actually do not have PCID, not a PCID system with 'nopcid' on the command
> line.

Do you have something in mind for this?  Basically *all* of the servers
that I have access to have PCID because they are newer than ~7 years old.

That leaves *some* Ivybridge and earlier desktops, Atoms and AMD
systems.  Atoms are going to be the easiest thing to get my hands on,
but I tend to shy away from them for performance work.
