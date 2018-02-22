Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2903091-1519261285-2-4946000891143924861
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519261285; b=V3Eith6Og39X9GPCDmAkPhxuJWnllEvLgaY7KCntzaWYVMW
    eYkq3aMdeQUh3aNCV8Eo3qVnRMAbvzNFQPKizkVD7ynrH/6Mihag/q/G/2QxC3bZ
    IMUsO10Xy85mn+igQw3c5pDKLs2/IUOFdABygrrGSMlXm4ZmCakG9dXuBD4zs4lP
    D7whrAezT3mR4YUgwAEuGNxxWuqITP9aFEXMqn5m0qhcyNC9mcK5Ttn33JI+jxZD
    vn5LCMTsm6eirEduckTPOxJmA/adqgadSdlMV5TmaUkbqD1eStX11h6ZOQFgpIRb
    OpyLDDgmAyDkQaADTn8TvPmUtyeKaRPPBIit/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1519261285; bh=uBe76AVOh9pcNvrprDox6Xw4AB52sqiTH+E3Vl
    z316c=; b=bFjzO7fxDVqSMfDf19zJXzLDFebde2J/9qyKkBsZ3cAAzinS7DZcpa
    y4IhXJlPI6PMLiaB/TfH9SbAFjUI+hB0EtufXmrUE2TwPYzU24HruH1XCin81/Cx
    haVYPUimgodSpBe2OVzGr4xMqPKgyC+J+YETT8c5hbI6GbF/Nfc4EDoF/7oGCbHx
    Oyg43PiTBYs8+fKC6u1yXvawJG6S6C12M3tlOC3GSvwv0bdJLvLRnpYdOInGCyBH
    sMlv6wMY7bvcXKi8adilQGuQyU+jPEvK90gatYJvnUOrIEGsPNMVEkBXnLjhTAon
    fMBEpIEeXvpex+6JWrbCWt0KtODbyAAw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ellerman.id.au header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ellerman.id.au header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeBVBBX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 20:01:23 -0500
Received: from ozlabs.org ([103.22.144.67]:34539 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeBVBBX (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 21 Feb 2018 20:01:23 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Yves-Alexis Perez <corsac@debian.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4.9 34/77] powerpc: fix build errors in stable tree
In-Reply-To: <20180221124433.618725458@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org> <20180221124433.618725458@linuxfoundation.org>
Date: Thu, 22 Feb 2018 12:01:21 +1100
Message-ID: <87k1v5rg66.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> 4.9-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Nicholas Piggin <npiggin@gmail.com>
>
> This is just the first chunk of commit
> 222f20f140623ef6033491d0103ee0875fe87d35 upstream.

That should have been back ported in full?

Oh I see now Greg took my 4.4 series and applied it to 4.9 but this one
didn't apply.

So I guess this patch is OK for now, but we do need a full back port of
222f20f to 4.9.

cheers


> to fix a build error in the powerpc tree due to other backports
> happening (and this full patch not being backported).
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Yves-Alexis Perez <corsac@debian.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Yves-Alexis Perez <corsac@debian.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  arch/powerpc/kernel/entry_64.S |    5 +++++
>  1 file changed, 5 insertions(+)
>
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -39,6 +39,11 @@
>  #include <asm/tm.h>
>  #include <asm/ppc-opcode.h>
>  #include <asm/export.h>
> +#ifdef CONFIG_PPC_BOOK3S
> +#include <asm/exception-64s.h>
> +#else
> +#include <asm/exception-64e.h>
> +#endif
>  
>  /*
>   * System calls.
