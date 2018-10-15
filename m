Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092BEC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1F8204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1F8204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeJONdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:33:49 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:48497 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeJONdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:33:49 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gBvlT-000213-Kg; Sun, 14 Oct 2018 23:50:03 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gBvlS-00058P-O9; Sun, 14 Oct 2018 23:50:03 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20181015151159.5ce4faa5@canb.auug.org.au>
        <20181015153437.70179aaf@canb.auug.org.au>
Date:   Mon, 15 Oct 2018 00:49:49 -0500
In-Reply-To: <20181015153437.70179aaf@canb.auug.org.au> (Stephen Rothwell's
        message of "Mon, 15 Oct 2018 15:34:37 +1100")
Message-ID: <87d0sbpxmq.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gBvlS-00058P-O9;;;mid=<87d0sbpxmq.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX187yBQmaHOszZIJb6Q4yuAlBNofYw+F3JA=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: linux-next: manual merge of the userns tree with the tip tree
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> On Mon, 15 Oct 2018 15:11:59 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the userns tree got a conflict in:
>> 
>>   arch/x86/mm/fault.c
>> 
>> between commit:
>> 
>>   164477c2331b ("x86/mm: Clarify hardware vs. software "error_code"")
>> (and others from that series)
>> 
>> from the tip tree and commits:
>> 
>>   768fd9c69bb5 ("signal/x86: Remove pkey parameter from bad_area_nosemaphore")
>>   25c102d803ea ("signal/x86: Remove pkey parameter from mm_fault_error")
>> 
>> from the userns tree.
>> 
>> I fixed it up (I think - see below) and can carry the fix as
>> necessary. This is now fixed as far as linux-next is concerned, but any
>> non trivial conflicts should be mentioned to your upstream maintainer
>> when your tree is submitted for merging.  You may also want to consider
>> cooperating with the maintainer of the conflicting tree to minimise any
>> particularly complex conflicts.
>> 
>> -- 
>> Cheers,
>> Stephen Rothwell
>> 
>> diff --cc arch/x86/mm/fault.c
>> index c2e3e5127ebc,8d77700a7883..000000000000
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>>  +/* Handle faults in the user portion of the address space */
>>  +static inline
>>  +void do_user_addr_fault(struct pt_regs *regs,
>>  +			unsigned long hw_error_code,
>>  +			unsigned long address)
>>  +{
>>  +	unsigned long sw_error_code;
>>  +	struct vm_area_struct *vma;
>>  +	struct task_struct *tsk;
>>  +	struct mm_struct *mm;
>>  +	vm_fault_t fault, major = 0;
>>  +	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
>>  +	u32 pkey;
>
> I missed removing the above line.

Yes.  At first glance with the above change it looks like you got it.

Eric

