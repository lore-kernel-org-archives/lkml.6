Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3925042-1518005315-2-14339848877632446110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518005314; b=jiqAS08hbMU0Bp//VUrhduQJRFdxxJb0FBasnu3GolESFuD
    5wXSuYyvxM/k8mqbTXnDDnF2zhKsPU9BrXjL49GlaPNBvgdzNZTqTzOM81MHmBMO
    O7LT24FBKgMEIROCYZpKEb/qgnqxSMDevKSd3zbkc5qojCxP618nVgi83aZQz78T
    fllXWGl5HILmo80pgBzHRa0ZSU+3uFr4OTc7VcTGfVN0h1BStTYMY1F7lY7ME4Ac
    0ydbR/sHkns44jvN7OUPvsyTxx7kwpQCrMhLUvQPLw12fGkGyWJHyRT4xguA5fjb
    GWm4J8LowkZY8+E/WC62QRYRorgslbDaq8J6kZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518005314; bh=eCln+2FgF6UmW20MXYwd7PCiiv
    IjXFPpB6eu28UA/QY=; b=xCUAs/zOoy/AfjxzbAygcgckGt7NmbPJIVeViW3WDO
    sckLZ2E2i9vmqM3bxpWI/gydLG32MqqD9+mhw0WzQZ/BYk9rSA1WkHnHUxmmE1Gg
    kVvyGDSKyeOsdJaZag8Ac6P+0FO8T8oQ8zH3GgzrV+2RSW40xayelU10Lz5Q9Hz7
    ALqx0UsRahPYmh+Xq/5VUDs6qzQfUOqTFPoDgXnrucKYG+AS4hxQBThfk2bGyqgH
    mobeVz5bS6v1D3VRv2A9+CXMe4ylMa2/FMWx7h8+1kOuMxaSbzKA4YhF9HET7OQE
    dbVHp9MNoc6xOmwP+rPL3B++jq0B/vKOzCr1hpD9Ra9Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbeBGMId (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 07:08:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753535AbeBGMIc (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Feb 2018 07:08:32 -0500
Date: Wed, 7 Feb 2018 20:08:27 +0800
From: Baoquan He <bhe@redhat.com>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Mike Galbraith <efault@gmx.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>, linux-mm@kvack.org,
        Vivek Goyal <vgoyal@redhat.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: Re: [PATCH 4.14 023/159] mm/sparsemem: Allocate mem_section at
 runtime for CONFIG_SPARSEMEM_EXTREME=y
Message-ID: <20180207120827.GB30270@localhost.localdomain>
References: <20171222084625.007160464@linuxfoundation.org>
 <1515302062.6507.18.camel@gmx.de>
 <20180108160444.2ol4fvgqbxnjmlpg@gmail.com>
 <20180108174653.7muglyihpngxp5tl@black.fi.intel.com>
 <20180109001303.dy73bpixsaegn4ol@node.shutemov.name>
 <1515469448.6766.12.camel@gmx.de>
 <d71ba136-71ba-333a-f99b-b8283e2dc545@cn.fujitsu.com>
 <20180207104111.sljc62bgkggmtio4@node.shutemov.name>
 <1518000336.29698.1.camel@gmx.de>
 <cd7e23ce-60a3-08ad-eb5d-21bb91df5937@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd7e23ce-60a3-08ad-eb5d-21bb91df5937@cn.fujitsu.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/07/18 at 08:00pm, Dou Liyang wrote:
> Hi Kirill,Mike
> 
> At 02/07/2018 06:45 PM, Mike Galbraith wrote:
> > On Wed, 2018-02-07 at 13:41 +0300, Kirill A. Shutemov wrote:
> > > On Wed, Feb 07, 2018 at 05:25:05PM +0800, Dou Liyang wrote:
> > > > Hi All,
> > > > 
> > > > I met the makedumpfile failed in the upstream kernel which contained
> > > > this patch. Did I missed something else?
> > > 
> > > None I'm aware of.
> > > 
> > > Is there a reason to suspect that the issue is related to the bug this patch
> > > fixed?
> > 
> 
> I did a contrastive test by my colleagues Indoh's suggestion.
> 
> Revert your two commits:
> 
> commit 83e3c48729d9ebb7af5a31a504f3fd6aff0348c4
> Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Date:   Fri Sep 29 17:08:16 2017 +0300
> 
> commit 629a359bdb0e0652a8227b4ff3125431995fec6e
> Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Date:   Tue Nov 7 11:33:37 2017 +0300
> 
> ...and keep others unchanged, the makedumpfile works well.
> 
> > Still works fine for me with .today.  Box is only 16GB desktop box though.
> > 
> Btw, In the upstream kernel which contained this patch, I did two tests:
> 
>  1) use the makedumpfile as core_collector in /etc/kdump.conf, then
> trigger the process of kdump by echo 1 >/proc/sysrq-trigger, the
> makedumpfile works well and I can get the vmcore file.
> 
>      ......It is OK
> 
>  2) use cp as core_collector, do the same operation to get the vmcore file.
> then use makedumpfile to do like above:
> 
>     [douly@localhost code]$ ./makedumpfile -d 31 --message-level 31 -x
> vmlinux_4.15+ vmcore_4.15+_from_cp_command vmcore_4.15+

Oh, then please ignore my previous comment. Adding '-D' can give more
debugging message.

> 
>     ......It causes makedumpfile failed.
> 
> 
> Thanks,
> 	dou.
> 
> > 	-Mike
> > 
> > 
> > 
> 
> 
