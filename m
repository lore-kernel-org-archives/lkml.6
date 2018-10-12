Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB5DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3262075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGZl1e7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3262075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeJLQea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:34:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42983 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbeJLQea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:34:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id c8-v6so5611638plo.9;
        Fri, 12 Oct 2018 02:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ecgA7/dAk8I/lT6yAtzH8MiQolUoS+Cs6H4mX4/y0c4=;
        b=VGZl1e7ssXoNTXiyLf9O7o2pjOWl1ref5rz0tNaHwgptwI8wdS5k9a6azmFG1WS6kT
         lc5etBOx/b+IeP0tXQ4SfK7FW9fZU7OrlbAZEDyNpS9+CBEqMBou0yY8qgKF0BBihPGN
         vCtuCs8KmMdJZ7YCwlekbHeq9t0FCrXHTp6qgwN6qn+iUCB5OfXebjKI+ZwlWhL6h7ya
         u248s7B9H2r/rL2Oqp67C2lxsqrVQqoEgxCLmBqkKA/61KOdCkdz7TR5iq0l+DPFen9U
         d+bFe2luB4xOt2nCCR2oEqIGHbXY/YHdRxIlOiOyZMHoKvZIQMKj05HD18Imj3AIv/3y
         YBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ecgA7/dAk8I/lT6yAtzH8MiQolUoS+Cs6H4mX4/y0c4=;
        b=tz/IOrwv+pPDgiD1vz6u9mqVtpmVPcui3ArKRsKtqNeRUjjo0CJzVH98HxXR7/03M5
         IkqAJBV0gwPsdT8ScNBt7dGgHJsi78vQt0kAtx56BQYrOslektUUdX7UZJTJzd9Odktx
         WP5dXEG3BTGE/8qnkDGoS1/Ttltxysa826u37JKBOsSpmYU9zLeCvfVtLC/3lsuIrPd3
         4+NhYvS0FLVZIsADHNkTSb7WzCEeIkw4eEBop7X3e8meG7zu67K89nOpK9IhGtD3xpi9
         KTd5Qj4ObI7U6x3UZ9py0qaosznV62dDrIL+XLQtBM6ZvG96RUxCXhaDCiH+HWi57IP4
         /BpQ==
X-Gm-Message-State: ABuFfoi0xsMOVMvHWk7vv7LZxJzmr8zXvKGL7KjCkTyWSF9jEI/G+fjO
        efjjrkLUn0Efp6g4re9Yxa0=
X-Google-Smtp-Source: ACcGV62bw9LaI+k0OBk6BmyOly5m0fcsQcuhJZQ1z5+y13vIse24HQsPQd1PY0yXFuEywW/WQXph6w==
X-Received: by 2002:a17:902:34a:: with SMTP id 68-v6mr5033657pld.39.1539334983845;
        Fri, 12 Oct 2018 02:03:03 -0700 (PDT)
Received: from [192.168.0.123] ([106.51.21.108])
        by smtp.gmail.com with ESMTPSA id b81-v6sm1745584pfm.96.2018.10.12.02.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 02:03:03 -0700 (PDT)
From:   "Aneesh Kumar K.V" <aneeshkumar.opensource@gmail.com>
X-Google-Original-From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [BUG][linux-next][ppc] kernel panic - not syncing:
 stack-protector: Kernel stack is corrupted in: __schedule+0x978/0xa80
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     sachinp <sachinp@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        npiggin <npiggin@gmail.com>,
        linux-next <linux-next@vger.kernel.org>,
        manvanth <manvanth@linux.vnet.ibm.com>
References: <1539330331.17569.32.camel@abdul.in.ibm.com>
 <1539330499.17569.33.camel@abdul.in.ibm.com>
 <eef38553-779a-c7f5-500f-145dbf4b6a49@c-s.fr>
Message-ID: <da8634b4-77ae-90e3-b6b4-fa1284ed8d85@linux.ibm.com>
Date:   Fri, 12 Oct 2018 14:32:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <eef38553-779a-c7f5-500f-145dbf4b6a49@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/18 1:38 PM, Christophe LEROY wrote:
> 
> 
> Le 12/10/2018 à 09:48, Abdul Haleem a écrit :
>> On Fri, 2018-10-12 at 13:15 +0530, Abdul Haleem wrote:
>>> Greeting's
>>>
>>> Today's linux-next fails to boot on powerpc bare-metal with this error
>>>
>>> POWER8 performance monitor hardware support registered
>>> rcu: Hierarchical SRCU implementation.
>>> smp: Bringing up secondary CPUs ...
>>> Kernel panic - not syncing: stack-protector: Kernel stack is 
>>> corrupted in: __schedule+0x978/0xa80
>>> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 
>>> 4.19.0-rc7-next-20181010-autotest-autotest #1
>>> Call Trace:
>>> [c000001fed5b3bf0] [c000000000a0ef3c] dump_stack+0xb0/0xf4 (unreliable)
>>> [c000001fed5b3c30] [c0000000000f9d68] panic+0x140/0x308
>>> [c000001fed5b3cc0] [c0000000000f9844] __stack_chk_fail+0x24/0x30
>>> [c000001fed5b3d20] [c000000000a2c3a8] __schedule+0x978/0xa80
>>> [c000001fed5b3e00] [c000000000a2c9b4] schedule_idle+0x34/0x60
>>> [c000001fed5b3e30] [c00000000013d344] do_idle+0x224/0x3d0
>>> [c000001fed5b3ec0] [c00000000013d6e0] cpu_startup_entry+0x30/0x50
>>> [c000001fed5b3ef0] [c000000000047f34] start_secondary+0x4d4/0x520
>>> [c000001fed5b3f90] [c00000000000b370] start_secondary_prolog+0x10/0x14
>>> Rebooting in 10 seconds..
>>>
>>> Machine: Power 8 bare-metal
>>> kernel version: 4.19.0-rc7-next-20181010
>>> gcc version: 4.8.5 20150623
>>> config attach
>>
>> Attaching the kernel config file
>>
> 
> # Linux/powerpc 4.11.0-rc4 Kernel Configuration
> 
> This is not the correct config file. Can you send the .config ?
> 
> Christophe

modified   kernel/sched/idle.c
@@ -352,7 +352,6 @@ void cpu_startup_entry(enum cpuhp_state state)
  	 * make this generic (ARM and SH have never invoked the canary
  	 * init for the non boot CPUs!). Will be fixed in 3.11
  	 */
-#ifdef CONFIG_X86
  	/*
  	 * If we're the non-boot CPU, nothing set the stack canary up
  	 * for us. The boot CPU already has it initialized but no harm
@@ -361,7 +360,6 @@ void cpu_startup_entry(enum cpuhp_state state)
  	 * canaries already on the stack wont ever trigger).
  	 */
  	boot_init_stack_canary();
-#endif
  	arch_cpu_idle_prepare();
  	cpuhp_online_idle(state);
  	while (1)


This fixes it for me. But we may have to look at the other arch details 
mentioned there.

-aneesh
