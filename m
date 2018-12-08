Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F463C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2982081C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qSgzCY0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2982081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbeLHMmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 07:42:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59946 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbeLHMms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 07:42:48 -0500
Received: from zn.tnic (p200300EC2BDEA700C0511CCA78411630.dip0.t-ipconnect.de [IPv6:2003:ec:2bde:a700:c051:1cca:7841:1630])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 864BB1EC0229;
        Sat,  8 Dec 2018 13:42:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544272967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MddpSfX/Z5b4o6oEd1QVsIadhzsWCcyAfGYIKMLMo6Q=;
        b=qSgzCY0mAE4sd38wv35yt/Uh0qfZ4n3UAn3Wq7AMgzs43MhIimwTgON+l84Ib+bmB5QZdN
        CsdMxCKgMnHfxrImRdYle5gHj/XPt1CYZAahrupmNbsMmmimpZd8azchkrnR8044Rd8k8B
        0yBk8G/Z9RKRp8gxX+xIO8dhHhK1SeA=
Date:   Sat, 8 Dec 2018 13:42:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kirill Marinushkin <k.marinushkin@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/retpoline: Fix forcing me to update my compiler
Message-ID: <20181208124240.GE30399@zn.tnic>
References: <20181208123816.22952-1-k.marinushkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181208123816.22952-1-k.marinushkin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 01:38:16PM +0100, Kirill Marinushkin wrote:
> First problem: I cannot compile the kernel with my version of compiler
> 
> ~~~~
> $ make defconfig
> *** Default configuration is based on 'i386_defconfig'
> \#
> \# configuration written to .config
> \#
> $ grep CONFIG_RETPOLINE .config
> CONFIG_RETPOLINE=y
> $ make
> arch/x86/Makefile:224: *** You are building kernel with non-retpoline
> compiler, please update your compiler..  Stop.
> ~~~~

Does this help?

https://git.kernel.org/tip/25896d073d8a0403b07e6dec56f58e6c33678207

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
