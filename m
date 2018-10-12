Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C901DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7074020835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7074020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeJLPjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:39:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:14278 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbeJLPjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:39:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42WgT03lzmz9ttwR;
        Fri, 12 Oct 2018 10:08:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ntjDzcRtUXKi; Fri, 12 Oct 2018 10:08:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42WgT03GRfz9ttwF;
        Fri, 12 Oct 2018 10:08:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E15A98B8BE;
        Fri, 12 Oct 2018 10:08:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pnEtCV9G6kCV; Fri, 12 Oct 2018 10:08:39 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 77A5E8B8BF;
        Fri, 12 Oct 2018 10:08:39 +0200 (CEST)
Subject: Re: [BUG][linux-next][ppc] kernel panic - not syncing:
 stack-protector: Kernel stack is corrupted in: __schedule+0x978/0xa80
To:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     sachinp <sachinp@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        npiggin <npiggin@gmail.com>,
        linux-next <linux-next@vger.kernel.org>,
        manvanth <manvanth@linux.vnet.ibm.com>
References: <1539330331.17569.32.camel@abdul.in.ibm.com>
 <1539330499.17569.33.camel@abdul.in.ibm.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <eef38553-779a-c7f5-500f-145dbf4b6a49@c-s.fr>
Date:   Fri, 12 Oct 2018 10:08:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539330499.17569.33.camel@abdul.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/10/2018 à 09:48, Abdul Haleem a écrit :
> On Fri, 2018-10-12 at 13:15 +0530, Abdul Haleem wrote:
>> Greeting's
>>
>> Today's linux-next fails to boot on powerpc bare-metal with this error
>>
>> POWER8 performance monitor hardware support registered
>> rcu: Hierarchical SRCU implementation.
>> smp: Bringing up secondary CPUs ...
>> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: __schedule+0x978/0xa80
>> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc7-next-20181010-autotest-autotest #1
>> Call Trace:
>> [c000001fed5b3bf0] [c000000000a0ef3c] dump_stack+0xb0/0xf4 (unreliable)
>> [c000001fed5b3c30] [c0000000000f9d68] panic+0x140/0x308
>> [c000001fed5b3cc0] [c0000000000f9844] __stack_chk_fail+0x24/0x30
>> [c000001fed5b3d20] [c000000000a2c3a8] __schedule+0x978/0xa80
>> [c000001fed5b3e00] [c000000000a2c9b4] schedule_idle+0x34/0x60
>> [c000001fed5b3e30] [c00000000013d344] do_idle+0x224/0x3d0
>> [c000001fed5b3ec0] [c00000000013d6e0] cpu_startup_entry+0x30/0x50
>> [c000001fed5b3ef0] [c000000000047f34] start_secondary+0x4d4/0x520
>> [c000001fed5b3f90] [c00000000000b370] start_secondary_prolog+0x10/0x14
>> Rebooting in 10 seconds..
>>
>> Machine: Power 8 bare-metal
>> kernel version: 4.19.0-rc7-next-20181010
>> gcc version: 4.8.5 20150623
>> config attach
> 
> Attaching the kernel config file
> 

# Linux/powerpc 4.11.0-rc4 Kernel Configuration

This is not the correct config file. Can you send the .config ?

Christophe
