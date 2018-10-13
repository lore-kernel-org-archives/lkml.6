Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448B5C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E7D20868
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRAnllfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E7D20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJMJO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 05:14:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42027 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeJMJO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 05:14:57 -0400
Received: by mail-io1-f66.google.com with SMTP id n18-v6so10517654ioa.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 18:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wde0HcwExXY831MfxZDBcHjXK7XvngyeZU1X9StNjyk=;
        b=mRAnllfVhCFMlnCIOcENVRpZ9fWtdthn5GIa/84lOa1zfYRyC7orxaopMW45sB8eGB
         ivJ95/M5otzqwf+a9a0kBxZZQSGJZfhDMo+nmJKVkyBRnP8qxtUI1xy15rJyzhFmnyt0
         8+wcDDhVwfzIxE7o4UdypM1uFOyBZO+dsZHL9V9EjcRk/t9uN1N8+jXX+FQbQNwLNM6+
         Yw/NuPi1khJ60fOVJAglTvakPu+RdegP9nyurUbv1ptWNwxhwQDL9ydwtFB3Y4wuPcbb
         mQP4MZorbCaZStz3SOglr9oedZvionoAiMgHFAr+d3BHihJaHkX9rSbjnDxfL9w+LOjP
         xsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wde0HcwExXY831MfxZDBcHjXK7XvngyeZU1X9StNjyk=;
        b=VPJ5A3cRf2JXQ8i7rQhY6a5fCSU+irvDLQTDqaSySjrTjpV2mX/NjbbqcGfCaSXmm6
         ETb/Ve3Q4af2+VtvybMvywm1mndlZV6mRcGDkcwFrh9Gbz2FR0odHvHYQrhigFLu/k6+
         Ci+r0V5mj8ICULdX08CJTuTukzxZD3sHpM9imUa7q2h3ht7UM3lmbu46+S1KSL+II7gv
         DsawiYu66tBjupi/x7xX6DGdphZPXVf+oK1FLRlu4Aeg10V8YhDWqXLZAYqBHMY7RdBM
         fnvn4giEwUAkiquGbnKcF992d9SHdp3Utghi5XBKGGK7Iqal3FmWl1eizdNde6OUbKPX
         FJww==
X-Gm-Message-State: ABuFfoiOqk2mFmWmusMB2szwXfvj2OcmThWdG/70yWjT5eBJ4u6aDf6c
        VwT/+7p4DbYcMcHrO/Hd/qpEcTiGqI+pLQmhJU3AVg==
X-Google-Smtp-Source: ACcGV63O+2oHow+MnmDFFN/fGr+ypIXJq0Jebw7vm8a3hwEac10cSSqcJGLdjRO5qFIM+0mJ+lFBqqSZgai2siyMk8M=
X-Received: by 2002:a6b:b249:: with SMTP id b70-v6mr5998814iof.252.1539394786418;
 Fri, 12 Oct 2018 18:39:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:d604:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 18:39:45
 -0700 (PDT)
In-Reply-To: <20181013013540.GA207108@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1> <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net> <20181013013540.GA207108@joelaf.mtv.corp.google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 12 Oct 2018 18:39:45 -0700
Message-ID: <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     David Miller <davem@davemloft.net>, kirill@shutemov.name,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Minchan Kim <minchan@kernel.org>,
        Ramon Pantin <pantin@google.com>, hughd@google.com,
        Lokesh Gidra <lokeshgidra@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, chris@zankel.net,
        dave.hansen@linux.intel.com, elfring@users.sourceforge.net,
        fenghua.yu@intel.com, geert@linux-m68k.org, gxt@pku.edu.cn,
        deller@gmx.de, mingo@redhat.com, jejb@parisc-linux.org,
        jdike@addtoit.com, jonas@southpole.se, Julia.Lawall@lip6.fr,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        lftan@altera.com, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm <linux-mm@kvack.org>, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, jcmvbkbc@gmail.com,
        nios2-dev@lists.rocketboards.org,
        Peter Zijlstra <peterz@infradead.org>, richard@nod.at
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not 32-bit ARM?

On Fri, Oct 12, 2018 at 6:35 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Fri, Oct 12, 2018 at 11:18:36AM -0700, David Miller wrote:
>> From: Joel Fernandes <joel@joelfernandes.org>
> [...]
>> > Also, do we not flush the caches from any path when we munmap
>> > address space?  We do call do_munmap on the old mapping from mremap
>> > after moving to the new one.
>>
>> Sparc makes sure that shared mapping have consistent colors.  Therefore
>> all that's left are private mappings and those will be initialized by
>> block stores to clear the page out or similar.
>>
>> Also, when creating new mappings, we flush the D-cache when necessary
>> in update_mmu_cache().
>>
>> We also maintain a bit in the page struct to track when a page which
>> was potentially written to on one cpu ends up mapped into another
>> address space and flush as necessary.
>>
>> The cache is write-through, which simplifies the preconditions we have
>> to maintain.
>
> Makes sense, thanks. For the moment I sent patches to enable this on arm64
> and x86. We can enable it on sparc as well at a later time as it sounds it
> could be a safe optimization to apply to that architecture as well.
>
> thanks,
>
>  - Joel
>
