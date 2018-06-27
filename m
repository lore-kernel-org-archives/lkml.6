Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF78C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D44242E8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="BzSYURWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D44242E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965704AbeF0QaM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:30:12 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:56096 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934313AbeF0QaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nDTL0KzWtQBBue6N64mp3+viprYWZG9tf/eFlFgf7tg=; b=BzSYURWga/qzEDfsqyvMBQM4jx
        +LyTploZYusbpOO/J/xJvhKAmvFxrQWmJDzQXWRee/AFfnaHRcNwo8+n8yzTvR0w/qLenkqgRl8kh
        xTA830suNnLG8jimsJR2BX/JZGRWPhqD8PHV0/qdlhWPz5GUl1OLzvgZCrAVgFw5QwYFQhoiEd6x5
        I4HpAuJbdQRJPQ18xrXQm4bv6C2oG7PVKGCezRy26E2e3NeDMQkXGE6kyOdHd7pV8kLuoKfftz9NF
        Vcyz6luletQhJkui0TXVvxFUCoQtiNobz7RNCOln/LdSFVetozbNNUqwHAovXGD+vFw3VQbjZzztY
        QzBGIk8g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:38150 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fYDKc-00C4xL-7H; Wed, 27 Jun 2018 16:30:10 +0000
Date:   Wed, 27 Jun 2018 09:30:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, mcroce@redhat.com,
        sbrivio@redhat.com, David Miller <davem@davemloft.net>
Subject: Re: Build/qemu test results for v4.18-rc2
Message-ID: <20180627163009.GA6826@roeck-us.net>
References: <0ecc33a4-60c0-f978-f281-99844508d09a@roeck-us.net>
 <CA+55aFzhE2PQOM-pykY=GammunCLYhY37eS_UiYnXWXuSvHLZQ@mail.gmail.com>
 <20180625163147.GA7112@roeck-us.net>
 <CA+55aFwZ1+HEYjo52OmX-aXEJ5iaGMakhJEZq1uY=CVKGdBSgg@mail.gmail.com>
 <CA+55aFx=UFQQi3c6MoA1jWaMf+-9vXC4pU56H_9dG3S8tbJdHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFx=UFQQi3c6MoA1jWaMf+-9vXC4pU56H_9dG3S8tbJdHA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 08:27:47AM -0700, Linus Torvalds wrote:
> On Tue, Jun 26, 2018 at 8:40 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The problem on x86-64 cross-building to i386 is that the *compiler* is
> > the same, but the flags are not, and the games the Makefile plays
> > aren't sufficient. It plays with changing HOSTCC to CC in order to get
> > he right target compiler, but since the difference between i386 and
> > x86-64 is not the compiler but the "-m64" in the cflags, it doesn't
> > actually do what it intended to do.
> >
> > We'll get it sorted, I think.
> 
> So right now the build fix is likely to be this:
> 
>     https://patchwork.ozlabs.org/patch/935246/
> 

I can confirm that the patch fixes the i386 cross-compile issue.
I just sent a Tested-by:.

Guenter

> but note that it's literally just a build fix, and for a i386
> cross-compile it embeds the wrong binary so it won't actually run
> correctly. For this whole "test the concept" stage that's fine.
> 
>                 Linus
