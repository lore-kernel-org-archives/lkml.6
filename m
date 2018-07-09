Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E54C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE15208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1Sdvx9W2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE15208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932469AbeGIGI2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:08:28 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37319 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754367AbeGIGIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:08:25 -0400
Received: by mail-oi0-f67.google.com with SMTP id k81-v6so33728697oib.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 23:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P4jcJAq3iIHqPi9ivj41bgsOIIsduwuwZRlpyX2lUS0=;
        b=1Sdvx9W2k/2aB/yzFxeNek6AVEz3Vi7ak8UDwjDkraqZsI8FEIkvIOda8MO8GzXubO
         h2LRlce/aj5AJ1VartheKTvMz/s+QjFgDWWwXP2rQeG9+Lg1viS1pznv3F082eppvZ+S
         ZrrjaW06UxlKPuTjwgbs/AHng0yhZxMJRGrSXjFaD4rRME4A7y6/CDs+XaKgAAUNcI71
         w6et7euKePk5BWDjKjLNxhTbiQ6gOmj3/uJ3ipj5raj/rM5RmC2Y7YHQiVjyNNa9Q0X2
         AGnIKIQp9w+DpFMdmG8LYGWmX5hIwvSvZHckJM2og0Uj0iImmuWyqVO3HQOFr7Y0Z/bW
         2mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P4jcJAq3iIHqPi9ivj41bgsOIIsduwuwZRlpyX2lUS0=;
        b=g+7yXCAq9afAgbCIFY5kkAwsmt4mQsjJgdBjL4X9EAuzZpy4cQwRpBxAGXey6CH7nX
         bco8WlxIQ1kcGyOm6ximjSYqkN8ehCx6QRUTOA2WCUgkDVhd+DFssyWAa4IksOEDOiB0
         QUbX2nxmOcsNQZGk2/Cst6kJMH21C/IOVB+JkEjqcnf1879TNvcWx424Kp2epxj9tvba
         SGNDL4MFoEEp/PVpLmvbLvQ/pGHy4IEm1Z5MTPKe3ZFCiT6Fzd1fOCx+uCw9RyfzJpBh
         BL1IwkCw5vEIze96itkef/vKybtCSC49kCF6oELV9lTS0RWo6iajM2nwUUk5V1U9SeoU
         EH+w==
X-Gm-Message-State: APt69E2VZ/pv9OIjy4y9C+DRgoqUJ1QA0R2VoVFmwugJ11lOoa9F8JMz
        o4aSDhGeyZaVCe8sbmdMnB2PyvqPlsPVBlMyPp1roQ==
X-Google-Smtp-Source: AAOMgpcnKCryTYx2snWbdRBnZSRI575v8jtNtlk1lNXHT8NOVEKE5F52PGoqS049fmV2JhyXT1aAa/xwVJL6rVOuogQ=
X-Received: by 2002:aca:3954:: with SMTP id g81-v6mr23134154oia.215.1531116505005;
 Sun, 08 Jul 2018 23:08:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Sun, 8 Jul 2018 23:08:24 -0700 (PDT)
In-Reply-To: <87muv1kluq.fsf@yhuang-dev.intel.com>
References: <20180622035151.6676-1-ying.huang@intel.com> <20180622035151.6676-2-ying.huang@intel.com>
 <CAA9_cmcwczyEb=+3F7HtDDqZA-3rdqgw=gkYipDtx5r+4Kd5Tw@mail.gmail.com> <87muv1kluq.fsf@yhuang-dev.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 8 Jul 2018 23:08:24 -0700
Message-ID: <CAPcyv4hxBwRx_XPt9MrDq6xgvFnCmQhJee_G3-k=c62vxYDv1A@mail.gmail.com>
Subject: Re: [PATCH -mm -v4 01/21] mm, THP, swap: Enable PMD swap operations
 for CONFIG_THP_SWAP
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        zi.yan@cs.rutgers.edu, daniel.m.jordan@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 8, 2018 at 10:40 PM, Huang, Ying <ying.huang@intel.com> wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
>
>> On Thu, Jun 21, 2018 at 8:55 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>
>>> From: Huang Ying <ying.huang@intel.com>
>>>
>>> Previously, the PMD swap operations are only enabled for
>>> CONFIG_ARCH_ENABLE_THP_MIGRATION.  Because they are only used by the
>>> THP migration support.  We will support PMD swap mapping to the huge
>>> swap cluster and swapin the THP as a whole.  That will be enabled via
>>> CONFIG_THP_SWAP and needs these PMD swap operations.  So enable the
>>> PMD swap operations for CONFIG_THP_SWAP too.
>>>
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: Shaohua Li <shli@kernel.org>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: Minchan Kim <minchan@kernel.org>
>>> Cc: Rik van Riel <riel@redhat.com>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>>> Cc: Zi Yan <zi.yan@cs.rutgers.edu>
>>> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
>>> ---
>>>  arch/x86/include/asm/pgtable.h |  2 +-
>>>  include/asm-generic/pgtable.h  |  2 +-
>>>  include/linux/swapops.h        | 44 ++++++++++++++++++++++--------------------
>>>  3 files changed, 25 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>>> index 99ecde23c3ec..13bf58838daf 100644
>>> --- a/arch/x86/include/asm/pgtable.h
>>> +++ b/arch/x86/include/asm/pgtable.h
>>> @@ -1224,7 +1224,7 @@ static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
>>>         return pte_clear_flags(pte, _PAGE_SWP_SOFT_DIRTY);
>>>  }
>>>
>>> -#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>> +#if defined(CONFIG_ARCH_ENABLE_THP_MIGRATION) || defined(CONFIG_THP_SWAP)
>>
>> How about introducing a new config symbol representing the common
>> infrastructure between the two and have them select that symbol.
>
> The common infrastructure shared by two mechanisms is PMD swap entry.
> But I didn't find there are many places where the common infrastructure
> is used.  So I think it may be over-engineering to introduce a new
> config symbol but use it for so few times.
>
>> Would that also allow us to clean up the usage of
>> CONFIG_ARCH_ENABLE_THP_MIGRATION in fs/proc/task_mmu.c? In other
>> words, what's the point of having nice ifdef'd alternatives in header
>> files when ifdefs are still showing up in C files, all of it should be
>> optionally determined by header files.
>
> Unfortunately, I think it is not a easy task to wrap all C code via
> #ifdef in header files.  And it may be over-engineering to wrap them
> all.  I guess this is why there are still some #ifdef in C files.

That's the entire point. Yes, over-engineer the header files so the
actual C code is more readable.
