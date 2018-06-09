Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id svosHocbG1ucYQAAmS7hNA
	; Sat, 09 Jun 2018 00:13:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DC3AC6089E; Sat,  9 Jun 2018 00:13:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdo8ukHI"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5019C607A4;
	Sat,  9 Jun 2018 00:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5019C607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeFIANQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 20:13:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51703 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbeFIANP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 20:13:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so5911204wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 17:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qruWTs6sVeYwLuu4kWvGf5y76V1KV/5XyDHxhxH4FM0=;
        b=vdo8ukHIaQbFgcBnxmOUDtzOtE2iR0EFK8dWVAzzNhyvIUZweE0L0aCYEpEBayaxuN
         LBbCWGsUjyE8XshrtsVGtRaiZqG9HXBGcnjST+OJJeubi6PhFsg6lYirxR6rmP9+vh9N
         Dd2Cm/DOfJItnDyz8Ti7SRC73k6Gd7mSfno5Vsgc1OT83HwL26/SQpi9zqnVgpORMTPY
         dW6hPotcVvBvGsyM+IS4ySQOAeyagCtiSsZBfzh9wUlZ3xg8kyiooSeYOx8u3U2Lszqi
         Ch5QfH9iK/5xvvssEhl5vJA0OYPCMyU+pGpoYnbc6VN0nz3NUVglkivi8wpUUG/c2xGE
         Bv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qruWTs6sVeYwLuu4kWvGf5y76V1KV/5XyDHxhxH4FM0=;
        b=gBFXo7QqX9yPKh3wx1fQ7bNtqHGJG7f6fDaUq5Jbw/mqh8ZTueu2XxRn/ZvFNLG+HT
         g2NprGZdo4dDcUFbZ7SwrQ+3oLdk0BJ5blURarArPmt/u5hpas3pcvzgCZAxadtLpi6p
         L2P46UlRtJwK7CbUVtJdCAxH5sCD812INFSDjR2yC+AlAxKO56InKYIbk2sq2yK70cVo
         Oi9bkNSIxFl3CuMdWrVyeOZx+AvudiaE/Yf+HFZU135RiS633tfD5Ku8rlgqyWuJEBcd
         sO0NwfIbRiWBWm2zpBVau9yYy3iM88cr0filw0q/esdfmB0Gcmd0hga+Q+0o/Q6Z47k4
         UjAA==
X-Gm-Message-State: APt69E0Q93Dym2lrf3aqWFW4doIyMCQ4Xi7xQgsRXpoO1kGq0vETo5RH
        EdPCcghODdhNFZALkzlG0Rc=
X-Google-Smtp-Source: ADUXVKKOmAvDmWHE6IFZ4GeRu7dne96euSGhp0d/5F0432U81npnSRk/w20Gjr2/bGO/uWfpVRr8QQ==
X-Received: by 2002:a50:a666:: with SMTP id d93-v6mr435471edc.294.1528503194111;
        Fri, 08 Jun 2018 17:13:14 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4108:7200:7966:ff62:c7df:1312])
        by smtp.gmail.com with ESMTPSA id m20-v6sm29149947edq.46.2018.06.08.17.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 17:13:13 -0700 (PDT)
Date: Sat, 9 Jun 2018 02:13:12 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, albert@sifive.com
Subject: Re: [PATCH 3/3] riscv: fix __user annotation for __copy_user()
Message-ID: <20180609001310.jxzcqtdacu4uiz6b@ltop.local>
References: <20180607165131.5qx43o6f2siwyivj@ltop.local>
 <mhng-d06d9c63-3188-4e2e-abe6-2f62e3b35d48@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-d06d9c63-3188-4e2e-abe6-2f62e3b35d48@palmer-si-x1c4>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 03:33:36PM -0700, Palmer Dabbelt wrote:
> On Thu, 07 Jun 2018 09:51:33 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
> > On Thu, Jun 07, 2018 at 09:30:19AM -0700, Palmer Dabbelt wrote:
> > > diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
> > > index 58fb2877c865..bd51e47ebd44 100644
> > > --- a/arch/riscv/lib/uaccess.S
> > > +++ b/arch/riscv/lib/uaccess.S
> > > @@ -13,7 +13,15 @@ _epc:
> > > 	.previous
> > > 	.endm
> > > 
> > > -ENTRY(__copy_user)
> > > +/* __asm_copy_to_user and __asm_copy_from_user are actually the same function,
> > > + * they're just provided as two different symbols to C code so sparse doesn't
> > > + * yell about casting between two different address spaces. */
> > > +.global __asm_copy_to_user
> > > +.set __asm_copy_to_user,__asm_copy_tofrom_user
> > > +.global __asm_copy_from_user
> > > +.set __asm_copy_from_user,__asm_copy_tofrom_user
> > > +
> > > +ENTRY(__asm_copy_tofrom_user)
> > 
> > I don't think that the size (as reported by objdump, for example) will
> > be correct or even present for __asm_copy_to_user & __asm_copy_to_user.
> > 
> > What can be done is:
> > 	ENTRY(__asm_copy_to_user)
> > 	ENTRY(__asm_copy_from_user)
> > 
> > 	<function definition>
> > 
> > 	ENDPROC(__asm_copy_to_user)
> > 	ENDPROC(__asm_copy_from_user)
> > 
> Thanks.  Do you mind checking to make sure this works and submitting a patch?

Not at all.
I should have done it already when I sent the previous email.

I tried it and ... the preprocessed asm is as expected:
	.globl __asm_copy_to_user ; .balign 4 ; __asm_copy_to_user:
	.globl __asm_copy_from_user ; .balign 4 ; __asm_copy_from_user:


	 li t6, 0x00040000
	 csrs sstatus, t6
	 ...

But the nm -S returns different sizes for them:
	0000000000000004 000000000000006c T __asm_copy_from_user
	0000000000000002 000000000000006e T __asm_copy_to_user

and the object code is:
	0000000000000000 <__asm_copy_to_user-0x2>:
	   0:   0001                    nop
	
	0000000000000002 <__asm_copy_to_user>:
	   2:   0001                    nop
	
	0000000000000004 <__asm_copy_from_user>:
	   4:   00040fb7                lui     t6,0x40
	   8:   100fa073                csrs    sstatus,t6
	   ...

Why these unnneded nops?
Is this a known problem of my toolchain (I use a plain gcc 7.3 +
binutils 2.29, both configured as riscv64-none-elf)?

If I remove the two ENTRY() and use instead:
	.globl __asm_copy_to_user ; __asm_copy_to_user:
	.globl __asm_copy_from_user ; __asm_copy_from_user:
(IOW, I drop the .balign) then I get the expected result.
But well, this seems unrelated to the double ENTRY.

I can't test it more for now because I've some link errors (which,
I understand are probably solved in the riscv tree of binutils).

I'll send you the patch anyway since, as far as I understand the changes
specific to this copy_to/from_user is OK.

Regards,
-- Luc
