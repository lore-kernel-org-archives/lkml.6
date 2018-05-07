Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1755588-1525735213-2-17608129455224994477
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
    1525735212; b=N63XDjxfQaUPUnSbOlEgkGBaB2C4IMgzL+Q/OyD14AWjRy1DcR
    o6cf4KdtLfK7oNLQ/JxBlMAoDzXiBULdmu5m+4m3QN/SpKRSlcijQvVs8AQTMBON
    ZgsD49skZYe1hjH8ypvyYgw85lSsdeWNePOjcgNZBzISFoK9tLQcg6gUoi63524+
    kSNm1dNZ26txFjNxkXKCedPYV2PXCpJnBhFzQbqVwj65l9S+BeUQ5zDE5rgGPq1X
    EDyhqUDaZ/tdrohr5MR483ME19bS2TjWk1CVhebFZYZEsadYblgmyeZPxyxulxhb
    tz2WsrqyYGhAsNHhstRw3tnPmld6Kqmvnmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=reply-to:subject:references:to:cc:from
    :message-id:date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525735212;
    bh=Nwu3qTbs1Ms6Pjvjcq7PYZtuG9munu1VrK3mvGwpwjs=; b=EAF1zTdyeF9q
    kNQvYOhSKeclAyZXInSwc3YfBjdqv0Yf2fj2eO8VguTsZmkkmrNyY9YOUiuClUy2
    BERQDVzLu/CK44jUgy7vM1AnKPlGUcYUP6z7yVrRg2bwmQa6PckRsuYzBso6Gg8k
    PDtaHMxUhp7xJsPKje7VqEbWdaVQfxnCL6AiHuSWsjVEzIK50/82nVU70Q2dm6J/
    pFAnpLj/w8xG1QO4YuEBLXjbJNsDcgp8B3qjabfruZTaOvBrCYm/evLdWe9ornnv
    4RSxmbjSv4N5zrbMLJgVslxwM0PkwUj9NrdrYWOshc8z1SQGXxah5lj5fjw0y/nf
    6JhCYDt6Pg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=EEuE2c8h x-bits=2048
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
      header.d=oracle.com header.i=@oracle.com header.b=EEuE2c8h x-bits=2048
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
X-CM-Envelope: MS4wfFfBW6LkPicaY1zrqCNJe4FYLkH7Jc53b2np0Sf/NqK9sCcR4A62KAMP3PtFkhNPzknsSsW6eWq0IytSg0kiy3ds70fOe29iSEfz5CY5aHhXPzw99wjN
    Ibphig34qhsaYrPWkm2P1/7C/KXEq8t6Rt8e/dFI6SlXbGL4xw5g23MYQYe6C2T9EIWCmEo1zqN6ZcHeP8RAU+XJRd7tVO/vlXeSeP/jPlRzp68qay4jv/eF
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=jR_jn9RygcA7SmgMFaAA:9 a=eTtvOPRKWyR9oeHr:21
    a=Oz6EAqsJdbJcoZrH:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753153AbeEGXUL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 19:20:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55290 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752966AbeEGXUK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 May 2018 19:20:10 -0400
Reply-To: prakash.sangappa@oracle.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <20180502143323.1c723ccb509c3497050a2e0a@linux-foundation.org>
 <2ce01d91-5fba-b1b7-2956-c8cc1853536d@intel.com>
 <33f96879-351f-674a-ca23-43f233f4eb1d@linux.vnet.ibm.com>
 <82d2b35c-272a-ad02-692f-2c109aacdfb6@oracle.com>
 <8569dabb-4930-aa20-6249-72457e2df51e@intel.com>
To: Dave Hansen <dave.hansen@intel.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com,
        drepper@gmail.com, rientjes@google.com,
        Naoya Horiguchi <nao.horiguchi@gmail.com>
From: "prakash.sangappa" <prakash.sangappa@oracle.com>
Message-ID: <51145ccb-fc0d-0281-9757-fb8a5112ec24@oracle.com>
Date: Mon, 7 May 2018 16:22:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <8569dabb-4930-aa20-6249-72457e2df51e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805070226
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/03/2018 03:26 PM, Dave Hansen wrote:
> On 05/03/2018 03:27 PM, prakash.sangappa wrote:
>> If each consecutive page comes from different node, yes in
>> the extreme case is this file will have a lot of lines. All the lines
>> are generated at the time file is read. The amount of data read will be
>> limited to the user read buffer size used in the read.
>>
>> /proc/<pid>/pagemap also has kind of  similar issue. There is 1 64
>> bit value for each user page.
> But nobody reads it sequentially.  Everybody lseek()s because it has a
> fixed block size.  You can't do that in text.

The current text based files  on /proc does allow seeking, but it will not
help to seek to a specific VA(vma) to start from, as the seek offset 
will be the
offset in the text. This is the case with using 'seq_file' interface in the
kernel to generate the /proc file content.

However, with the proposed new file, we could allow seeking to specified
virtual address. The lseek offset in this case would represent the 
virtual address
of the process. Subsequent read from the file would provide VA range to 
numa node
information starting from that VA. In case the VA seek'ed to is invalid, 
it will start
from the next valid mapped VA of the process. The implementation would
not be based on seq_file.

For example.
Getting numa node information for a process having the following VMAs 
mapped,
starting from '006dc000'

00400000-004dd000
006dc000-006dd000
006dd000-006e6000

Can  seek to VA 006dc000 and start reading, it would get following

006dc000-006dd000 N1=1 kernelpagesize_kB=4 anon=1 dirty=1 
file=/usr/bin/bash
006dd000-006de000 N0=1 kernelpagesize_kB=4 anon=1 dirty=1 
file=/usr/bin/bash
006de000-006e0000 N1=2 kernelpagesize_kB=4 anon=2 dirty=2 
file=/usr/bin/bash
006e0000-006e6000 N0=6 kernelpagesize_kB=4 anon=6 dirty=6 
file=/usr/bin/bash
..


One advantage with getting numa node information from this /proc file vs 
say
using 'move_pages()' API, will be that the /proc file will be able to 
provide address
range to numa node information, not one page at a time.

