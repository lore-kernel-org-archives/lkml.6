Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3120174-1524577193-2-1978471021558333061
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524577193; b=Zqt7uVczTMqd8Yk1eVETq6Js21ZiU1kjoBGIg3HDXT5xumBST1
    qQB1x0hvOLUQXvEwdwgvYBt7adEDaZIGKGiK9YeNMmfdMsN9ZPqXti1jI2Bax0A7
    ddotV7USSqaNY1GGyIsjjV1as3ed5cSAJAhHnZK4dWg43KwZMjYEvnBZqvt3tz/r
    J69EwGD6PW7vQBCndT79xlHX65+ZCLBqaKSnPzoW01RjtwesMoOuVFoB1jtPTDWI
    YPUQ/xbjijD/5fShkjLCs7HwVVvg6b0gsP2EgNfXEAXlvEZ26gEvVVGhgf/JLFLR
    zx4Zo41ptkUld1lW/Og4B+zGc8lEsybhsQAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524577193; bh=w64IX4JIThVtWZNktZO2xS7DBHFHOP
    /H0fHv2i9lL4U=; b=sBWXgjp+dOKftb4ZGvsJ23YuW0Cb2mSoAuo7yHLhlbYsye
    S/y+Zst/xVnu2CX9nZam43nkyF/Dr9tnNq6jJXff1OjfIMEH3vysoT36bJEEiE9u
    YqDEz9GWkimPluU7PXvd2Zn8bKEey2oSnhFTa5vLbYmAgMLliQ+BSkD3g72tkPXV
    T9o+ZzHf/C4dF5SDMjDI/W1AcgG4utwVdmykEHin/hJCr1/8l/pTtg+CRANELIXw
    d86N6O1p1am13xtBEt1SxY5pg/FcZYaWS+iZxICDNJP7TZZ3HUPfI6R9/AzNb4F4
    Q7VkRRQrCl1eugn/UL9jTskoClS45uh8/C7nsXMA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKETv335wxk6NjUToGDDBYxwj5t8CTOb0Zvj4IRS1vjYkQILIaEB9EMNxumvik5C52b6PiLVEwbSEy1HC17ZOCrimOKsjH5w4hjY8899K2W+ehgnFCOt
    aspWxuYYEsaL4aZoMQOo/yaAoERzHEhxGMvpAEok55Cxb4inTUpoFo3m8bPhLR75jKZeYkHzEVie6CncqU7jRXwmAdvIkjk4G9LeQ3oFHi/EpjETBJWCC0/g
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=UGG5zPGqAAAA:8 a=VwQbUJbxAAAA:8 a=mDV3o1hIAAAA:8 a=JUuAu6ssyF_ILAN8w98A:9
    a=CjuIK1q_8ugA:10 a=17ibUXfGiVyGqR_YBevW:22 a=AjGcO6oz07-iQ99wixmX:22
    a=_FVE-zBwftR9WsbkzFJk:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933346AbeDXNee (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 09:34:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53264 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933173AbeDXNeb (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 24 Apr 2018 09:34:31 -0400
Date: Tue, 24 Apr 2018 14:34:49 +0100
From: Will Deacon <will.deacon@arm.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        PaX Team <pageexec@freemail.hu>, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: export tishift functions to modules
Message-ID: <20180424133449.GA24599@arm.com>
References: <20180415160416.28161-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180415160416.28161-1-Jason@zx2c4.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jason,

On Sun, Apr 15, 2018 at 06:04:16PM +0200, Jason A. Donenfeld wrote:
> Otherwise modules that use these arithmetic operations will fail to
> link. We accomplish this with EXPORT_SYMBOL in the .S file, but because
> of symbol versioning, we actually need to have a declaration of these
> too in C. So, we introduce asm-prototypes.h, which is the same file name
> and technique used for similar reasons in the m68k arch tree.
> 
> While we're at it, we also fix this up to use SPDX, and I personally
> choose to relicense this as GPL2||BSD so that these symbols don't need
> to be export_symbol_gpl, so all modules can use the routines, since
> these are important general purpose compiler-generated function calls.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Reported-by: PaX Team <pageexec@freemail.hu>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/asm-prototypes.h | 11 +++++++++++
>  arch/arm64/lib/tishift.S                | 19 ++++++-------------
>  2 files changed, 17 insertions(+), 13 deletions(-)
>  create mode 100644 arch/arm64/include/asm/asm-prototypes.h

I've not run into any build issues here -- is this specifically with some
out-of-tree module?

> diff --git a/arch/arm64/include/asm/asm-prototypes.h b/arch/arm64/include/asm/asm-prototypes.h
> new file mode 100644
> index 000000000000..8f1919e44f51
> --- /dev/null
> +++ b/arch/arm64/include/asm/asm-prototypes.h

It would be better not to introduce a new header file just for this, I
think. How about compiler.h instead?

> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> + *
> + * Copyright (C) 2017-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +
> +/* These functions are defined in lib/tishift.S, but need to be declared
> + * here so that symbol versioning picks them up.
> + */
> +extern long long __ashlti3(long long a, int b);
> +extern long long __ashrti3(long long a, int b);
> +extern long long __lshrti3(long long a, int b);
> diff --git a/arch/arm64/lib/tishift.S b/arch/arm64/lib/tishift.S
> index d3db9b2cd479..3bca433973cb 100644
> --- a/arch/arm64/lib/tishift.S
> +++ b/arch/arm64/lib/tishift.S
> @@ -1,20 +1,10 @@
> -/*
> - * Copyright (C) 2017 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + * Copyright (C) 2017-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
>   */
>  
>  #include <linux/linkage.h>
> +#include <asm-generic/export.h>
>  
>  ENTRY(__ashlti3)
>  	cbz	x2, 1f
> @@ -36,6 +26,7 @@ ENTRY(__ashlti3)
>  	mov	x0, x2
>  	ret
>  ENDPROC(__ashlti3)
> +EXPORT_SYMBOL(__ashlti3)

We normally export asm symbols via arm64ksyms.c. In fact, would doing that
remove the need for the explicit declarations completely?

Will
