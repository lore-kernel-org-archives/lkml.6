Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1755588-1525733310-2-18081471160596351169
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
    1525733310; b=XxKaKCNlY5yuhrbw4faCamxxg3kgRxxbYNz0IDnpsF4ucLBgLw
    K+ckAfq8VMWASWDKjgMHNSf1Mhn7Y/GDkHvOMyG7UcmKzU3Hh5ZVpNwzzbMShpS1
    w3ONBhfLRBCNBH0juVJsIRscsXklDFl/mA8p3bDLLnNV9Z2YaP4XVdhoZucoyqO3
    6brh+FgzmCX/5u1DARSIAJohLQyWOrjFTtpt0MIMdoedpPpJI75QYON5A0viZtFH
    bus69Jh9/9RSXjfCF+xCJSYgcdEVCHJOVv2GgT+YidLld8A3UZMy46Af3Ar4ZxYO
    eli/jlIvsFRQq0WtcZcqvEDlwvNkr9cXnhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=reply-to:subject:references:to:cc:from
    :message-id:date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525733310;
    bh=DezHSekBPw1AuLDSaqQB8DO4UA3zE09KSVpqiHKQcCc=; b=jstaRsjKNgE+
    pgYSwuKkVc+yOu4e55rXyzBBGXxLOucsTLtRUvW2LvotMMbl8QJdAWDu1ACdW/KL
    1S7N8gsrReTO3uxwyEO/Dj5aK8iYxltmAWMhOTVFqGJoDV98/m3ZtgagR29VPum/
    W6yb6RqxkJKhQbCwmm6oQ0spSehB/9NkxccPbGwC9kDSz05qWE1wJUjSX6Q3lkDs
    LsrBvkh/A9Zr+JuviJur/lbfxBXREhZ+A3STzogjr5eJ0txrGkoSjW6wONm2LTJA
    Tsut/x5I8f7R8WUOJjsjjOdImOlLrKENxJj2uWXezUelbxKvCrQNLJOE8fMNiBUc
    rufPv0SVqg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=tZaEowwh x-bits=2048
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
      header.d=oracle.com header.i=@oracle.com header.b=tZaEowwh x-bits=2048
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
X-CM-Envelope: MS4wfHxSaTiTEFSorFboyTqMWX4ogZ2P5w0DqQSmEM6xtdlG8RBkNJPGHG3q7hkCNdu0UEdzfmlTlDjbZiSPMgZbnQxBbjfafpdyWAPief7m0BdXQQGK7SuW
    9K/seaVkldURqRaVvzO6Yx1Q2mLtn2J33tPFheQGWmm6eEJgoY4KwWkxLV7JSdHXzZzbyuxr1l3cfN1FG76OURt1lj3W9oDqb356MR/dRiDu9QTAclwpMGML
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=8O9ujZzbC0vujZHPNxwA:9 a=EkXTgdVJ4xe28xfw:21
    a=RSc3w1EJVMWi50ln:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeEGWs1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 18:48:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46510 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeEGWs0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 May 2018 18:48:26 -0400
Reply-To: prakash.sangappa@oracle.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <alpine.DEB.2.21.1805031259210.7831@nuc-kabylake>
 <c80ee329-084b-367f-1937-3175c178e978@oracle.com>
 <alpine.DEB.2.21.1805040955550.10847@nuc-kabylake>
 <98e34010-d55a-5f2d-7d98-cba424de2e74@oracle.com>
 <alpine.DEB.2.21.1805070945200.21162@nuc-kabylake>
To: Christopher Lameter <cl@linux.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        n-horiguchi@ah.jp.nec.com, drepper@gmail.com, rientjes@google.com
From: "prakash.sangappa" <prakash.sangappa@oracle.com>
Message-ID: <a61bc7b6-ed98-045d-95c0-b6c91fc8d1da@oracle.com>
Date: Mon, 7 May 2018 15:50:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805070945200.21162@nuc-kabylake>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805070221
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/07/2018 07:47 AM, Christopher Lameter wrote:
> On Fri, 4 May 2018, Prakash Sangappa wrote:
>> Currently 'numa_maps' gives a list of numa nodes, memory is allocated per
>> VMA.
>> Ex. we get something like from numa_maps.
>>
>> 04000  N0=1,N2=2 kernelpagesize_KB=4
>>
>> First is the start address of a VMA. This VMA could be much larger then 3 4k
>> pages.
>> It does not say which address in the VMA has the pages mapped.
> Not precise. First the address is there as you already said. That is the
> virtual address of the beginning of the VMA. What is missing? You need

Yes,

> each address for each page? Length of the VMA segment?
> Physical address?

Need numa node information for each virtual address with pages mapped.
No need of physical address.

