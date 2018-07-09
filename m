Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAB4C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D73D208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D73D208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754450AbeGIFRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:17:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754417AbeGIFRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:17:36 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w695E2HS129389
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 01:17:35 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k40bq3496-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:17:35 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Mon, 9 Jul 2018 01:17:35 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Jul 2018 01:17:31 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w695HUFU10027720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Jul 2018 05:17:30 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6B39AC05E;
        Mon,  9 Jul 2018 01:18:29 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62BBAAC059;
        Mon,  9 Jul 2018 01:18:28 -0400 (EDT)
Received: from [9.124.31.51] (unknown [9.124.31.51])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jul 2018 01:18:28 -0400 (EDT)
Subject: Re: [RFC PATCH 2/2] mm/pmem: Add memblock based e820 platform driver
To:     Dan Williams <dan.j.williams@intel.com>, Oliver <oohall@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180706082911.13405-1-aneesh.kumar@linux.ibm.com>
 <20180706082911.13405-2-aneesh.kumar@linux.ibm.com>
 <CAPcyv4gjrsswcakSog7jxT+agH7NrBEvwxe9jT0ycU3RZV5sWA@mail.gmail.com>
 <CAOSf1CFuxga8BAbnvPdZvutgpAxmzgjiqxzHFuVTVLOkMwKO+A@mail.gmail.com>
 <CAPcyv4ihixEN9LV6TMqax3Qa2huiPnR-kFyhtO0H51GvGu2C2Q@mail.gmail.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Mon, 9 Jul 2018 10:47:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ihixEN9LV6TMqax3Qa2huiPnR-kFyhtO0H51GvGu2C2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070905-0064-0000-0000-0000032722DB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009335; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01058671; UDB=6.00543270; IPR=6.00836591;
 MB=3.00022064; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-09 05:17:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070905-0065-0000-0000-000039DEE12C
Message-Id: <2581eec7-ad1e-578b-d0cd-7076a4f88776@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807090061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2018 11:06 PM, Dan Williams wrote:
> On Sat, Jul 7, 2018 at 12:15 AM, Oliver <oohall@gmail.com> wrote:
>> On Sat, Jul 7, 2018 at 5:38 AM, Dan Williams <dan.j.williams@intel.com> wrote:
>>> On Fri, Jul 6, 2018 at 1:29 AM, Aneesh Kumar K.V
>>> <aneesh.kumar@linux.ibm.com> wrote:
>>>> This patch steal system RAM and use that to emulate pmem device using the
>>>> e820 platform driver.
>>>>
>>>> This adds a new kernel command line 'pmemmap' which takes the format <size[KMG]>
>>>> to allocate memory early in the boot. This memory is later registered as
>>>> persistent memory range.
>>>>
>>>> Based on original patch from Oliver OHalloran <oliveroh@au1.ibm.com>
>>>>
>>>> Not-Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> ---
>>>>   drivers/nvdimm/Kconfig        |  13 ++++
>>>>   drivers/nvdimm/Makefile       |   1 +
>>>>   drivers/nvdimm/memblockpmem.c | 115 ++++++++++++++++++++++++++++++++++
>>>>   3 files changed, 129 insertions(+)
>>>>   create mode 100644 drivers/nvdimm/memblockpmem.c
>>>>
>>> [..]
>>>> +/*
>>>> + * pmemmap=ss[KMG]
>>>> + *
>>>> + * This is similar to the memremap=offset[KMG]!size[KMG] paramater
>>>> + * for adding a legacy pmem range to the e820 map on x86, but it's
>>>> + * platform agnostic.
>>
>>> The current memmap=ss!nn option is a non-stop source of bugs and
>>> fragility. The fact that this lets the kernel specify the base address
>>> helps, but then this is purely just a debug facility because
>>> memmap=ss!nn is there to cover platform firmware implementations that
>>> fail to mark a given address range as persistent.
>>
>>> If this is just for debug, why not use qemu?
>>
>> To make a long story short, we have two virtualisation stacks and only one of
>> them is based on qemu. An unfortunately large chunk of our customers (and
>> our internal test systems) run the other one so we need to accommodate them
>> somehow.
>>
>>> If this is not for debug what are these systems that don't have proper firmware
>>> support?
>>
>> I wrote the original version (for RHEL 7.something) for a customer who wanted
>> to do some testing which needed to be run on real hardware for some reason.
>> We couldn't install a FW update on their system so this ended up being the least
>> painful way to get them going. That's not a strong argument for
>> merging this, but
>> the point is that it's sometimes useful to have the capability in the kernel.
> 
> Ok, correct me if I'm wrong, but it seems to be purely about debug and
> emulation? If that's the case would it be acceptable to just add more
> capabilities to tools/testing/nvdimm/ for what you want to do? That
> has been our primary vehicle for testing libnvdimm.
> 

What we need is the ability to run with fsdax on hypervisor other than KVM.

-aneesh

