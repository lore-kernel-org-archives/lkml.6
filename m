Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeEKHRV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 03:17:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752153AbeEKHRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 03:17:19 -0400
Date: Fri, 11 May 2018 10:17:05 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <91e95111-eb0c-205b-722b-18016da93c04@infradead.org>
References: <20180510172842.2619e058@canb.auug.org.au> <e55fad49-6c19-7c43-ef37-eb148bd3d55d@infradead.org> <20180510134825.372f4a7ec17ce3e945640ac2@linux-foundation.org> <91e95111-eb0c-205b-722b-18016da93c04@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: linux-next: Tree for May 10 (mm/ksm.c)
To: Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
From: Mike Rapoprt <rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051107-0020-0000-0000-0000041C2A41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051107-0021-0000-0000-000042B12BAB
Message-Id: <5574BF43-F2BB-4A19-BCCE-37F402DCED06@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110068
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 11, 2018 1:03:04 AM GMT+03:00, Randy Dunlap <rdunlap@infradead.org> wrote:
>On 05/10/2018 01:48 PM, Andrew Morton wrote:
>> On Thu, 10 May 2018 09:37:51 -0700 Randy Dunlap
><rdunlap@infradead.org> wrote:
>> 
>>> On 05/10/2018 12:28 AM, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> Changes since 20180509:
>>>>
>>>
>>> on i386:
>>>
>>> ../mm/ksm.c: In function 'try_to_merge_one_page':
>>> ../mm/ksm.c:1244:4: error: implicit declaration of function
>'set_page_stable_node' [-Werror=implicit-function-declaration]
>>>     set_page_stable_node(page, NULL);

Oops, missed that, sorry.

>> Thanks.
>> 
>> From: Andrew Morton <akpm@linux-foundation.org>
>> Subject: mm-ksm-move-page_stable_node-from-ksmh-to-ksmc-fix
>> 
>> fix SYSFS=n build
>> 
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>
>Acked-by: Randy Dunlap <rdunlap@infradead.org>
>Reported-by: Randy Dunlap <rdunlap@infradead.org>
>Tested-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>> 
>>  mm/ksm.c |    9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>> 
>> diff -puN
>include/linux/ksm.h~mm-ksm-move-page_stable_node-from-ksmh-to-ksmc-fix
>include/linux/ksm.h
>> diff -puN mm/ksm.c~mm-ksm-move-page_stable_node-from-ksmh-to-ksmc-fix
>mm/ksm.c
>> --- a/mm/ksm.c~mm-ksm-move-page_stable_node-from-ksmh-to-ksmc-fix
>> +++ a/mm/ksm.c
>> @@ -823,11 +823,6 @@ static int unmerge_ksm_pages(struct vm_a
>>  	return err;
>>  }
>>  
>> -#ifdef CONFIG_SYSFS
>> -/*
>> - * Only called through the sysfs control interface:
>> - */
>> -
>>  static inline struct stable_node *page_stable_node(struct page
>*page)
>>  {
>>  	return PageKsm(page) ? page_rmapping(page) : NULL;
>> @@ -839,6 +834,10 @@ static inline void set_page_stable_node(
>>  	page->mapping = (void *)((unsigned long)stable_node |
>PAGE_MAPPING_KSM);
>>  }
>>  
>> +#ifdef CONFIG_SYSFS
>> +/*
>> + * Only called through the sysfs control interface:
>> + */
>>  static int remove_stable_node(struct stable_node *stable_node)
>>  {
>>  	struct page *page;
>> _
