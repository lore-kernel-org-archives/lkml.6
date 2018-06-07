Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MSSIEH5iGVuZXgAAmS7hNA
	; Thu, 07 Jun 2018 16:51:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B86A8607E7; Thu,  7 Jun 2018 16:51:39 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmbMqGRX"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1BE1A60115;
	Thu,  7 Jun 2018 16:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BE1A60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbeFGQvh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:51:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52233 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932400AbeFGQvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:51:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id p126-v6so19321265wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FD97m8AK1AVb5+u+DQXLPQT7pMrOXEAToLOLo79seT4=;
        b=QmbMqGRXbUxIEx/rTzFG7wbuwGYVZtiWWkHVS0ZMZ7vYTBQ88W2gvPp78pHvdMBxJf
         3BrAibpjZtdgiv0kFFgEhrnCzxg9+tzVabsRtu4qsCIs333pvPotBmyWMns6i49ZbZBC
         /yzkRY7/RYgXy7pLhAza3vt8UuK3oC+ZmIGgcg4GYeer9TY6qyJqxWLGMmsOEIJF0n4K
         Eic3fHnfYlnU93RSzoIvj++fvlBh09+8w4CLUCVybqT3eVUQFr3JWLwqao98ovDZPxw+
         TjU7V3/PSvdwyCBurvYYHQyTfxjVLPsE4VL0dBit1DqsSLABc3YyZLNBw6bje4qViDci
         Z7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FD97m8AK1AVb5+u+DQXLPQT7pMrOXEAToLOLo79seT4=;
        b=XHvD5KRGfEJTFSO32Y0zvREfCDwdN0GBFjqzhALwSaB6m7eItDXGk/RgLTt50nEPwk
         LxfFrEmPCSbLxCRC6qqCzHnQHbSnYk87LIp5socErGiVYcFnc3vWesX8QMNr2SLnLDiu
         bsNP9iwfPlM3pgqKEurFb6S1ZPMr13IfXxTQQ76fplIUJrLBu8C8MX3cxWQdtJtFhk15
         WGHkVYSVqBkt9ctR+65Hr/VmoVHeLJ5twZUeaOdKlBe46tMdwkq219HLlO5UQuz8B1xl
         GnH84OICDMmmXVxOluDhtssm8pG6tJwZTPD07/fQHZYimzrVynmK+B3dhxRSXCSRnW+h
         K2LA==
X-Gm-Message-State: APt69E2T3twrjTVSRXIdBM3BeyvzigRAbBLqIOHUsPUD/S8pPAPx0voX
        wTftVk/5AeeOAEiVVNbqs84=
X-Google-Smtp-Source: ADUXVKJ/52y55qvJEoKG5QwoAJgXyRtFLTTgibtmnMmGXK11plHR2nb+SNCmn17GxYcFXrE+eRf5Ew==
X-Received: by 2002:a50:d55e:: with SMTP id f30-v6mr3359645edj.73.1528390294583;
        Thu, 07 Jun 2018 09:51:34 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4108:7200:4cda:2d35:e86f:d034])
        by smtp.gmail.com with ESMTPSA id a4-v6sm14244826eda.52.2018.06.07.09.51.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 09:51:34 -0700 (PDT)
Date: Thu, 7 Jun 2018 18:51:33 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        albert@sifive.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] riscv: fix __user annotation for __copy_user()
Message-ID: <20180607165131.5qx43o6f2siwyivj@ltop.local>
References: <6a0ab99d-6e4d-eb80-bc4d-854d154ae827@wdc.com>
 <mhng-497a442f-c0da-4f88-9b48-827c4f164ed1@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-497a442f-c0da-4f88-9b48-827c4f164ed1@palmer-si-x1c4>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 09:30:19AM -0700, Palmer Dabbelt wrote:
> 
> I haven't compiled this, but I think it should work.  It's on the
> fix-sparse branch of kernel.org/palmer/linux.git .

It's essentially what I was thinking but I have some small remarks.
 
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 14b0b22fb578..0dbbbab05dac 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -392,19 +392,21 @@ do {								\
> })
> 
> 
> -extern unsigned long __must_check __copy_user(void __user *to,
> +extern unsigned long __must_check __asm_copy_from_user_user(void *to,
> 	const void __user *from, unsigned long n);
> +extern unsigned long __must_check __asm_copy_to_user_user(void __user *to,
> +	const void *from, unsigned long n);
> 
> static inline unsigned long
> raw_copy_from_user(void *to, const void __user *from, unsigned long n)
> {
> -	return __copy_user(to, from, n);
> +	return __asm_copy_from_user(to, from, n);
> }
> 
> static inline unsigned long
> raw_copy_to_user(void __user *to, const void *from, unsigned long n)
> {
> -	return __copy_user(to, from, n);
> +	return __asm_copy_to_user(to, from, n);
> }

The asm function could have directly be named raw_copy_{to,from}_user()
because the inline functions are just no-ops but it's very clear like so.

> extern long strncpy_from_user(char *dest, const char __user *src, long count);
> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
> index 58fb2877c865..bd51e47ebd44 100644
> --- a/arch/riscv/lib/uaccess.S
> +++ b/arch/riscv/lib/uaccess.S
> @@ -13,7 +13,15 @@ _epc:
> 	.previous
> 	.endm
> 
> -ENTRY(__copy_user)
> +/* __asm_copy_to_user and __asm_copy_from_user are actually the same function,
> + * they're just provided as two different symbols to C code so sparse doesn't
> + * yell about casting between two different address spaces. */
> +.global __asm_copy_to_user
> +.set __asm_copy_to_user,__asm_copy_tofrom_user
> +.global __asm_copy_from_user
> +.set __asm_copy_from_user,__asm_copy_tofrom_user
> +
> +ENTRY(__asm_copy_tofrom_user)

I don't think that the size (as reported by objdump, for example) will
be correct or even present for __asm_copy_to_user & __asm_copy_to_user.

What can be done is:
	ENTRY(__asm_copy_to_user)
	ENTRY(__asm_copy_from_user)

	<function definition>

	ENDPROC(__asm_copy_to_user)
	ENDPROC(__asm_copy_from_user)


Finally, the symbol table need also something like:
diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
index 551734248..1e8f8fa54 100644
--- a/arch/riscv/kernel/riscv_ksyms.c
+++ b/arch/riscv/kernel/riscv_ksyms.c
@@ -13,6 +13,7 @@
  * Assembly functions that may be used (directly or indirectly) by modules
  */
 EXPORT_SYMBOL(__clear_user);
-EXPORT_SYMBOL(__copy_user);
+EXPORT_SYMBOL(__asm_copy_to_user);
+EXPORT_SYMBOL(__asm_copy_from_user);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcpy);


Best regards,
-- Luc
