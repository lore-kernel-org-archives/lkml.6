Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660C5C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326192184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="cNTK42Un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfBAJmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:42:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54818 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbfBAJmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:42:23 -0500
Received: from zn.tnic (p200300EC2BCC5000604F5F4DB2DDD4A2.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:5000:604f:5f4d:b2dd:d4a2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8AC341EC05C2;
        Fri,  1 Feb 2019 10:42:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549014142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Owso+egIjx1ufNCqmQegAC3pkVX+gSLiMo9tyClI1Ls=;
        b=cNTK42UnAZAvQ7prvX20Oo9ib9xj6tDYk+byzpzCyAbBHqOfvmugFR0wobdSwSt003RLKF
        Txg0iO4ZcA10/RakPiC0Gll+mSmqr4QseJMH0M8Cfr/r1zDgCTyLCEoW9eIbLSb3BE79hc
        FYvdbCYDWFlC6UtiCxMoR6KDTeKndVw=
Date:   Fri, 1 Feb 2019 10:42:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] kbuild: Disable extra debugging info in .s output
Message-ID: <20190201094217.GB31854@zn.tnic>
References: <20190121095338.8565-1-bp@alien8.de>
 <20190131115820.GF6749@zn.tnic>
 <CAK7LNATGUs0PPssA=WfHojEEPuztDcNHf0NdH6ohOdf8k8PZOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNATGUs0PPssA=WfHojEEPuztDcNHf0NdH6ohOdf8k8PZOQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 12:06:13PM +0900, Masahiro Yamada wrote:
> This would make the build speed slower
> because the compiler is invoked to check those flags in every directory.
> 
> I tested this patch with x86_64_defconfig and GCC 8.2
> (on ubuntu 18.10 in docker)
> but I saw no effect of this patch.

Yes, because that's the .s target which is meant to be used to convert
only a *single* .c file to assembly in order to stare at the resulting
asm. For example:

make arch/x86/kernel/cpu/common.s

It is a debugging aid - and a very basic and important one - and is not
usually used during a normal kernel build. AFAIK.

So we shouldn't worry about any slowdowns here.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
