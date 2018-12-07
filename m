Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3236C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9D92083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ioJXVhA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9D92083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeLGKTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:19:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47546 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbeLGKTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:19:45 -0500
Received: from zn.tnic (p200300EC2BCEC90030FF5A381F5D9977.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:c900:30ff:5a38:1f5d:9977])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4ED21EC0B1A;
        Fri,  7 Dec 2018 11:19:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544177984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=URcuonAnXujwK7HvMXjuglmsr5UUDLHLmr0FLz0UaGQ=;
        b=ioJXVhA9OhvyqPdl5zjS5NIFsntVk1pFh9RoVTgukMiijcN/BX3HCcNIG2DSnD7iQXRKV3
        D5GByH5yySt9xc1DKhtEdpU7uYNEkbIfQLZVZ7u4Jz5ORxcZh4KaynjwtE1S+0OvQtdFkt
        e5h6fweFOW9hRcuKCLkGX1hoLjIwsKI=
Date:   Fri, 7 Dec 2018 11:19:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 08/29] x86/fpu: Remove fpu->initialized usage in
 __fpu__restore_sig()
Message-ID: <20181207101941.GB9385@zn.tnic>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
 <20181128222035.2996-9-bigeasy@linutronix.de>
 <20181206200722.GF3986@zn.tnic>
 <20181207081712.dys7zeh546e2r3wn@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207081712.dys7zeh546e2r3wn@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 09:17:13AM +0100, Sebastian Andrzej Siewior wrote:
> You mean:
>   		struct user_i387_ia32_struct env;
>  +		union fpregs_state *state;
>  +		void *tmp;
>   		int err = 0;
> ?

Yap.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
