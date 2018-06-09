Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dTGsB55IHFssAgAAmS7hNA
	; Sat, 09 Jun 2018 21:42:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 16447608C1; Sat,  9 Jun 2018 21:42:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oahs4CYO"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7CC186032D;
	Sat,  9 Jun 2018 21:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CC186032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbeFIVmQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 17:42:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35397 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753265AbeFIVmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 17:42:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id j15-v6so9749324wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mdbMqDfyEVKYLBpsU48VuzIRvNwxI4c+vkos9lY9dns=;
        b=Oahs4CYOyBjcE+gUNusu/WWfNI8zcOeigH4gcPnOqjqKX+ztgTUjkyR5dB+X8GZpLJ
         wQRDrJsYe0S12RsvhyqgSlS+5GMy919MiGlj5Cb6HRriAcqyjYuU0efQDAWnBUMZzM3N
         9zE8mkM1pCDFQ8Wm/OHlltPoNrGf2fC52oTkkIQjOMheGg6plWQk8CyS8DK8BUOei30K
         P+Tt3p4iLwTBEx4RvlqK9m8Ni8HU8G1526nLgqY8R23dpl5vIYouEfpKISGLZzk+FIJs
         sy/4tOGai5S8VFgm4udjainCxumxMIao4NU67dsUZAfeyqm9ScTZwK8UhoX0+BQkeFUF
         IMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mdbMqDfyEVKYLBpsU48VuzIRvNwxI4c+vkos9lY9dns=;
        b=rPmPiUotINbqlm1EEBqMIqfr1kI45GfaEiYSdu7Kw01snSKH77U/GcKQvIhLYU5gqX
         q/8K0zVp943YUfW2WAthszthNj6cZpEpao/3yekEV7ge66MDlaYLuDlKRGlF4VRCvm2T
         WMU+wbz/O3k59ylo9oKWXbKkPq9GWiE40VSAZNNIXw6eUBnOfEIbl7K8Fg/DC8ATgoY4
         kyqnp53ioL49K+awN38H0aweAYIQr2aCWrPfe9DmPUgXB30DwwRWyIEbvMcHet4OUHGG
         Pr3JQY9jElbTD5ehTsN9riAL1MqQViguwauN0nY5v+Z/kCjoxLAnhX8uINX8bmMKVjQ8
         iNFA==
X-Gm-Message-State: APt69E236vlHV5m9dFQjyZWBXGt278VCsmZggK8HHEJxfiuGkuUepURj
        6/h9yHBBe5f5CPYm+SIPfEykhg5D
X-Google-Smtp-Source: ADUXVKJHQbrLubf/3PZ+owEfYitQcUsasJattAsppB7AG843M684h24GUv3R9VLQU4USswDC08fUVw==
X-Received: by 2002:a50:864b:: with SMTP id 11-v6mr12256719edt.229.1528580534514;
        Sat, 09 Jun 2018 14:42:14 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4108:7200:a90a:9fe:dec5:615])
        by smtp.gmail.com with ESMTPSA id m10-v6sm10243613edp.57.2018.06.09.14.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 14:42:13 -0700 (PDT)
Date: Sat, 9 Jun 2018 23:42:12 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, albert@sifive.com
Subject: Re: [PATCH 3/3] riscv: fix __user annotation for __copy_user()
Message-ID: <20180609214211.u42vfrddl75ow7bb@ltop.local>
References: <20180609001310.jxzcqtdacu4uiz6b@ltop.local>
 <mhng-34378b5f-fa64-4886-b454-a2cb319d6abb@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-34378b5f-fa64-4886-b454-a2cb319d6abb@palmer-si-x1c4>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 01:00:08PM -0700, Palmer Dabbelt wrote:
> On Fri, 08 Jun 2018 17:13:12 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
> > I tried it and ... the preprocessed asm is as expected:
> > 	.globl __asm_copy_to_user ; .balign 4 ; __asm_copy_to_user:
> > 	.globl __asm_copy_from_user ; .balign 4 ; __asm_copy_from_user:
> > 
> > 
> > 	 li t6, 0x00040000
> > 	 csrs sstatus, t6
> > 	 ...
> > 
> > But the nm -S returns different sizes for them:
> > 	0000000000000004 000000000000006c T __asm_copy_from_user
> > 	0000000000000002 000000000000006e T __asm_copy_to_user
> > 
> > and the object code is:
> > 	0000000000000000 <__asm_copy_to_user-0x2>:
> > 	   0:   0001                    nop
> > 
> > 	0000000000000002 <__asm_copy_to_user>:
> > 	   2:   0001                    nop
> > 
> > 	0000000000000004 <__asm_copy_from_user>:
> > 	   4:   00040fb7                lui     t6,0x40
> > 	   8:   100fa073                csrs    sstatus,t6
> > 	   ...
> > 
> > Why these unnneded nops?
> > Is this a known problem of my toolchain (I use a plain gcc 7.3 +
> > binutils 2.29, both configured as riscv64-none-elf)?
> > 
> > If I remove the two ENTRY() and use instead:
> > 	.globl __asm_copy_to_user ; __asm_copy_to_user:
> > 	.globl __asm_copy_from_user ; __asm_copy_from_user:
> > (IOW, I drop the .balign) then I get the expected result.
> > But well, this seems unrelated to the double ENTRY.
> > 
> > I can't test it more for now because I've some link errors (which,
> > I understand are probably solved in the riscv tree of binutils).
> > 
> > I'll send you the patch anyway since, as far as I understand the changes
> > specific to this copy_to/from_user is OK.
> 
> I think it's probably a bug in binutils-2.29 that should be fixed by
> 2.30 -- IIRC we had some bugs that looked like this and they got
> fixed, though it might be just in master (so 2.31).

I've tried binutils-2.30 and riscv-binutils-gdb, both still have
the problem and master binutils-gdb doesn't compile for me.
OTOH, everything is fine if I disabled CONFIG_RISCV_ISA_C.

> Either way it looks innocuous WRT the patch.

Indeed.
With this, the RISC-V arch should be sparse clean.
I'll recheck after -rc1.

Cheers,
-- Luc
