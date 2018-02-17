Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3035676-1518881587-2-8999814539919324532
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518881586; b=SVSrY91EsvcKnJ3mb/c0YDfkKMJuysKh/sIsG+nBVZxmh9z
    /mdo6s+/YZKMhFhPyUlY722TKxtNBk60wew0n6LsOqJpmgz4XFrtvbcw56DwvUIf
    zgKsFXhVsTuNdhJYiQ1zMMDJYReA8IZBcc6+kRYkGTsC/tDWC1gR0kwwDxA1S5wh
    Z7jqCUhsRojKo8pMptV4h/gEidXMyvtpEvgK7blYePV5Wrl9umfg7mY3ZpLTFNcf
    fUe2FgxZb0FKivYDzOvRAMWZOnsRUlzZ0mXEPrWNV6D5mKa7MPVWPMvhpd71cY18
    hJ6CPz/v72+2uPjwim/AojIreES9fGGs927vnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518881586; bh=i2/3Eg4iq3z2QVziYAyN5rwI3EcozCpgnbkbBO+mTIQ=; b=e
    rVy5FWO/1dFBjN25vQPZxIPLtNXazAGbNhG6Syouza8p+rL9gZYMn4wUkXqJ6nRk
    ZgswnCZwph1QZ4ORHpj7eb/hwJLed5rA9y0nZcS29/We/eg7+taGSRRlRrAc6OC8
    7diVH58KU6CA+Wn1vS2s9fWL7lRNys9TlLm8RaELXQIVFdGmyCQ+r9OBnY1tIgXy
    f40Pf5oHrE1qxIlABF7NfhjdQI2mIobZrf/FiH37cGWGFCW5tR34Xttp0ohOcDFl
    PqiwZl0yobKwDdknWzsZL7kGZ0QHoT/sOszKPnUFfFHyOBSiqJkHqyaBtbHFXXNn
    Ixx5vXxYCltDURgBtK6dw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=wKkoH5Uy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=wKkoH5Uy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbeBQPdD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Feb 2018 10:33:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40416 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeBQPdD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Feb 2018 10:33:03 -0500
Subject: Re: [RESEND v2] mm: don't defer struct page initialization for Xen pv
 guests
To: Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, mhocko@suse.com,
        stable@vger.kernel.org
References: <20180216154101.22865-1-jgross@suse.com>
 <20180216124004.8465f643a5539125d77ba79f@linux-foundation.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <b153984d-4976-ebb0-c88f-0cb13d78d5b5@oracle.com>
Date: Sat, 17 Feb 2018 10:32:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216124004.8465f643a5539125d77ba79f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8808 signatures=668674
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802170207
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

This is unique for Xen, so this particular issue won't effect other 
configurations. I am going to investigate if there is a way to re-enable 
deferred page initialization on xen guests.

Pavel

