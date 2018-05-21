Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751073AbeEUUdR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 16:33:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47952 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeEUUdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 16:33:15 -0400
Subject: Re: [Xen-devel] [RFC 1/3] xen/balloon: Allow allocating DMA buffers
To: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, matthew.d.roper@intel.com,
        dongwon.kim@intel.com
References: <20180517082604.14828-1-andr2000@gmail.com>
 <20180517082604.14828-2-andr2000@gmail.com>
 <6a108876-19b7-49d0-3de2-9e10f984736c@oracle.com>
 <9541926e-001a-e41e-317c-dbff6d687761@gmail.com>
 <218e2bf7-490d-f89e-9866-27b7e3dbc835@oracle.com>
 <a08e7d0d-f7d5-6b7e-979b-8a17060482f0@gmail.com>
 <b177a327-6a73-bb77-c69b-bc0958a05532@oracle.com>
 <f87478c7-3523-851c-5c3a-12a9e8753bb6@epam.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <c2f0845b-ab2f-4b9b-6f46-6ddd236ad9ed@oracle.com>
Date: Mon, 21 May 2018 16:36:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f87478c7-3523-851c-5c3a-12a9e8753bb6@epam.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8900 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805210243
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21/2018 03:13 PM, Oleksandr Andrushchenko wrote:
> On 05/21/2018 09:53 PM, Boris Ostrovsky wrote:
>> On 05/21/2018 01:32 PM, Oleksandr Andrushchenko wrote:
>>> On 05/21/2018 07:35 PM, Boris Ostrovsky wrote:
>>>> On 05/21/2018 01:40 AM, Oleksandr Andrushchenko wrote:
>>>>> On 05/19/2018 01:04 AM, Boris Ostrovsky wrote:
>>>>>> On 05/17/2018 04:26 AM, Oleksandr Andrushchenko wrote:
>>>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>> A commit message would be useful.
>>>>> Sure, v1 will have it
>>>>>>> Signed-off-by: Oleksandr Andrushchenko
>>>>>>> <oleksandr_andrushchenko@epam.com>
>>>>>>>
>>>>>>>         for (i = 0; i < nr_pages; i++) {
>>>>>>> -        page = alloc_page(gfp);
>>>>>>> -        if (page == NULL) {
>>>>>>> -            nr_pages = i;
>>>>>>> -            state = BP_EAGAIN;
>>>>>>> -            break;
>>>>>>> +        if (ext_pages) {
>>>>>>> +            page = ext_pages[i];
>>>>>>> +        } else {
>>>>>>> +            page = alloc_page(gfp);
>>>>>>> +            if (page == NULL) {
>>>>>>> +                nr_pages = i;
>>>>>>> +                state = BP_EAGAIN;
>>>>>>> +                break;
>>>>>>> +            }
>>>>>>>             }
>>>>>>>             scrub_page(page);
>>>>>>>             list_add(&page->lru, &pages);
>>>>>>> @@ -529,7 +565,7 @@ static enum bp_state
>>>>>>> decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>>>>>>>         i = 0;
>>>>>>>         list_for_each_entry_safe(page, tmp, &pages, lru) {
>>>>>>>             /* XENMEM_decrease_reservation requires a GFN */
>>>>>>> -        frame_list[i++] = xen_page_to_gfn(page);
>>>>>>> +        frames[i++] = xen_page_to_gfn(page);
>>>>>>>       #ifdef CONFIG_XEN_HAVE_PVMMU
>>>>>>>             /*
>>>>>>> @@ -552,18 +588,22 @@ static enum bp_state
>>>>>>> decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>>>>>>>     #endif
>>>>>>>             list_del(&page->lru);
>>>>>>>     -        balloon_append(page);
>>>>>>> +        if (!ext_pages)
>>>>>>> +            balloon_append(page);
>>>>>> So what you are proposing is not really ballooning. You are just
>>>>>> piggybacking on existing interfaces, aren't you?
>>>>> Sort of. Basically I need to {increase|decrease}_reservation, not
>>>>> actually
>>>>> allocating ballooned pages.
>>>>> Do you think I can simply EXPORT_SYMBOL for
>>>>> {increase|decrease}_reservation?
>>>>> Any other suggestion?
>>>> I am actually wondering how much of that code you end up reusing. You
>>>> pretty much create new code paths in both routines and common code
>>>> ends
>>>> up being essentially the hypercall.
>>> Well, I hoped that it would be easier to maintain if I modify existing
>>> code
>>> to support both use-cases, but I am also ok to create new routines if
>>> this
>>> seems to be reasonable - please let me know
>>>>    So the question is --- would it make
>>>> sense to do all of this separately from the balloon driver?
>>> This can be done, but which driver will host this code then? If we
>>> move from
>>> the balloon driver, then this could go to either gntdev or grant-table.
>>> What's your preference?
>> A separate module?
>
>> Is there any use for this feature outside of your zero-copy DRM driver?
> Intel's hyper dma-buf (Dongwon/Matt CC'ed), V4L/GPU at least.
>
> At the time I tried to upstream zcopy driver it was discussed and
> decided that
> it would be better if I remove all DRM specific code and move it to
> Xen drivers.
> Thus, this RFC.
>
> But it can also be implemented as a dedicated Xen dma-buf driver which
> will have all the
> code from this RFC + a bit more (char/misc device handling at least).
> This will also require a dedicated user-space library, just like
> libxengnttab.so
> for gntdev (now I have all new IOCTLs covered there).
>
> If the idea of a dedicated Xen dma-buf driver seems to be more
> attractive we
> can work toward this solution. BTW, I do support this idea, but was not
> sure if Xen community accepts yet another driver which duplicates
> quite some code
> of the existing gntdev/balloon/grant-table. And now after this RFC I
> hope that all cons
> and pros of both dedicated driver and gntdev/balloon/grant-table
> extension are
> clearly seen and we can make a decision.


IIRC the objection for a separate module was in the context of gntdev
was discussion, because (among other things) people didn't want to have
yet another file in /dev/xen/

Here we are talking about (a new) balloon-like module which doesn't
create any new user-visible interfaces. And as for duplicating code ---
as I said, I am not convinced there is much of duplication.

I might even argue that we should add a new config option for this module.


-boris

>
>>
>> -boris
> Thank you,
> Oleksandr
> [1]
> https://lists.freedesktop.org/archives/dri-devel/2018-April/173163.html
