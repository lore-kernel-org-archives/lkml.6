Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B6CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B62221502
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="O3CQwzmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B62221502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeHOVPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:15:35 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:39188 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbeHOVPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=VsuITbvS6MM7hRj1ZoGSFjrSukJtGVH7UBI5LkD+WVI=;
        b=O3CQwzmGn/g8h+3dcxwSqWunbrTvAOTJ6fom9CQr6RuyGJbvwNbJV6VJREIihCrDlCrUNPolwvEe9SX6wtbGX02qXTxc1MraLCLKy9yJRfRLD/z4wFjHEerP1X5QC8Zl/u0iUOwsHGsSyI9vDyZGo6oLr6akSRFndZEkHMQDdkM=;
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
To:     Sven Joachim <svenjoac@gmx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180814171520.883143803@linuxfoundation.org>
 <6272e062-6cfc-0669-bebf-ebb039da051a@dd-wrt.com>
 <87k1orms9i.fsf@turtle.gmx.de>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <e675976b-c23d-5bee-0583-cf241033d02f@dd-wrt.com>
Date:   Wed, 15 Aug 2018 20:22:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87k1orms9i.fsf@turtle.gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [79.251.189.74] (helo=[10.88.193.131])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1fq0R0-0006vm-Mm; Wed, 15 Aug 2018 20:22:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 15.08.2018 um 19:52 schrieb Sven Joachim:
> On 2018-08-15 19:01 +0200, Sebastian Gottschall wrote:
>
>> nother issue seen on xscale and as it affects all non SMP configured kernels
>>
>>
>> kernel/cpu.c: In function 'boot_cpu_hotplug_init':
>> kernel/cpu.c:2204:28: error: 'struct cpuhp_cpu_state' has no member
>> named 'booted_once'
>>    this_cpu_write(cpuhp_state.booted_once, true);
> I got a different error in 4.9.120 with CONFIG_SMP unset:

that doesnt make it better :-) i havend checked x86 without smp, just 
xscale. your error doesnt affect xscale which is a arm platform. all 
these issues seem to affect 4.14 as well

btw. i found another compile error with x86 :-)


arch/x86/kernel/apic/apic.c:2050:6: error: redefinition of 
'apic_id_is_primary_thread'
  bool apic_id_is_primary_thread(unsigned int apicid)
       ^~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ./arch/x86/include/asm/smp.h:12,
                  from ./arch/x86/include/asm/tlbflush.h:10,
                  from ./arch/x86/include/asm/highmem.h:26,
                  from ./include/linux/highmem.h:34,
                  from ./include/linux/pagemap.h:10,
                  from ./arch/x86/include/asm/pgalloc.h:6,
                  from arch/x86/kernel/apic/apic.c:43:
./arch/x86/include/asm/apic.h:641:20: note: previous definition of 
'apic_id_is_primary_thread' was here
  static inline bool apic_id_is_primary_thread(unsigned int id) { return 
false; }



Sebastian

>
> ,----
> | CC      drivers/rtc/rtc-cmos.o
> | In file included from drivers/rtc/rtc-cmos.c:45:0:
> | ./arch/x86/include/asm/i8259.h: In function 'inb_pic':
> | ./arch/x86/include/asm/i8259.h:32:24: error: implicit declaration of function 'inb' [-Werror=implicit-function-declaration]
> |   unsigned char value = inb(port);
> |                         ^~~
> | ./arch/x86/include/asm/i8259.h: In function 'outb_pic':
> | ./arch/x86/include/asm/i8259.h:45:2: error: implicit declaration of function 'outb' [-Werror=implicit-function-declaration]
> |   outb(value, port);
> |   ^~~~
> | In file included from ./include/linux/mc146818rtc.h:14:0,
> |                  from drivers/rtc/rtc-cmos.c:49:
> | ./arch/x86/include/asm/io.h: At top level:
> | ./arch/x86/include/asm/io.h:277:20: warning: conflicting types for 'outb'
> |  static inline void out##bwl(unsigned type value, int port)  \
> |                     ^
> | ./arch/x86/include/asm/io.h:316:1: note: in expansion of macro 'BUILDIO'
> |  BUILDIO(b, b, char)
> |  ^~~~~~~
> | ./arch/x86/include/asm/io.h:277:20: error: static declaration of 'outb' follows non-static declaration
> |  static inline void out##bwl(unsigned type value, int port)  \
> |                     ^
> | ./arch/x86/include/asm/io.h:316:1: note: in expansion of macro 'BUILDIO'
> |  BUILDIO(b, b, char)
> |  ^~~~~~~
> | In file included from drivers/rtc/rtc-cmos.c:45:0:
> | ./arch/x86/include/asm/i8259.h:45:2: note: previous implicit declaration of 'outb' was here
> |   outb(value, port);
> |   ^~~~
> | In file included from ./include/linux/mc146818rtc.h:14:0,
> |                  from drivers/rtc/rtc-cmos.c:49:
> | ./arch/x86/include/asm/io.h:283:29: error: conflicting types for 'inb'
> |  static inline unsigned type in##bwl(int port)    \
> |                              ^
> | ./arch/x86/include/asm/io.h:316:1: note: in expansion of macro 'BUILDIO'
> |  BUILDIO(b, b, char)
> |  ^~~~~~~
> | In file included from drivers/rtc/rtc-cmos.c:45:0:
> | ./arch/x86/include/asm/i8259.h:32:24: note: previous implicit declaration of 'inb' was here
> |   unsigned char value = inb(port);
> `----
>
> Cheers,
>         Sven
>
