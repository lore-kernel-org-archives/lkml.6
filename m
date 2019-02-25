Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FBEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C84F20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfBYMMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:12:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59840 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfBYMMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:12:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84D101596;
        Mon, 25 Feb 2019 04:12:52 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26EF63F575;
        Mon, 25 Feb 2019 04:12:49 -0800 (PST)
Date:   Mon, 25 Feb 2019 12:12:46 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>,
        Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [RFC PATCH 08/20] m68k: io: Remove useless definition of mmiowb()
Message-ID: <20190225121246.GB17076@fuggles.cambridge.arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
 <20190222185026.10973-9-will.deacon@arm.com>
 <CAMuHMdXq5N1e+=dTPUu+AtSgh4QzuDzmhBowG_HFoVHwmndvkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXq5N1e+=dTPUu+AtSgh4QzuDzmhBowG_HFoVHwmndvkg@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:25:52AM +0100, Geert Uytterhoeven wrote:
> On Fri, Feb 22, 2019 at 7:51 PM Will Deacon <will.deacon@arm.com> wrote:
> > m68k includes asm-generic/io.h, which provides a dummy definition of
> > mmiowb() if one isn't already provided by the architecture.
> >
> > Remove the useless definition.
> >
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Thanks!
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Do you want me to queue this in the m68k tree for v5.2, or would
> you prefer to apply the whole series?
> In case of the latter:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Cheers, Geert! For now, I think it's best to keep all the patches together
since I anticipate a few rounds of rework before I have a good idea about
what the final series will look like.

Will
