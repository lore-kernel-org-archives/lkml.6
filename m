Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B202C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 20:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE149208B8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 20:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE149208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeHZXym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 19:54:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41933 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbeHZXym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 19:54:42 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=[192.168.0.145])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fu1NK-0007gZ-Iz; Sun, 26 Aug 2018 22:11:06 +0200
Date:   Sun, 26 Aug 2018 22:10:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT pull] timer updates for 4.19
In-Reply-To: <CA+55aFwBRzrWDsyzQLLurET_cfD4JNRPddNmFnJJodtLdLpL4w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808262206010.1195@nanos.tec.linutronix.de>
References: <153527451522.1785.1711099585239615812.tglx@nanos.tec.linutronix.de> <153527451524.1785.7684129956167424331.tglx@nanos.tec.linutronix.de> <CA+55aFwBRzrWDsyzQLLurET_cfD4JNRPddNmFnJJodtLdLpL4w@mail.gmail.com>
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

On Sun, 26 Aug 2018, Linus Torvalds wrote:

> On Sun, Aug 26, 2018 at 2:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > New defines for the compat time* types so they can be shared between 32bit
> > and 64bit builds. Not used yet, but merging them now allows the actual
> > conversions to be merged through different maintainer trees without
> > dependencies
> 
> So I pulled this, then looked at it a bit more, and went "that's stupid".
> 
> Why introduce a completely useless new name for something we already have?
> 
> Why can't the 32-bit code just use the "compat" names instead? Even
> for 32-bit systems, it's about compatibility with the old world order.
> 
> So what's the advantage of calling it "old" over just calling it "compat"?
> 
> I do not for a *second* believe that "compat" is somehow confusing to
> 32-bit architectures. They all have the new 64-bit time code already,
> it's not like there is any confusion what-so-ever about what is going
> on here.
> 
> The fact is, those 32-bit interfaces are FOR COMPATIBILITY with old
> binaries. What the hell is confusing about that? No, the real
> confusion would be to have yet another name for the same thing for no
> good reason.

We still have compat interfaces for 32bit on 64bit even with the new 2038
safe timespec/val variants because pointer size is different. And for the
old style timespec/val interfaces we need yet another 'compat' interface
for both 32bit native and 32bit on 64bit. That's why we need a different
name.

Thanks,

	tglx





