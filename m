Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kTT2IzKRGVvAMwAAmS7hNA
	; Thu, 07 Jun 2018 20:11:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E3BA86074D; Thu,  7 Jun 2018 20:11:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1WrFgII"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0C74A6063F;
	Thu,  7 Jun 2018 20:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C74A6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeFGUL2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751037AbeFGUL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:11:27 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FA3E20895;
        Thu,  7 Jun 2018 20:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528402286;
        bh=5Hk6JyFDrdi19F+nO0Op9LqB8jmXdMne9xrVHreSEmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1WrFgIIl0Druhy32ZKNXVdNO4+6Uden2SOopvY5FavtF834Gpqni5+q5MdbwTi9Q
         oMnme18p5f2xBM5BQy8RouPi879R3yUk5s8ELOnd+VpfWwkH+wPNL3J8BrT73yT72n
         Ga2YK2MlVYr8pOA0I09kfW6I7DPUPUiJWxB02FHY=
Date: Thu, 7 Jun 2018 22:11:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Y Knight <jyknight@google.com>,
        Chandler Carruth <chandlerc@google.com>,
        Stephen Hines <srhines@google.com>,
        Kees Cook <keescook@google.com>, groeck@chromium.org,
        Greg Hackmann <ghackmann@google.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
Message-ID: <20180607201102.GA6844@kroah.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
 <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net>
 <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com>
 <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
 <20180404093823.GC25996@kroah.com>
 <CAKwvOdmk-e5NCkyMT_LX2i5F1X+xGP+ZxAjaJasjgE6FaXKi6w@mail.gmail.com>
 <20180404193247.lsoxe3xjcidwtlgv@treble>
 <CAKwvOdmFVO=SUxazTR+WGgrTtKyfqgEup-aY_P3LrQBZqrL84Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmFVO=SUxazTR+WGgrTtKyfqgEup-aY_P3LrQBZqrL84Q@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 12:23:31PM -0700, Nick Desaulniers wrote:
> On Wed, Apr 4, 2018 at 12:32 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Wed, Apr 04, 2018 at 04:53:52PM +0000, Nick Desaulniers wrote:
> > > (re-sending as plain text)
> > >
> > > On Wed, Apr 4, 2018 at 2:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > There are known-bugs with building a kernel with clang right now (I
> > > > pointed one out a few days ago about NULL checks being deleted from the
> > > > clang output for no good reason, which really is scary for obvious
> > > > reasons).
> > >
> > > Is this the thread you are referring to?
> > > https://lkml.org/lkml/2018/3/27/1286
> > >
> > > It's definitely something curious that I'll need to sit down and
> > > investigate more.  If there are other known instances, it would be good to
> > > let me know.
> >
> > As Matthias mentioned elsewhere, it sounds like they're planning to
> > implement -fno-delete-null-pointer-checks, which would presumably fix
> > the above issue.
> 
> Just to follow this up, -fno-delete-null-pointer-checks is being added
> to clang in:
> https://reviews.llvm.org/D47894
> https://reviews.llvm.org/D47895

That's great news, thanks for letting us know.

greg k-h
