Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C24C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B2C20645
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B2C20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438936AbeKWH7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 02:59:07 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49050 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbeKWH7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 02:59:07 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPwM5-0005CH-QE; Thu, 22 Nov 2018 22:17:45 +0100
Date:   Thu, 22 Nov 2018 22:17:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
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
In-Reply-To: <20181122175229.GD10365@zn.tnic>
Message-ID: <alpine.DEB.2.21.1811222215360.1665@nanos.tec.linutronix.de>
References: <20181121201430.559770965@linutronix.de> <20181121201722.337599561@linutronix.de> <CAHk-=wgLZkKDLeNN818VG0wC6B_kCUJqKPLdW+KDVocU6_DvtA@mail.gmail.com> <CAHk-=wj6fZpcad+1O5Ou0HZb0NEv1RM_BweyM0XBGtzE87YXXg@mail.gmail.com>
 <alpine.DEB.2.21.1811212345180.1665@nanos.tec.linutronix.de> <20181121230450.k75e4ipdag73dayz@treble> <20181121230854.GH27559@zn.tnic> <20181122173004.fn4tqoclhcyibxff@treble> <20181122175229.GD10365@zn.tnic>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018, Borislav Petkov wrote:
> On Thu, Nov 22, 2018 at 11:30:04AM -0600, Josh Poimboeuf wrote:
> > But it does describe its purpose, especially in relation to the
> > 'spectre_v2=' option.
> 
> Sure, but the thing I'm proposing
> 
> spectre_v2_task_isol=
> 
> describes it more precisely, IMHO. :)
> 
> I.e., "enable/disable spectre v2 task isolation".
> 
> > Previously 'spectre_v2=' might have been more appropriately named
> > 'spectre_v2_kernel=' because it only protected the kernel from Spectre
> > v2 attacks.  Now with these new patches, 'spectre_v2=on' will protect
> > the entire system.
> 
> Hmmm, crazy idea: can we extend the options of spectre_v2= nstead?
> 
> spectre_v2=user_isolation,...
> spectre_v2=kernel,...
> spectre_v2=task_isolation,...
> 
> and so on?
> 
> This way we can do a couple of option switches in one go.

That's results in a huge parser state space and changes the existing
interface. We stay with the separate option.

Thanks,

	tglx
