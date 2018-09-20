Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF99ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBE72150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBE72150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbeITTCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:02:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10747 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbeITTCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:02:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42GHPc1Tpyz9ttFS;
        Thu, 20 Sep 2018 15:19:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7lTOW4tI1zDP; Thu, 20 Sep 2018 15:19:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42GHPc0z7Bz9ttCB;
        Thu, 20 Sep 2018 15:19:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B05F8B77F;
        Thu, 20 Sep 2018 15:19:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id M-WJmpeYon6p; Thu, 20 Sep 2018 15:19:16 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C5F2F8B867;
        Thu, 20 Sep 2018 15:19:15 +0200 (CEST)
Subject: Re: Checkpatch bad Warning (Re: [PATCH] powerpc/kgdb: add
 kgdb_arch_set/remove_breakpoint())
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <872199441fd43b05fc1c7d049098ef7c0e83f4c5.1537262646.git.christophe.leroy@c-s.fr>
 <2f5f572a-a28c-9d17-844b-9e1961febf64@c-s.fr>
 <595c96f5adcccd7eab9dc95eb48618981af66d3c.camel@perches.com>
 <87worgia60.fsf@concordia.ellerman.id.au>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <f9ad7501-4d07-ddc2-6236-a7eb61283378@c-s.fr>
Date:   Thu, 20 Sep 2018 15:19:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87worgia60.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 20/09/2018 à 15:13, Michael Ellerman a écrit :
> Joe Perches <joe@perches.com> writes:
> 
>> On Tue, 2018-09-18 at 09:33 +0000, Christophe Leroy wrote:
>>> On the below patch, checkpatch reports
>>>
>>> WARNING: struct kgdb_arch should normally be const
>>> #127: FILE: arch/powerpc/kernel/kgdb.c:480:
>>> +struct kgdb_arch arch_kgdb_ops;
>>>
>>> But when I add 'const', I get compilation failure
>>
>> So don't add const.
>>
>> checkpatch is stupid.  You are not.
>>
>> _Always_ take checkpatch bleats with very
>> large grains of salt.
>>
>> Perhaps send a patch to remove kgbd_arch
>> from scripts/const_structs.checkpatch as
>> it seems not ever to be const.
> 
> I think it could/should be const though, it just requires updating all
> arches.
> 

Yes I was thinking about doing it, but first thing is to change the way 
MIPS initialises it:


struct kgdb_arch arch_kgdb_ops;

int kgdb_arch_init(void)
{
	union mips_instruction insn = {
		.r_format = {
			.opcode = spec_op,
			.func	= break_op,
		}
	};
	memcpy(arch_kgdb_ops.gdb_bpt_instr, insn.byte, BREAK_INSTR_SIZE);


Can this be done staticaly ?

Christophe
