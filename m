Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCCAC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FA720652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FA720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJHSH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:07:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:43013 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbeJHSH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:07:58 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w98A2pvY009011;
        Mon, 8 Oct 2018 05:02:51 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w98A2k5p008969;
        Mon, 8 Oct 2018 05:02:46 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 8 Oct 2018 05:02:46 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Richard Biener <rguenther@suse.de>
Cc:     Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>,
        gcc@gcc.gnu.org, Nadav Amit <namit@vmware.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-sparse@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Message-ID: <20181008100245.GP29268@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 11:07:46AM +0200, Richard Biener wrote:
> > All of a targets register names and alternative register names are
> > allowed in the clobber list.  Will that never conflict with an attribute
> > name?  We already *have* syntax for specifying attributes on an asm (on
> > *any* statement even), so mixing these two things has no advantage.
> 
> Heh, but I failed to make an example with attribute synatx working.
> IIRC attributes do not work on stmts.  What could work is to use
> a #pragma though.

Apparently statement attributes currently(?) only work for null statements.
Oh well.


Segher
