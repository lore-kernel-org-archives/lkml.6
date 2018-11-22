Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CB2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E72620824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E72620824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406343AbeKWEKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:10:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404220AbeKWEKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:10:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7483230013B9;
        Thu, 22 Nov 2018 17:30:12 +0000 (UTC)
Received: from treble (ovpn-121-105.rdu2.redhat.com [10.10.121.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 769F65C25A;
        Thu, 22 Nov 2018 17:30:06 +0000 (UTC)
Date:   Thu, 22 Nov 2018 11:30:04 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20181122173004.fn4tqoclhcyibxff@treble>
References: <20181121201430.559770965@linutronix.de>
 <20181121201722.337599561@linutronix.de>
 <CAHk-=wgLZkKDLeNN818VG0wC6B_kCUJqKPLdW+KDVocU6_DvtA@mail.gmail.com>
 <CAHk-=wj6fZpcad+1O5Ou0HZb0NEv1RM_BweyM0XBGtzE87YXXg@mail.gmail.com>
 <alpine.DEB.2.21.1811212345180.1665@nanos.tec.linutronix.de>
 <20181121230450.k75e4ipdag73dayz@treble>
 <20181121230854.GH27559@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181121230854.GH27559@zn.tnic>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 22 Nov 2018 17:30:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 12:08:54AM +0100, Borislav Petkov wrote:
> On Wed, Nov 21, 2018 at 05:04:50PM -0600, Josh Poimboeuf wrote:
> > Why not just 'user'?  Like SPECTRE_V2_USER_*.
> 
> Sure, a bit better except that it doesn't explain what it does, I'd say.

But it does describe its purpose, especially in relation to the
'spectre_v2=' option.

Previously 'spectre_v2=' might have been more appropriately named
'spectre_v2_kernel=' because it only protected the kernel from Spectre
v2 attacks.  Now with these new patches, 'spectre_v2=on' will protect
the entire system.

Whereas 'spectre_v2_user=' is a subset of that; it helps protect user
space from itself.  Appending "user" to the existing 'spectre_v2='
option helps to communicate that, IMO.

Now off to eat a giant turkey.

-- 
Josh
