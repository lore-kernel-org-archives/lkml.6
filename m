Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874849-1523971277-2-3343451342713021091
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523971277; b=GkWhfpAspe01v7qBodU4UYXnF1taxGl05WtSGc7FPSN7ABQ5OW
    NekI3d7uFWgVnaAvlF2onxK696kf6Em+g7tUALSlKWKf4Ip2t6Elr18+SU/AksIQ
    2GnA2agLA8H0jOuo7X4mCjN2iqi8JdGClpr3W2Y3/uqgIu01UJKlM9Bma68sFF4A
    FOV8hPxcF13e0TougJiUA8bdQI16YHEYr9jkC34ExNEuoDkP1qjTsdpKnLpvaTJP
    hrpYZg/9Ias9EUGcpmyEZzu1l5xkm3jvC22a36W+97UPcmpoNE5G1nUIDneceZ/u
    pmmGViFYIaAHzclss8V/N1YQTRVLNqgvk4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523971277;
    bh=FOUGgsRk773l8K6Zq9SdygVnDWNGg2ZfC4yaQhzt8x4=; b=YNdzBwRPQzTT
    7ixmfQ7p1xWULww/OsSxnMXnB5BSV0CFPagFsVZPe7KGLoj3eMohXPLhMomRsxui
    F24KUukkpMewLLw8fjUX0Z/3mZ7xl26CF/TCqz3ZJo2wzth1vVaz7wKCSd+PYi94
    0wGvBGWveJhxs2dx+zQriG4SIYaojHeqyKv+DDEa2BUrJMH+tuagOvKwQpqBcBRx
    tvYZrZPISlJB9+z4C/VMs3hSpSbcu9ViQgJYhStnnLjrG9P5haQGEfjq59ZLD0nq
    YW0erXCL+xvHj8J7OrC1Ey9D/NFZfp/lBKrCYQAP2LSkPVafMxcH+84qxC4lddgg
    aDxoebqhYA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOrjZsqTIyHux9VRM4impyDHpTFoWWSsqUthUmmZwMguM3qGeiRIuMyyZ+h9hqbFqzSAyPOPvSn1wPNdHaOHlw8Q6AtZ5SOUaruxNfbtcHkzqBBMzvVw
    TGBPzKjXv7KcyY0+gx37IIG0xPE0XAoCuoF3gge+9Y2ijEjurD4PU7PbGYml2HfwVHZkyicxQ0LBOrDzIzE14xDDGXg2OqUwklJ9suJKtlNXpWjW7gT8Sw4O
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IhDdiLrqHVMA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=1GaL7g8AZR1AH_c1xs0A:9
    a=NNTdbeig87KZFCoc:21 a=X_uU_rS27uBKLeNx:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752779AbeDQNVO (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 09:21:14 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:33234 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbeDQNVN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 09:21:13 -0400
Subject: Re: [PATCH 2/2] MIPS: memset.S: Fix return of __clear_user from
 Lpartial_fixup
To: James Hogan <jhogan@kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1522315704-31641-1-git-send-email-matt.redfearn@mips.com>
 <1522315704-31641-3-git-send-email-matt.redfearn@mips.com>
 <20180416221340.GB23881@saruman>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <db826cd2-1b15-9577-6504-84cd9f6b08cd@mips.com>
Date: Tue, 17 Apr 2018 14:21:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180416221340.GB23881@saruman>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1523971267-321458-29111-11540-1
X-BESS-VER: 2018.4-r1804121647
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192080
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi James,

On 16/04/18 23:13, James Hogan wrote:
> On Thu, Mar 29, 2018 at 10:28:24AM +0100, Matt Redfearn wrote:
>> The __clear_user function is defined to return the number of bytes that
>> could not be cleared. From the underlying memset / bzero implementation
>> this means setting register a2 to that number on return. Currently if a
>> page fault is triggered within the memset_partial block, the value
>> loaded into a2 on return is meaningless.
>>
>> The label .Lpartial_fixup\@ is jumped to on page fault. Currently it
>> masks the remaining count of bytes (a2) with STORMASK, meaning that the
>> least significant 2 (32bit) or 3 (64bit) bits of the remaining count are
>> always clear.
> 
> Are you sure about that. It seems to do that *to ensure those bits are
> set correctly*...
> 
>> Secondly, .Lpartial_fixup\@ expects t1 to contain the end address of the
>> copy. This is set up by the initial block:
>> 	PTR_ADDU	t1, a0			/* end address */
>> However, the .Lmemset_partial\@ block then reuses register t1 to
>> calculate a jump through a block of word copies. This leaves it no
>> longer containing the end address of the copy operation if a page fault
>> occurs, and the remaining bytes calculation is incorrect.
>>
>> Fix these issues by removing the and of a2 with STORMASK, and replace t1
>> with register t2 in the .Lmemset_partial\@ block.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>> ---
>>
>>   arch/mips/lib/memset.S | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
>> index 90bcdf1224ee..3257dca58cad 100644
>> --- a/arch/mips/lib/memset.S
>> +++ b/arch/mips/lib/memset.S
>> @@ -161,19 +161,19 @@
>>   
>>   .Lmemset_partial\@:
>>   	R10KCBARRIER(0(ra))
>> -	PTR_LA		t1, 2f			/* where to start */
>> +	PTR_LA		t2, 2f			/* where to start */
>>   #ifdef CONFIG_CPU_MICROMIPS
>>   	LONG_SRL	t7, t0, 1
> 
> Hmm, on microMIPS t7 isn't on the clobber list for __bzero, and nor is
> t8...
> 
>>   #endif
>>   #if LONGSIZE == 4
>> -	PTR_SUBU	t1, FILLPTRG
>> +	PTR_SUBU	t2, FILLPTRG
>>   #else
>>   	.set		noat
>>   	LONG_SRL	AT, FILLPTRG, 1
>> -	PTR_SUBU	t1, AT
>> +	PTR_SUBU	t2, AT
>>   	.set		at
>>   #endif
>> -	jr		t1
>> +	jr		t2
>>   	PTR_ADDU	a0, t0			/* dest ptr */
> 
> ^^^ note this...
> 
>>   
>>   	.set		push
>> @@ -250,7 +250,6 @@
>>   
>>   .Lpartial_fixup\@:
>>   	PTR_L		t0, TI_TASK($28)
>> -	andi		a2, STORMASK
> 
> ... this isn't right.
> 
> If I read correctly, t1 (after the above change stops clobbering it) is
> the end of the full 64-byte blocks, i.e. the start address of the final
> partial block.
> 
> 
> The .Lfwd_fixup calculation (for full blocks) appears to be:
> 
>    a2 = ((len & 0x3f) + start_of_partial) - badvaddr
> 
> which is spot on. (len & 0x3f) is the partial block and remaining bytes
> that haven't been set yet, add start_of_partial to get end of the full
> range, subtract bad address to find how much didn't copy.
> 
> 
> The calculation for .Lpartial_fixup however appears to (currently) do:
> 
>    a2 = ((len & STORMASK) + start_of_partial) - badvaddr
> 
> Which might make sense if start_of_partial (t1) was replaced with
> end_of_partial, which does seem to be calculated as noted above, and put
> in a0 ready for the final few bytes to be set.
> 
>>   	LONG_L		t0, THREAD_BUADDR(t0)
>>   	LONG_ADDU	a2, t1
> 
> ^^ So I think either it needs to just s/t1/a0/ here and not bother
> preserving t1 above (smaller change and probably the original intent),
> or preserve t1 and mask 0x3f instead of STORMASK like .Lfwd_fixup does
> (which would work but seems needlessly complicated to me).
> 
> Does that make any sense or have I misunderstood some subtlety?

Thanks for taking the time to work this through - you're right, changing 
t1 to a0 in the fault handler does give the right result and is much 
less invasive.  Updated patch incoming :-)

Thanks,
Matt


> 
> Cheers
> James
> 
>>   	jr		ra
>> -- 
>> 2.7.4
>>
