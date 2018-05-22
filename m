Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2827271-1527009919-2-10242238189041069467
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527009919; b=lYccvaK9RxmQSgMrHFzTH8vOztI1Psxo2ClBok/1XJPtMscnjn
    SijSVuBalW6ny9E3vC92htfGFJbatXV9B+dmr6g6Qpl/p4w6Q4EBslNRS+ADrVqX
    X/kUiot+RTxTcrC+edkPtmgcUrigxqatNCFjyvXudtvu2tBBsV1E/W2ImulVz7sJ
    pkJg1L8CTbXvDsvDEdxU9z37j9eaQKNcsbKuDytCAmNb4FnzyROsKfxEB2g26ErC
    VOk8ZrHIaJrzPNgmQ6WhVK3VaEOmwxZfY6tueKGAiMqK8OZr8iGhyOGNyzNTBw0U
    uOKABi5gT9+YxMVZjU/oyg4zQ8n4HSHq33GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527009919; bh=TA3eXxEM7naW4rOxzZ6Mz8xkFRgKAr5z8JyQAR0fdv
    0=; b=IL/wj6WGbjM3wnnum81MCpzVQ0wQAY8JoDX/XHYqBICNP9GIeBf6oc53nO
    EILGRvRg0X7HLGW+pgzz0OV5Vx7RBrMdi86wzEAUTp4GiPbrD+fTEm2PYhVULPDY
    hngf2SoLVNEeoQsAzSeDJhXMDjr5VBeAiSO3+FcXlRL0EwgwagKom+QpQEC2wBnS
    B0T+8ILvCKPN8WKiaUTY38Mvtg/mpWag3yeoDsiKR60zC64FsY6fxA2d/6VubxJl
    H6/mrjHShX8psGV+mbi12Q0ayFlSNxOrc6NaAvu5OwgAiUiFTt9YiPe47CpdWpZY
    lXQAfFSWAMjebwenqroYkCZgOSrw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=intel-com.20150623.gappssmtp.com
    header.i=@intel-com.20150623.gappssmtp.com header.b=J0mv7cgQ
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=q3zUVWqr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=intel-com.20150623.gappssmtp.com
      header.i=@intel-com.20150623.gappssmtp.com header.b=J0mv7cgQ
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=q3zUVWqr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMKrq9jV1gOr0ajQ2jDhBCXeN+4wER8ACJJ4iAJtrP+KCxFIpo3Ngbec3BD6SPceHVOoJ/SjpXvX4K+jm2K/vzDOT/jncH6Hspr6L53ATgjkI9uEkbnP
    0C1XHCl44iJIibTGLyjtUsbmzM8gwfcgacy5+Rb8jt+LFs2MhgnVvF6mD2alQ2zlx19ek/wUk+b3EjN5Ez3RJZiRocDkZJf/TZIFRdn8ZVlPg3jAHFw4hmA3
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=gXLdhW2jAAAA:8 a=7UXch9-P2N7pDQFF84UA:9 a=X1eiucYRf_K0tspx:21
    a=tpFlwsYEHzyDKE2_:21 a=QEXdDO2ut3YA:10 a=Dn9eIPSr_RzuO0KTJioD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeEVRZP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 13:25:15 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37012 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbeEVRZO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 13:25:14 -0400
X-Google-Smtp-Source: AB8JxZpy1pKNnCgyZ2Ga2gyB1KNNSq0SyiJIV2cnrW+0phgz4prHG7Gkc5/hTZAYGtUJM3Dgq1p7CyRbxudyGLLOH0o=
MIME-Version: 1.0
In-Reply-To: <b636aa5e-205b-4d67-09f8-230755de31b6@deltatee.com>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152694212460.5484.13180030631810166467.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180521161026.709d5f2876e44f151da3d179@linux-foundation.org>
 <CAPcyv4hMwMefMu3La+hZvN6r+Q6_N5t+eOgGE0bqVou=Cjpfwg@mail.gmail.com>
 <860a8c46-5171-78ac-0255-ee1d21b16ce8@deltatee.com> <CAPcyv4i-MAYLsmT1M4=D_fwMNF98MupDyNBjWNmOzwY5Lzz0Lw@mail.gmail.com>
 <b636aa5e-205b-4d67-09f8-230755de31b6@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 22 May 2018 10:25:13 -0700
Message-ID: <CAPcyv4ga3e0WSe4LeGbzpwj2QNU-XMezYDh54TPon6UKbhpP0Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm, devm_memremap_pages: handle errors allocating
 final devres action
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 10:03 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 22/05/18 10:56 AM, Dan Williams wrote:
>> On Tue, May 22, 2018 at 9:42 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
>>> Hey Dan,
>>>
>>> On 21/05/18 06:07 PM, Dan Williams wrote:
>>>> Without this change we could fail to register the teardown of
>>>> devm_memremap_pages(). The likelihood of hitting this failure is tiny
>>>> as small memory allocations almost always succeed. However, the impact
>>>> of the failure is large given any future reconfiguration, or
>>>> disable/enable, of an nvdimm namespace will fail forever as subsequent
>>>> calls to devm_memremap_pages() will fail to setup the pgmap_radix
>>>> since there will be stale entries for the physical address range.
>>>
>>> Sorry, I don't follow this. The change only seems to prevent a warning
>>> from occurring in this situation. Won't pgmap_radix_release() still be
>>> called regardless of whether this patch is applied?
>>
>> devm_add_action() does not call the release function,
>> devm_add_action_or_reset() does.
>
> Oh, yes. Thanks I see that now.
>
>> Ah, true, good catch!
>>
>> We should manually kill in the !registered case. I think this means we
>> need to pass in the custom kill routine, because for the pmem driver
>> it's blk_freeze_queue_start().
>
> It may be cleaner to just have the caller call the specific kill
> function if devm_memremap_pages fails...

As far as I can see by then it's too late, or we need to expose
release details to the caller which defeats the purpose of devm
semantics.

> Though, I don't fully
> understand how the nvdimm pmem driver cleans up the percpu counter.

The dev_pagemap setup for pmem is entirely too subtle and arguably a
layering violation as it reuses the block layer q_usage_counter
percpu_ref. We arrange for that counter to be shutdown before the
blk_cleanup_queue() does the same.
