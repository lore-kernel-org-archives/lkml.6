Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3209358-1525386366-2-5317887332994715562
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525386365; b=PJdFBkvtTp4vx9MyjXaH4WHF1CiP5dVxd9SHF+hUa3+Tapi5dt
    4ENPeQxH/L/yivQ+a1LnLnpsHqa3ZF2QKShTSmI0N5qup0zQ5TlvWRQa42iJ7poA
    mvxe/kK2nMWm5fgSZe5RqW2iiMysXj9NPIfGGxm8gspp6qGY88vR56ZDRHg1LwJM
    RLdT94daxfJAHqEC6wVUEPk/JuumQPC8B1sfpGsN2bcG1Xy0s1lhAXLRpDwPom9c
    Z0QYkkRVsBH8flKExxt8sWqH/QcRq/YR+SnIqbpjyhzxcv+bHen5oxJxLGntFaRM
    W5iSLt84XpziF8lAFe248eca15weyjH/hAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=reply-to:subject:references:to:cc:from
    :message-id:date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525386365;
    bh=m8xaoq5smF6LzfYkfY3TXZ6pns6EUtA92+nmOKAQZKg=; b=fRUHd1YsySFy
    JT4XQpsHkaYl8TWSeCdZU4wgdfWZ9WTyFMJAiF0RK3Xi7/f8XA7sKGhCC08WOUrA
    deUK0xcdewt9/bQQafxNsvTApv6zjkhy/NWnBY/h86rWbaEd94VdvkCzMUhRFC6Z
    VojkMgpX3ui01Fmc9oYwpdmGHbWldzfklD4zj9xiK74Vm8gGeLg7u7vdhqS/7AtT
    TV2s0A82ZfpeEGJbMD+wc+uINO8Q2WUCMPvS40N6SlLcgCy51/YdeJEoKo08PWmb
    7QiY9r5tPgdO4c0obyr+JoZChRCl1dFghES9o6EwqnVHVVKYrEqMUFhPZb9phZxF
    jy9ssm+jaA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=uJfjKqYK x-bits=2048
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=uJfjKqYK x-bits=2048
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
X-CM-Envelope: MS4wfMCg0eV0iLW43ieMqsc//ZJ5pk4zwrFmISZFym3/Qvia4vnQD89mlXK1zknuSAUZuaElVUskp7l84NUhGWmrj6wOsVp1S5kgqje71BMbpRE1JuixxPRX
    kjbMkX/EMiLHR3Sr+B/Cqmin/sS1tafArIbBE0uBH68CzEviId1MKpPiUb6TfyQ7Dym42lZ9n7xe9/2BIZowjb5xPItdwb1CGZh8jn7ULiZrFBSXiIYjm6Dw
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=IhMvO81UP1UsV3Oi84gA:9
    a=dmxy92tORmMVRSav:21 a=uHV4vyzeFbRI9-DF:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750911AbeECW0C (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 18:26:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37178 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeECW0C (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 18:26:02 -0400
Reply-To: prakash.sangappa@oracle.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <20180502143323.1c723ccb509c3497050a2e0a@linux-foundation.org>
 <2ce01d91-5fba-b1b7-2956-c8cc1853536d@intel.com>
 <33f96879-351f-674a-ca23-43f233f4eb1d@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com,
        drepper@gmail.com, rientjes@google.com,
        Naoya Horiguchi <nao.horiguchi@gmail.com>
From: "prakash.sangappa" <prakash.sangappa@oracle.com>
Message-ID: <82d2b35c-272a-ad02-692f-2c109aacdfb6@oracle.com>
Date: Thu, 3 May 2018 15:27:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <33f96879-351f-674a-ca23-43f233f4eb1d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8882 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030194
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/03/2018 01:46 AM, Anshuman Khandual wrote:
> On 05/03/2018 03:58 AM, Dave Hansen wrote:
>> On 05/02/2018 02:33 PM, Andrew Morton wrote:
>>> On Tue,  1 May 2018 22:58:06 -0700 Prakash Sangappa <prakash.sangappa@oracle.com> wrote:
>>>> For analysis purpose it is useful to have numa node information
>>>> corresponding mapped address ranges of the process. Currently
>>>> /proc/<pid>/numa_maps provides list of numa nodes from where pages are
>>>> allocated per VMA of the process. This is not useful if an user needs to
>>>> determine which numa node the mapped pages are allocated from for a
>>>> particular address range. It would have helped if the numa node information
>>>> presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
>>>> exact numa node from where the pages have been allocated.
>> I'm finding myself a little lost in figuring out what this does.  Today,
>> numa_maps might us that a 3-page VMA has 1 page from Node 0 and 2 pages
>> from Node 1.  We group *entirely* by VMA:
>>
>> 1000-4000 N0=1 N1=2
>>
>> We don't want that.  We want to tell exactly where each node's memory is
>> despite if they are in the same VMA, like this:
>>
>> 1000-2000 N1=1
>> 2000-3000 N0=1
>> 3000-4000 N1=1
> I am kind of wondering on a big memory system how many lines of output
> we might have for a large (consuming lets say 80 % of system RAM) VMA
> in interleave policy. Is not that a problem ?
>
If each consecutive page comes from different node, yes in
the extreme case is this file will have a lot of lines. All the lines
are generated at the time file is read. The amount of data read will be
limited to the user read buffer size used in the read.

/proc/<pid>/pagemap also has kind of  similar issue. There is 1 64 bit 
value
for each user page.

