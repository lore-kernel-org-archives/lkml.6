Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656E9C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090F120C0A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yll5MIii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090F120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeIMCFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 22:05:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43682 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeIMCFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 22:05:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8CKrsqx096413;
        Wed, 12 Sep 2018 20:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 references : to : cc : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=AjgqPpWGn1RAC0V72f53myLraLtbblMtLHSCj1uaba4=;
 b=yll5MIiiACxQKMlOeC2FAfbt+oahk2KcZvUNMnbrCLl0PsMwkfZbovBWsLNk3rCL4Cyt
 ons/bfy1QaiyoB1Njd7hO4vZR5X3BcnJssLodn5ThZoqlpOlezki2tVLUEOqKTpv9LxH
 KdEA6TefS8S4juKsX/pfANzBj47ks/ssfjVbSkiUX5msZBJo8oBliOS/WggJ6jauWPsN
 xqRVjYQWmvOPk8AYOVoCuNl00I1so0XvM2oDd+RLXqiyRXZm2ic2h7zVXHCH7Slycwns
 7+GAtD3vvFfrN1NJkojKvVdSt5ICYB7UYNvX31usubMLuGQxM82LOznqsZbpxAup649J YA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mc5utmkfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:58:35 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8CKwYo1030426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 20:58:34 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8CKwX22020507;
        Wed, 12 Sep 2018 20:58:33 GMT
Received: from [10.132.93.61] (/10.132.93.61)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Sep 2018 13:58:33 -0700
Reply-To: prakash.sangappa@oracle.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <20180502143323.1c723ccb509c3497050a2e0a@linux-foundation.org>
 <2ce01d91-5fba-b1b7-2956-c8cc1853536d@intel.com>
 <33f96879-351f-674a-ca23-43f233f4eb1d@linux.vnet.ibm.com>
 <82d2b35c-272a-ad02-692f-2c109aacdfb6@oracle.com>
 <8569dabb-4930-aa20-6249-72457e2df51e@intel.com>
 <51145ccb-fc0d-0281-9757-fb8a5112ec24@oracle.com>
 <c72fea44-59f3-b106-8311-b5eae2d254e7@intel.com>
 <addeaadc-5ab2-f0c9-2194-dd100ae90f3a@oracle.com>
 <aaca3180-7510-c008-3e12-8bbe92344ef4@intel.com>
 <94ee0b6c-4663-0705-d4a8-c50342f6b483@oracle.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com,
        drepper@gmail.com, rientjes@google.com,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Steven Sistare <steven.sistare@oracle.com>
From:   "prakash.sangappa" <prakash.sangappa@oracle.com>
Message-ID: <261d2ecb-53b4-a696-2216-8bf1bfaf61b8@oracle.com>
Date:   Wed, 12 Sep 2018 13:57:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <94ee0b6c-4663-0705-d4a8-c50342f6b483@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9014 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809120205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/12/2018 01:42 PM, prakash.sangappa wrote:
>
>
> On 05/09/2018 04:31 PM, Dave Hansen wrote:
>> On 05/07/2018 06:16 PM, prakash.sangappa wrote:
>>> It will be /proc/<pid>/numa_vamaps. Yes, the behavior will be
>>> different with respect to seeking. Output will still be text and
>>> the format will be same.
>>>
>>> I want to get feedback on this approach.
>> I think it would be really great if you can write down a list of the
>> things you actually want to accomplish.  Dare I say: you need a
>> requirements list.
>>
>> The numa_vamaps approach continues down the path of an ever-growing list
>> of highly-specialized /proc/<pid> files.  I don't think that is
>> sustainable, even if it has been our trajectory for many years.
>>
>> Pagemap wasn't exactly a shining example of us getting new ABIs right,
>> but it sounds like something along those is what we need.
>
> Just sent out a V2 patch.  This patch simplifies the file content. It
> only provides VA range to numa node id information.
>
> The requirement is basically observability for performance analysis.
>
> - Need to be able to determine VA range to numa node id information.
>   Which also gives an idea of which range has memory allocated.
>
> - The proc file /proc/<pid>/numa_vamaps is in text so it is easy to
>   directly view.
>
> The V2 patch supports seeking to a particular process VA from where
> the application could read the VA to  numa node id information.
>
> Also added the 'PTRACE_MODE_READ_REALCREDS' check when opening the
> file /proc file as was indicated by Michal Hacko
>
I meant Michal Hocko
Sorry misspelled the name.


> The VA range to numa node information from this file can be used by pmap.
>
> Here is a sample from a prototype change to pmap(procps) showing
> numa node information, gathered from the new 'numa_vamaps' file.
>
> $ ./rpmap -L -A 00000000006f8000,00007f5f730fe000 31423|more
> 31423:   bash
> 00000000006f8000     16K  N1 rw--- bash
> 00000000006fc000      4K  N0 rw--- bash
> 00000000006fd000      4K  N0 rw---   [ anon ]
> 00000000006fe000      8K  N1 rw---   [ anon ]
> 0000000000700000      4K  N0 rw---   [ anon ]
> 0000000000701000      4K  N1 rw---   [ anon ]
> 0000000000702000      4K  N0 rw---   [ anon ]
> 0000000000ce8000     52K  N0 rw---   [ anon ]
> 0000000000cf5000      4K  N1 rw---   [ anon ]
> 0000000000cf6000     28K  N0 rw---   [ anon ]
> 0000000000cfd000      4K  N1 rw---   [ anon ]
> 0000000000cfe000     28K  N0 rw---   [ anon ]
> 0000000000d05000    504K  N1 rw---   [ anon ]
> 0000000000d83000      8K  N0 rw---   [ anon ]
> 0000000000d85000    932K  N1 rw---   [ anon ]
> 0000000000e6e000      4K   - rw---   [ anon ]
> 0000000000e6f000    168K  N1 rw---   [ anon ]
> 00007f5f72ef4000      4K  N2 r-x-- libnss_files-2.23.so
> 00007f5f72ef5000     40K  N0 r-x-- libnss_files-2.23.so
> 00007f5f72eff000   2044K   - ----- libnss_files-2.23.so
> 00007f5f730fe000      4K  N0 r---- libnss_files-2.23.so
>  total             3868K
>
> -Prakash.

