Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CDCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F0A26CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F0A26CB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbeFZPAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:00:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:38049 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751650AbeFZPAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:00:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 08:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="53034489"
Received: from 2b52.sc.intel.com ([143.183.136.147])
  by orsmga006.jf.intel.com with ESMTP; 26 Jun 2018 08:00:04 -0700
Message-ID: <1530024994.27091.0.camel@intel.com>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hjl.tools@gmail.com,
        vedvyas.shanbhogue@intel.com, ravi.v.shankar@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Date:   Tue, 26 Jun 2018 07:56:34 -0700
In-Reply-To: <CAG48ez2puLWrDDPg=ighCY+yxFoP-nN97MqVseqYabBad+eKmg@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <CAG48ez2puLWrDDPg=ighCY+yxFoP-nN97MqVseqYabBad+eKmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 04:46 +0200, Jann Horn wrote:
> On Tue, Jun 26, 2018 at 4:45 AM Yu-cheng Yu <yu-cheng.yu@intel.com>
> wrote:
> > 
> > 
> > This series introduces CET - Shadow stack
> > 
> > At the high level, shadow stack is:
> > 
> >         Allocated from a task's address space with vm_flags
> > VM_SHSTK;
> >         Its PTEs must be read-only and dirty;
> >         Fixed sized, but the default size can be changed by sys
> > admin.
> > 
> > For a forked child, the shadow stack is duplicated when the next
> > shadow stack access takes place.
> > 
> > For a pthread child, a new shadow stack is allocated.
> > 
> > The signal handler uses the same shadow stack as the main program.
> > 
> > Yu-cheng Yu (10):
> >   x86/cet: User-mode shadow stack support
> >   x86/cet: Introduce WRUSS instruction
> >   x86/cet: Signal handling for shadow stack
> >   x86/cet: Handle thread shadow stack
> >   x86/cet: ELF header parsing of Control Flow Enforcement
> >   x86/cet: Add arch_prctl functions for shadow stack
> >   mm: Prevent mprotect from changing shadow stack
> >   mm: Prevent mremap of shadow stack
> >   mm: Prevent madvise from changing shadow stack
> >   mm: Prevent munmap and remap_file_pages of shadow stack
> Shouldn't patches like these be CC'ed to linux-api@vger.kernel.org?

Yes, I will do that.

Thanks,
Yu-cheng
