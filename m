Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1503315-1525302950-2-11488568958444490464
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
    1525302949; b=jx/mu/e+UzZ7leSAORNzOH4GtxlamgZmPnqZPcVVF32/+ytcV2
    k+j2II2l9twS0M/EETksMpbt/rH0Ef5pYMrhVRkbDHOyZxic0bry1IbY32Kf80ji
    Hn5V3zapNcd7BGBR0zstlRJ3otIBWqgZ1JhfFjYtsx78wa9X/PVC9aJJC0b5GCbx
    f1sPkleeM2Awxe1lUOUQzVo/I2L+XIwE/s9GKtbMUXufPdkrD/s7EessQcAD6KO5
    HMw+499jITH2yMNE4FUyf88ggY2jbamop4z84rRXWDPFAMpfKxFQLoXNMq9NNKSO
    i1OiYZ2gQqxdtMGFVSsy4BB3Sdnd4EPOcc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=reply-to:subject:references:to:cc:from
    :message-id:date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525302949;
    bh=N1I+OdSSjv13Xpp9V6mTIZxZvrNZBREoiqyUkuZXu10=; b=RFWcFYzkCKhy
    WxQPzVL7Ars7i2RKobmLWhJG5k8rDXr0soSqSsBf5N3sB/88bb9PrUcBPRkXmrtE
    27ghWfAFpdpIlhGNwnHBlT2lIbi35Q9PQg/bPpYfNEkkaNcAS1MfSzUJgYnnQm86
    /tr0vCnUTcuQaWapsJGkBvtxnqzyftfWQ7sDIkIav1og6HEzuk2D+H/WNrvGNdiO
    8v1IVqfXD7lD9Ximn5+3y17dxcXnj5Hhy3I+ADlFRCE8N7sAWmKeLFu4FCMN2bxy
    UT7z/tE4NBAJwKlIxQ3VBQ1MFUpucLyx9KsuZZOAjEMS3aN2vWbRfcOINorTrsdS
    vKx61bLhgQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=fBfbB1+1 x-bits=2048
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
      header.d=oracle.com header.i=@oracle.com header.b=fBfbB1+1 x-bits=2048
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
X-CM-Envelope: MS4wfNOZzoN6Wva3X8WlDtTTPKfVpYpmT3qLyZ8cZOx9BOh65YA1Pvzkrd41L6ozYQpXJXb821uATKlEwz1AJdOMfu0UOcNDDaXZS8RNlCJudkyorg0jOZxX
    a21wZP3hbY5GucP7Jlf7/94qGPrYwXWboN3LL7PpFRXDsbVArly9lP1UoT90zZ5CF+K/dAuN1/osULnwwqaI3lo+ppj1j5j4TcRLJp7E/2goDEC45avuE6Fs
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=D_SMEIBUBYLu0gkwncgA:9
    a=Ax7jt-hkKLtsyz7L:21 a=YcE46P1NyH1fY2rP:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeEBXPs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 19:15:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41594 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbeEBXPq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 19:15:46 -0400
Reply-To: prakash.sangappa@oracle.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <20180502143323.1c723ccb509c3497050a2e0a@linux-foundation.org>
 <2ce01d91-5fba-b1b7-2956-c8cc1853536d@intel.com>
To: Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com,
        drepper@gmail.com, rientjes@google.com,
        Naoya Horiguchi <nao.horiguchi@gmail.com>
From: "prakash.sangappa" <prakash.sangappa@oracle.com>
Message-ID: <5d2d820b-4a6e-242d-3927-0d693198602a@oracle.com>
Date: Wed, 2 May 2018 16:17:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <2ce01d91-5fba-b1b7-2956-c8cc1853536d@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805020193
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/02/2018 03:28 PM, Dave Hansen wrote:
> On 05/02/2018 02:33 PM, Andrew Morton wrote:
>> On Tue,  1 May 2018 22:58:06 -0700 Prakash Sangappa <prakash.sangappa@oracle.com> wrote:
>>> For analysis purpose it is useful to have numa node information
>>> corresponding mapped address ranges of the process. Currently
>>> /proc/<pid>/numa_maps provides list of numa nodes from where pages are
>>> allocated per VMA of the process. This is not useful if an user needs to
>>> determine which numa node the mapped pages are allocated from for a
>>> particular address range. It would have helped if the numa node information
>>> presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
>>> exact numa node from where the pages have been allocated.
> I'm finding myself a little lost in figuring out what this does.  Today,
> numa_maps might us that a 3-page VMA has 1 page from Node 0 and 2 pages
> from Node 1.  We group *entirely* by VMA:
>
> 1000-4000 N0=1 N1=2

Yes

>
> We don't want that.  We want to tell exactly where each node's memory is
> despite if they are in the same VMA, like this:
>
> 1000-2000 N1=1
> 2000-3000 N0=1
> 3000-4000 N1=1
>
> So that no line of output ever has more than one node's memory.  It

Yes, that is exactly what this patch will provide. It may not have
been clear from the sample output I had included.

Here is another snippet from a process.

..
006dc000-006dd000 N1=1 kernelpagesize_kB=4 anon=1 dirty=1 file=/usr/bin/bash
006dd000-006de000 N0=1 kernelpagesize_kB=4 anon=1 dirty=1 file=/usr/bin/bash
006de000-006e0000 N1=2 kernelpagesize_kB=4 anon=2 dirty=2 file=/usr/bin/bash
006e0000-006e6000 N0=6 kernelpagesize_kB=4 anon=6 dirty=6 file=/usr/bin/bash
006e6000-006eb000 N0=5 kernelpagesize_kB=4 anon=5 dirty=5
006eb000-006ec000 N1=1 kernelpagesize_kB=4 anon=1 dirty=1
007f9000-007fa000 N1=1 kernelpagesize_kB=4 anon=1 dirty=1 heap
007fa000-00965000 N0=363 kernelpagesize_kB=4 anon=363 dirty=363 heap
00965000-0096c000 -  heap
0096c000-0096d000 N0=1 kernelpagesize_kB=4 anon=1 dirty=1 heap
0096d000-00984000 -  heap
..

> *appears* in this new file as if each contiguous range of memory from a
> given node has its own VMA.  Right?

No. It just breaks down each VMA of the process into address ranges
which have pages on a numa node on each line. i.e Each line will
indicate memory from one numa node only.

>
> This sounds interesting, but I've never found myself wanting this
> information a single time that I can recall.  I'd love to hear more.
>
> Is this for debugging?  Are apps actually going to *parse* this file?

Yes, mainly for debugging/performance analysis . User analyzing can look
at this file. Oracle Database team will be using this information.

>
> How hard did you try to share code with numa_maps?  Are you sure we
> can't just replace numa_maps?  VMAs are a kernel-internal thing and we
> never promised to represent them 1:1 in our ABI.

I was inclined to just modify numa_maps. However the man page
documents numa_maps format to correlate with 'maps' file.
Wondering if apps/scripts will break if we change the output
of 'numa_maps'.  So decided to add a new file instead.

I could try to share the code with numa_maps.

>
> Are we going to continue creating new files in /proc every time a tiny
> new niche pops up? :)

Wish we could just enhance the existing files.


