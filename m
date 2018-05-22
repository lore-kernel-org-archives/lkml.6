Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2827271-1527008213-2-8258686472617839496
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
    1527008212; b=IfabQ0hzX3AkhTj0GbUCENVMejWzwUgMdR7VJJtj8XSmE2cANa
    a8dUIs121sB3X8NcrTP78/j04a8Q/grLpfLu6fZf8QMV8YE6q9copp/FvvQ0crUP
    GtDEFKwgq2OnUNCrxo0J4axgIAKHgrk8KbWC2xavb/OiU/dFEkYpD+DxM9lov3t8
    yu6Ei3eo6o+2luJAgzGACmMeCQ/blt0AJTqmjYBg4Oxk8w89W+aJjTLxrpXWldzF
    JvzsjFCnrn4GzabNUiNMB61wnLudwcG3AlLQhzLB0nozFYHyBYCb31OLVHhgy3Xk
    35Q7uOS5funb3/Cl87Zol8diC4PVLEEL80/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527008212; bh=/l0m8ANWCNqND9koj6lEgg0tBz7SvjMSi3csxWzZMu
    A=; b=KPofJI+3t0MCHT2KWzG0V+Z2jMuPqkhjJwJrY33QWDpp3o17f0sIGVxzMe
    Cxg6u134fBOEHH10s4b9iz+t/khvv47dmBMZAtfxVZQk83iRRY8GaUzCPS4Tm+mP
    8146i1N8TAp4vt7QvwLTa+DX1+3BjXP3Zd9PmnOlG0xPvhLogGFUIcyR5/jPGQc2
    3JQWjUa10YmpSvnfNYzeRfa2VlhJAspNqFURbprEH2qQDKJMGoqUuxujRy904ua0
    cwr0f4OA3F5BT9vivs6tq/7oKhhKfQ0T2Mu635Ou7f+4YqiWPFwjYU1jRNGh1s1b
    onY5sZ0ROXfBGb1jqcAI+Kpmz7Og==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=intel-com.20150623.gappssmtp.com
    header.i=@intel-com.20150623.gappssmtp.com header.b=G/SqopQP
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=fNR9kgjn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=intel-com.20150623.gappssmtp.com
      header.i=@intel-com.20150623.gappssmtp.com header.b=G/SqopQP
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=fNR9kgjn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfACsFugF+bSow67Lz0grAutLhObmn19kKR6FvyhZW+WK083bMPvLDcdbq4H7MVpNpRf08qaYPmjC01PhFW5vHX5ncJ448TNeM7O42kv+NLl4cHHAwRJF
    xVQ6Rq74nYnlF/+AaxXV0D2TgcoWVpJXgMRsr99gI5bijueNm8z5uwArK7Bus9kth+Xqzr0tLhWRIRYAIu0k5B5cZuoL+15+gc8gtCz2OdnlbStha1ye9XYG
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=gXLdhW2jAAAA:8 a=MeWJhdUGKXdRlJ8CxssA:9 a=NpK3qhgGWWvbtWCS:21
    a=1rJIDyIbjoA42pVq:21 a=QEXdDO2ut3YA:10 a=Dn9eIPSr_RzuO0KTJioD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeEVQ4u (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 12:56:50 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46629 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEVQ4t (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 12:56:49 -0400
X-Google-Smtp-Source: AB8JxZrWrD+oKRkx2bkluA3fH6uXzlthR2K/x1at5uVLfw2is5YVH5pZWljqWvLF7FmJiXWLZbSStd3A/LhlCEBOuh4=
MIME-Version: 1.0
In-Reply-To: <860a8c46-5171-78ac-0255-ee1d21b16ce8@deltatee.com>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152694212460.5484.13180030631810166467.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180521161026.709d5f2876e44f151da3d179@linux-foundation.org>
 <CAPcyv4hMwMefMu3La+hZvN6r+Q6_N5t+eOgGE0bqVou=Cjpfwg@mail.gmail.com> <860a8c46-5171-78ac-0255-ee1d21b16ce8@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 22 May 2018 09:56:48 -0700
Message-ID: <CAPcyv4i-MAYLsmT1M4=D_fwMNF98MupDyNBjWNmOzwY5Lzz0Lw@mail.gmail.com>
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

On Tue, May 22, 2018 at 9:42 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Hey Dan,
>
> On 21/05/18 06:07 PM, Dan Williams wrote:
>> Without this change we could fail to register the teardown of
>> devm_memremap_pages(). The likelihood of hitting this failure is tiny
>> as small memory allocations almost always succeed. However, the impact
>> of the failure is large given any future reconfiguration, or
>> disable/enable, of an nvdimm namespace will fail forever as subsequent
>> calls to devm_memremap_pages() will fail to setup the pgmap_radix
>> since there will be stale entries for the physical address range.
>
> Sorry, I don't follow this. The change only seems to prevent a warning
> from occurring in this situation. Won't pgmap_radix_release() still be
> called regardless of whether this patch is applied?

devm_add_action() does not call the release function,
devm_add_action_or_reset() does.

> But it looks to me like this patch doesn't quite solve the issue -- at
> least when looking at dax/pmem.c: If devm_add_action_or_reset() fails,
> then dax_pmem_percpu_kill() won't be registered as an action and the
> percpu_ref will never get killed. Thus, dax_pmem_percpu_release() would
> not get called and dax_pmem_percpu_exit() will hang waiting for a
> completion that will never occur. So we probably need to add a kill call
> somewhere on the failing path...

Ah, true, good catch!

We should manually kill in the !registered case. I think this means we
need to pass in the custom kill routine, because for the pmem driver
it's blk_freeze_queue_start().
