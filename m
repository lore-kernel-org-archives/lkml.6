Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3174000-1520552306-2-439791014805055845
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520552305; b=L0qqY8IF7IBNvmd1qNQIX9V7sIGaaS/uLgXwszn/3oYflCx
    HMzIonsBaN61L0gSv7a3OChmf5evWdPg4NJoSbi1fzwBloXog+iAbf59ga3tz+gF
    WUiVSHVTOQG2zPO5ycZ08rHeS7AuTYqyvuOWTwOnnGHjB3hV54sUxT62prnru+uG
    17e0o7b9vx12jl/svPy6tTUKCpz6B4WK098hxOLj3sciWz0hh4PAC2o2gNgAUsdF
    CPq7FPKRpoS3B3fOn4XeO+4tWScYhsAzo+rSc987l1NtJoAQLeMAm5XFHKHd+MwW
    zmNNHnWdWDx2gNCDuMt5WT5/E+PbFm7eLESHdrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520552305; bh=ZabL7zYVXObPB8i74AWU99IUmg3rP6rhuJoon1lJF4E=; b=F
    6/l34JVNaJ7AN/zpNkfy+RTy0RLmNc7k2RqszW+4PEPa8hq+gBrsU5sMFufaYzcY
    pjhv1XEWD8wieIyCkVm0d1eoxm5x1kZ5PNHCzjQINNw8uV8KjiZwx/mCz2kuUDeP
    48bCs4/YkkISwmxrVU64p5U5ohH/srwL79V2GVg+J6+wc3QHlhU8+BNVS/UjQ/AD
    s/pt+EMTsLtbh7QFccALzhuIivvYrds5NmsLBmHdkgt4FLYIIe3oPZwu1Rn6+uV7
    3152TpJgjSyl0h6pHKDmdpyQhoyudq2zehcP37KSunwS7pO7hJhD48CJqT+duKhG
    rqN/ykSQsbaghgZrlga3w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=jeE6zwsj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=jeE6zwsj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeCHXiO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 18:38:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46726 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeCHXiM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 18:38:12 -0500
Subject: Re: [PATCH v2] hugetlbfs: check for pgoff value overflow
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bugzilla-daemon@bugzilla.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nic Losby <blurbdust@gmail.com>,
        Yisheng Xie <xieyisheng1@huawei.com>, stable@vger.kernel.org
References: <20180306133135.4dc344e478d98f0e29f47698@linux-foundation.org>
 <20180308210502.15952-1-mike.kravetz@oracle.com>
 <20180308141533.d16e43f5f559215089e522ae@linux-foundation.org>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a5e3c0c4-d41e-6ffd-935d-63cce2527d0f@oracle.com>
