Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B868C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155282081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NIxNjXAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155282081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeLEOdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:33:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43300 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbeLEOdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:33:06 -0500
Received: from zn.tnic (p200300EC2BC09900B100099FAFCBAE1B.dip0.t-ipconnect.de [IPv6:2003:ec:2bc0:9900:b100:99f:afcb:ae1b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 567301EC0B7A;
        Wed,  5 Dec 2018 15:33:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544020385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9TBJ+cIFMqiLqT0QyT6lbblxI0QqaTTBaZvJyyywD3w=;
        b=NIxNjXArFf9IAUM5gsz9NzhjER4+h+fK0lBpFkNBSc8Lf5lo38j3rhnhJkrBWUJpHpx4yD
        COO0ayxntF26Lr66OPDCYvEnRvLs4jhOANVWk1btlofT/h5SsWv5fPa93Q0GnBAkVsjivy
        bu3RcsDJZD7y2LxLtmnnp2AYx+BuVtk=
Date:   Wed, 5 Dec 2018 15:33:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Linux 4.20-rc5: Lab setup broken by build-related x86 change
Message-ID: <20181205143303.GI29510@zn.tnic>
References: <CAHk-=wizcNrsoyCM1EXQqoswMCYsJaby2iAkZb9wBAzDEhvxNg@mail.gmail.com>
 <1753172.TxHhsZQBsE@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1753172.TxHhsZQBsE@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 01:15:10PM +0100, Rafael J. Wysocki wrote:
> After commit
> 
> commit 4cd24de3a0980bf3100c9dcb08ef65ca7c31af48
> Author: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Date:   Fri Nov 2 01:45:41 2018 -0700
> 
>     x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support

I see Ingo committed a fix for this thing:

https://git.kernel.org/tip/25896d073d8a0403b07e6dec56f58e6c33678207

Does it work with that cherry-picked ontop?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
