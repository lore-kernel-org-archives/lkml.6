Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EF3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C0920873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C0920873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbeK0Snl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:43:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:59884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728267AbeK0Snl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:43:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F58AAEF5;
        Tue, 27 Nov 2018 07:46:39 +0000 (UTC)
Subject: Re: [PATCH] xen/x86: add diagnostic printout to xen_mc_flush() in
 case of error
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     sstabellini@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
References: <20181123162451.3351-1-jgross@suse.com>
 <0727da38-bfe8-f484-6b06-7205c1d953c1@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <04dc8206-d7ad-9438-2f68-c25bf5a10b96@suse.com>
Date:   Tue, 27 Nov 2018 08:46:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <0727da38-bfe8-f484-6b06-7205c1d953c1@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2018 21:11, Boris Ostrovsky wrote:
> On 11/23/18 11:24 AM, Juergen Gross wrote:
>> Failure of an element of a Xen multicall is signalled via a WARN()
>> only unless the kernel is compiled with MC_DEBUG. It is impossible to
> 
> s/unless/if
> 
> 
>> know which element failed and why it did so.
>>
>> Change that by printing the related information even without MC_DEBUG,
>> even if maybe in some limited form (e.g. without information which
>> caller produced the failing element).
>>
>> Move the printing out of the switch statement in order to have the
>> same information for a single call.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>  arch/x86/xen/multicalls.c | 35 ++++++++++++++++++++---------------
>>  1 file changed, 20 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/x86/xen/multicalls.c b/arch/x86/xen/multicalls.c
>> index 2bce7958ce8b..0766a08bdf45 100644
>> --- a/arch/x86/xen/multicalls.c
>> +++ b/arch/x86/xen/multicalls.c
>> @@ -69,6 +69,11 @@ void xen_mc_flush(void)
>>  
>>  	trace_xen_mc_flush(b->mcidx, b->argidx, b->cbidx);
>>  
>> +#if MC_DEBUG
>> +	memcpy(b->debug, b->entries,
>> +	       b->mcidx * sizeof(struct multicall_entry));
>> +#endif
>> +
>>  	switch (b->mcidx) {
>>  	case 0:
>>  		/* no-op */
>> @@ -87,32 +92,34 @@ void xen_mc_flush(void)
>>  		break;
>>  
>>  	default:
>> -#if MC_DEBUG
>> -		memcpy(b->debug, b->entries,
>> -		       b->mcidx * sizeof(struct multicall_entry));
>> -#endif
>> -
>>  		if (HYPERVISOR_multicall(b->entries, b->mcidx) != 0)
>>  			BUG();
>>  		for (i = 0; i < b->mcidx; i++)
>>  			if (b->entries[i].result < 0)
>>  				ret++;
>> +	}
>>  
>> +	if (WARN_ON(ret)) {
>> +		pr_err("%d of %d multicall(s) failed: cpu %d\n",
>> +		       ret, b->mcidx, smp_processor_id());
>> +		for (i = 0; i < b->mcidx; i++) {
>> +			if (b->entries[i].result < 0) {
>>  #if MC_DEBUG
>> -		if (ret) {
>> -			printk(KERN_ERR "%d multicall(s) failed: cpu %d\n",
>> -			       ret, smp_processor_id());
>> -			dump_stack();
>> -			for (i = 0; i < b->mcidx; i++) {
>> -				printk(KERN_DEBUG "  call %2d/%d: op=%lu arg=[%lx] result=%ld\t%pF\n",
>> -				       i+1, b->mcidx,
>> +				pr_err("  call %2d: op=%lu arg=[%lx] result=%ld\t%pF\n",
>> +				       i + 1,
>>  				       b->debug[i].op,
>>  				       b->debug[i].args[0],
>>  				       b->entries[i].result,
>>  				       b->caller[i]);
>> +#else
>> +				pr_err("  call %2d: op=%lu arg=[%lx] result=%ld\n",
>> +				       i + 1,
>> +				       b->entries[i].op,
>> +				       b->entries[i].args[0],
>> +				       b->entries[i].result);
>> +#endif
> 
> Doesn't (non-debug) hypervisor corrupt op and args?

No. Only debug hypervisor does so.

See my patch (and rather lengthy discussion) on xen-devel:

https://lists.xen.org/archives/html/xen-devel/2018-11/msg02714.html

> 
> (Also, we don't really need to print anything when b->entries[i].result
> == 0)

Right. Did you miss the:

+			if (b->entries[i].result < 0) {

above?


Juergen