Date: Thu, 8 Mar 2018 15:37:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180308141533.d16e43f5f559215089e522ae@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8826 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803080252
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/08/2018 02:15 PM, Andrew Morton wrote:
> On Thu,  8 Mar 2018 13:05:02 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>> A vma with vm_pgoff large enough to overflow a loff_t type when
>> converted to a byte offset can be passed via the remap_file_pages
>> system call.  The hugetlbfs mmap routine uses the byte offset to
>> calculate reservations and file size.
>>
>> A sequence such as:
>>   mmap(0x20a00000, 0x600000, 0, 0x66033, -1, 0);
>>   remap_file_pages(0x20a00000, 0x600000, 0, 0x20000000000000, 0);
>> will result in the following when task exits/file closed,
>>   kernel BUG at mm/hugetlb.c:749!
>> Call Trace:
>>   hugetlbfs_evict_inode+0x2f/0x40
>>   evict+0xcb/0x190
>>   __dentry_kill+0xcb/0x150
>>   __fput+0x164/0x1e0
>>   task_work_run+0x84/0xa0
>>   exit_to_usermode_loop+0x7d/0x80
>>   do_syscall_64+0x18b/0x190
>>   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>>
>> The overflowed pgoff value causes hugetlbfs to try to set up a
>> mapping with a negative range (end < start) that leaves invalid
>> state which causes the BUG.
>>
>> The previous overflow fix to this code was incomplete and did not
>> take the remap_file_pages system call into account.
>>
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -111,6 +111,7 @@ static void huge_pagevec_release(struct pagevec *pvec)
>>  static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>>  {
>>  	struct inode *inode = file_inode(file);
>> +	unsigned long ovfl_mask;
>>  	loff_t len, vma_len;
>>  	int ret;
>>  	struct hstate *h = hstate_file(file);
>> @@ -127,12 +128,16 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>>  	vma->vm_ops = &hugetlb_vm_ops;
>>  
>>  	/*
>> -	 * Offset passed to mmap (before page shift) could have been
>> -	 * negative when represented as a (l)off_t.
>> +	 * page based offset in vm_pgoff could be sufficiently large to
>> +	 * overflow a (l)off_t when converted to byte offset.
>>  	 */
>> -	if (((loff_t)vma->vm_pgoff << PAGE_SHIFT) < 0)
>> +	ovfl_mask = (1UL << (PAGE_SHIFT + 1)) - 1;
>> +	ovfl_mask <<= ((sizeof(unsigned long) * BITS_PER_BYTE) -
>> +		       (PAGE_SHIFT + 1));
> 
> That's a compile-time constant.  The compiler will indeed generate an
> immediate load, but I think it would be better to make the code look
> more like we know that it's a constant, if you get what I mean. 
> Something like
> 
> /*
>  * If a pgoff_t is to be converted to a byte index, this is the max value it
>  * can have to avoid overflow in that conversion.
>  */
> #define PGOFF_T_MAX	<long string of crap>

Ok

> And I bet that this constant could be used elsewhere - surely it's a
> very common thing to be checking for.
> 
> 
> Also, the expression seems rather complicated.  Why are we adding 1 to
> PAGE_SHIFT?  Isn't there a logical way of using PAGE_MASK?

The + 1 is there because this value will eventually be converted to
a loff_t which is signed.  So, we need to take that sign bit into
account or we could end up with a negative value.

For PAGE_SHIFT == 12, PAGE_MASK is 0xfffffffffffff000.  Our target
mask is  0xfff8000000000000 (for the sign bit).  So, we could do
PAGE_MASK << (BITS_PER_LONG - (2 * PAGE_SHIFT) - 1)

This legacy hugetlbfs code may be a little different than other areas
in the use of loff_t.  When doing some previous work in this area, I
did not find enough common used to make this more general purpose.  See,
https://lkml.org/lkml/2017/4/12/793

> The resulting constant is 0xfff8000000000000 on 64-bit.  We could just
> use along the lines of
> 
> 	1UL << (BITS_PER_LONG - PAGE_SHIFT - 1)

Ah yes, BITS_PER_LONG is better than (sizeof(unsigned long) * BITS_PER_BYTE

> But why the -1?  We should be able to handle a pgoff_t of
> 0xfff0000000000000 in this code?

I'm not exactly sure what you are asking/suggesting here and in the line
above.  It is because of the conversion to a signed value that we have to
go with 0xfff8000000000000 instead of 0xfff0000000000000.

Here are a couple options for computing the mask.  I changed the name
you suggested to make it more obvious that the mask is being used to
check for loff_t overflow.

If we want to explicitly comptue the mask as in code above.
#define PGOFF_LOFFT_MAX \
	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))

Or, we use PAGE_MASK
#define PGOFF_LOFFT_MAX (PAGE_MASK << (BITS_PER_LONG - (2 * PAGE_SHIFT) - 1))

In either case, we need a big comment explaining the mask and
how we have that extra bit +/- 1 because the offset will be converted
to a signed value.
	
> Also, we later to
> 
> 	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> 	/* check for overflow */
> 	if (len < vma_len)
> 		return -EINVAL;
> 
> which is ungainly: even if we passed the PGOFF_T_MAX test, there can
> still be an overflow which we still must check for.  Is that avoidable?
> Probably not...

Yes, it is required.  That check takes into account the length argument
which is added to page offset.  So, yes you can pass the first check and
fail this one.

-- 
Mike Kravetz
