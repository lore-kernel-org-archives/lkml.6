Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD75C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA661205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA661205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeK3AOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:14:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:56810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728243AbeK3AOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:14:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4268FAC17;
        Thu, 29 Nov 2018 13:09:26 +0000 (UTC)
Date:   Thu, 29 Nov 2018 14:09:25 +0100 (CET)
From:   Richard Biener <rguenther@suse.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, matz@suse.de, gcc@gcc.gnu.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-sparse@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
In-Reply-To: <20181129130718.GA3070@nazgul.tnic>
Message-ID: <alpine.LSU.2.20.1811291408400.1827@zhemvz.fhfr.qr>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org> <CAK7LNARmrdtyE7JRAdJH_zbfvD_cej+TGLh+5KfT20o538KUcA@mail.gmail.com> <20181129130718.GA3070@nazgul.tnic>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018, Borislav Petkov wrote:

> On Thu, Nov 29, 2018 at 08:46:34PM +0900, Masahiro Yamada wrote:
> > But, I'd like to ask if x86 people want to keep this macros.s approach.
> > Revert 77b0bf55bc675 right now
> > assuming the compiler will eventually solve the issue?
> 
> Yap, considering how elegant the compiler solution is and how much
> problems this macros-in-asm thing causes, I think we should patch
> out the latter and wait for gcc9. I mean, the savings are not so
> mind-blowing to have to deal with the fallout.
> 
> But this is just my opinion.

I'd be not opposed to backporting the asm inline support.

Of course we still have to be happy with it and install the patch ;)

Are you (kernel folks) happy with asm inline ()?

Richard.

> Thx.
> 
> 

-- 
Richard Biener <rguenther@suse.de>
SUSE LINUX GmbH, GF: Felix Imendoerffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nuernberg)
