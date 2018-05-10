Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2396152-1525970262-2-3430628603877875874
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525970261; b=H3FegNzs2XjmMhRyMWKZg9e+LKKa6YkdiCyCWW7XWhfvhVcVx3
    sylKtPtLzm8AAfpm1sYNUvQhV2RztPr+wfh/OXHoXLzhEJBy3E0NuwvJLZZUUAjW
    KlUw9XBexAWdylw9923WidHhVT2/ajT0GCJ96Eag7fnLQ6qZ/AMDKA5HXQR4I7bM
    GoQhvCn9IJ7ldft6yT4ghecVlZ3T5o2ato7nhoxMr7LnRATHoeVoXjWI8oQ65BtX
    YmYlFQRoFE0pHPshCV/gcjnYypM8xCaKy8i3/9MNzY+vGDvbS2iROKRh1oSowO+T
    QIcgcqkn1n6443p7yDHUGuUwwkAzn5gDBhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525970261;
    bh=b7iCek+m1+XycWGujD8rO6dDRwq/JhpHIeT1m4NyXQY=; b=U9ITcRpiL+Vm
    jafj6tLK72qUdCaEhPaWtJyY9lLLIV0VyEtJp0ewFPcb2D6H5ANQvSB5whNogPZl
    vmxsBKY9Hlrk5VT0xphePDRIh0ROGqX96Ojf16TG5fA6MiyQBcEGuGSNcGrBVjFL
    VP/9kNcQCbdDWB1ytiPm2lUvfn6owW948cJb6TvnLkP3hoIW3plBYYV6aM+xKCgI
    Q4td9BJgWIBmERX0ykyjnQ1FhQYxNhxCI/iUaBCSTm4CIRlZJAI5f+4Z/UXycHpK
    ykbS7x7HN9w9kHJ7uOXE5tV/3WFQeF5mZPyustIlV+buSEC2R+l+wPEnMsG3jTyt
    kuApAUfJ1w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=eU6dn2p0 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=eU6dn2p0 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDTdxlpQi0AdJm+N7+D+We0MSXXz3GkBgGFDR14nK4/OPZnLNE1UH3Q4ElykOY1q3A5LI3A6VTVaUXLpd3t2ZaDn93fxOSWgYPf/AmjgRumBCSZ6vJJN
    7XZKhUOnIbluD+CeQKSKn51LdBDgeJx33oWfBc/tuz3mNjU665kQsGwT+bXs03Q0anivLcDYRx4GWmvLMCRnVdcOWkUksSCzKTEblJVDlDQOIGwcQUoP0aYk
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=62oRJt5XXfBYd8pBSfMA:9 a=UO2K_p9QxXwtMQR8:21
    a=4bBN9JC4ciVgQKZs:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966087AbeEJQhk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 12:37:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38972 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965017AbeEJQhj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 May 2018 12:37:39 -0400
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
To: Michal Hocko <mhocko@kernel.org>
Cc: Christopher Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        n-horiguchi@ah.jp.nec.com, drepper@gmail.com, rientjes@google.com
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <alpine.DEB.2.21.1805031259210.7831@nuc-kabylake>
 <c80ee329-084b-367f-1937-3175c178e978@oracle.com>
 <20180504111211.GO4535@dhcp22.suse.cz>
 <de18dc06-6448-d6e5-fa80-c6065edd3aa4@oracle.com>
 <20180510074254.GE32366@dhcp22.suse.cz>
From: Prakash Sangappa <prakash.sangappa@oracle.com>
Message-ID: <ce2c36aa-8c03-63d6-e1ce-031197f45a5d@oracle.com>
Date: Thu, 10 May 2018 09:00:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510074254.GE32366@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8888 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805100156
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 5/10/18 12:42 AM, Michal Hocko wrote:
> On Fri 04-05-18 09:18:11, Prakash Sangappa wrote:
>>
>> On 5/4/18 4:12 AM, Michal Hocko wrote:
>>> On Thu 03-05-18 15:39:49, prakash.sangappa wrote:
>>>> On 05/03/2018 11:03 AM, Christopher Lameter wrote:
>>>>> On Tue, 1 May 2018, Prakash Sangappa wrote:
>>>>>
>>>>>> For analysis purpose it is useful to have numa node information
>>>>>> corresponding mapped address ranges of the process. Currently
>>>>>> /proc/<pid>/numa_maps provides list of numa nodes from where pages are
>>>>>> allocated per VMA of the process. This is not useful if an user needs to
>>>>>> determine which numa node the mapped pages are allocated from for a
>>>>>> particular address range. It would have helped if the numa node information
>>>>>> presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
>>>>>> exact numa node from where the pages have been allocated.
>>>>> Cant you write a small script that scans the information in numa_maps and
>>>>> then displays the total pages per NUMA node and then a list of which
>>>>> ranges have how many pages on a particular node?
>>>> Don't think we can determine which numa node a given user process
>>>> address range has pages from, based on the existing 'numa_maps' file.
>>> yes we have. See move_pages...
>> Sure using move_pages, not based on just 'numa_maps'.
>>
>>>>>> reading this file will not be restricted(i.e requiring CAP_SYS_ADMIN).
>>>>> So a prime motivator here is security restricted access to numa_maps?
>>>> No it is the opposite. A regular user should be able to determine
>>>> numa node information.
>>> Well, that breaks the layout randomization, doesn't it?
>> Exposing numa node information itself should not break randomization right?
> I thought you planned to expose address ranges for each numa node as
> well. /me confused.

Yes, are you suggesting this information should not be available to a 
regular
user?

Is it not possible to get that same information using the move_pages() 
api as a regular
user, although one / set of pages at a time?


>> It would be upto the application. In case of randomization, the application
>> could generate  address range traces of interest for debugging and then
>> using numa node information one could determine where the memory is laid
>> out for analysis.
> ... even more confused
>

