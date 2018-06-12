Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AA805C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5447D208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHuw7Oi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5447D208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935239AbeFLDAN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:00:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55104 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935168AbeFLDAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:00:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id o13-v6so17877778wmf.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 20:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B6RG5MLssEBwvKEoQdT4tAhZTmJh1AzsJc4KXAlHCbQ=;
        b=qHuw7Oi/mlP3SV+oRVVwHGLa6FRKvpoUYI8RW9hMJpmbc1JDK5Ie6NfNzdfOrYgj5y
         uTHXsosgQw4J1dYFgqErz6uzJM8bNHl6OJWMEThdggZuFySgz+a7a4VWJDyi0lswbgBN
         X6Uk9EUjyuGGrkEP5qAzIdqgc5UNz1sKYnIwEFRWu48SAyMClCnw2d/f8F80o02lsIvD
         U2kTAYqr0LL4G71kbajhBT8ZnKHrS1322hf6HcWO7MdOHMh6BjunwS0+tLIQM118GtGS
         X0rLd6wTzLMDOMtyvqDXNcJrnzyMzUu/D8cC/PSzk+IQWToqvaezLBfAD9OFLLCP1NdN
         IwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B6RG5MLssEBwvKEoQdT4tAhZTmJh1AzsJc4KXAlHCbQ=;
        b=SaqJx7rWM6177Stcb6StiZBVX54qvVRChwxh96D0mvHn6YNo4gGQiaORRTn4mrIwhh
         QeAGQL+xgI0lJ3a7toAenIIH+L2JWCNxkH9fpKvok1fWIrLmDYDDqR05Ff6Bw9uNmvGh
         6op8bU/qZ9zhWxIbYU9A3iDX1F/hZJjNg51VhoqxdQ93BHHp9MbS7WqEH/dE5RTNFl6s
         eQws9uAMoOM0n3EI1TGFQXuD8OijOG0my6AduGpL5gIIXDgbhfnRZtNfiLGdY6nJl2hs
         HEVZuuwgR2+eqB5FfvKk/V3PMOlo4CaXFol/VYkJyQ3XfnbgOCWHzlnvuHbBm989iAYi
         xWqA==
X-Gm-Message-State: APt69E1g7LxdFmw195oSF8T7lTO2zkB+rhG2yy0MvR9YTnZ02JBWuBSU
        aRqGDRY0qzMkNTkPwHdev14=
X-Google-Smtp-Source: ADUXVKJHDfsKPlBkECjuE4Ce1VUM6Nq3PGYK5U5SYaOA2O6vBFVnp57Eg387STkBMW88tZyngN0auA==
X-Received: by 2002:aa7:c50f:: with SMTP id o15-v6mr1634192edq.21.1528772409925;
        Mon, 11 Jun 2018 20:00:09 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40a0:8d00:a561:f7:a86d:7de9])
        by smtp.gmail.com with ESMTPSA id c13-v6sm15570edr.78.2018.06.11.20.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:00:09 -0700 (PDT)
Date:   Tue, 12 Jun 2018 05:00:08 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, albert@sifive.com
Subject: Re: [PATCH 3/3] riscv: fix __user annotation for __copy_user()
Message-ID: <20180612030006.h7a4mag76aqqifod@ltop.local>
References: <20180609214211.u42vfrddl75ow7bb@ltop.local>
 <mhng-b01e0f6b-07fd-4271-a256-c09024675db8@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-b01e0f6b-07fd-4271-a256-c09024675db8@palmer-si-x1c4>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 12:01:37PM -0700, Palmer Dabbelt wrote:
> On Sat, 09 Jun 2018 14:42:12 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
> > On Sat, Jun 09, 2018 at 01:00:08PM -0700, Palmer Dabbelt wrote:
> > > On Fri, 08 Jun 2018 17:13:12 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
> > > > I tried it and ... the preprocessed asm is as expected:
> > > > 	.globl __asm_copy_to_user ; .balign 4 ; __asm_copy_to_user:
> > > > 	.globl __asm_copy_from_user ; .balign 4 ; __asm_copy_from_user:
> > > >
> > > >
> > > > 	 li t6, 0x00040000
> > > > 	 csrs sstatus, t6
> > > > 	 ...
> > > >
> > > > But the nm -S returns different sizes for them:
> > > > 	0000000000000004 000000000000006c T __asm_copy_from_user
> > > > 	0000000000000002 000000000000006e T __asm_copy_to_user
> > > >
> > > > and the object code is:
> > > > 	0000000000000000 <__asm_copy_to_user-0x2>:
> > > > 	   0:   0001                    nop
> > > >
> > > > 	0000000000000002 <__asm_copy_to_user>:
> > > > 	   2:   0001                    nop
> > > >
> > > > 	0000000000000004 <__asm_copy_from_user>:
> > > > 	   4:   00040fb7                lui     t6,0x40
> > > > 	   8:   100fa073                csrs    sstatus,t6
> > > > 	   ...
> > > >
> > > > Why these unnneded nops?
> > > > Is this a known problem of my toolchain (I use a plain gcc 7.3 +
> > > > binutils 2.29, both configured as riscv64-none-elf)?
> > > >
> > > > If I remove the two ENTRY() and use instead:
> > > > 	.globl __asm_copy_to_user ; __asm_copy_to_user:
> > > > 	.globl __asm_copy_from_user ; __asm_copy_from_user:
> > > > (IOW, I drop the .balign) then I get the expected result.
> > > > But well, this seems unrelated to the double ENTRY.
> > > >
> > > > I can't test it more for now because I've some link errors (which,
> > > > I understand are probably solved in the riscv tree of binutils).
> > > >
> > > > I'll send you the patch anyway since, as far as I understand the changes
> > > > specific to this copy_to/from_user is OK.
> > > 
> > > I think it's probably a bug in binutils-2.29 that should be fixed by
> > > 2.30 -- IIRC we had some bugs that looked like this and they got
> > > fixed, though it might be just in master (so 2.31).
> > 
> > I've tried binutils-2.30 and riscv-binutils-gdb, both still have
> > the problem and master binutils-gdb doesn't compile for me.
> > OTOH, everything is fine if I disabled CONFIG_RISCV_ISA_C.
> 
> OK, I'll try and figure out what's going on.  We've had a handful of
> headaches trying to get things like '.align 2; .align 2' to actually produce
> no NOPs for the second alignment directive, which is surprisingly
> complicated due to the aggressive linker relaxation we do.

OK. I imagine indeed but note that no linker is involved here so,
if the problem is still present, it must already be in the assembler.
 
> > With this, the RISC-V arch should be sparse clean.
> > I'll recheck after -rc1.
> 
> This will be part of the PR that I tag today, so I anticipate it'll be in.

Cool! 

-- Luc
