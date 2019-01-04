Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACF5C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F67218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfADRhC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:37:02 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:6467 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADRhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:37:01 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43WX621Whcz9v25c;
        Fri,  4 Jan 2019 18:36:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0iC6j55v_-A8; Fri,  4 Jan 2019 18:36:58 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43WX620ydVz9v25b;
        Fri,  4 Jan 2019 18:36:58 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id AFDFFD4E; Fri,  4 Jan 2019 18:36:59 +0100 (CET)
Received: from 37.165.122.65 ([37.165.122.65]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Fri, 04 Jan 2019 18:36:59 +0100
Date:   Fri, 04 Jan 2019 18:36:59 +0100
Message-ID: <20190104183659.Horde.Xco_Q-bqCSSJoWwerf1bVw4@messagerie.si.c-s.fr>
From:   LEROY Christophe <christophe.leroy@c-s.fr>
To:     sparclinux@vger.kernel.org, Mathieu Malaterre <malat@debian.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] Remove 'type' argument from access_ok() function
In-Reply-To: <20190104092758.4378-1-malat@debian.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> a écrit :

> In commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
> access_ok()") an attempt was made to remove a warning by referencing the
> variable `type`, however in commit 96d4f267e40f ("Remove 'type' argument
> from access_ok() function") the variable `type` has been removed.
>
> Revert commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
> access_ok()") to fix the following compilation error:
>
>   arch/powerpc/include/asm/uaccess.h:66:32: error: ‘type’ undeclared  
> (first use in this function)
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Should you add a Fixes:  96d4f267e40f ?

Note that sparc arch will have the same issue.

Christophe

> ---
>  arch/powerpc/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/uaccess.h  
> b/arch/powerpc/include/asm/uaccess.h
> index b31bf45eebd4..5f0c98e511a0 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -63,7 +63,7 @@ static inline int __access_ok(unsigned long addr,  
> unsigned long size,
>  #endif
>
>  #define access_ok(addr, size)		\
> -	(__chk_user_ptr(addr), (void)(type),		\
> +	(__chk_user_ptr(addr),			\
>  	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
>
>  /*
> --
> 2.19.2


