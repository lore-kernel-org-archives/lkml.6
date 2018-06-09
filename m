Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 61LxJM4xHFu+CQAAmS7hNA
	; Sat, 09 Jun 2018 20:00:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7B659608C1; Sat,  9 Jun 2018 20:00:14 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H42bA/cg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DB537600D0;
	Sat,  9 Jun 2018 20:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB537600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932950AbeFIUAL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 16:00:11 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36465 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932157AbeFIUAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 16:00:09 -0400
Received: by mail-pl0-f65.google.com with SMTP id a7-v6so7606975plp.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=DiYFxDvpqRVFiFokfbm4aZzqVbaUgwSqjfDGyraqZ3k=;
        b=H42bA/cgL91pqYueLRb5vTdn9MA2lRbSGjpJ7nhiKmnMwUlE33HF5w1bhlITu4qoSe
         Y0IabMEZI9rn3h/Vykd1j00b9E1wi6I/5D/UBNJnlIucSZkZwfkbGATor3Qj7pIbPvIF
         n1M00RqmouCEGgMht74V9DH0Gf62p/Wuccj2/Q0LWgpTlurWkyNYospxAsMfJP37TUc7
         QUfcoK65mkwja6+ZIGOHLW6wwJMbXeplJjrQL91lFV++TBnC3N7q3x9uNZRBmfaVWw0x
         nWo5nA6E1Pto2nuTct88y0iIIdjO1ubxUsCQv4NJi/tVNOmqgngOPcsuAvhVs8gJPPBr
         ZZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=DiYFxDvpqRVFiFokfbm4aZzqVbaUgwSqjfDGyraqZ3k=;
        b=Pp3728k9HXdV1zu8ESbpwM/ZvfgxB+87d8n13jyw2R0JpxYkKhnbCTMpveiOcTraGs
         BaqM3HE2eeOov46bzn4NoWAB/QtGM+kyJpow7a4P1YtNtC4+gUu1PgYOAErHGpyHgYKh
         cnIQgzfuV03FL2eS5MCCW6QPJzOmo+6tUvIgUyZnwojHFiSCFNjgVoXyj7QzVU2xNGaS
         ukWZuvOcEGZs+DZo4rV7EZykVcElAMTefbOGIlP+O9ynfiho0W+WgJ97R1UIJnjhQy8X
         5hE/MYD50w+B18o5d6VqPuQcXBi6j+iC6WwQjWgg4oHN7PqHnH/BUImVHPyKekbahYx1
         k48g==
X-Gm-Message-State: APt69E2LY4eAYSe+EGwelWaGADggl8C4qy3N2ykkZchgqTAz5dk0Fh5l
        K0KpgATTFcWKDjGw9Ixjn2gcKA==
X-Google-Smtp-Source: ADUXVKJnEDZJu3R/F7gXtmt8p/rCjehrKTdO+dt2MX9i5nBJXf9bVGBTjcNGa/it/fJdd6AstOvBgw==
X-Received: by 2002:a17:902:543:: with SMTP id 61-v6mr12004792plf.47.1528574409277;
        Sat, 09 Jun 2018 13:00:09 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id e17-v6sm34213003pfd.15.2018.06.09.13.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 13:00:08 -0700 (PDT)
Date: Sat, 09 Jun 2018 13:00:08 -0700 (PDT)
X-Google-Original-Date: Sat, 09 Jun 2018 12:33:18 PDT (-0700)
Subject: Re: [PATCH 3/3] riscv: fix __user annotation for __copy_user()
In-Reply-To: <20180609001310.jxzcqtdacu4uiz6b@ltop.local>
CC: atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, albert@sifive.com
From: Palmer Dabbelt <palmer@sifive.com>
To: luc.vanoostenryck@gmail.com
Message-ID: <mhng-34378b5f-fa64-4886-b454-a2cb319d6abb@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jun 2018 17:13:12 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
> On Fri, Jun 08, 2018 at 03:33:36PM -0700, Palmer Dabbelt wrote:
>> On Thu, 07 Jun 2018 09:51:33 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
>> > On Thu, Jun 07, 2018 at 09:30:19AM -0700, Palmer Dabbelt wrote:
>> > > diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
>> > > index 58fb2877c865..bd51e47ebd44 100644
>> > > --- a/arch/riscv/lib/uaccess.S
>> > > +++ b/arch/riscv/lib/uaccess.S
>> > > @@ -13,7 +13,15 @@ _epc:
>> > > 	.previous
>> > > 	.endm
>> > >
>> > > -ENTRY(__copy_user)
>> > > +/* __asm_copy_to_user and __asm_copy_from_user are actually the same function,
>> > > + * they're just provided as two different symbols to C code so sparse doesn't
>> > > + * yell about casting between two different address spaces. */
>> > > +.global __asm_copy_to_user
>> > > +.set __asm_copy_to_user,__asm_copy_tofrom_user
>> > > +.global __asm_copy_from_user
>> > > +.set __asm_copy_from_user,__asm_copy_tofrom_user
>> > > +
>> > > +ENTRY(__asm_copy_tofrom_user)
>> >
>> > I don't think that the size (as reported by objdump, for example) will
>> > be correct or even present for __asm_copy_to_user & __asm_copy_to_user.
>> >
>> > What can be done is:
>> > 	ENTRY(__asm_copy_to_user)
>> > 	ENTRY(__asm_copy_from_user)
>> >
>> > 	<function definition>
>> >
>> > 	ENDPROC(__asm_copy_to_user)
>> > 	ENDPROC(__asm_copy_from_user)
>> >
>> Thanks.  Do you mind checking to make sure this works and submitting a patch?
>
> Not at all.
> I should have done it already when I sent the previous email.
>
> I tried it and ... the preprocessed asm is as expected:
> 	.globl __asm_copy_to_user ; .balign 4 ; __asm_copy_to_user:
> 	.globl __asm_copy_from_user ; .balign 4 ; __asm_copy_from_user:
>
>
> 	 li t6, 0x00040000
> 	 csrs sstatus, t6
> 	 ...
>
> But the nm -S returns different sizes for them:
> 	0000000000000004 000000000000006c T __asm_copy_from_user
> 	0000000000000002 000000000000006e T __asm_copy_to_user
>
> and the object code is:
> 	0000000000000000 <__asm_copy_to_user-0x2>:
> 	   0:   0001                    nop
>
> 	0000000000000002 <__asm_copy_to_user>:
> 	   2:   0001                    nop
>
> 	0000000000000004 <__asm_copy_from_user>:
> 	   4:   00040fb7                lui     t6,0x40
> 	   8:   100fa073                csrs    sstatus,t6
> 	   ...
>
> Why these unnneded nops?
> Is this a known problem of my toolchain (I use a plain gcc 7.3 +
> binutils 2.29, both configured as riscv64-none-elf)?
>
> If I remove the two ENTRY() and use instead:
> 	.globl __asm_copy_to_user ; __asm_copy_to_user:
> 	.globl __asm_copy_from_user ; __asm_copy_from_user:
> (IOW, I drop the .balign) then I get the expected result.
> But well, this seems unrelated to the double ENTRY.
>
> I can't test it more for now because I've some link errors (which,
> I understand are probably solved in the riscv tree of binutils).
>
> I'll send you the patch anyway since, as far as I understand the changes
> specific to this copy_to/from_user is OK.

I think it's probably a bug in binutils-2.29 that should be fixed by 2.30 -- 
IIRC we had some bugs that looked like this and they got fixed, though it might 
be just in master (so 2.31).

Either way it looks innocuous WRT the patch.

Thanks!
