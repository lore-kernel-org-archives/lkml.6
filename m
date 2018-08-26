Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DF7C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F23216E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F23216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeHZJrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 05:47:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51908 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeHZJrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 05:47:46 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B9D27707;
        Sun, 26 Aug 2018 06:06:15 +0000 (UTC)
Date:   Sun, 26 Aug 2018 08:06:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave@sr71.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: Re: [PATCH 4.4 037/107] x86/mm: Factor out LDT init from context init
Message-ID: <20180826060612.GA21746@kroah.com>
References: <20180723122413.003644357@linuxfoundation.org>
 <20180723122414.735940678@linuxfoundation.org>
 <1535154250.2902.63.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1535154250.2902.63.camel@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 12:44:10AM +0100, Ben Hutchings wrote:
> On Mon, 2018-07-23 at 14:41 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> > 
> > commit 39a0526fb3f7d93433d146304278477eb463f8af upstream
> [...]
> > --- a/arch/x86/include/asm/mmu_context.h
> > +++ b/arch/x86/include/asm/mmu_context.h
> [...]
> > +static inline int init_new_context(struct task_struct *tsk,
> > +				   struct mm_struct *mm)
> > +{
> > +	init_new_context_ldt(tsk, mm);
> > +	return 0;
> > +}
> [...]
> 
> This hides errors from init_new_context_ldt(), which is very bad.
> Fixed upstream by:
> 
> commit ccd5b3235180eef3cfec337df1c8554ab151b5cc
> Author: Eric Biggers <ebiggers@google.com>
> Date:   Thu Aug 24 10:50:29 2017 -0700
> 
>     x86/mm: Fix use-after-free of ldt_struct
> 
> Ben.

Good catch, now applied, thanks.

greg k-h
