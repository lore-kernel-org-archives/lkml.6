Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A1FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1769421479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg9b864o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1769421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeJJN4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:56:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39858 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeJJN4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:56:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id 61-v6so4292421wrb.6;
        Tue, 09 Oct 2018 23:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c/b+tGNeYLdIoMaVBGbfpEfqfRH4TY0pQUseN/E8q9g=;
        b=Gg9b864oudgq5QNt04lzCm1yWQe2m2oN53NFboy3V1QxTuzKy1gsFdX2cN/LnDbi6Q
         7IHi+kp8TM0F8SQ5owNL0gtnpszBtRsFA4N8E5Gmm88UuY0nekqsO6pR8apP5QpYYME1
         h9dLWRU0Wvb0zDdlyZOYrby+IssJfZGQQfNA2xOn46k8QkuRTaeyT6WTejWe+efoT1u4
         r+duFC7zApRpZ4JG7/mypHal8xMwUHOi/KocZKoCOBH8HXkTdea3iovKzR697v2qu8pb
         RoX4UQIXok7De9Wr21u2MPm+J0h/by3BjGqHxHKKvt3TKyUza8l50dd9stYKGNckfZQk
         zQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=c/b+tGNeYLdIoMaVBGbfpEfqfRH4TY0pQUseN/E8q9g=;
        b=cbAjs4dTt18THjIjQuk0qzORzJMiNWicdHy/VzQHHnjry36YwN/ocfCGfoPT0AGdet
         PgYKmt72KIOW4892CEM09/xQjCzc3wTsfuLjdOwiirNGaeo0wXQPbiTxLauqqcqM538V
         cCGtLebLazq3p1zXZmPoUwv579cryXGvN3K2RmIqzfYQohF255Jx+Yos7bvfouioGwWW
         FJyPtqg5YWVd5wsNmxgvvdtx0H8dmdEV5eiQXNy4tSD752LWuqShZs+ZOSDNx68aYb+u
         w926FFFTZBHlMpQ9l+D6y3QbExyv1RRC/rzY2cFoHiAjS5pHHLrmjNtZUBj98EO9xEY4
         w1xA==
X-Gm-Message-State: ABuFfohICkfTu7JeJqjO+467LJuAbg2iLh79DX6cC1euUCctBeAm6Pso
        AJ7p02JsKjXG/Wi39NMHnCE=
X-Google-Smtp-Source: ACcGV608rWVGxEAFPvquVQFC30r+9Hl9EKCAQ3A1usB4avjV/b3sE+qKFjrmpeaNxKYMsbuSzs1O4Q==
X-Received: by 2002:a5d:6883:: with SMTP id h3-v6mr22374466wru.108.1539153339556;
        Tue, 09 Oct 2018 23:35:39 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t143-v6sm13901675wmt.2.2018.10.09.23.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 23:35:38 -0700 (PDT)
Date:   Wed, 10 Oct 2018 08:35:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Richard Biener <rguenther@suse.de>, Michael Matz <matz@suse.de>,
        Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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
Message-ID: <20181010063536.GA124923@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic>
 <20181007132228.GJ29268@gate.crashing.org>
 <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
 <20181008073128.GL29268@gate.crashing.org>
 <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009145330.GT29268@gate.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Segher Boessenkool <segher@kernel.crashing.org> wrote:

> On Mon, Oct 08, 2018 at 11:07:46AM +0200, Richard Biener wrote:
> > On Mon, 8 Oct 2018, Segher Boessenkool wrote:
> > > On Sun, Oct 07, 2018 at 03:53:26PM +0000, Michael Matz wrote:
> > > > On Sun, 7 Oct 2018, Segher Boessenkool wrote:
> > > > > On Sun, Oct 07, 2018 at 11:18:06AM +0200, Borislav Petkov wrote:
> > > > > > Now, Richard suggested doing something like:
> > > > > > 
> > > > > >  1) inline asm ("...")
> > > > > 
> > > > > What would the semantics of this be?
> > > > 
> > > > The size of the inline asm wouldn't be counted towards the inliner size 
> > > > limits (or be counted as "1").
> > > 
> > > That sounds like a good option.
> > 
> > Yes, I also like it for simplicity.  It also avoids the requirement
> > of translating the number (in bytes?) given by the user to
> > "number of GIMPLE instructions" as needed by the inliner.
> 
> This patch implements this, for C only so far.  And the syntax is
> "asm inline", which is more in line with other syntax.
> 
> How does this look?

Cool, thanks for implementing this!

In the kernel we'd likely wrap this in some "asm_inline()" type of construct to be
compatible with older toolchains and other compilers.

Thanks,

	Ingo
