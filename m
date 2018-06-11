Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B4FC0C16ABE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0122086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C8CUy06F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0122086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934568AbeFKTBl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 15:01:41 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33030 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933906AbeFKTBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 15:01:39 -0400
Received: by mail-pl0-f66.google.com with SMTP id n10-v6so12849043plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 12:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5f7yfRDyQ0fcqV7vIas5H4Rx+CaGEJSrNiYcpltsYXo=;
        b=C8CUy06FPIdlXnnaY0cNl3EYlj44UFElJTSsuRbUKfmPO/zsd5NjE+pNZybruINnji
         Jd5+FA7EpYZCRxiu7dcmEJVsoDAnP7gnkCeasnVfzvWKmzIacQYGJabg8bSr/TvezKJ1
         qcwo/h5tDw1gFPVq954RGYHcCX9Np4BWzH0cFJerJJzJlOexpIXrNGgrufqc7lc+4QA5
         rceUzyK3Kpi+iSooqU36OqAytErnIqFqpxh0mUMgPGsBaotR/teAPb88rdHAhoXWndlB
         bbKRLkipaz4Yo+gR4W1gs8nAB8Pw4c/EO6BnYz69rTi5zHAEGqn25sWrn7nlkuuSMNT1
         TUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5f7yfRDyQ0fcqV7vIas5H4Rx+CaGEJSrNiYcpltsYXo=;
        b=N/wTFiSVV2BS8FZJGQXDX0I11GWUxuB4AmqgNT96k/lP8gbgNI9MDudMPqR01Ri++x
         eezjzYYWh8x7Jc+KWynDnCj4cOHF0awvLT6SFtTTd1vNCw4CLbIOf3dLzSTw5hKA15mT
         A/RXv+1TTvjKRoIP3uUgyg79cw5P4RUsYmmcvE+S1pEP+PUiXqnR1133qrIc+lSiS7ja
         DjEraOttDS+C8V8ctCBVB3ATjYdAPdHiT1F+KdBnAy1SjFwuP+e1lUQU4EYPtp9qp1MC
         cpyyCpHgomAhS3LeA1xTZ87gAP2PfciyEXxRqMmVzuaEpA8H5CxEeDWHRNJQkQH6gSbi
         TgEA==
X-Gm-Message-State: APt69E2MSPqccnjEJW2eoZZQW0F/4QWSax+4mWP5Ne8cW0wm7tl2hX77
        VugMT82czBk5jJPAfRJZ1ze77A==
X-Google-Smtp-Source: ADUXVKJD22K0En2ZhoJxjHdDkvz1WW5dRMPiIGFoHjmIBYpL/nlso6E77ltzYtzTlLdP/q74zSb6+g==
X-Received: by 2002:a17:902:5602:: with SMTP id h2-v6mr417121pli.314.1528743698269;
        Mon, 11 Jun 2018 12:01:38 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id y15-v6sm3994037pfm.136.2018.06.11.12.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 12:01:37 -0700 (PDT)
Date:   Mon, 11 Jun 2018 12:01:37 -0700 (PDT)
X-Google-Original-Date: Mon, 11 Jun 2018 12:01:29 PDT (-0700)
Subject:     Re: [PATCH 3/3] riscv: fix __user annotation for __copy_user()
In-Reply-To: <20180609214211.u42vfrddl75ow7bb@ltop.local>
CC:     atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, albert@sifive.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     luc.vanoostenryck@gmail.com
Message-ID: <mhng-b01e0f6b-07fd-4271-a256-c09024675db8@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Jun 2018 14:42:12 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
> On Sat, Jun 09, 2018 at 01:00:08PM -0700, Palmer Dabbelt wrote:
>> On Fri, 08 Jun 2018 17:13:12 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
>> > I tried it and ... the preprocessed asm is as expected:
>> > 	.globl __asm_copy_to_user ; .balign 4 ; __asm_copy_to_user:
>> > 	.globl __asm_copy_from_user ; .balign 4 ; __asm_copy_from_user:
>> >
>> >
>> > 	 li t6, 0x00040000
>> > 	 csrs sstatus, t6
>> > 	 ...
>> >
>> > But the nm -S returns different sizes for them:
>> > 	0000000000000004 000000000000006c T __asm_copy_from_user
>> > 	0000000000000002 000000000000006e T __asm_copy_to_user
>> >
>> > and the object code is:
>> > 	0000000000000000 <__asm_copy_to_user-0x2>:
>> > 	   0:   0001                    nop
>> >
>> > 	0000000000000002 <__asm_copy_to_user>:
>> > 	   2:   0001                    nop
>> >
>> > 	0000000000000004 <__asm_copy_from_user>:
>> > 	   4:   00040fb7                lui     t6,0x40
>> > 	   8:   100fa073                csrs    sstatus,t6
>> > 	   ...
>> >
>> > Why these unnneded nops?
>> > Is this a known problem of my toolchain (I use a plain gcc 7.3 +
>> > binutils 2.29, both configured as riscv64-none-elf)?
>> >
>> > If I remove the two ENTRY() and use instead:
>> > 	.globl __asm_copy_to_user ; __asm_copy_to_user:
>> > 	.globl __asm_copy_from_user ; __asm_copy_from_user:
>> > (IOW, I drop the .balign) then I get the expected result.
>> > But well, this seems unrelated to the double ENTRY.
>> >
>> > I can't test it more for now because I've some link errors (which,
>> > I understand are probably solved in the riscv tree of binutils).
>> >
>> > I'll send you the patch anyway since, as far as I understand the changes
>> > specific to this copy_to/from_user is OK.
>>
>> I think it's probably a bug in binutils-2.29 that should be fixed by
>> 2.30 -- IIRC we had some bugs that looked like this and they got
>> fixed, though it might be just in master (so 2.31).
>
> I've tried binutils-2.30 and riscv-binutils-gdb, both still have
> the problem and master binutils-gdb doesn't compile for me.
> OTOH, everything is fine if I disabled CONFIG_RISCV_ISA_C.

OK, I'll try and figure out what's going on.  We've had a handful of headaches 
trying to get things like '.align 2; .align 2' to actually produce no NOPs for 
the second alignment directive, which is surprisingly complicated due to the 
aggressive linker relaxation we do.

>> Either way it looks innocuous WRT the patch.
>
> Indeed.
> With this, the RISC-V arch should be sparse clean.
> I'll recheck after -rc1.

This will be part of the PR that I tag today, so I anticipate it'll be in.

Thanks!
