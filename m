Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE5CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DB02084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iUj1Ufiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfBYTmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:42:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47134 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfBYTmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:42:13 -0500
Received: from zn.tnic (p200300EC2BC68000EC11815BDBFEF01F.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:8000:ec11:815b:dbfe:f01f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F1D9A1EC0253;
        Mon, 25 Feb 2019 20:42:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551123732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aKBi6KZmevMf1KXK9eWON+Vt9c3nuUaYtUaUFW4Dogg=;
        b=iUj1UfizrWujO/Wg0xXEUJ2r9Zz4jiz8YeN43LrxEa5E/CPcTCMKLTDYerXy0kf7bAHJ5z
        9axxkzmWHOO/UnHSTGpihywbVwxGswau0Z4fIRzhWMKnGh2qJeN1WEZVgkr1zhl9YT/R84
        HaN+m6Ufx5F1G0RoQi1eeFF/U2rdt60=
Date:   Mon, 25 Feb 2019 20:42:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: Re: [PATCH] x86/uaccess: Remove unused __addr_ok() macro
Message-ID: <20190225194203.GI26145@zn.tnic>
References: <20190225191109.7671-1-bp@alien8.de>
 <CAHk-=wjOtNqb98XxYks0PMdhqgNiu97_hDxqOKG8Sz3F8H=VcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjOtNqb98XxYks0PMdhqgNiu97_hDxqOKG8Sz3F8H=VcQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 11:20:42AM -0800, Linus Torvalds wrote:
> On Mon, Feb 25, 2019 at 11:11 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > This was caught while staring at the whole {set,get}_fs() machinery.
> 
> Heh.
> 
> You should probably have researched _when_ it became unused.
> 
> That seems to have happened in commit 5723aa993d83 ("x86: use the new
> generic strnlen_user() function") which removed the single user from
> the x86-32 version of strnlen_user(), which used to have
> 
>         unsigned long mask = -__addr_ok(s);

Yap, found it. I still have

$ git log -p -G__addr_ok --pickaxe-all

in one of the shells' history here.

I'll add that to the commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
