Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC62C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6221219EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6221219EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeHFMBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:01:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727004AbeHFMBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:01:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769ionv144394
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 05:52:42 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kph86xr6h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 05:52:41 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 6 Aug 2018 10:52:39 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 10:52:33 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w769qWRr34340870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 09:52:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1B3052051;
        Mon,  6 Aug 2018 12:52:40 +0100 (BST)
Received: from [9.124.35.244] (unknown [9.124.35.244])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 897105204F;
        Mon,  6 Aug 2018 12:52:37 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v7 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, liu.song.a23@gmail.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180731035143.11942-1-ravi.bangoria@linux.ibm.com>
 <20180731035143.11942-4-ravi.bangoria@linux.ibm.com>
 <20180803112455.GA13794@redhat.com>
Date:   Mon, 6 Aug 2018 15:22:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180803112455.GA13794@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18080609-4275-0000-0000-000002A50712
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080609-4276-0000-0000-000037AD073E
Message-Id: <bfb47985-8f58-e5e4-f8b4-695dfea7937f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

Sorry for bit late reply.


On 08/03/2018 04:54 PM, Oleg Nesterov wrote:
> Hi Ravi,
> 
> I was going to give up and ack this series, but it seems I noticed
> a bug...
> 
> On 07/31, Ravi Bangoria wrote:
>>
>> +static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
>> +{
>> +	struct delayed_uprobe *du;
>> +
>> +	if (delayed_uprobe_check(uprobe, mm))
>> +		return 0;
>> +
>> +	du  = kzalloc(sizeof(*du), GFP_KERNEL);
>> +	if (!du)
>> +		return -ENOMEM;
>> +
>> +	du->uprobe = uprobe;
>> +	du->mm = mm;
> 
> I am surprised I didn't notice this before...
> 
> So
> 	du->mm = mm;
> 
> is fine, mm can't go away, uprobe_clear_state() does delayed_uprobe_remove(NULL,mm).
> 
> But
> 	du->uprobe = uprobe;
> 
> doesn't look right, uprobe can go away and it can be freed, its memory can be reused.
> We can't rely on remove_breakpoint(),


I'm sorry. I didn't get this. How can uprobe go away without calling
    uprobe_unregister()
    -> rergister_for_each_vma()
       -> remove_breakpoint()
And remove_breakpoint() will get called only when last uprobe consumer is going
away _for that mm_. So, we can rely on remove_breakpoint() to remove {uprobe,mm}
from delayed_uprobe_list. Am I missing anything? Or it would be even better if
you can tell me some example scenario.


> the application can unmap the probed page/vma.
> Yes we do not care about the application in this case, say, the next uprobe_mmap() can
> wrongly increment the counter, we do not care although this can lead to hard-to-debug
> problems. But, if nothing else, the kernel can crash if the freed memory is unmapped.
> So I think put_uprobe() should do delayed_uprobe_remove(uprobe, NULL) before kfree()
> and delayed_uprobe_remove() should be updated to handle the mm==NULL case.
> 
> Also. delayed_uprobe_add() should check the list and avoid duplicates. Otherwise the
> trivial
> 
> 	for (;;)
> 		munmap(mmap(uprobed_file));
> 
> will eat the memory until uprobe is unregistered.


I'm already calling delayed_uprobe_check(uprobe, mm) from delayed_uprobe_add().
So, we don't add same {uprobe,mm} multiple time in delayed_uprobe_list.

Is it the same check you are asking me to add or something else.


> 
> 
>> +static bool valid_ref_ctr_vma(struct uprobe *uprobe,
>> +			      struct vm_area_struct *vma)
>> +{
>> +	unsigned long vaddr = offset_to_vaddr(vma, uprobe->ref_ctr_offset);
>> +
>> +	return uprobe->ref_ctr_offset &&
>> +		vma->vm_file &&
>> +		file_inode(vma->vm_file) == uprobe->inode &&
>> +		vma->vm_flags & VM_WRITE &&
>> +		!(vma->vm_flags & VM_SHARED) &&
> 
> 		vma->vm_flags & (VM_WRITE|VM_SHARED) == VM_WRITE &&
> 
> looks a bit better to me, but I won't insist.

Sure. I'll change it.

> 
>> +static int delayed_uprobe_install(struct vm_area_struct *vma)
>> +{
>> +	struct list_head *pos, *q;
>> +	struct delayed_uprobe *du;
>> +	unsigned long vaddr;
>> +	int ret = 0, err = 0;
>> +
>> +	mutex_lock(&delayed_uprobe_lock);
>> +	list_for_each_safe(pos, q, &delayed_uprobe_list) {
>> +		du = list_entry(pos, struct delayed_uprobe, list);
>> +
>> +		if (!valid_ref_ctr_vma(du->uprobe, vma))
>> +			continue;
>> +
>> +		vaddr = offset_to_vaddr(vma, du->uprobe->ref_ctr_offset);
>> +		ret = __update_ref_ctr(vma->vm_mm, vaddr, 1);
>> +		/* Record an error and continue. */
>> +		err = ret & !err ? ret : err;
> 
> I try to avoid the cosmetic nits, but I simply can't look at this line ;)
> 
> 		if (ret && !err)
> 			err = ret;

This is neat. Will replace it.

> 
>> @@ -1072,7 +1281,14 @@ int uprobe_mmap(struct vm_area_struct *vma)
>>  	struct uprobe *uprobe, *u;
>>  	struct inode *inode;
>>
>> -	if (no_uprobe_events() || !valid_vma(vma, true))
>> +	if (no_uprobe_events())
>> +		return 0;
>> +
>> +	if (vma->vm_flags & VM_WRITE &&
>> +	    test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags))
>> +		delayed_uprobe_install(vma);
> 
> OK, so you also added the VM_WRITE check and I agree. But then I think we
> should also check VM_SHARED, just like valid_ref_ctr_vma() does?

Right. I'll add a check here.

Thanks for reviewing :)

