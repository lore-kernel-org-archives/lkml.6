Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64F2C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA732080D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA732080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeKJBBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:01:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:33138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727800AbeKJBBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:01:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B6F1AE17;
        Fri,  9 Nov 2018 15:20:33 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen: fix xen_qlock_wait()
To:     Sander Eikelenboom <linux@eikelenboom.it>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        stable@vger.kernel.org
References: <20181109120413.9539-1-jgross@suse.com>
 <400409f5-397e-780b-d13b-19a1ee578f44@eikelenboom.it>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <068f9560-598b-0228-463b-bc7f202cf8e0@suse.com>
Date:   Fri, 9 Nov 2018 16:20:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <400409f5-397e-780b-d13b-19a1ee578f44@eikelenboom.it>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 16:02, Sander Eikelenboom wrote:
> On 09/11/18 13:04, Juergen Gross wrote:
>> Commit a856531951dc80 ("xen: make xen_qlock_wait() nestable")
>> introduced a regression for Xen guests running fully virtualized
>> (HVM or PVH mode). The Xen hypervisor wouldn't return from the poll
>> hypercall with interrupts disabled in case of an interrupt (for PV
>> guests it does).
>>
>> So instead of disabling interrupts in xen_qlock_wait() use a nesting
>> counter to avoid calling xen_clear_irq_pending() in case
>> xen_qlock_wait() is nested.
>>
>> Fixes: a856531951dc80 ("xen: make xen_qlock_wait() nestable")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> Although you don't seem too interested, you can stick on a:
> Tested-by: Sander Eikelenboom <linux@eikelenboom.it>
> if you like.

I am interested.

OTOH I wanted to post the patch officially to give others the chance to
send remarks.


Juergen

> 
> --
> Sander
> 
>> ---
>>  arch/x86/xen/spinlock.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
>> index 441c88262169..1c8a8816a402 100644
>> --- a/arch/x86/xen/spinlock.c
>> +++ b/arch/x86/xen/spinlock.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/log2.h>
>>  #include <linux/gfp.h>
>>  #include <linux/slab.h>
>> +#include <linux/atomic.h>
>>  
>>  #include <asm/paravirt.h>
>>  #include <asm/qspinlock.h>
>> @@ -21,6 +22,7 @@
>>  
>>  static DEFINE_PER_CPU(int, lock_kicker_irq) = -1;
>>  static DEFINE_PER_CPU(char *, irq_name);
>> +static DEFINE_PER_CPU(atomic_t, xen_qlock_wait_nest);
>>  static bool xen_pvspin = true;
>>  
>>  static void xen_qlock_kick(int cpu)
>> @@ -39,25 +41,25 @@ static void xen_qlock_kick(int cpu)
>>   */
>>  static void xen_qlock_wait(u8 *byte, u8 val)
>>  {
>> -	unsigned long flags;
>>  	int irq = __this_cpu_read(lock_kicker_irq);
>> +	atomic_t *nest_cnt = this_cpu_ptr(&xen_qlock_wait_nest);
>>  
>>  	/* If kicker interrupts not initialized yet, just spin */
>>  	if (irq == -1 || in_nmi())
>>  		return;
>>  
>> -	/* Guard against reentry. */
>> -	local_irq_save(flags);
>> +	/* Detect reentry. */
>> +	atomic_inc(nest_cnt);
>>  
>> -	/* If irq pending already clear it. */
>> -	if (xen_test_irq_pending(irq)) {
>> +	/* If irq pending already and no nested call clear it. */
>> +	if (atomic_read(nest_cnt) == 1 && xen_test_irq_pending(irq)) {
>>  		xen_clear_irq_pending(irq);
>>  	} else if (READ_ONCE(*byte) == val) {
>>  		/* Block until irq becomes pending (or a spurious wakeup) */
>>  		xen_poll_irq(irq);
>>  	}
>>  
>> -	local_irq_restore(flags);
>> +	atomic_dec(nest_cnt);
>>  }
>>  
>>  static irqreturn_t dummy_handler(int irq, void *dev_id)
>>
> 
> 

