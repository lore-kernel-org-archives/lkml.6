Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3577380-1517487943-3-5787670802719276596
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517487943; b=ixi3zbRFHzJ40R1mtqcXWUIENfbcfqaomc/gIdTbn+exOZA
    Bcq0p/nL5F54NDcCR7sGJuNUpFwSI34rxK9yuZa1uZpG9mBbH9xm/Kg76LFCEhjo
    WSb9iizJzWhoqIZv56lNGVs7Zq+ZLRBUTy79ZrW635HrZmQ6RhDj+i5cAcjStfhp
    JJh8zjVUOqqkUpw5gaBRMCsrVpPm7d2KwzpDIIqs6Cl5nt4a7FqznS53Jxk/9mZP
    pp0bzeCKp71ndqM2zHyIffCShE/tyR1eyIByJBDLFa5n8xbnawSVmWXweg31RObP
    nUhJPNrOvlmm7hb7WXdFNPdYYFiy3qe2WCgnVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517487943; bh=fH7T9eTiB+UHmd/c1NXwYVqTBde2eJMCyCx0c8GjDpw=; b=f
    NjNrKWr0f6CPVUXDkF01ACFHvuMzQ0+wPjbOhDCK23PVWHPItgoUMivsEV8jK+hZ
    Jq44fNlmVbmeW+EH8qREBrYZu+b6LYliq31uPYpXzEujj78TcSJUDb/6QYDxr8Rr
    0ZhHDcbzg1bc7NRLurVeG+UMiNwCb7M7WJmTYbXsCImnumvPyg0srbDt567Droc/
    PydtQf1lMtf1PlmxP3ALerywbFexmqKi9guksvJAtmMqtLf63M+tSUl/CCz1oDry
    dBbTmAio6lmpxU52DHlSflgQvOAHiLFzf6uGLAV5m8ovBEkDteZfA886naJvYZjc
    8e8YifJgkojq79TykLBAg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbeBAMYn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 07:24:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:33909 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752244AbeBAMYm (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Feb 2018 07:24:42 -0500
Subject: Re: [PATCH] x86/xen: init %gs very early to avoid page faults with
 stack protector
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: boris.ostrovsky@oracle.com, stable@vger.kernel.org
References: <20180201121601.1268-1-jgross@suse.com>
 <66ad81d7-0230-d0a5-f4fb-9dbbd8162884@citrix.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <24614db8-7369-8178-f690-7c1614e2c0c9@suse.com>
Date: Thu, 1 Feb 2018 13:24:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <66ad81d7-0230-d0a5-f4fb-9dbbd8162884@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/02/18 13:22, Andrew Cooper wrote:
> On 01/02/18 12:16, Juergen Gross wrote:
>> When running as Xen pv guest %gs is initialized some time after
>> C code is started. Depending on stack protector usage this might be
>> too late, resulting in page faults.
>>
>> So setup %gs and MSR_GS_BASE in assembly code already.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>  arch/x86/xen/xen-head.S | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
>> index 497cc55a0c16..b47d87076efb 100644
>> --- a/arch/x86/xen/xen-head.S
>> +++ b/arch/x86/xen/xen-head.S
>> @@ -9,7 +9,9 @@
>>  
>>  #include <asm/boot.h>
>>  #include <asm/asm.h>
>> +#include <asm/msr.h>
>>  #include <asm/page_types.h>
>> +#include <asm/percpu.h>
>>  #include <asm/unwind_hints.h>
>>  
>>  #include <xen/interface/elfnote.h>
>> @@ -35,6 +37,18 @@ ENTRY(startup_xen)
>>  	mov %_ASM_SI, xen_start_info
>>  	mov $init_thread_union+THREAD_SIZE, %_ASM_SP
>>  
>> +	/* Set up %gs.
>> +	 *
>> +	 * The base of %gs always points to the bottom of the irqstack
>> +	 * union.  If the stack protector canary is enabled, it is
>> +	 * located at %gs:40.  Note that, on SMP, the boot cpu uses
>> +	 * init data section till per cpu areas are set up.
>> +	 */
>> +	movl	$MSR_GS_BASE,%ecx
>> +	movq	$INIT_PER_CPU_VAR(irq_stack_union),%rax
>> +	cdq
>> +	wrmsr
> 
> You surely want a #ifdef __x86_64__ ?  This path is common to the 32bit
> entry as well?

Oh, indeed! Thanks for noticing.

V2 coming soon...


Juergen
