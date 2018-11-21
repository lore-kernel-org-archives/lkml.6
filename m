Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C18C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5648B2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5648B2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390444AbeKVJlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:41:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387744AbeKVJlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:41:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4EF7308FB93;
        Wed, 21 Nov 2018 23:04:54 +0000 (UTC)
Received: from treble (ovpn-122-214.rdu2.redhat.com [10.10.122.214])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5041419C7C;
        Wed, 21 Nov 2018 23:04:52 +0000 (UTC)
Date:   Wed, 21 Nov 2018 17:04:50 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>, thomas.lendacky@amd.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com, Kees Cook <keescook@chromium.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [patch 01/24] x86/speculation: Update the TIF_SSBD comment
Message-ID: <20181121230450.k75e4ipdag73dayz@treble>
References: <20181121201430.559770965@linutronix.de>
 <20181121201722.337599561@linutronix.de>
 <CAHk-=wgLZkKDLeNN818VG0wC6B_kCUJqKPLdW+KDVocU6_DvtA@mail.gmail.com>
 <CAHk-=wj6fZpcad+1O5Ou0HZb0NEv1RM_BweyM0XBGtzE87YXXg@mail.gmail.com>
 <alpine.DEB.2.21.1811212345180.1665@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811212345180.1665@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 21 Nov 2018 23:04:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:48:41PM +0100, Thomas Gleixner wrote:
> On Wed, 21 Nov 2018, Linus Torvalds wrote:
> 
> > On Wed, Nov 21, 2018 at 12:28 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > Ugh. Now you're using the broken quilt thing that makes a mush of emails for me.
> > 
> > Reading the series in alpine makes it look fine. No testing, but each
> > patch seems sensible.
> > 
> > And yes, triggering on seccomp makes more sense than dumpable to me.
> 
> That's what we ended up with SSBD as well. We had the same discussion before.
> 
> Btw, I really do not like the app2app wording. I'd rather go for usr2usr,
> but that's kinda horrible as well. But then, all of this is horrible.

Why not just 'user'?  Like SPECTRE_V2_USER_*.

-- 
Josh
