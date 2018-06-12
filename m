Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0CA7DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA68C208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JWmqTD6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA68C208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934560AbeFLRMM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:12:12 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43332 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933076AbeFLRMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:12:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so3369741pfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=FoDXdS4ZXvyQY40hdq9fq+uUUOjlxUzbq+i9wGl3Ik8=;
        b=JWmqTD6rSvBUahw7z34cKh3qwgxb69S2GRGm0ABtUM6gEbRzPC/CNJ/fU692eu7lka
         vuOxax0PhY6quuKiickS5Zx35/kAf+0Bl93KkJuLlS3sR+f6R3s/PzwE4wuS7qFPsSnv
         FRU+iuM/uiwZfUZ1V2ZI85ry+1z3jjp49pnHAuNjPF0+sTZbP4ZVuAsKS0jJLldBVmVn
         Mc40JqLhT2HWeS7aW5fd44UGg40T6PSgXD6S2iD7nSou4Juxtqv/0xWEIQpoOfBRgQUP
         MPvjhJrFFUWkKFlgIE4io7FW+MhKj9ez/tBsclTqImDceVh7138Z+GAudNsxmj7l+6JW
         rC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=FoDXdS4ZXvyQY40hdq9fq+uUUOjlxUzbq+i9wGl3Ik8=;
        b=XjglXi24/gfw+qCDm2oNdNNMFeooFak5FpgZLqwfZKhw0K2B63h08ROv1XD27GsT6E
         y/EaBbs/kj9mDDI4ZGA/dzfpht25MRgIhbOdfRd3t8DFse0EKxHOKlBcrM+4LljNf2Yu
         fMXQnvyXRK/RXYTNquhUWmrL0V56iTY8GUJGIzJZ7jp7wtMLTtY+8rLZjz3L/du7AEK2
         bpTFUzf+vvB3RSo3uWONkkH3ZJ6IIWMhZ3NFnCOGrygpaPs7tT6geROQ4Gn/fKvkDTJ8
         xaMeRwiEiAw9+KQiUZ980sFz0I4sCgxwRosXJoi5b5nDX0F8WJZpgUsHAhkkHNdmNlYy
         MmXw==
X-Gm-Message-State: APt69E2n4i0kHFh4JNiQvcm0taEnrjSngPACwJrVtQLyncOcg0+17Cjj
        xinYuztgXqtmVikggBdYZ4WU6A==
X-Google-Smtp-Source: ADUXVKJMgYqVzFTgHJSKOrpuLm8dK12ej0XM/EGG4mtS1xcANdgxC/SM4p8f6AeFFmh1zpt+C3gcjA==
X-Received: by 2002:a65:51cb:: with SMTP id i11-v6mr1079340pgq.320.1528823529717;
        Tue, 12 Jun 2018 10:12:09 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id a14-v6sm686556pgv.4.2018.06.12.10.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 10:12:08 -0700 (PDT)
Date:   Tue, 12 Jun 2018 10:12:08 -0700 (PDT)
X-Google-Original-Date: Tue, 12 Jun 2018 09:39:03 PDT (-0700)
Subject:     Re: [PATCH 3/3] riscv: fix __user annotation for __copy_user()
In-Reply-To: <20180612030006.h7a4mag76aqqifod@ltop.local>
CC:     atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, albert@sifive.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     luc.vanoostenryck@gmail.com
Message-ID: <mhng-92398134-2db9-4a35-b432-0ab444418e1b@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018 20:00:08 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
> On Mon, Jun 11, 2018 at 12:01:37PM -0700, Palmer Dabbelt wrote:
>> On Sat, 09 Jun 2018 14:42:12 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
>> > On Sat, Jun 09, 2018 at 01:00:08PM -0700, Palmer Dabbelt wrote:
>> > > On Fri, 08 Jun 2018 17:13:12 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
>> > > > I tried it and ... the preprocessed asm is as expected:
>> > > > 	.globl __asm_copy_to_user ; .balign 4 ; __asm_copy_to_user:
>> > > > 	.globl __asm_copy_from_user ; .balign 4 ; __asm_copy_from_user:
>> > > >
>> > > >
>> > > > 	 li t6, 0x00040000
>> > > > 	 csrs sstatus, t6
>> > > > 	 ...
>> > > >
>> > > > But the nm -S returns different sizes for them:
>> > > > 	0000000000000004 000000000000006c T __asm_copy_from_user
>> > > > 	0000000000000002 000000000000006e T __asm_copy_to_user
>> > > >
>> > > > and the object code is:
>> > > > 	0000000000000000 <__asm_copy_to_user-0x2>:
>> > > > 	   0:   0001                    nop
>> > > >
>> > > > 	0000000000000002 <__asm_copy_to_user>:
>> > > > 	   2:   0001                    nop
>> > > >
>> > > > 	0000000000000004 <__asm_copy_from_user>:
>> > > > 	   4:   00040fb7                lui     t6,0x40
>> > > > 	   8:   100fa073                csrs    sstatus,t6
>> > > > 	   ...
>> > > >
>> > > > Why these unnneded nops?
>> > > > Is this a known problem of my toolchain (I use a plain gcc 7.3 +
>> > > > binutils 2.29, both configured as riscv64-none-elf)?
>> > > >
>> > > > If I remove the two ENTRY() and use instead:
>> > > > 	.globl __asm_copy_to_user ; __asm_copy_to_user:
>> > > > 	.globl __asm_copy_from_user ; __asm_copy_from_user:
>> > > > (IOW, I drop the .balign) then I get the expected result.
>> > > > But well, this seems unrelated to the double ENTRY.
>> > > >
>> > > > I can't test it more for now because I've some link errors (which,
>> > > > I understand are probably solved in the riscv tree of binutils).
>> > > >
>> > > > I'll send you the patch anyway since, as far as I understand the changes
>> > > > specific to this copy_to/from_user is OK.
>> > >
>> > > I think it's probably a bug in binutils-2.29 that should be fixed by
>> > > 2.30 -- IIRC we had some bugs that looked like this and they got
>> > > fixed, though it might be just in master (so 2.31).
>> >
>> > I've tried binutils-2.30 and riscv-binutils-gdb, both still have
>> > the problem and master binutils-gdb doesn't compile for me.
>> > OTOH, everything is fine if I disabled CONFIG_RISCV_ISA_C.
>>
>> OK, I'll try and figure out what's going on.  We've had a handful of
>> headaches trying to get things like '.align 2; .align 2' to actually produce
>> no NOPs for the second alignment directive, which is surprisingly
>> complicated due to the aggressive linker relaxation we do.
>
> OK. I imagine indeed but note that no linker is involved here so,
> if the problem is still present, it must already be in the assembler.

Ah, OK -- in that case then it's just not a bug.  In RISC-V land we handle 
alignment as part of relaxation in the linker, so if you're looking at the 
output of the assembler then you'll always see a bunch of NOPs for every 
alignment directive.  If you 'objdump -dr' you should be able to see the 
relocations that get emitted, there should be a R_RISCV_ALIGN that points to 
the run of NOPs.

>> > With this, the RISC-V arch should be sparse clean.
>> > I'll recheck after -rc1.
>>
>> This will be part of the PR that I tag today, so I anticipate it'll be in.
>
> Cool!
>
> -- Luc
