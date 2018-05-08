Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1916315-1525742056-2-2966299465619539492
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525742055; b=asi2r8ylWij/HtWVwVeSbgXlzkxJnpoMSqJnSfMEKLACi8Fs+s
    eE40SiVJls2J3h42DJsARF8DYMWHVxKv6uO/4FqRhKFv5KA1puWPYlQgpVuDxCv4
    uiLH+9m5TiBHBR1qxBX9SG4bydcKC7DrIuaJZHoEivWxkqztrWypAgZmE+v5tES2
    mdySeBAhYRHk7HxhNvTAeMzxXOm3UHt+p3A9cpa4k+wbzcF30Clp94mascAT6Lxv
    CubnZQchpButgXIcTkIGiTT2bETlRuhG3OekIZWSi/7SNs6o0HWhyYNUIU8rYxTY
    Td+hypGyxP+WDj6B/+QmZUMFo8/vDhp6TmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=reply-to:subject:references:to:cc:from
    :message-id:date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525742055;
    bh=Mfuhdk+qZrkctJfg3HmVRAfwTKiJHziJV3wcZJQEt0I=; b=EibPRxnr94W8
    XS0ARqm6H25Kqcs62p0aIZp2QP6DlvxUG2Gxb4O/noHETH3ySVqzGFL0XX/21gg/
    SupIrRm3kTJEIKpCyPCmV2wyWOiegge8HkJTAyr3x/ACq9e7ZOfz1HefWCL/7jG2
    iDgfOTLWPKe7TS7RBbXhdnT6xZrY64h7PeNFmTecKCgln8ioeCtRHQgJfpk/xDRl
    yiiFXaFlm4hHzxBy77GfWJhW8ypy0gUgpEbH07m7EUKehWbkoM17LcazIHNYLLQl
    OA0CBwXSHM6MMA+WjJnWzCucnujI1u8zfQyhopmgtrU4w7K7miP9uua6d3FsXCM+
    GIwCyfPVEw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=aZOM/QLj x-bits=2048
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=aZOM/QLj x-bits=2048
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
X-CM-Envelope: MS4wfHN9gN8x7pkTbdeRbjDILswC1nrRAA08cMB2n3PQlXT7hE8tic1du0PJQBMoZCh4ivEpmEb1YTy2f/OEtT6H6uMdfeTtuRRDmq5OMBciIPuRdRzgROCo
    jb9B/lG9QDa+DQPJ3D5i+IL5ajzIHM2BBrRJnE3EuTLd3Y4Z9oYU3vrJXhImNWvx93VWzGQ6iVAyfjkiyYqOFaI4GhmHNyF1ZLPLoWKncXyBh1vJYxKH7xSa
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=x-6f8LiKhg_-_drJVn4A:9 a=1SfNubkCIE6c7GWb:21
    a=tKxCqLBNKp1NrC-l:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753617AbeEHBON (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 21:14:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47996 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753581AbeEHBOM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 May 2018 21:14:12 -0400
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
To: Dave Hansen <dave.hansen@intel.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com,
        drepper@gmail.com, rientjes@google.com,
        Naoya Horiguchi <nao.horiguchi@gmail.com>
From: "prakash.sangappa" <prakash.sangappa@oracle.com>
Message-ID: <addeaadc-5ab2-f0c9-2194-dd100ae90f3a@oracle.com>
Date: Mon, 7 May 2018 18:16:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <c72fea44-59f3-b106-8311-b5eae2d254e7@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=776
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080009
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/07/2018 05:05 PM, Dave Hansen wrote:
> On 05/07/2018 04:22 PM, prakash.sangappa wrote:
>> However, with the proposed new file, we could allow seeking to
>> specified virtual address. The lseek offset in this case would
>> represent the virtual address of the process. Subsequent read from
>> the file would provide VA range to numa node information starting
>> from that VA. In case the VA seek'ed to is invalid, it will start
>> from the next valid mapped VA of the process. The implementation
>> would not be based on seq_file.
> So you're proposing a new /proc/<pid> file that appears next to and is
> named very similarly to the exiting /proc/<pid>, but which has entirely
> different behavior?

It will be /proc/<pid>/numa_vamaps. Yes, the behavior will be
different with respect to seeking. Output will still be text and
the format will be same.

I want to get feedback on this approach.