On 02/16/2018 03:40 PM, Andrew Morton wrote:
> On Fri, 16 Feb 2018 16:41:01 +0100 Juergen Gross <jgross@suse.com> wrote:
> 
>> Commit f7f99100d8d95dbcf09e0216a143211e79418b9f ("mm: stop zeroing
>> memory during allocation in vmemmap") broke Xen pv domains in some
>> configurations, as the "Pinned" information in struct page of early
>> page tables could get lost. This will lead to the kernel trying to
>> write directly into the page tables instead of asking the hypervisor
>> to do so. The result is a crash like the following:
> 
> Let's cc Pavel, who authored f7f99100d8d95d.
> 
>> [    0.004000] BUG: unable to handle kernel paging request at ffff8801ead19008
>> [    0.004000] IP: xen_set_pud+0x4e/0xd0
>> [    0.004000] PGD 1c0a067 P4D 1c0a067 PUD 23a0067 PMD 1e9de0067 PTE 80100001ead19065
>> [    0.004000] Oops: 0003 [#1] PREEMPT SMP
>> [    0.004000] Modules linked in:
>> [    0.004000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-default+ #271
>> [    0.004000] Hardware name: Dell Inc. Latitude E6440/0159N7, BIOS A07 06/26/2014
>> [    0.004000] task: ffffffff81c10480 task.stack: ffffffff81c00000
>> [    0.004000] RIP: e030:xen_set_pud+0x4e/0xd0
>> [    0.004000] RSP: e02b:ffffffff81c03cd8 EFLAGS: 00010246
>> [    0.004000] RAX: 002ffff800000800 RBX: ffff88020fd31000 RCX: 0000000000000000
>> [    0.004000] RDX: ffffea0000000000 RSI: 00000001b8308067 RDI: ffff8801ead19008
>> [    0.004000] RBP: ffff8801ead19008 R08: aaaaaaaaaaaaaaaa R09: 00000000063f4c80
>> [    0.004000] R10: aaaaaaaaaaaaaaaa R11: 0720072007200720 R12: 00000001b8308067
>> [    0.004000] R13: ffffffff81c8a9cc R14: ffff88018fd31000 R15: 000077ff80000000
>> [    0.004000] FS:  0000000000000000(0000) GS:ffff88020f600000(0000) knlGS:0000000000000000
>> [    0.004000] CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    0.004000] CR2: ffff8801ead19008 CR3: 0000000001c09000 CR4: 0000000000042660
>> [    0.004000] Call Trace:
>> [    0.004000]  __pmd_alloc+0x128/0x140
>> [    0.004000]  ? acpi_os_map_iomem+0x175/0x1b0
>> [    0.004000]  ioremap_page_range+0x3f4/0x410
>> [    0.004000]  ? acpi_os_map_iomem+0x175/0x1b0
>> [    0.004000]  __ioremap_caller+0x1c3/0x2e0
>> [    0.004000]  acpi_os_map_iomem+0x175/0x1b0
>> [    0.004000]  acpi_tb_acquire_table+0x39/0x66
>> [    0.004000]  acpi_tb_validate_table+0x44/0x7c
>> [    0.004000]  acpi_tb_verify_temp_table+0x45/0x304
>> [    0.004000]  ? acpi_ut_acquire_mutex+0x12a/0x1c2
>> [    0.004000]  acpi_reallocate_root_table+0x12d/0x141
>> [    0.004000]  acpi_early_init+0x4d/0x10a
>> [    0.004000]  start_kernel+0x3eb/0x4a1
>> [    0.004000]  ? set_init_arg+0x55/0x55
>> [    0.004000]  xen_start_kernel+0x528/0x532
>> [    0.004000] Code: 48 01 e8 48 0f 42 15 a2 fd be 00 48 01 d0 48 ba 00 00 00 00 00 ea ff ff 48 c1 e8 0c 48 c1 e0 06 48 01 d0 48 8b 00 f6 c4 02 75 5d <4c> 89 65 00 5b 5d 41 5c c3 65 8b 05 52 9f fe 7e 89 c0 48 0f a3
>> [    0.004000] RIP: xen_set_pud+0x4e/0xd0 RSP: ffffffff81c03cd8
>> [    0.004000] CR2: ffff8801ead19008
>> [    0.004000] ---[ end trace 38eca2e56f1b642e ]---
>>
>> Avoid this problem by not deferring struct page initialization when
>> running as Xen pv guest.
>>
>> ...
>>
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -347,6 +347,9 @@ static inline bool update_defer_init(pg_data_t *pgdat,
>>   	/* Always populate low zones for address-constrained allocations */
>>   	if (zone_end < pgdat_end_pfn(pgdat))
>>   		return true;
>> +	/* Xen PV domains need page structures early */
>> +	if (xen_pv_domain())
>> +		return true;
>>   	(*nr_initialised)++;
>>   	if ((*nr_initialised > pgdat->static_init_pgcnt) &&
>>   	    (pfn & (PAGES_PER_SECTION - 1)) == 0) {
> 
> I'm OK with applying the patch as a short-term regression fix but I do
> wonder whether it's the correct fix.  What is special about Xen (in
> some configurations!) that causes it to find a hole in deferred
> initialization?
> 
> I'd like us to delve further please.  Because if Xen found a hole in
> the implementation, others might do so.  Or perhaps Xen is doing
> something naughty.
> 
