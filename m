Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1210825-1517802861-2-10458151749669107319
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517802860; b=C8aMLvd+PvFaTb+1QWZu2bLX8+03iH68ihnpY+P0POQ4qvU
    EfeEbiJvCjKdlqevpY+OvreS407U7tr/rRHhzOz1Dcoj4z4dyzhnzfdN2/eBizR+
    hrp3FsiApY698ncVhBmH6XQsqVGEqOqrLKjObHOi50apF5P7K0s9GzLnBYZNnczW
    dP+z34Tv5jeG/4v5DKHAoN//+XPFPHQH2x3xj8cAJc3PvsExGuE74vjjXwTjZ75X
    l24q4S4geccD7e32S+rn7xJ33puuugXLVbePoIfdVUxTrlkYd9lAg3OI5bAkh8Ay
    pNQ0YD4biZxAmV4f4nAjLd1NTX9W9fttuCeSGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:content-type:sender:list-id; s=
    arctest; t=1517802860; bh=oyhaMKc98zzjM2lR68JGX3HbTNZjd9hxZPS3Ee
    r4k3E=; b=Wxruamb4nb5kKNRmStYxMLU1TBVykPZVPaA3vIzweH7LlKAbC147ZH
    yNOlTGkmbCsMAvu0gKVuUHwwnM0Dwr/hy0/Kq1bQ5YaPh2Agj4KQN+R0wYeznuRo
    HIP2u7rU1DP/SzCQ+wHWA+fioqPzPt72v3iHh+7gwKQs6ZBoq81xZ70/nKblJbdT
    geAXfKQbaH4QFkXESpTki5W+ejhRWJX7xdqmXgWyiDmvSvwNJ/4gR8WW48Hcc2dE
    I3x9oLhRCJ8jWfptcjgisEWZ4mXHaHnvOwPuaDiVnC4uzzUaiFlr5TuN1mP2rhPs
    NODVhfQx5cEQektCnhOGDzyfmVycDUHg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=YYZaF94c x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lhYZH++E;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=YYZaF94c x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lhYZH++E;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeBEDyO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Feb 2018 22:54:14 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:32871 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbeBEDyM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Feb 2018 22:54:12 -0500
X-Google-Smtp-Source: AH8x226VjavzHL6eLIsdrLfRm+R16GX86WHGzKCB8QM6w4yzhqTJe6D5IEUFVcPuO9TiUSiK2wd1zeMWtr6AJpjuf7k=
MIME-Version: 1.0
In-Reply-To: <20180205034653.mfnla2nq55ikkhav@hz-desktop>
References: <151778551496.7139.17808629759104553625.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151778553083.7139.6601964812589807125.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180205034653.mfnla2nq55ikkhav@hz-desktop>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 4 Feb 2018 19:54:11 -0800
Message-ID: <CAPcyv4iNk=mmyRak6tyDyvF8BzKqi+z-_-aTh8ZQBeAQe-Q7gw@mail.gmail.com>
Subject: Re: [PATCH 3/3] vfio: disable filesystem-dax page pinning
To: Dan Williams <dan.j.williams@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        KVM list <kvm@vger.kernel.org>, linux-nvdimm@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 4, 2018 at 7:46 PM, Haozhong Zhang <haozhong.zhang@intel.com> wrote:
> On 02/04/18 15:05 -0800, Dan Williams wrote:
>> Filesystem-DAX is incompatible with 'longterm' page pinning. Without
>> page cache indirection a DAX mapping maps filesystem blocks directly.
>> This means that the filesystem must not modify a file's block map while
>> any page in a mapping is pinned. In order to prevent the situation of
>> userspace holding of filesystem operations indefinitely, disallow
>> 'longterm' Filesystem-DAX mappings.
>>
>> RDMA has the same conflict and the plan there is to add a 'with lease'
>> mechanism to allow the kernel to notify userspace that the mapping is
>> being torn down for block-map maintenance. Perhaps something similar can
>> be put in place for vfio.
>>
>> Note that xfs and ext4 still report:
>>
>>    "DAX enabled. Warning: EXPERIMENTAL, use at your own risk"
>>
>> ...at mount time, and resolving the dax-dma-vs-truncate problem is one
>> of the last hurdles to remove that designation.
>>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: kvm@vger.kernel.org
>> Cc: <stable@vger.kernel.org>
>> Reported-by: Haozhong Zhang <haozhong.zhang@intel.com>
>> Fixes: d475c6346a38 ("dax,ext2: replace XIP read and write with DAX I/O")
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  drivers/vfio/vfio_iommu_type1.c |   18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index e30e29ae4819..45657e2b1ff7 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -338,11 +338,12 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
>>  {
>>       struct page *page[1];
>>       struct vm_area_struct *vma;
>> +     struct vm_area_struct *vmas[1];
>>       int ret;
>>
>>       if (mm == current->mm) {
>> -             ret = get_user_pages_fast(vaddr, 1, !!(prot & IOMMU_WRITE),
>> -                                       page);
>> +             ret = get_user_pages_longterm(vaddr, 1, !!(prot & IOMMU_WRITE),
>> +                                           page, vmas);
>
> vmas is not used subsequently if this branch is taken, so can we use
> NULL here?

I'd rather go the other way and refactor this a bit further to skip
the find_vma_intersection() below since get_user_pages() already does
that work.
