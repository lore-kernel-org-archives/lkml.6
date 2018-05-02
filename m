Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1359032-1525295672-2-1857010679927478261
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
    1525295671; b=gXdDNwLP51bOVlumM7wV6SDfNJmOYAIMMlDhC0CEXNJgAVQAMP
    9EEOSsnYmF4L2qjC5hAnkmdcfmDGgcF+39LsH15FPSoLD9KxBcSb2V2+XG6Fechh
    lEYfW4pQ973rsKzksFKm47sr+dmZfb2n0ZhMkEc2jdZsGpUZlY1fdlazPmn9xILp
    pT92LFT+5bo3Vx/Fp/SVxFzKQJoWh+eRGUE0MKL435IAn78zsTkbCs904JCX1mQw
    24paC9lo12khJ6bQZXLfmKuHMOQUppF/2tAn5FfCiN2HBZwX5vOsQg+QmvXH8itL
    Sp2EE9jxCCdHx2f8Ocj76lmnt/s7a6/CxVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525295671;
    bh=72JnI+JEj4YoV4MAwZTgwB5mqAczNaRHwv4wNhpXJjY=; b=HTQ6YtDrPzXg
    ybgTN97jkz92o1vKqh4Es6ZnvDUhWLPY96VXREGFnSUS0Upfypb5K9BWcJU/VPCl
    i6DNrGvsR16tNtsGnoR2/cHq+DRrpJVR7PdjzOIGjNnBBWJARs7i9NuqksiLZlAF
    AIj+/zdaNDQjzHsFsn2O5jElpD+oDc+4AK2ElDO2yeT+4uYHQ7Fbx0uSaYVUTTkG
    JzJCyNCxsqic6vxvtDojBXUskpdsjNcxdszDnXjmhcZzcM/akIjgoQUaGZFvktBU
    Iy58h9yDZGTZVIkUb+IVNY1TlYr0MrP2dsjp89FCQVBSmup09+rfEJqAe5XEBIye
    0/H4Wzm+1w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=pU5j3IdZ x-bits=2048
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=pU5j3IdZ x-bits=2048
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
X-CM-Envelope: MS4wfGw1FTxvg77Yoh3Ybs2sNBXe9V6DezM7pLNfRFY6al394HsLRsL2LZZAkIk5pBSDsApTXHOLuLipd3daZC/OPZRpQIT4YwX0Sjm+VIdpfJC0iPa0HxRH
    9duEz/O7LPO/PvPveyRZABLUL4wuMK6ILyiHxbuw2sIu1uW1uE8KWV1XmtmvmR/JjinnxUaE4Q7vAfiA42utjCJj/HLNoitEFYZ56Ns3YMzI2Dc4YAN2JXd5
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=qqHblvjzxz2coTAlHHIA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeEBVOa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:14:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38884 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeEBVO3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 17:14:29 -0400
Subject: Re: [PATCH 2/3] mm: add find_alloc_contig_pages() interface
To: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Guy Shattah <sguy@mellanox.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        David Nellans <dnellans@nvidia.com>,
        Laura Abbott <labbott@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180417020915.11786-1-mike.kravetz@oracle.com>
 <20180417020915.11786-3-mike.kravetz@oracle.com>
 <deb9dd1d-84bf-75c7-2880-a7bcec880d47@suse.cz>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <af56d281-fea1-2bd7-aff1-108fa1d9f3be@oracle.com>
Date: Wed, 2 May 2018 14:13:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <deb9dd1d-84bf-75c7-2880-a7bcec880d47@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=855
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805020177
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/21/2018 09:16 AM, Vlastimil Babka wrote:
> On 04/17/2018 04:09 AM, Mike Kravetz wrote:
>> find_alloc_contig_pages() is a new interface that attempts to locate
>> and allocate a contiguous range of pages.  It is provided as a more
>> convenient interface than alloc_contig_range() which is currently
>> used by CMA and gigantic huge pages.
>>
>> When attempting to allocate a range of pages, migration is employed
>> if possible.  There is no guarantee that the routine will succeed.
>> So, the user must be prepared for failure and have a fall back plan.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Hi, just two quick observations, maybe discussion pointers for the
> LSF/MM session:
> - it's weird that find_alloc_contig_pages() takes an order, and
> free_contig_pages() takes a nr_pages. I suspect the interface would be
> more future-proof with both using nr_pages? Perhaps also minimum
> alignment for the allocation side? Order is fine for hugetlb, but what
> about other potential users?

Agreed, and I am changing this to nr_pages and adding alignment.

> - contig_alloc_migratetype_ok() says that MIGRATE_CMA blocks are OK to
> allocate from. This silently assumes that everything allocated by this
> will be migratable itself, or it might eat CMA reserves. Is it the case?
> Also you then call alloc_contig_range() with MIGRATE_MOVABLE, so it will
> skip/fail on MIGRATE_CMA anyway IIRC.

When looking closer at the code, alloc_contig_range currently has comments
saying migratetype must be MIGRATE_MOVABLE or MIGRATE_CMA.  However, this
is not checked/enforced anywhere in the code (that I can see).  The
migratetype passed to alloc_contig_range() will be used to set the migrate
type of all pageblocks in the range.  If there is an error, one side effect
is that some pageblocks may have their migrate type changed to migratetype.
Depending on how far we got before hitting the error, the number of pageblocks
changed is unknown.  This actually can happen at the lower level routine
start_isolate_page_range().

My first thought was to make start_isolate_page_range/set_migratetype_isolate
check that the migrate type of a pageblock was migratetype before isolating.
This would work for CMA, and I could make it work for the new allocator.
However, offline_pages also calls start_isolate_page_range and I believe we
do not want to enforce such a rule (all pageblocks must be of the same migrate
type) for memory hotplug/offline?

Should we be concerned at all about this potential changing of migrate type
on error?  The only way I can think to avoid this is to save the original
migrate type before isolation.

-- 
Mike Kravetz
